import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/models/code_content_type.dart';
import 'package:sreerajp_qr_studio/providers/scan_provider.dart';

void main() {
  group('ScanProvider QuishingGuard sticker reminder', () {
    late ScanProvider provider;

    setUp(() {
      provider = ScanProvider();
    });

    test('shows for a link read by the camera', () {
      provider.setScanResult(
        'https://example.com/pay',
        CodeContentType.url,
        fromCamera: true,
      );
      expect(provider.showStickerReminder, isTrue);
    });

    test('shows for a payment code read by the camera', () {
      provider.setScanResult(
        'upi://pay?pa=shop@bank&pn=Corner Shop&cu=INR',
        CodeContentType.text,
        fromCamera: true,
      );
      expect(provider.showStickerReminder, isTrue);
    });

    test('hidden for plain text read by the camera', () {
      provider.setScanResult(
        'Hello there',
        CodeContentType.text,
        fromCamera: true,
      );
      expect(provider.showStickerReminder, isFalse);
    });

    test('hidden for a link from a photo, clipboard or screen', () {
      provider.setScanResult('https://example.com/pay', CodeContentType.url);
      expect(provider.showStickerReminder, isFalse);
    });

    test('clearScan hides the reminder', () {
      provider.setScanResult(
        'https://example.com/pay',
        CodeContentType.url,
        fromCamera: true,
      );
      provider.clearScan();
      expect(provider.showStickerReminder, isFalse);
    });

    test('history records no longer carry a tamper level', () {
      provider.setScanResult(
        'https://example.com/pay',
        CodeContentType.url,
        fromCamera: true,
      );
      final record = provider.createScanRecord();
      expect(record, isNotNull);
      expect(record!.metadata?.containsKey('quishingRisk'), isFalse);
    });
  });
}
