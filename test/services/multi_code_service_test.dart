import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/models/visible_barcode.dart';
import 'package:sreerajp_qr_studio/services/multi_code_service.dart';
import 'package:sreerajp_qr_studio/models/code_format.dart';
import 'package:sreerajp_qr_studio/models/code_content_type.dart';

void main() {
  group('MultiCodeService Unit Tests', () {
    late MultiCodeService service;

    setUp(() {
      service = MultiCodeService();
    });

    test(
      'convertFrameToScreenOffset scales points correctly with BoxFit.cover',
      () {
        const framePoint = Offset(360, 640);
        const frameSize = Size(720, 1280);
        const screenSize = Size(360, 640);

        final result = service.convertFrameToScreenOffset(
          framePoint: framePoint,
          frameSize: frameSize,
          screenSize: screenSize,
        );

        expect(result.dx, 180.0);
        expect(result.dy, 320.0);
      },
    );

    test('projectCornersToScreen converts corner list', () {
      const corners = [
        Offset(0, 0),
        Offset(720, 0),
        Offset(720, 1280),
        Offset(0, 1280),
      ];
      const frameSize = Size(720, 1280);
      const screenSize = Size(360, 640);

      final result = service.projectCornersToScreen(
        corners: corners,
        frameSize: frameSize,
        screenSize: screenSize,
      );

      expect(result.length, 4);
      expect(result[0], const Offset(0, 0));
      expect(result[1], const Offset(360, 0));
      expect(result[2], const Offset(360, 640));
      expect(result[3], const Offset(0, 640));
    });

    test('projectFrameToScreenRect expands to minTouchTargetSize for small targets', () {
      const smallRect = Rect.fromLTWH(100, 100, 10, 10);
      const frameSize = Size(1000, 1000);
      const screenSize = Size(1000, 1000);

      final projected = service.projectFrameToScreenRect(
        frameRect: smallRect,
        frameSize: frameSize,
        screenSize: screenSize,
      );

      expect(
        projected.width,
        greaterThanOrEqualTo(MultiCodeService.minTouchTargetSize),
      );
      expect(
        projected.height,
        greaterThanOrEqualTo(MultiCodeService.minTouchTargetSize),
      );
      expect(projected.center, const Offset(105, 105));
    });

    test('computeBoundingBox calculates enclosing rect from corners', () {
      const corners = [
        Offset(20, 40),
        Offset(120, 50),
        Offset(110, 180),
        Offset(15, 170),
      ];

      final box = service.computeBoundingBox(corners);
      expect(box.left, 15);
      expect(box.top, 40);
      expect(box.right, 120);
      expect(box.bottom, 180);
    });

    test('decayStaleBarcodes prunes items older than decayDuration', () {
      final now = DateTime.now();
      final fresh = VisibleBarcode(
        id: 'fresh',
        rawValue: 'fresh',
        format: CodeFormat.qrCode,
        type: CodeContentType.text,
        corners: const [],
        boundingBox: Rect.zero,
        screenRect: Rect.zero,
        lastSeen: now,
        isUrl: false,
        displayLabel: 'Code',
      );
      final stale = VisibleBarcode(
        id: 'stale',
        rawValue: 'stale',
        format: CodeFormat.qrCode,
        type: CodeContentType.text,
        corners: const [],
        boundingBox: Rect.zero,
        screenRect: Rect.zero,
        lastSeen: now.subtract(const Duration(seconds: 3)),
        isUrl: false,
        displayLabel: 'Code',
      );

      final filtered = service.decayStaleBarcodes([
        fresh,
        stale,
      ], decayDuration: const Duration(seconds: 2));

      expect(filtered.length, 1);
      expect(filtered.first.id, 'fresh');
    });

    test('getDisplayLabel returns appropriate labels', () {
      expect(
        service.getDisplayLabel(CodeContentType.url, 'https://example.com'),
        'URL',
      );
      expect(
        service.getDisplayLabel(CodeContentType.wifi, 'WIFI:S:Home;P:pass;;'),
        'Wi-Fi',
      );
      expect(
        service.getDisplayLabel(CodeContentType.contactInfo, 'BEGIN:VCARD'),
        'Contact',
      );
      expect(
        service.getDisplayLabel(CodeContentType.product, '123456789012'),
        'Product',
      );
      expect(
        service.getDisplayLabel(CodeContentType.text, 'upi://pay?pa=test@upi'),
        'UPI Pay',
      );
    });
  });
}
