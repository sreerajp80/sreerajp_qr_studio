import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';
import 'dart:ui';

import 'package:ffi/ffi.dart';
import 'package:sreerajp_qr_studio/models/code_format.dart';
import 'package:sreerajp_qr_studio/models/decode_profile.dart';
import 'package:sreerajp_qr_studio/models/scanned_code.dart';
import 'package:sreerajp_qr_studio/services/barcode_content_classifier.dart';
import 'package:sreerajp_qr_studio/services/barcode_decoder/barcode_ffi_bindings.dart';

/// One decode job: a pixel buffer plus how to read it.
///
/// Plain data only, so it can be sent to the decoder isolate.
class DecodeRequest {
  final Uint8List pixels;
  final int width;
  final int height;

  /// Bytes per row; 0 means tightly packed.
  final int rowStride;

  /// One of [SrbImageFormat].
  final int imageFormat;

  /// Clockwise rotation (0, 90, 180, 270) that makes the image upright.
  final int rotationDegrees;
  final int formatMask;
  final DecodeProfile profile;

  /// Also look for light-on-dark (inverted) codes.
  final bool tryInvert;

  /// Maximum codes to return (1–32).
  final int maxSymbols;

  const DecodeRequest({
    required this.pixels,
    required this.width,
    required this.height,
    this.rowStride = 0,
    required this.imageFormat,
    this.rotationDegrees = 0,
    required this.formatMask,
    this.profile = DecodeProfile.thorough,
    this.tryInvert = false,
    this.maxSymbols = 8,
  });
}

/// Calls the native decoder synchronously. Meant to run on a background
/// isolate (see `BarcodeDecoderService`), never on the UI isolate.
class NativeBarcodeReader {
  final BarcodeFfiBindings _bindings;
  final BarcodeContentClassifier _classifier;

  NativeBarcodeReader(
    this._bindings, {
    this._classifier = const BarcodeContentClassifier(),
  });

  /// Version of the native bridge and vendored decoder.
  String get version => _bindings.version().cast<Utf8>().toDartString();

  /// Decodes [request]. Returns an empty list on any failure.
  List<ScannedCode> read(DecodeRequest request) {
    if (request.pixels.isEmpty || request.formatMask == 0) return const [];

    final buffer = malloc<Uint8>(request.pixels.length);
    Pointer<SrbResult> result = nullptr;
    try {
      buffer.asTypedList(request.pixels.length).setAll(0, request.pixels);
      result = _bindings.read(
        buffer,
        request.pixels.length,
        request.width,
        request.height,
        request.rowStride,
        request.imageFormat,
        request.rotationDegrees,
        request.formatMask,
        _optionsFor(request),
        request.maxSymbols,
      );
      if (result == nullptr || result.ref.error != SrbError.ok) {
        return const [];
      }
      return _convert(result.ref);
    } finally {
      if (result != nullptr) _bindings.free(result);
      malloc.free(buffer);
    }
  }

  int _optionsFor(DecodeRequest request) {
    var options = request.tryInvert ? SrbOption.tryInvert : 0;
    switch (request.profile) {
      case DecodeProfile.fast:
        options |= SrbOption.tryDownscale;
      case DecodeProfile.live:
        options |=
            SrbOption.tryHarder | SrbOption.tryRotate | SrbOption.tryDownscale;
      case DecodeProfile.thorough:
        options |=
            SrbOption.tryHarder |
            SrbOption.tryRotate |
            SrbOption.tryDownscale |
            SrbOption.tryInvert;
    }
    return options;
  }

  List<ScannedCode> _convert(SrbResult result) {
    final codes = <ScannedCode>[];
    for (var i = 0; i < result.count; i++) {
      final code = (result.codes + i).ref;
      final format = CodeFormat.fromNativeBit(code.format);
      final text = code.text == nullptr || code.textLength <= 0
          ? ''
          : utf8.decode(
              code.text.asTypedList(code.textLength),
              allowMalformed: true,
            );
      final bytes = code.bytes == nullptr || code.bytesLength <= 0
          ? null
          : Uint8List.fromList(code.bytes.asTypedList(code.bytesLength));
      final corners = List<Offset>.generate(
        4,
        (c) => Offset(
          code.corners[c * 2].toDouble(),
          code.corners[c * 2 + 1].toDouble(),
        ),
        growable: false,
      );
      codes.add(
        ScannedCode(
          rawValue: text,
          rawBytes: bytes,
          format: format,
          type: _classifier.classify(text, format),
          corners: corners,
        ),
      );
    }
    return codes;
  }
}
