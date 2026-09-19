import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sreeraj_qr_reader/models/visible_barcode.dart';

void main() {
  group('VisibleBarcode Model Tests', () {
    final now = DateTime.now();

    test('constructs and holds properties correctly', () {
      final barcode = VisibleBarcode(
        id: 'test_123',
        rawValue: 'https://example.com',
        format: BarcodeFormat.qrCode,
        type: BarcodeType.url,
        corners: const [Offset(10, 10), Offset(100, 100)],
        boundingBox: const Rect.fromLTWH(10, 10, 90, 90),
        screenRect: const Rect.fromLTWH(20, 20, 180, 180),
        lastSeen: now,
        isUrl: true,
        displayLabel: 'URL',
      );

      expect(barcode.id, 'test_123');
      expect(barcode.rawValue, 'https://example.com');
      expect(barcode.format, BarcodeFormat.qrCode);
      expect(barcode.type, BarcodeType.url);
      expect(barcode.corners.length, 2);
      expect(barcode.boundingBox, const Rect.fromLTWH(10, 10, 90, 90));
      expect(barcode.screenRect, const Rect.fromLTWH(20, 20, 180, 180));
      expect(barcode.lastSeen, now);
      expect(barcode.isUrl, isTrue);
      expect(barcode.displayLabel, 'URL');
    });

    test(
      'toBarcode returns MobileScanner Barcode with matching properties',
      () {
        final barcode = VisibleBarcode(
          id: 'test_qr',
          rawValue: 'WIFI:S:MyNetwork;T:WPA;P:secret;;',
          format: BarcodeFormat.qrCode,
          type: BarcodeType.wifi,
          corners: const [Offset(0, 0), Offset(50, 50)],
          boundingBox: const Rect.fromLTWH(0, 0, 50, 50),
          screenRect: const Rect.fromLTWH(0, 0, 100, 100),
          lastSeen: now,
          isUrl: false,
          displayLabel: 'Wi-Fi',
        );

        final mbBarcode = barcode.toBarcode();
        expect(mbBarcode.rawValue, 'WIFI:S:MyNetwork;T:WPA;P:secret;;');
        expect(mbBarcode.format, BarcodeFormat.qrCode);
        expect(mbBarcode.corners, barcode.corners);
      },
    );

    test('copyWith updates properties correctly', () {
      final barcode = VisibleBarcode(
        id: 'item_1',
        rawValue: '12345678',
        format: BarcodeFormat.ean8,
        type: BarcodeType.product,
        corners: const [],
        boundingBox: Rect.zero,
        screenRect: Rect.zero,
        lastSeen: now,
        isUrl: false,
        displayLabel: 'Product',
      );

      final updated = barcode.copyWith(
        displayLabel: 'Barcode',
        screenRect: const Rect.fromLTWH(5, 5, 50, 50),
      );

      expect(updated.id, 'item_1');
      expect(updated.displayLabel, 'Barcode');
      expect(updated.screenRect, const Rect.fromLTWH(5, 5, 50, 50));
      expect(updated.rawValue, '12345678');
    });

    test('equality and hashCode verify correctly', () {
      final b1 = VisibleBarcode(
        id: 'id_1',
        rawValue: 'test',
        format: BarcodeFormat.qrCode,
        type: BarcodeType.text,
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
        format: BarcodeFormat.qrCode,
        type: BarcodeType.text,
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
