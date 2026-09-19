import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sreeraj_qr_reader/models/clipboard_scan_data.dart';
import 'package:sreeraj_qr_reader/services/clipboard_scan_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ClipboardScanService service;
  String? mockClipboardText;

  setUpAll(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, (call) async {
          if (call.method == 'Clipboard.setData') {
            final args = call.arguments as Map;
            mockClipboardText = args['text'] as String?;
            return null;
          } else if (call.method == 'Clipboard.getData') {
            if (mockClipboardText == null) return null;
            return {'text': mockClipboardText};
          }
          return null;
        });

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/path_provider'),
          (call) async {
            if (call.method == 'getTemporaryDirectory') {
              return Directory.systemTemp.path;
            }
            return null;
          },
        );
  });

  setUp(() {
    service = ClipboardScanService();
    mockClipboardText = null;
  });

  tearDown(() async {
    mockClipboardText = null;
  });

  group('ClipboardScanService - URLs', () {
    test('detects standard HTTPS URL', () async {
      await Clipboard.setData(
        const ClipboardData(text: 'https://flutter.dev/docs'),
      );

      final result = await service.checkClipboard();
      expect(result, isNotNull);
      expect(result!.type, equals(ClipboardContentType.url));
      expect(result.barcodeType, equals(BarcodeType.url));
      expect(result.content, equals('https://flutter.dev/docs'));
      expect(result.preview, equals('https://flutter.dev/docs'));
    });

    test('detects HTTP URL with query parameters', () async {
      await Clipboard.setData(
        const ClipboardData(text: 'http://example.com/search?q=qr+code&safe=1'),
      );

      final result = await service.checkClipboard();
      expect(result, isNotNull);
      expect(result!.type, equals(ClipboardContentType.url));
      expect(result.barcodeType, equals(BarcodeType.url));
      expect(
        result.content,
        equals('http://example.com/search?q=qr+code&safe=1'),
      );
    });
  });

  group('ClipboardScanService - Barcode Payloads', () {
    test('detects Wi-Fi network payload', () async {
      await Clipboard.setData(
        const ClipboardData(text: 'WIFI:S:MyNetwork;T:WPA;P:MySecretPass;;'),
      );

      final result = await service.checkClipboard();
      expect(result, isNotNull);
      expect(result!.type, equals(ClipboardContentType.barcodePayload));
      expect(result.barcodeType, equals(BarcodeType.wifi));
      expect(result.content, equals('WIFI:S:MyNetwork;T:WPA;P:MySecretPass;;'));
    });

    test('detects vCard contact payload', () async {
      const vcard =
          'BEGIN:VCARD\nVERSION:3.0\nN:Smith;Jane;;;\nFN:Jane Smith\nTEL:5551234\nEND:VCARD';
      await Clipboard.setData(const ClipboardData(text: vcard));

      final result = await service.checkClipboard();
      expect(result, isNotNull);
      expect(result!.type, equals(ClipboardContentType.barcodePayload));
      expect(result.barcodeType, equals(BarcodeType.contactInfo));
    });

    test('detects SMS payload', () async {
      await Clipboard.setData(
        const ClipboardData(text: 'SMSTO:+1987654321:Testing SMS payload'),
      );

      final result = await service.checkClipboard();
      expect(result, isNotNull);
      expect(result!.type, equals(ClipboardContentType.barcodePayload));
      expect(result.barcodeType, equals(BarcodeType.sms));
    });

    test('detects Email mailto: payload', () async {
      await Clipboard.setData(
        const ClipboardData(text: 'mailto:developer@example.com?subject=Hello'),
      );

      final result = await service.checkClipboard();
      expect(result, isNotNull);
      expect(result!.type, equals(ClipboardContentType.barcodePayload));
      expect(result.barcodeType, equals(BarcodeType.email));
    });

    test('detects Geographic coordinate payload', () async {
      await Clipboard.setData(
        const ClipboardData(text: 'geo:37.7749,-122.4194?q=San+Francisco'),
      );

      final result = await service.checkClipboard();
      expect(result, isNotNull);
      expect(result!.type, equals(ClipboardContentType.barcodePayload));
      expect(result.barcodeType, equals(BarcodeType.geo));
    });

    test('detects Phone tel: payload', () async {
      await Clipboard.setData(const ClipboardData(text: 'tel:+1234567890'));

      final result = await service.checkClipboard();
      expect(result, isNotNull);
      expect(result!.type, equals(ClipboardContentType.barcodePayload));
      expect(result.barcodeType, equals(BarcodeType.phone));
    });

    test('detects UPI payment payload', () async {
      await Clipboard.setData(
        const ClipboardData(
          text: 'upi://pay?pa=merchant@okhdfcbank&pn=Merchant&am=100',
        ),
      );

      final result = await service.checkClipboard();
      expect(result, isNotNull);
      expect(result!.type, equals(ClipboardContentType.barcodePayload));
    });

    test('detects 2FA / TOTP payload', () async {
      await Clipboard.setData(
        const ClipboardData(
          text:
              'otpauth://totp/Service:user@example.com?secret=JBSWY3DPEHPK3PXP&issuer=Service',
        ),
      );

      final result = await service.checkClipboard();
      expect(result, isNotNull);
      expect(result!.type, equals(ClipboardContentType.barcodePayload));
    });

    test('detects EAN-13 numeric product barcode', () async {
      await Clipboard.setData(const ClipboardData(text: '8901030383123'));

      final result = await service.checkClipboard();
      expect(result, isNotNull);
      expect(result!.type, equals(ClipboardContentType.barcodePayload));
      expect(result.barcodeType, equals(BarcodeType.product));
    });

    test('detects EAN-8 numeric barcode', () async {
      await Clipboard.setData(const ClipboardData(text: '96385074'));

      final result = await service.checkClipboard();
      expect(result, isNotNull);
      expect(result!.type, equals(ClipboardContentType.barcodePayload));
      expect(result.barcodeType, equals(BarcodeType.product));
    });
  });

  group('ClipboardScanService - Image Detection', () {
    test('detects base64 image data URI', () async {
      // 1x1 transparent PNG base64
      const base64Png =
          'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+M9QDwADhgGAWjR9awAAAABJRU5ErkJggg==';
      await Clipboard.setData(const ClipboardData(text: base64Png));

      final result = await service.checkClipboard();
      expect(result, isNotNull);
      expect(result!.type, equals(ClipboardContentType.image));
      expect(result.barcodeType, equals(BarcodeType.unknown));
      expect(result.content, endsWith('.png'));
      expect(File(result.content).existsSync(), isTrue);

      // Clean up temp file
      try {
        File(result.content).deleteSync();
      } catch (_) {}
    });

    test('detects existing local image file path', () async {
      final tempDir = Directory.systemTemp;
      final tempFile = File('${tempDir.path}/test_clipboard_image.jpg');
      await tempFile.writeAsBytes(utf8.encode('fake image bytes'));

      await Clipboard.setData(ClipboardData(text: tempFile.path));

      final result = await service.checkClipboard();
      expect(result, isNotNull);
      expect(result!.type, equals(ClipboardContentType.image));
      expect(result.content, equals(tempFile.path));

      try {
        tempFile.deleteSync();
      } catch (_) {}
    });
  });

  group('ClipboardScanService - Generic Text & Filtering', () {
    test(
      'ignores arbitrary plain text when includeGenericText is false',
      () async {
        await Clipboard.setData(
          const ClipboardData(text: 'Remember to pick up groceries at 5 PM'),
        );

        final result = await service.checkClipboard();
        expect(result, isNull);
      },
    );

    test('accepts plain text when includeGenericText is true', () async {
      await Clipboard.setData(
        const ClipboardData(text: 'Remember to pick up groceries at 5 PM'),
      );

      final result = await service.checkClipboard(includeGenericText: true);
      expect(result, isNotNull);
      expect(result!.type, equals(ClipboardContentType.text));
      expect(result.barcodeType, equals(BarcodeType.text));
      expect(result.content, equals('Remember to pick up groceries at 5 PM'));
    });

    test('returns null for empty or whitespace clipboard', () async {
      await Clipboard.setData(const ClipboardData(text: '   '));
      final result = await service.checkClipboard(includeGenericText: true);
      expect(result, isNull);
    });

    test('truncates long preview correctly', () async {
      final longText = 'A' * 100;
      await Clipboard.setData(ClipboardData(text: longText));

      final result = await service.checkClipboard(includeGenericText: true);
      expect(result, isNotNull);
      expect(result!.preview.length, equals(30));
      expect(result.preview.endsWith('...'), isTrue);
    });
  });
}
