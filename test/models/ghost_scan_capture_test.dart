import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/models/ghost_scan_capture.dart';

void main() {
  group('GhostScanCapture.fromChannel', () {
    test('reads the older plain path string', () {
      final capture = GhostScanCapture.fromChannel('/cache/a.jpg');
      expect(capture, isNotNull);
      expect(capture!.imagePath, '/cache/a.jpg');
      expect(capture.fromBubble, isFalse);
      expect(capture.blocked, isFalse);
    });

    test('reads the map form with flags', () {
      final capture = GhostScanCapture.fromChannel({
        'imagePath': '/cache/b.jpg',
        'fromBubble': true,
        'blocked': true,
      });
      expect(capture, isNotNull);
      expect(capture!.imagePath, '/cache/b.jpg');
      expect(capture.fromBubble, isTrue);
      expect(capture.blocked, isTrue);
    });

    test('treats missing or wrong-typed flags as false', () {
      final capture = GhostScanCapture.fromChannel({
        'imagePath': '/cache/c.jpg',
        'fromBubble': 'yes',
      });
      expect(capture!.fromBubble, isFalse);
      expect(capture.blocked, isFalse);
    });

    test('returns null for bad input without throwing', () {
      expect(GhostScanCapture.fromChannel(null), isNull);
      expect(GhostScanCapture.fromChannel(''), isNull);
      expect(GhostScanCapture.fromChannel(42), isNull);
      expect(GhostScanCapture.fromChannel({'imagePath': ''}), isNull);
      expect(GhostScanCapture.fromChannel({'imagePath': 7}), isNull);
      expect(GhostScanCapture.fromChannel(<String, Object>{}), isNull);
    });
  });
}
