import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:sreeraj_qr_reader/models/distance_enhanced_scan_result.dart';

void main() {
  group('DistanceScanConfig Tests', () {
    test('default configuration parameters', () {
      const config = DistanceScanConfig();
      expect(config.zoomFactor, 2.5);
      expect(config.unsharpAmount, 1.5);
      expect(config.contrastBoost, 1.3);
      expect(config.cropPadding, 0.25);
      expect(config.autoZoom, true);
    });

    test('copyWith updates properties properly', () {
      const config = DistanceScanConfig();
      final updated = config.copyWith(
        zoomFactor: 3.5,
        unsharpAmount: 2.0,
        contrastBoost: 1.5,
        cropPadding: 0.3,
        autoZoom: false,
      );

      expect(updated.zoomFactor, 3.5);
      expect(updated.unsharpAmount, 2.0);
      expect(updated.contrastBoost, 1.5);
      expect(updated.cropPadding, 0.3);
      expect(updated.autoZoom, false);
    });
  });

  group('DistanceEnhancedScanResult Tests', () {
    test('success result instantiation', () {
      const result = DistanceEnhancedScanResult(
        success: true,
        rawValue: 'https://example.com/poster',
        format: 'qrCode',
        appliedZoom: 2.5,
        unsharpApplied: true,
        durationMs: 45,
      );

      expect(result.success, isTrue);
      expect(result.rawValue, 'https://example.com/poster');
      expect(result.format, 'qrCode');
      expect(result.appliedZoom, 2.5);
      expect(result.unsharpApplied, isTrue);
      expect(result.durationMs, 45);
    });

    test('failure factory result', () {
      final failure = DistanceEnhancedScanResult.failure(
        durationMs: 12,
        roiBounds: const Rect.fromLTWH(10, 10, 50, 50),
        appliedZoom: 3.0,
      );

      expect(failure.success, isFalse);
      expect(failure.rawValue, isNull);
      expect(failure.durationMs, 12);
      expect(failure.roiBounds, const Rect.fromLTWH(10, 10, 50, 50));
      expect(failure.appliedZoom, 3.0);
    });
  });

  group('ImagePixelBuffer Tests', () {
    test('empty creates all-zero buffer with correct size', () {
      final buffer = ImagePixelBuffer.empty(4, 4);
      expect(buffer.width, 4);
      expect(buffer.height, 4);
      expect(buffer.rgbaBytes.length, 4 * 4 * 4);
      expect(buffer.rgbaBytes.every((b) => b == 0), isTrue);
    });

    test('crop extracts sub-rectangle accurately', () {
      // 4x4 image with identifiable pixel colors
      final raw = Uint8List(4 * 4 * 4);
      for (int y = 0; y < 4; y++) {
        for (int x = 0; x < 4; x++) {
          final idx = (y * 4 + x) * 4;
          raw[idx] = x * 50; // R
          raw[idx + 1] = y * 50; // G
          raw[idx + 2] = 100; // B
          raw[idx + 3] = 255; // A
        }
      }

      final buffer = ImagePixelBuffer(width: 4, height: 4, rgbaBytes: raw);
      final cropped = buffer.crop(const Rect.fromLTWH(1, 1, 2, 2));

      expect(cropped.width, 2);
      expect(cropped.height, 2);
      // Top-left pixel of crop should correspond to (1,1) in source
      expect(cropped.rgbaBytes[0], 50); // x=1
      expect(cropped.rgbaBytes[1], 50); // y=1
      expect(cropped.rgbaBytes[2], 100);
      expect(cropped.rgbaBytes[3], 255);
    });

    test('scaleBilinear enlarges image dimensions', () {
      final raw = Uint8List(4 * 4 * 4);
      final buffer = ImagePixelBuffer(width: 4, height: 4, rgbaBytes: raw);
      final scaled = buffer.scaleBilinear(2.0);

      expect(scaled.width, 8);
      expect(scaled.height, 8);
      expect(scaled.rgbaBytes.length, 8 * 8 * 4);
    });

    test('applyContrast stretches dynamic range', () {
      final raw = Uint8List.fromList([
        100, 100, 100, 255, // dark-ish grey
        160, 160, 160, 255, // light-ish grey
        128, 128, 128, 255,
        128, 128, 128, 255,
      ]);
      final buffer = ImagePixelBuffer(width: 2, height: 2, rgbaBytes: raw);
      final boosted = buffer.applyContrast(contrast: 1.5);

      // (100 - 128) * 1.5 + 128 = -42 + 128 = 86
      expect(boosted.rgbaBytes[0], 86);
      // (160 - 128) * 1.5 + 128 = 48 + 128 = 176
      expect(boosted.rgbaBytes[4], 176);
    });

    test('applyUnsharpMask sharpens high frequency edge', () {
      // 5x5 image with center impulse/edge
      final raw = Uint8List(5 * 5 * 4);
      for (int i = 0; i < raw.length; i += 4) {
        raw[i] = 50;
        raw[i + 1] = 50;
        raw[i + 2] = 50;
        raw[i + 3] = 255;
      }
      // Center pixel is bright
      const centerIdx = (2 * 5 + 2) * 4;
      raw[centerIdx] = 200;
      raw[centerIdx + 1] = 200;
      raw[centerIdx + 2] = 200;

      final buffer = ImagePixelBuffer(width: 5, height: 5, rgbaBytes: raw);
      final sharpened = buffer.applyUnsharpMask();

      // Center bright pixel becomes even brighter / emphasized
      expect(sharpened.rgbaBytes[centerIdx], greaterThanOrEqualTo(200));
    });

    test('toBmpBytes produces valid 24-bit BMP header and file structure', () {
      final raw = Uint8List(10 * 10 * 4);
      // Fill with test red color
      for (int i = 0; i < raw.length; i += 4) {
        raw[i] = 255; // R
        raw[i + 1] = 0; // G
        raw[i + 2] = 0; // B
        raw[i + 3] = 255; // A
      }

      final buffer = ImagePixelBuffer(width: 10, height: 10, rgbaBytes: raw);
      final bmp = buffer.toBmpBytes();

      // Check BMP signature 'BM'
      expect(bmp[0], 0x42);
      expect(bmp[1], 0x4D);

      final byteData = ByteData.sublistView(bmp);
      final fileSize = byteData.getUint32(2, Endian.little);
      expect(fileSize, bmp.length);

      final offset = byteData.getUint32(10, Endian.little);
      expect(offset, 54);

      final headerSize = byteData.getUint32(14, Endian.little);
      expect(headerSize, 40);

      final width = byteData.getInt32(18, Endian.little);
      final height = byteData.getInt32(22, Endian.little);
      expect(width, 10);
      expect(height, 10);

      final bpp = byteData.getUint16(28, Endian.little);
      expect(bpp, 24);
    });
  });
}
