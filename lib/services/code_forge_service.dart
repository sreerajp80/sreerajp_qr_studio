import 'dart:io';
import 'dart:ui' as ui;
import 'package:barcode/barcode.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr/qr.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sreeraj_qr_reader/core/constants/app_constants.dart';
import 'package:sreeraj_qr_reader/models/app_message.dart';
import 'package:sreeraj_qr_reader/models/code_forge_config.dart';
import 'package:sreeraj_qr_reader/models/safety_check_result.dart';
import 'package:sreeraj_qr_reader/services/url_safety_service.dart';
import 'package:sreeraj_qr_reader/widgets/code_forge_qr_painter.dart';

/// Result of reading a text file for CodeForge QR generation.
class CodeForgeFileReadResult {
  final String? content;
  final bool wasTruncated;
  final AppMessage? message;
  final bool isSuccess;

  const CodeForgeFileReadResult({
    this.content,
    this.wasTruncated = false,
    this.message,
    this.isSuccess = true,
  });
}

/// Service responsible for payload formatting, barcode encoding,
/// high-resolution PNG rasterization, vector SVG generation, and file sharing.
class CodeForgeService {
  final UrlSafetyService _urlSafetyService;

  CodeForgeService({UrlSafetyService? urlSafetyService})
    : _urlSafetyService = urlSafetyService ?? UrlSafetyService();

  /// Formats the raw barcode string based on the configuration and payload type.
  String buildPayloadString(CodeForgeConfig config) {
    if (config.barcodeType != CodeForgeBarcodeType.qrCode) {
      return config.rawContent.trim();
    }

    switch (config.payloadType) {
      case CodeForgePayloadType.text:
        return config.rawContent;

      case CodeForgePayloadType.url:
        final trimmed = config.rawContent.trim();
        if (trimmed.isEmpty) return '';
        if (!trimmed.contains('://') && !trimmed.startsWith('//')) {
          return 'https://$trimmed';
        }
        return trimmed;

      case CodeForgePayloadType.wifi:
        final ssid = _escapeWifi(config.wifiSsid);
        final pass = _escapeWifi(config.wifiPassword);
        final sec = config.wifiSecurity;
        final hidden = config.wifiHidden ? 'H:true;' : '';
        return 'WIFI:T:$sec;S:$ssid;P:$pass;$hidden;';

      case CodeForgePayloadType.contactVCard:
        final buffer = StringBuffer();
        buffer.writeln('BEGIN:VCARD');
        buffer.writeln('VERSION:3.0');
        if (config.contactName.isNotEmpty) {
          buffer.writeln('FN:${config.contactName}');
          buffer.writeln('N:;${config.contactName};;;');
        }
        if (config.contactOrg.isNotEmpty) {
          buffer.writeln('ORG:${config.contactOrg}');
        }
        if (config.contactTitle.isNotEmpty) {
          buffer.writeln('TITLE:${config.contactTitle}');
        }
        if (config.contactPhone.isNotEmpty) {
          buffer.writeln('TEL:${config.contactPhone}');
        }
        if (config.contactEmail.isNotEmpty) {
          buffer.writeln('EMAIL:${config.contactEmail}');
        }
        if (config.contactUrl.isNotEmpty) {
          buffer.writeln('URL:${config.contactUrl}');
        }
        buffer.write('END:VCARD');
        return buffer.toString();

      case CodeForgePayloadType.upiPayment:
        final params = <String>[
          'pa=${Uri.encodeComponent(config.upiVpa.trim())}',
        ];
        if (config.upiName.isNotEmpty) {
          params.add('pn=${Uri.encodeComponent(config.upiName.trim())}');
        }
        if (config.upiAmount.isNotEmpty) {
          params.add('am=${Uri.encodeComponent(config.upiAmount.trim())}');
        }
        if (config.upiNote.isNotEmpty) {
          params.add('tn=${Uri.encodeComponent(config.upiNote.trim())}');
        }
        params.add('cu=INR');
        return 'upi://pay?${params.join('&')}';

      case CodeForgePayloadType.sms:
        return 'smsto:${config.smsPhone.trim()}:${config.smsMessage}';

      case CodeForgePayloadType.email:
        final email = config.emailTo.trim();
        final subject = Uri.encodeComponent(config.emailSubject);
        final body = Uri.encodeComponent(config.emailBody);
        return 'mailto:$email?subject=$subject&body=$body';

      case CodeForgePayloadType.geo:
        return 'geo:${config.geoLat.trim()},${config.geoLng.trim()}';
    }
  }

