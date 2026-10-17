import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/models/parsed_payload.dart';
import 'package:sreerajp_qr_studio/services/payload_action_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PayloadActionService connectToWifi Tests', () {
    const channel = MethodChannel('in.sreerajp.qr_studio/wifi');
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

  group('PayloadActionService UPI amount helpers', () {
    PaymentPayload upi(String raw, {String amount = ''}) => PaymentPayload(
      rawContent: raw,
      scheme: PaymentScheme.upi,
      payeeName: 'Shop',
      payeeAddress: 'shop@bank',
      amount: amount,
    );

    test('upiNeedsAmount is true when amount is missing, zero or bad', () {
      for (final amount in ['', '0', '0.00', 'abc', '-5']) {
        expect(
          PayloadActionService.upiNeedsAmount(
            upi('upi://pay?pa=shop@bank', amount: amount),
          ),
          isTrue,
          reason: 'amount "$amount"',
        );
      }
    });

    test('upiNeedsAmount is false for a valid amount or non-UPI', () {
      expect(
        PayloadActionService.upiNeedsAmount(
          upi('upi://pay?pa=shop@bank&am=10', amount: '10'),
        ),
        isFalse,
      );
      for (final scheme in [PaymentScheme.sepa, PaymentScheme.crypto]) {
        expect(
          PayloadActionService.upiNeedsAmount(
            PaymentPayload(
              rawContent: 'bitcoin:abc',
              scheme: scheme,
              payeeName: '',
              payeeAddress: 'abc',
            ),
          ),
          isFalse,
        );
      }
    });

    test('isValidUpiAmount accepts 1 or more with up to 2 decimals', () {
      for (final ok in ['1', '1.5', '250.75', ' 99 ']) {
        expect(PayloadActionService.isValidUpiAmount(ok), isTrue, reason: ok);
      }
      for (final bad in ['', '0', '0.99', '-5', '1.234', 'abc', '1.', '.5']) {
        expect(
          PayloadActionService.isValidUpiAmount(bad),
          isFalse,
          reason: bad,
        );
      }
    });

    test('withUpiAmount appends am and keeps the rest unchanged', () {
      const raw =
          'upi://pay?pa=shop@bank&pn=POPULAR VEHICLES AND SERVICES&cu=INR';
      expect(
        PayloadActionService.withUpiAmount(raw, '50'),
        equals('$raw&am=50.00'),
      );
    });

    test('withUpiAmount replaces an empty or zero am value', () {
      expect(
        PayloadActionService.withUpiAmount(
          'upi://pay?pa=shop@bank&am=&cu=INR',
          '12.5',
        ),
        equals('upi://pay?pa=shop@bank&am=12.50&cu=INR'),
      );
      expect(
        PayloadActionService.withUpiAmount('upi://pay?am=0&pa=shop@bank', '7'),
        equals('upi://pay?am=7.00&pa=shop@bank'),
      );
    });

    test('withUpiAmount does not touch params that only end in am', () {
      expect(
        PayloadActionService.withUpiAmount('upi://pay?pa=x@y&tam=1', '5'),
        equals('upi://pay?pa=x@y&tam=1&am=5.00'),
      );
    });

    test('withUpiAmount keeps the link unchanged for a bad amount', () {
      const raw = 'upi://pay?pa=shop@bank&am=10&cu=INR';
      for (final amount in ['', 'abc', '1,5', 'NaN', 'Infinity']) {
        expect(PayloadActionService.withUpiAmount(raw, amount), equals(raw));
      }
    });
  });

  group('PayloadActionService payViaApp amount', () {
    const launcherChannel = MethodChannel('plugins.flutter.io/url_launcher');
    final launched = <String>[];

    setUp(() {
      launched.clear();
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(launcherChannel, (call) async {
            if (call.method == 'launch') {
              launched.add((call.arguments as Map)['url'] as String);
            }
            return true;
          });
    });

    tearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(launcherChannel, null);
    });

    test('adds the entered amount to a UPI link', () async {
      const payment = PaymentPayload(
        rawContent: 'upi://pay?pa=shop@bank&cu=INR',
        scheme: PaymentScheme.upi,
        payeeName: 'Shop',
        payeeAddress: 'shop@bank',
      );
      final ok = await PayloadActionService.payViaApp(payment, amount: '20');
      expect(ok, isTrue);
      expect(launched.last, contains('am=20.00'));
    });

    test('launches the scanned link unchanged without an amount', () async {
      const payment = PaymentPayload(
        rawContent: 'upi://pay?pa=shop@bank&am=10',
        scheme: PaymentScheme.upi,
        payeeName: 'Shop',
        payeeAddress: 'shop@bank',
        amount: '10',
      );
      await PayloadActionService.payViaApp(payment);
      expect(launched.last, endsWith('am=10'));
    });
  });
}
