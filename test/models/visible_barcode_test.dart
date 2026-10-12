import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/models/visible_barcode.dart';
import 'package:sreerajp_qr_studio/models/code_format.dart';
import 'package:sreerajp_qr_studio/models/code_content_type.dart';

void main() {
  group('VisibleBarcode Model Tests', () {
    final now = DateTime.now();

    test('constructs and holds properties correctly', () {
      final barcode = VisibleBarcode(
        id: 'test_123',
        rawValue: 'https://example.com',
        format: CodeFormat.qrCode,
        type: CodeContentType.url,
        corners: const [Offset(10, 10), Offset(100, 100)],
        boundingBox: const Rect.fromLTWH(10, 10, 90, 90),
        screenRect: const Rect.fromLTWH(20, 20, 180, 180),
        lastSeen: now,
        isUrl: true,
        displayLabel: 'URL',
      );

      expect(barcode.id, 'test_123');
      expect(barcode.rawValue, 'https://example.com');
      expect(barcode.format, CodeFormat.qrCode);
      expect(barcode.type, CodeContentType.url);
      expect(barcode.corners.length, 2);
      expect(barcode.boundingBox, const Rect.fromLTWH(10, 10, 90, 90));
      expect(barcode.screenRect, const Rect.fromLTWH(20, 20, 180, 180));
      expect(barcode.lastSeen, now);
      expect(barcode.isUrl, isTrue);
      expect(barcode.displayLabel, 'URL');
    });

    test(
      'toBarcode returns MobileScanner ScannedCode with matching properties',
      () {
        final barcode = VisibleBarcode(
          id: 'test_qr',
          rawValue: 'WIFI:S:MyNetwork;T:WPA;P:secret;;',
          format: CodeFormat.qrCode,
          type: CodeContentType.wifi,
          corners: const [Offset(0, 0), Offset(50, 50)],
          boundingBox: const Rect.fromLTWH(0, 0, 50, 50),
          screenRect: const Rect.fromLTWH(0, 0, 100, 100),
          lastSeen: now,
          isUrl: false,
          displayLabel: 'Wi-Fi',
        );

        final mbBarcode = barcode.toScannedCode();
        expect(mbBarcode.rawValue, 'WIFI:S:MyNetwork;T:WPA;P:secret;;');
        expect(mbBarcode.format, CodeFormat.qrCode);
        expect(mbBarcode.corners, barcode.corners);
      },
    );

    test('copyWith updates properties correctly', () {
      final barcode = VisibleBarcode(
        id: 'item_1',
        rawValue: '12345678',
        format: CodeFormat.ean8,
        type: CodeContentType.product,
        corners: const [],
        boundingBox: Rect.zero,
        screenRect: Rect.zero,
        lastSeen: now,
        isUrl: false,
        displayLabel: 'Product',
      );

      final updated = barcode.copyWith(
        displayLabel: 'ScannedCode',
        screenRect: const Rect.fromLTWH(5, 5, 50, 50),
      );

      expect(updated.id, 'item_1');
      expect(updated.displayLabel, 'ScannedCode');
      expect(updated.screenRect, const Rect.fromLTWH(5, 5, 50, 50));
      expect(updated.rawValue, '12345678');
    });

    test('equality and hashCode verify correctly', () {
      final b1 = VisibleBarcode(
        id: 'id_1',
        rawValue: 'test',
        format: CodeFormat.qrCode,
        type: CodeContentType.text,
        corners: const [],
        boundingBox: Rect.zero,
        screenRect: const Rect.fromLTWH(0, 0, 50, 50),
        lastSeen: now,
        isUrl: false,
        displayLabel: 'Code',
      );

      final b2 = VisibleBarcode(
        id: 'id_1',
        rawValue: 'test',
        format: CodeFormat.qrCode,
        type: CodeContentType.text,
        corners: const [],
        boundingBox: Rect.zero,
        screenRect: const Rect.fromLTWH(0, 0, 50, 50),
        lastSeen: now,
        isUrl: false,
        displayLabel: 'Code',
      );

      expect(b1, equals(b2));
      expect(b1.hashCode, equals(b2.hashCode));
    });
  });
}
