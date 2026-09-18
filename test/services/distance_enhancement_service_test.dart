import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:sreeraj_qr_reader/models/distance_enhanced_scan_result.dart';
import 'package:sreeraj_qr_reader/services/distance_enhancement_service.dart';

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
}
