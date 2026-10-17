import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sreerajp_qr_studio/core/logging/app_logger.dart';
import 'package:sreerajp_qr_studio/models/clipboard_scan_data.dart';
import 'package:sreerajp_qr_studio/models/parsed_payload.dart';
import 'package:sreerajp_qr_studio/services/payload_parser_service.dart';
import 'package:sreerajp_qr_studio/services/stego_qr_service.dart';
import 'package:sreerajp_qr_studio/models/code_content_type.dart';

/// Service responsible for inspecting the system clipboard and detecting scannable
/// images, URLs, and structured barcode payloads.
class ClipboardScanService {
  static const String _clipboardChannelName = 'in.sreerajp.qr_studio/clipboard';
  final MethodChannel _channel;
  final PayloadParserService _payloadParserService;
  final StegoQrService _stegoQrService;

  static final RegExp _urlRegex = RegExp(
    r'^https?://[\w\-]+(\.[\w\-]+)+[/#?]?.*$',
    caseSensitive: false,
  );

  static final RegExp _numericBarcodeRegex = RegExp(r'^\d{8}$|^\d{12,14}$');

  ClipboardScanService({
    MethodChannel? channel,
    PayloadParserService? payloadParserService,
    StegoQrService? stegoQrService,
  }) : _channel = channel ?? const MethodChannel(_clipboardChannelName),
       _payloadParserService = payloadParserService ?? PayloadParserService(),
       _stegoQrService = stegoQrService ?? StegoQrService();

  /// Inspects the system clipboard and returns scannable data if found.
  ///
  /// When [includeGenericText] is false, only URLs, structured barcode payloads,
  /// and images are detected. When true, arbitrary non-empty text is also accepted.
  Future<ClipboardScanData?> checkClipboard({
    bool includeGenericText = false,
  }) async {
    try {
      // 1. Check for native Android clipboard image
      final nativeImagePath = await _checkNativeClipboardImage();
      if (nativeImagePath != null) {
        return ClipboardScanData(
          type: ClipboardContentType.image,
          content: nativeImagePath,
          barcodeType: CodeContentType.unknown,
          preview: 'Image',
        );
      }

      // 2. Check for text in clipboard
      final clipData = await Clipboard.getData(Clipboard.kTextPlain);
      final rawText = clipData?.text?.trim();
      if (rawText == null || rawText.isEmpty) {
        return null;
      }

      // 3. Check for base64 image data URI
      final dataUriFile = await _extractDataUriImage(rawText);
      if (dataUriFile != null) {
        return ClipboardScanData(
          type: ClipboardContentType.image,
          content: dataUriFile,
          barcodeType: CodeContentType.unknown,
          preview: 'Image',
        );
      }

      // 4. Check for local image file path in text
      if (_isLocalImagePath(rawText)) {
        return ClipboardScanData(
          type: ClipboardContentType.image,
          content: rawText,
          barcodeType: CodeContentType.unknown,
          preview: 'Image',
        );
      }

      // 5. Check for URL
      if (_urlRegex.hasMatch(rawText)) {
        return ClipboardScanData(
          type: ClipboardContentType.url,
          content: rawText,
          barcodeType: CodeContentType.url,
          preview: _makePreview(rawText),
        );
      }

      // 6. Check for structured barcode payload or StegoQR
      final structuredType = _detectBarcodePayloadType(rawText);
      if (structuredType != null) {
        return ClipboardScanData(
          type: ClipboardContentType.barcodePayload,
          content: rawText,
          barcodeType: structuredType,
          preview: _makePreview(rawText),
        );
      }

      // 7. Generic plain text (if explicitly requested)
      if (includeGenericText) {
        return ClipboardScanData(
          type: ClipboardContentType.text,
          content: rawText,
          barcodeType: CodeContentType.text,
          preview: _makePreview(rawText),
        );
      }

      return null;
    } catch (e, st) {
      AppLogger.error('ClipboardScanService error', error: e, stackTrace: st);
      return null;
    }
  }

  /// Queries the Android native method channel for a copied image file.
  Future<String?> _checkNativeClipboardImage() async {
    try {
      final path = await _channel.invokeMethod<String>('getClipboardImage');
      if (path != null && path.isNotEmpty && File(path).existsSync()) {
        return path;
      }
    } catch (_) {
      // Non-Android platforms or channel unhandled
    }
    return null;
  }

  /// Extracts a base64 encoded data URI (e.g. data:image/png;base64,...) to a temp file.
  Future<String?> _extractDataUriImage(String text) async {
    if (!text.toLowerCase().startsWith('data:image/') ||
        !text.contains(';base64,')) {
      return null;
    }

    try {
      final parts = text.split(';base64,');
      if (parts.length != 2) return null;

      final mime = parts[0].substring(5); // e.g. "image/png"
      final base64Str = parts[1].trim();
      final bytes = base64Decode(base64Str);

      final ext = mime.contains('png')
          ? '.png'
          : mime.contains('webp')
          ? '.webp'
          : '.jpg';

      final tempDir = await getTemporaryDirectory();
      final file = File(
        '${tempDir.path}/clipboard_data_uri_${DateTime.now().millisecondsSinceEpoch}$ext',
      );
      await file.writeAsBytes(bytes);
      return file.path;
    } catch (_) {
      return null;
    }
  }

  /// Checks if [text] is an existing local image file path.
  bool _isLocalImagePath(String text) {
    final lower = text.toLowerCase();
    if (lower.endsWith('.png') ||
        lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.webp')) {
      try {
        return File(text).existsSync();
      } catch (_) {}
    }
    return false;
  }

  /// Detects if [text] matches structured barcode formats or StegoQR payloads.
  CodeContentType? _detectBarcodePayloadType(String text) {
    if (_stegoQrService.isStegoQr(text)) {
      return CodeContentType.text;
    }

    if (_numericBarcodeRegex.hasMatch(text)) {
      return CodeContentType.product;
    }

    final parsed = _payloadParserService.parse(text);
    if (parsed is! GenericPayload) {
      return switch (parsed) {
        WifiPayload _ => CodeContentType.wifi,
        EmailPayload _ => CodeContentType.email,
        PhonePayload _ => CodeContentType.phone,
        SmsPayload _ => CodeContentType.sms,
        GeoPayload _ => CodeContentType.geo,
        ContactPayload _ => CodeContentType.contactInfo,
        IsbnPayload _ => CodeContentType.isbn,
        ProductBarcodePayload _ => CodeContentType.product,
        AppLinkPayload _ => CodeContentType.url,
        PaymentPayload _ => CodeContentType.text,
        TotpPayload _ => CodeContentType.text,
        CalendarPayload _ => CodeContentType.text,
        _ => CodeContentType.text,
      };
    }

    return null;
  }

  /// Creates a clean truncated preview string.
  String _makePreview(String text, {int maxLength = 30}) {
    final clean = text.replaceAll(RegExp(r'\s+'), ' ').trim();
    if (clean.length > maxLength) {
      return '${clean.substring(0, maxLength - 3)}...';
    }
    return clean;
  }
}
