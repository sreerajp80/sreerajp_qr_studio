import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sreeraj_qr_reader/models/parsed_payload.dart';
import 'package:sreeraj_qr_reader/services/payload_action_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PayloadActionService connectToWifi Tests', () {
    const channel = MethodChannel('in.sreeraj.qr_reader/wifi');
    final log = <MethodCall>[];

    setUp(() {
      log.clear();
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
            log.add(methodCall);
            if (methodCall.method == 'connectWifi') {
              return true;
            }
            return null;
          });
    });

    tearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, null);
    });

    test(
      'invokes native platform channel with correct Wi-Fi parameters',
      () async {
        const wifi = WifiPayload(
          ssid: 'Office_Guest',
          password: 'securePassword123',
          securityType: 'WPA2',
          rawContent: 'WIFI:S:Office_Guest;T:WPA2;P:securePassword123;;',
        );

        final result = await PayloadActionService.connectToWifi(wifi);

        expect(result, isTrue);
        expect(log, hasLength(1));
        expect(log.first.method, 'connectWifi');
        expect(log.first.arguments, {
          'ssid': 'Office_Guest',
          'password': 'securePassword123',
          'securityType': 'WPA2',
          'isHidden': false,
        });
      },
    );

    test(
      'handles native channel exception gracefully without crashing',
      () async {
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
              throw PlatformException(
                code: 'UNAVAILABLE',
                message: 'Wi-Fi service unavailable',
              );
            });

        const wifi = WifiPayload(
          ssid: 'Home_Network',
          password: 'pass',
          isHidden: true,
          rawContent: 'WIFI:S:Home_Network;T:WPA;P:pass;H:true;;',
        );

        // Should not throw, should fall back safely
        final result = await PayloadActionService.connectToWifi(wifi);
        expect(result, isA<bool>());
      },
    );
  });

  group('PayloadActionService Smart Action Launchers', () {
    const launcherChannel = MethodChannel('plugins.flutter.io/url_launcher');
    final launcherLog = <MethodCall>[];

    setUp(() {
      launcherLog.clear();
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(launcherChannel, (
            MethodCall methodCall,
          ) async {
            launcherLog.add(methodCall);
            if (methodCall.method == 'canLaunch' ||
                methodCall.method == 'launch') {
              return true;
            }
            return null;
          });
    });

    tearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(launcherChannel, null);
    });

    String lastLaunchedUrl() {
      final launchCall = launcherLog.lastWhere(
        (c) => c.method == 'launch',
        orElse: () => const MethodCall('none', {}),
      );
      return (launchCall.arguments as Map)['url'] as String? ?? '';
    }

    test('sendEmail launches mailto with all parameters', () async {
      const email = EmailPayload(
        rawContent: 'mailto:dev@example.com',
        toAddress: 'dev@example.com',
        subject: 'Feedback',
        body: 'Great app',
        cc: 'cc@example.com',
        bcc: 'bcc@example.com',
      );

      final result = await PayloadActionService.sendEmail(email);

      expect(result, isTrue);
      final url = lastLaunchedUrl();
      expect(url, contains('mailto:dev@example.com'));
      expect(url, contains('subject=Feedback'));
      expect(url, contains('body=Great+app'));
      expect(url, contains('cc=cc%40example.com'));
      expect(url, contains('bcc=bcc%40example.com'));
    });

    test('dialPhone launches tel: URL', () async {
      const phone = PhonePayload(
        rawContent: 'tel:+1234567890',
        number: '+1234567890',
      );

      final result = await PayloadActionService.dialPhone(phone);

      expect(result, isTrue);
      expect(lastLaunchedUrl(), equals('tel:+1234567890'));
    });

    test('sendSms launches sms: URL with body', () async {
      const sms = SmsPayload(
        rawContent: 'sms:+9876543210',
        number: '+9876543210',
        body: 'Hello',
      );

      final result = await PayloadActionService.sendSms(sms);

      expect(result, isTrue);
      final url = lastLaunchedUrl();
      expect(url, contains('sms:+9876543210'));
      expect(url, contains('body=Hello'));
    });

    test('openAppLink launches deep link URI', () async {
      const appLink = AppLinkPayload(
        rawContent: 'https://wa.me/1234567890',
        appName: 'WhatsApp',
        deepLinkUri: 'https://wa.me/1234567890',
      );

      final result = await PayloadActionService.openAppLink(appLink);

      expect(result, isTrue);
      expect(lastLaunchedUrl(), equals('https://wa.me/1234567890'));
    });

    test('searchProduct launches Open Food Facts when specified', () async {
      const product = ProductBarcodePayload(
        rawContent: '8901030383424',
        code: '8901030383424',
        format: 'EAN-13',
      );

      final result = await PayloadActionService.searchProduct(product);

      expect(result, isTrue);
      expect(
        lastLaunchedUrl(),
        equals('https://world.openfoodfacts.org/product/8901030383424'),
      );
    });

    test('searchProduct launches Google Shopping when specified', () async {
      const product = ProductBarcodePayload(
        rawContent: '012345678905',
        code: '012345678905',
        format: 'UPC-A',
      );

      final result = await PayloadActionService.searchProduct(
        product,
        useOpenFoodFacts: false,
      );

      expect(result, isTrue);
      expect(
        lastLaunchedUrl(),
        equals('https://www.google.com/search?q=012345678905+barcode'),
      );
    });

    test('lookupBook launches Google Books when specified', () async {
      const isbn = IsbnPayload(
        rawContent: '9780306406157',
        isbn: '9780306406157',
        isIsbn13: true,
      );

      final result = await PayloadActionService.lookupBook(isbn);

      expect(result, isTrue);
      expect(
        lastLaunchedUrl(),
        equals('https://books.google.com/books?vid=ISBN9780306406157'),
      );
    });

    test('lookupBook launches Open Library when specified', () async {
      const isbn = IsbnPayload(
        rawContent: '0306406152',
        isbn: '0306406152',
        isIsbn13: false,
      );

      final result = await PayloadActionService.lookupBook(
        isbn,
        useGoogleBooks: false,
      );

      expect(result, isTrue);
      expect(
        lastLaunchedUrl(),
        equals('https://openlibrary.org/isbn/0306406152'),
      );
    });
  });
}
