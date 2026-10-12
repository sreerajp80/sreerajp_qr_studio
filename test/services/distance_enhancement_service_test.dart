import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/models/code_format.dart';
import 'package:sreerajp_qr_studio/models/decode_profile.dart';
import 'package:sreerajp_qr_studio/models/distance_enhanced_scan_result.dart';
import 'package:sreerajp_qr_studio/models/scanned_code.dart';
import 'package:sreerajp_qr_studio/services/barcode_decoder/barcode_decoder_service.dart';
import 'package:sreerajp_qr_studio/services/distance_enhancement_service.dart';

/// Decoder double: records RGBA sizes and returns [result] for RGBA input.
class _RgbaDecoder implements BarcodeDecoder {
  final List<ScannedCode> result;
  final List<Size> rgbaSizes = [];

  _RgbaDecoder(this.result);

  @override
  Future<List<ScannedCode>> decodeRgba(
    Uint8List rgba,
    int width,
    int height, {
    List<CodeFormat> formats = CodeFormat.allReadable,
    DecodeProfile profile = DecodeProfile.thorough,
    int maxSymbols = 8,
  }) async {
    rgbaSizes.add(Size(width.toDouble(), height.toDouble()));
    return result;
  }

  @override
  Future<List<ScannedCode>> decodePixels(DecodeRequest request) async =>
      const [];

  @override
  Future<List<ScannedCode>> decodeEncodedImage(
    Uint8List encoded, {
    List<CodeFormat> formats = CodeFormat.allReadable,
    DecodeProfile profile = DecodeProfile.thorough,
    int maxSymbols = 8,
  }) async => const [];

  @override
  Future<List<ScannedCode>> decodeImageFile(
    String path, {
    List<CodeFormat> formats = CodeFormat.allReadable,
    DecodeProfile profile = DecodeProfile.thorough,
    int maxSymbols = 8,
  }) async => const [];
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late DistanceEnhancementService service;

  setUp(() {
    service = const DistanceEnhancementService();
  });

  group('DistanceEnhancementService Tests', () {
    test('calculateCandidateRoi returns center box by default', () {
      const size = Size(1000, 1000);
      final roi = service.calculateCandidateRoi(size, defaultFraction: 0.4);

      expect(roi.width, 400);
      expect(roi.height, 400);
      expect(roi.left, 300);
      expect(roi.top, 300);
    });

    test('calculateCandidateRoi centers around tapFocus', () {
      const size = Size(1000, 1000);
      const tap = Offset(200, 200);
      final roi = service.calculateCandidateRoi(
        size,
        tapFocus: tap,
        defaultFraction: 0.3,
      );

      expect(roi.width, 300);
      expect(roi.height, 300);
      expect(roi.left, 50); // 200 - 150
      expect(roi.top, 50); // 200 - 150
    });

    test('calculateCandidateRoi builds expanded bounding box for corners', () {
      const size = Size(1000, 1000);
      final corners = [
        const Offset(100, 100),
        const Offset(200, 100),
        const Offset(200, 200),
        const Offset(100, 200),
      ];

      // Bounding box is 100x100. With default 0.25 padding: 25px added to each side.
      final roi = service.calculateCandidateRoi(size, corners: corners);

      expect(roi.left, 75);
      expect(roi.top, 75);
      expect(roi.right, 225);
      expect(roi.bottom, 225);
    });

    test(
      'enhancePixelBuffer runs full crop, zoom, contrast, and unsharp pipeline',
      () {
        final raw = Uint8List(100 * 100 * 4);
        for (int i = 0; i < raw.length; i += 4) {
          raw[i] = 120;
          raw[i + 1] = 120;
          raw[i + 2] = 120;
          raw[i + 3] = 255;
        }

        final source = ImagePixelBuffer(
          width: 100,
          height: 100,
          rgbaBytes: raw,
        );
        const roi = Rect.fromLTWH(20, 20, 40, 40);
        const config = DistanceScanConfig(zoomFactor: 2.0, cropPadding: 0.0);

        final enhanced = service.enhancePixelBuffer(source, roi, config);

        // Cropped 40x40 scaled 2.0x = 80x80
        expect(enhanced.width, 80);
        expect(enhanced.height, 80);
        expect(enhanced.rgbaBytes.length, 80 * 80 * 4);
      },
    );

    test('createPixelBuffer constructs pixel buffer correctly', () {
      final raw = Uint8List(2 * 2 * 4);
      final buffer = service.createPixelBuffer(
        width: 2,
        height: 2,
        rgbaBytes: raw,
      );

      expect(buffer.width, 2);
      expect(buffer.height, 2);
      expect(buffer.rgbaBytes.length, 16);
    });
  });

  group('Live camera distance assist', () {
    const crop = Rect.fromLTWH(55, 27, 90, 45);

    test('maps crop points back to the frame for every rotation', () {
      Offset map(int rotation) =>
          DistanceEnhancementService.mapCropPointToUprightFrame(
            const Offset(20, 10),
            crop: crop,
            scaleX: 2.0,
            scaleY: 2.0,
            frameWidth: 200,
            frameHeight: 100,
            rotationDegrees: rotation,
          );

      // Crop point (20, 10) at 2x = sensor point (65, 32).
      expect(map(0), const Offset(65, 32));
      expect(map(90), const Offset(68, 65));
      expect(map(180), const Offset(135, 68));
      expect(map(270), const Offset(32, 135));
    });

    test('crops the centre, enlarges it, and maps corners back', () async {
      final decoder = _RgbaDecoder(const [
        ScannedCode(
          rawValue: 'far away',
          format: CodeFormat.qrCode,
          corners: [Offset(20, 10)],
        ),
      ]);
      final service = DistanceEnhancementService(decoder: decoder);

      final codes = await service.processLuminanceFrame(
        luminance: Uint8List(200 * 100),
        width: 200,
        height: 100,
        rotationDegrees: 90,
        config: const DistanceScanConfig(zoomFactor: 2.0),
      );

      // Centre 45% of 200x100 is 90x45, enlarged 2x.
      expect(decoder.rgbaSizes.single, const Size(180, 90));
      expect(codes.single.rawValue, 'far away');
      expect(codes.single.corners.single, const Offset(68, 65));
    });

    test('caps the enlarged crop size', () async {
      final decoder = _RgbaDecoder(const []);
      final service = DistanceEnhancementService(decoder: decoder);

      await service.processLuminanceFrame(
        // Centre crop is 1800x45; 4x would be 7200 wide.
        luminance: Uint8List(4000 * 100),
        width: 4000,
        height: 100,
        config: const DistanceScanConfig(zoomFactor: 4.0),
      );

      final size = decoder.rgbaSizes.single;
      expect(
        size.longestSide,
        lessThanOrEqualTo(DistanceEnhancementService.liveAssistMaxSide),
      );
    });

    test('returns nothing for a buffer that is too small', () async {
      final decoder = _RgbaDecoder(const [ScannedCode(rawValue: 'x')]);
      final service = DistanceEnhancementService(decoder: decoder);

      final codes = await service.processLuminanceFrame(
        luminance: Uint8List(10),
        width: 200,
        height: 100,
      );

      expect(codes, isEmpty);
      expect(decoder.rgbaSizes, isEmpty);
    });
  });
}