  /// ZXing standard backslash escaping for Wi-Fi strings.
  String _escapeWifi(String text) {
    return text
        .replaceAll(r'\', r'\\')
        .replaceAll(';', r'\;')
        .replaceAll(',', r'\,')
        .replaceAll(':', r'\:')
        .replaceAll('"', r'\"');
  }

  /// Maps the enum to a `package:barcode` generator.
  Barcode getBarcodeInstance(CodeForgeBarcodeType type) {
    switch (type) {
      case CodeForgeBarcodeType.code128:
        return Barcode.code128();
      case CodeForgeBarcodeType.ean13:
        return Barcode.ean13();
      case CodeForgeBarcodeType.ean8:
        return Barcode.ean8();
      case CodeForgeBarcodeType.upcA:
        return Barcode.upcA();
      case CodeForgeBarcodeType.code39:
        return Barcode.code39();
      case CodeForgeBarcodeType.pdf417:
        return Barcode.pdf417();
      case CodeForgeBarcodeType.dataMatrix:
        return Barcode.dataMatrix();
      case CodeForgeBarcodeType.qrCode:
        return Barcode.qrCode();
    }
  }

  /// Validates whether the given configuration contains valid content for its barcode type.
  String? validateContent(CodeForgeConfig config) {
    final payload = buildPayloadString(config);
    if (payload.trim().isEmpty) {
      return 'Content cannot be empty';
    }

    if (config.barcodeType == CodeForgeBarcodeType.qrCode) {
      if (config.payloadType == CodeForgePayloadType.text &&
          config.rawContent.length > AppConstants.maxCodeForgeTextLength) {
        return 'Text must not exceed ${AppConstants.maxCodeForgeTextLength} characters';
      }
      if (config.payloadType == CodeForgePayloadType.wifi &&
          config.wifiSsid.trim().isEmpty) {
        return 'Wi-Fi Network Name (SSID) is required';
      }
      if (config.payloadType == CodeForgePayloadType.upiPayment &&
          config.upiVpa.trim().isEmpty) {
        return 'UPI ID / VPA is required';
      }
      return null;
    }

    // 1D / 2D Barcode format validation via package:barcode
    final barcode = getBarcodeInstance(config.barcodeType);
    try {
      barcode.verify(payload);
      return null;
    } catch (e) {
      final message = e.toString().replaceFirst('Exception: ', '');
      return message;
    }
  }

  /// Generates the QR matrix using `package:qr`.
  QrImage? generateQrMatrix(String data, int errorCorrectionLevel) {
    if (data.isEmpty) return null;
    try {
      final qrCode = QrCode.fromData(
        data: data,
        errorCorrectLevel: errorCorrectionLevel,
      );
      return QrImage(qrCode);
    } catch (e) {
      if (kDebugMode) debugPrint('Error generating QR matrix: $e');
      return null;
    }
  }

  /// Generates SVG vector string for 1D or 2D barcodes.
  String generateBarcodeSvg(
    CodeForgeConfig config, {
    double width = 300,
    double height = 150,
  }) {
    final payload = buildPayloadString(config);
    final barcode = getBarcodeInstance(config.barcodeType);
    return barcode.toSvg(
      payload,
      width: width,
      height: height,
      color: config.foregroundColorValue,
      drawText: config.includeTextLabel,
    );
  }

  /// Generates SVG vector string for customized QR codes.
  String generateQrSvg(CodeForgeConfig config, {double size = 400}) {
    final payload = buildPayloadString(config);
    final qrImage = generateQrMatrix(payload, config.errorCorrectionLevel);
    if (qrImage == null) return '';

    final moduleCount = qrImage.moduleCount;
    final moduleSize = size / moduleCount;
    final fgHex =
        '#${(config.foregroundColorValue & 0x00FFFFFF).toRadixString(16).padLeft(6, '0')}';
    final bgHex =
        '#${(config.backgroundColorValue & 0x00FFFFFF).toRadixString(16).padLeft(6, '0')}';

    final buffer = StringBuffer();
    buffer.writeln(
      '<svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="$size" height="$size" viewBox="0 0 $size $size">',
    );
    buffer.writeln('  <rect width="$size" height="$size" fill="$bgHex" />');

    for (int r = 0; r < moduleCount; r++) {
      for (int c = 0; c < moduleCount; c++) {
        if (qrImage.isDark(r, c)) {
          final x = c * moduleSize;
          final y = r * moduleSize;

          if (config.patternShape == QrPatternShape.dots) {
            final cx = x + moduleSize / 2;
            final cy = y + moduleSize / 2;
            final radius = (moduleSize / 2) * 0.85;
            buffer.writeln(
              '  <circle cx="$cx" cy="$cy" r="$radius" fill="$fgHex" />',
            );
          } else if (config.patternShape == QrPatternShape.rounded) {
            final radius = moduleSize * 0.3;
            buffer.writeln(
              '  <rect x="$x" y="$y" width="$moduleSize" height="$moduleSize" rx="$radius" ry="$radius" fill="$fgHex" />',
            );
          } else {
            buffer.writeln(
              '  <rect x="$x" y="$y" width="$moduleSize" height="$moduleSize" fill="$fgHex" />',
            );
          }
        }
      }
    }

    buffer.writeln('</svg>');
    return buffer.toString();
  }

  /// Renders a high-resolution PNG image byte array directly in memory.
  Future<Uint8List?> renderQrToPngBytes(
    CodeForgeConfig config, {
    double size = 1024,
  }) async {
    final payload = buildPayloadString(config);
    final qrImage = generateQrMatrix(payload, config.errorCorrectionLevel);
    if (qrImage == null) return null;

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder, Rect.fromLTWH(0, 0, size, size));

    final painter = CodeForgeQrPainter(config: config, qrImage: qrImage);

    painter.paint(canvas, Size(size, size));

    final picture = recorder.endRecording();
    final img = await picture.toImage(size.toInt(), size.toInt());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }

