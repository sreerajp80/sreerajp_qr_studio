import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/models/app_message.dart';
import 'package:sreerajp_qr_studio/models/code_forge_config.dart';
import 'package:sreerajp_qr_studio/services/code_forge_service.dart';

void main() {
  group('CodeForgeService Tests', () {
    late CodeForgeService service;

    setUp(() {
      service = CodeForgeService();
    });

    test('buildPayloadString correctly formats plain text and URLs', () {
      const textConfig = CodeForgeConfig(rawContent: 'Simple Plain Text');
      expect(service.buildPayloadString(textConfig), 'Simple Plain Text');

      const urlConfig = CodeForgeConfig(
        payloadType: CodeForgePayloadType.url,
        rawContent: 'google.com',
      );
      expect(service.buildPayloadString(urlConfig), 'https://google.com');

      const fullUrlConfig = CodeForgeConfig(
        payloadType: CodeForgePayloadType.url,
        rawContent: 'http://example.com/page',
      );
      expect(
        service.buildPayloadString(fullUrlConfig),
        'http://example.com/page',
      );
    });

    test('buildPayloadString correctly formats Wi-Fi network payload', () {
      const wifiConfig = CodeForgeConfig(
        payloadType: CodeForgePayloadType.wifi,
        wifiSsid: 'MyHomeWiFi',
        wifiPassword: 'Secret;Password',
        wifiHidden: true,
      );

      final payload = service.buildPayloadString(wifiConfig);
      expect(payload, contains('WIFI:T:WPA;'));
      expect(payload, contains(r'S:MyHomeWiFi;P:Secret\;Password;H:true;;'));
    });

    test('buildPayloadString correctly formats Contact vCard', () {
      const vCardConfig = CodeForgeConfig(
        payloadType: CodeForgePayloadType.contactVCard,
        contactName: 'Alice Smith',
        contactPhone: '+1234567890',
        contactEmail: 'alice@example.com',
        contactOrg: 'Tech Corp',
      );

      final payload = service.buildPayloadString(vCardConfig);
      expect(payload, startsWith('BEGIN:VCARD'));
      expect(payload, contains('FN:Alice Smith'));
      expect(payload, contains('TEL:+1234567890'));
      expect(payload, contains('EMAIL:alice@example.com'));
      expect(payload, contains('ORG:Tech Corp'));
      expect(payload, endsWith('END:VCARD'));
    });

    test('buildPayloadString correctly formats UPI Payment string', () {
      const upiConfig = CodeForgeConfig(
        payloadType: CodeForgePayloadType.upiPayment,
        upiVpa: 'merchant@upi',
        upiName: 'Merchant Name',
        upiAmount: '500.00',
        upiNote: 'Coffee & Snack',
      );

      final payload = service.buildPayloadString(upiConfig);
      expect(payload, startsWith('upi://pay?'));
      expect(payload, contains('pa=merchant%40upi'));
      expect(payload, contains('pn=Merchant%20Name'));
      expect(payload, contains('am=500.00'));
      expect(payload, contains('tn=Coffee%20%26%20Snack'));
      expect(payload, contains('cu=INR'));
    });

    test('buildPayloadString correctly formats SMS and Email', () {
      const smsConfig = CodeForgeConfig(
        payloadType: CodeForgePayloadType.sms,
        smsPhone: '+919876543210',
        smsMessage: 'Hello from CodeForge',
      );
      expect(
        service.buildPayloadString(smsConfig),
        'smsto:+919876543210:Hello from CodeForge',
      );

      const emailConfig = CodeForgeConfig(
        payloadType: CodeForgePayloadType.email,
        emailTo: 'support@example.com',
        emailSubject: 'Bug Report',
        emailBody: 'Found an issue',
      );
      expect(
        service.buildPayloadString(emailConfig),
        'mailto:support@example.com?subject=Bug%20Report&body=Found%20an%20issue',
      );
    });

    test('validateContent validates inputs according to barcode rules', () {
      // Empty content fails
      const emptyConfig = CodeForgeConfig();
      expect(service.validateContent(emptyConfig), isNotNull);

      // Valid QR code passes
      const validQr = CodeForgeConfig(rawContent: 'Valid text');
      expect(service.validateContent(validQr), isNull);

      // Text QR code within 500 characters passes
      final normalTextQr = CodeForgeConfig(rawContent: 'A' * 500);
      expect(service.validateContent(normalTextQr), isNull);

      // Text QR code exceeding 500 characters fails
      final tooLongTextQr = CodeForgeConfig(rawContent: 'A' * 501);
      expect(service.validateContent(tooLongTextQr), isNotNull);

      // Wi-Fi requires SSID
      const invalidWifi = CodeForgeConfig(
        payloadType: CodeForgePayloadType.wifi,
      );
      expect(service.validateContent(invalidWifi), isNotNull);

      // EAN-13 validation via Barcode
      const validEan13 = CodeForgeConfig(
        barcodeType: CodeForgeBarcodeType.ean13,
        rawContent: '890123456789', // 12 digits
      );
      expect(service.validateContent(validEan13), isNull);

      const invalidEan13 = CodeForgeConfig(
        barcodeType: CodeForgeBarcodeType.ean13,
        rawContent: 'NOT-NUMBERS',
      );
      expect(service.validateContent(invalidEan13), isNotNull);
    });

    test('validateContent returns a localizable message key, not text', () {
      expect(
        service.validateContent(const CodeForgeConfig())?.key,
        AppMessageKey.codeForgeContentEmpty,
      );

      final tooLong = service.validateContent(
        CodeForgeConfig(rawContent: 'A' * 501),
      );
      expect(tooLong?.key, AppMessageKey.codeForgeTextTooLong);
      expect(tooLong?.args['max'], '500');

      expect(
        service
            .validateContent(
              const CodeForgeConfig(payloadType: CodeForgePayloadType.wifi),
            )
            ?.key,
        AppMessageKey.codeForgeWifiSsidRequired,
      );

      expect(
        service
            .validateContent(
              const CodeForgeConfig(
                payloadType: CodeForgePayloadType.upiPayment,
              ),
            )
            ?.key,
        AppMessageKey.codeForgeUpiVpaRequired,
      );

      final badEan = service.validateContent(
        const CodeForgeConfig(
          barcodeType: CodeForgeBarcodeType.ean13,
          rawContent: 'NOT-NUMBERS',
        ),
      );
      expect(badEan?.key, AppMessageKey.codeForgeBarcodeInvalid);
      expect(badEan?.args['detail'], isNotEmpty);
    });

    test('generateQrMatrix generates valid matrix and module count', () {
      final qrImage = service.generateQrMatrix('https://flutter.dev', 0);
      expect(qrImage, isNotNull);
      expect(qrImage!.moduleCount, greaterThanOrEqualTo(21));
    });

    test('generateBarcodeSvg produces valid SVG tags', () {
      const config = CodeForgeConfig(
        barcodeType: CodeForgeBarcodeType.code128,
        rawContent: 'CODE128-TEST',
      );
      final svg = service.generateBarcodeSvg(config);
      expect(svg, contains('<svg'));
      expect(svg, contains('</svg>'));
      expect(svg, contains('CODE128-TEST'));
    });

    test('generateQrSvg produces styled SVG markup', () {
      const config = CodeForgeConfig(
        rawContent: 'SVG-QR-TEST',
        patternShape: QrPatternShape.dots,
      );
      final svg = service.generateQrSvg(config);
      expect(svg, contains('<svg'));
      expect(svg, contains('<circle'));
      expect(svg, contains('</svg>'));
    });

    test(
      'renderQrToPngBytes returns PNG image bytes with valid magic header',
      () async {
        const config = CodeForgeConfig(rawContent: 'PNG-TEST-DATA');
        final bytes = await service.renderQrToPngBytes(config, size: 256);
        expect(bytes, isNotNull);
        expect(bytes!.length, greaterThan(100));
        // Verify PNG magic header: [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]
        expect(bytes[0], 0x89);
        expect(bytes[1], 0x50); // P
        expect(bytes[2], 0x4E); // N
        expect(bytes[3], 0x47); // G
      },
    );

    group('readTextFromFile tests', () {
      late Directory tempDir;

      setUp(() {
        tempDir = Directory.systemTemp.createTempSync('cf_test_');
      });

      tearDown(() {
        if (tempDir.existsSync()) {
          tempDir.deleteSync(recursive: true);
        }
      });

      test('successfully reads file within 500 characters', () async {
        final file = File('${tempDir.path}/short.txt');
        file.writeAsStringSync('Hello, world! This is a test file.');

        final result = await service.readTextFromFile(file.path);
        expect(result.isSuccess, isTrue);
        expect(result.wasTruncated, isFalse);
        expect(result.content, 'Hello, world! This is a test file.');
        expect(result.message?.key, AppMessageKey.codeForgeFileLoaded);
      });

      test(
        'truncates file exceeding 500 characters and sets wasTruncated',
        () async {
          final file = File('${tempDir.path}/long.txt');
          final longContent = 'A' * 600;
          file.writeAsStringSync(longContent);

          final result = await service.readTextFromFile(file.path);
          expect(result.isSuccess, isTrue);
          expect(result.wasTruncated, isTrue);
          expect(result.content?.length, 500);
          expect(result.content, 'A' * 500);
          expect(result.message?.key, AppMessageKey.codeForgeFileTruncated);
        },
      );

      test('returns error for empty file', () async {
        final file = File('${tempDir.path}/empty.txt');
        file.writeAsStringSync('   \n  ');

        final result = await service.readTextFromFile(file.path);
        expect(result.isSuccess, isFalse);
        expect(result.content, isNull);
        expect(result.message?.key, AppMessageKey.codeForgeFileEmpty);
      });

      test('returns error for non-existent file', () async {
        final result = await service.readTextFromFile(
          '${tempDir.path}/does_not_exist.txt',
        );
        expect(result.isSuccess, isFalse);
        expect(result.content, isNull);
        expect(result.message?.key, AppMessageKey.codeForgeFileReadError);
      });
    });
  });
}
