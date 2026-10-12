import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/models/parsed_payload.dart';
import 'package:sreerajp_qr_studio/services/payload_parser_service.dart';

void main() {
  group('PayloadParserService', () {
    late PayloadParserService parser;

    setUp(() {
      parser = PayloadParserService();
    });

    test('parses Wi-Fi QR payload correctly', () {
      const raw = 'WIFI:S:MyHomeWiFi;T:WPA;P:SuperSecret123;H:false;;';
      final payload = parser.parse(raw);

      expect(payload, isA<WifiPayload>());
      final wifi = payload as WifiPayload;
      expect(wifi.ssid, equals('MyHomeWiFi'));
      expect(wifi.securityType, equals('WPA'));
      expect(wifi.password, equals('SuperSecret123'));
      expect(wifi.isHidden, isFalse);
    });

    test('parses vCard contact payload correctly', () {
      const raw = '''
BEGIN:VCARD
VERSION:3.0
FN:Sreeraj P
TEL;TYPE=CELL:+1234567890
EMAIL:sreeraj@example.com
ORG:Deepmind
TITLE:Engineer
END:VCARD
''';
      final payload = parser.parse(raw);

      expect(payload, isA<ContactPayload>());
      final contact = payload as ContactPayload;
      expect(contact.name, equals('Sreeraj P'));
      expect(contact.phones.length, equals(1));
      expect(contact.phones.first.value, equals('+1234567890'));
      expect(contact.emails.first.value, equals('sreeraj@example.com'));
      expect(contact.organization, equals('Deepmind'));
    });

    test('parses MeCard contact payload correctly', () {
      const raw = 'MECARD:N:Doe,John;TEL:9876543210;EMAIL:john@doe.com;;';
      final payload = parser.parse(raw);

      expect(payload, isA<ContactPayload>());
      final contact = payload as ContactPayload;
      expect(contact.name, equals('Doe John'));
      expect(contact.phones.first.value, equals('9876543210'));
      expect(contact.emails.first.value, equals('john@doe.com'));
    });

    test('parses Geographic location payload correctly', () {
      const raw = 'geo:37.7749,-122.4194?q=San+Francisco';
      final payload = parser.parse(raw);

      expect(payload, isA<GeoPayload>());
      final geo = payload as GeoPayload;
      expect(geo.latitude, equals(37.7749));
      expect(geo.longitude, equals(-122.4194));
      expect(geo.query, equals('San Francisco'));
    });

    test('parses Calendar iCal event payload correctly', () {
      const raw = '''
BEGIN:VCALENDAR
BEGIN:VEVENT
SUMMARY:Team Sync Meeting
LOCATION:Conference Room A
DTSTART:20260731T090000Z
DTEND:20260731T100000Z
END:VEVENT
END:VCALENDAR
''';
      final payload = parser.parse(raw);

      expect(payload, isA<CalendarPayload>());
      final cal = payload as CalendarPayload;
      expect(cal.summary, equals('Team Sync Meeting'));
      expect(cal.location, equals('Conference Room A'));
      expect(cal.dtStart, equals(DateTime(2026, 7, 31, 9)));
      expect(cal.dtEnd, equals(DateTime(2026, 7, 31, 10)));
    });

    test('parses UPI Payment payload correctly', () {
      const raw =
          'upi://pay?pa=merchant@upi&pn=Store%20Name&am=150.00&cu=INR&tn=Order123';
      final payload = parser.parse(raw);

      expect(payload, isA<PaymentPayload>());
      final payment = payload as PaymentPayload;
      expect(payment.scheme, equals(PaymentScheme.upi));
      expect(payment.payeeAddress, equals('merchant@upi'));
      expect(payment.payeeName, equals('Store Name'));
      expect(payment.amount, equals('150.00'));
      expect(payment.currency, equals('INR'));
    });

    test('parses Crypto Payment payload correctly', () {
      const raw =
          'bitcoin:1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa?amount=0.05&label=Satoshi';
      final payload = parser.parse(raw);

      expect(payload, isA<PaymentPayload>());
      final payment = payload as PaymentPayload;
      expect(payment.scheme, equals(PaymentScheme.crypto));
      expect(
        payment.payeeAddress,
        equals('1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa'),
      );
      expect(payment.amount, equals('0.05'));
      expect(payment.currency, equals('BITCOIN'));
    });

    test('parses 2FA TOTP payload correctly', () {
      const raw =
          'otpauth://totp/Google:user@gmail.com?secret=JBSWY3DPEHPK3PXP&issuer=Google';
      final payload = parser.parse(raw);

      expect(payload, isA<TotpPayload>());
      final totp = payload as TotpPayload;
      expect(totp.issuer, equals('Google'));
      expect(totp.accountName, equals('user@gmail.com'));
      expect(totp.secret, equals('JBSWY3DPEHPK3PXP'));
      expect(totp.digits, equals(6));
      expect(totp.period, equals(30));
    });

    test('parses mailto: email payload with parameters correctly', () {
      const raw =
          'mailto:developer@example.com?subject=Bug%20Report&body=App%20crash&cc=team@example.com';
      final payload = parser.parse(raw);

      expect(payload, isA<EmailPayload>());
      final email = payload as EmailPayload;
      expect(email.toAddress, equals('developer@example.com'));
      expect(email.subject, equals('Bug Report'));
      expect(email.body, equals('App crash'));
      expect(email.cc, equals('team@example.com'));
    });

    test('parses MATMSG: email payload correctly', () {
      const raw = 'MATMSG:TO:user@example.com;SUB:Hello;BODY:World;;';
      final payload = parser.parse(raw);

      expect(payload, isA<EmailPayload>());
      final email = payload as EmailPayload;
      expect(email.toAddress, equals('user@example.com'));
      expect(email.subject, equals('Hello'));
      expect(email.body, equals('World'));
    });

    test('parses raw email address string as EmailPayload fallback', () {
      const raw = 'sreeraj.dev@example.com';
      final payload = parser.parse(raw);

      expect(payload, isA<EmailPayload>());
      final email = payload as EmailPayload;
      expect(email.toAddress, equals('sreeraj.dev@example.com'));
    });

    test('parses tel: phone payload correctly', () {
      const raw = 'tel:+1234567890';
      final payload = parser.parse(raw);

      expect(payload, isA<PhonePayload>());
      final phone = payload as PhonePayload;
      expect(phone.number, equals('+1234567890'));
    });

    test('parses raw international phone number as PhonePayload fallback', () {
      const raw = '+91 98765 43210';
      final payload = parser.parse(raw);

      expect(payload, isA<PhonePayload>());
      final phone = payload as PhonePayload;
      expect(phone.number, equals('+91 98765 43210'));
    });

    test('parses sms: payload with body correctly', () {
      const raw = 'sms:+1234567890?body=Hello%20Friend';
      final payload = parser.parse(raw);

      expect(payload, isA<SmsPayload>());
      final sms = payload as SmsPayload;
      expect(sms.number, equals('+1234567890'));
      expect(sms.body, equals('Hello Friend'));
    });

    test('parses SMSTO: payload correctly', () {
      const raw = 'SMSTO:+9876543210:Meeting at 5pm';
      final payload = parser.parse(raw);

      expect(payload, isA<SmsPayload>());
      final sms = payload as SmsPayload;
      expect(sms.number, equals('+9876543210'));
      expect(sms.body, equals('Meeting at 5pm'));
    });

    test('parses mms: payload correctly', () {
      const raw = 'mms:+1122334455?body=Photo%20update';
      final payload = parser.parse(raw);

      expect(payload, isA<SmsPayload>());
      final sms = payload as SmsPayload;
      expect(sms.number, equals('+1122334455'));
      expect(sms.body, equals('Photo update'));
    });

    test('parses Play Store market URI as AppLinkPayload', () {
      const raw = 'market://details?id=in.sreerajp.qr_studio';
      final payload = parser.parse(raw);

      expect(payload, isA<AppLinkPayload>());
      final app = payload as AppLinkPayload;
      expect(app.packageId, equals('in.sreerajp.qr_studio'));
      expect(app.storeName, equals(AppStoreName.playStore));
    });

    test('parses WhatsApp link as AppLinkPayload', () {
      const raw = 'https://wa.me/1234567890';
      final payload = parser.parse(raw);

      expect(payload, isA<AppLinkPayload>());
      final app = payload as AppLinkPayload;
      expect(app.appName, equals('WhatsApp'));
      expect(app.storeName, equals(AppStoreName.whatsApp));
    });

    test('parses Telegram link as AppLinkPayload', () {
      const raw = 'https://t.me/example_channel';
      final payload = parser.parse(raw);

      expect(payload, isA<AppLinkPayload>());
      final app = payload as AppLinkPayload;
      expect(app.appName, equals('Telegram'));
      expect(app.storeName, equals(AppStoreName.telegram));
    });

    test('parses YouTube link as AppLinkPayload', () {
      const raw = 'https://youtube.com/watch?v=dQw4w9WgXcQ';
      final payload = parser.parse(raw);

      expect(payload, isA<AppLinkPayload>());
      final app = payload as AppLinkPayload;
      expect(app.appName, equals('YouTube'));
      expect(app.storeName, equals(AppStoreName.youTube));
    });

    test('parses valid ISBN-13 payload correctly', () {
      const raw = '978-0-306-40615-7';
      final payload = parser.parse(raw);

      expect(payload, isA<IsbnPayload>());
      final isbn = payload as IsbnPayload;
      expect(isbn.isbn, equals('9780306406157'));
      expect(isbn.isIsbn13, isTrue);
    });

    test('parses valid ISBN-10 payload correctly', () {
      const raw = '0-306-40615-2';
      final payload = parser.parse(raw);

      expect(payload, isA<IsbnPayload>());
      final isbn = payload as IsbnPayload;
      expect(isbn.isbn, equals('0306406152'));
      expect(isbn.isIsbn13, isFalse);
    });

    test('rejects invalid ISBN checksum', () {
      const raw = '978-0-306-40615-9'; // Wrong check digit
      final payload = parser.parse(raw);

      expect(payload is IsbnPayload, isFalse);
    });

    test('parses valid EAN-13 product barcode correctly', () {
      const raw = '8901030383424';
      final payload = parser.parse(raw);

      expect(payload, isA<ProductBarcodePayload>());
      final product = payload as ProductBarcodePayload;
      expect(product.code, equals('8901030383424'));
      expect(product.format, equals('EAN-13'));
    });

    test('parses valid UPC-A retail barcode correctly', () {
      const raw = '012345678905';
      final payload = parser.parse(raw);

      expect(payload, isA<ProductBarcodePayload>());
      final product = payload as ProductBarcodePayload;
      expect(product.code, equals('012345678905'));
      expect(product.format, equals('UPC-A'));
    });

    test('parses valid EAN-8 product barcode correctly', () {
      const raw = '96385074';
      final payload = parser.parse(raw);

      expect(payload, isA<ProductBarcodePayload>());
      final product = payload as ProductBarcodePayload;
      expect(product.code, equals('96385074'));
      expect(product.format, equals('EAN-8'));
    });

    test('falls back to GenericPayload for plain text', () {
      const raw = 'Hello Sreeraj QR Reader';
      final payload = parser.parse(raw);

      expect(payload, isA<GenericPayload>());
      expect(payload.rawContent, equals(raw));
    });
  });
}