  /// Saves image bytes to temporary storage and shares via the system sheet.
  Future<void> shareImage(
    Uint8List pngBytes,
    String fileName, {
    String? subject,
  }) async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/$fileName');
    await file.writeAsBytes(pngBytes, flush: true);

    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path, mimeType: 'image/png')],
        subject: subject ?? 'Generated Barcode',
      ),
    );
  }

  /// Saves SVG string to temporary storage and shares via the system sheet.
  Future<void> shareSvg(
    String svgString,
    String fileName, {
    String? subject,
  }) async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/$fileName');
    await file.writeAsString(svgString, flush: true);

    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path, mimeType: 'image/svg+xml')],
        subject: subject ?? 'Generated Barcode Vector SVG',
      ),
    );
  }

  /// Pre-flight URL safety verification check using UrlSafetyService.
  Future<List<SafetyCheckResult>> verifyUrlSafety(String url) async {
    return _urlSafetyService.runAllChecks(url);
  }

  /// Reads text from a local file at [filePath], validating and truncating if it exceeds [maxLength].
  Future<CodeForgeFileReadResult> readTextFromFile(
    String filePath, {
    int maxLength = AppConstants.maxCodeForgeTextLength,
  }) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) {
        return const CodeForgeFileReadResult(
          isSuccess: false,
          message: AppMessage(AppMessageKey.codeForgeFileReadError),
        );
      }
      final rawText = await file.readAsString();
      if (rawText.trim().isEmpty) {
        return const CodeForgeFileReadResult(
          isSuccess: false,
          message: AppMessage(AppMessageKey.codeForgeFileEmpty),
        );
      }
      if (rawText.length > maxLength) {
        final truncated = rawText.substring(0, maxLength);
        return CodeForgeFileReadResult(
          content: truncated,
          wasTruncated: true,
          message: const AppMessage(AppMessageKey.codeForgeFileTruncated),
        );
      }
      return CodeForgeFileReadResult(
        content: rawText,
        message: const AppMessage(AppMessageKey.codeForgeFileLoaded),
      );
    } catch (e) {
      if (kDebugMode) debugPrint('Error reading text file: $e');
      return const CodeForgeFileReadResult(
        isSuccess: false,
        message: AppMessage(AppMessageKey.codeForgeFileReadError),
      );
    }
  }

  /// Opens the system file picker to select a text-based document and reads its contents.
  Future<CodeForgeFileReadResult> pickAndReadTextFile({
    int maxLength = AppConstants.maxCodeForgeTextLength,
  }) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'txt',
          'csv',
          'json',
          'md',
          'log',
          'xml',
          'yaml',
          'yml',
        ],
      );
      if (result == null ||
          result.files.isEmpty ||
          result.files.single.path == null) {
        return const CodeForgeFileReadResult(isSuccess: false);
      }
      return await readTextFromFile(
        result.files.single.path!,
        maxLength: maxLength,
      );
    } catch (e) {
      if (kDebugMode) debugPrint('Error picking text file: $e');
      return const CodeForgeFileReadResult(
        isSuccess: false,
        message: AppMessage(AppMessageKey.codeForgeFileReadError),
      );
    }
  }
}
