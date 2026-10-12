import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/models/code_content_type.dart';
import 'package:sreerajp_qr_studio/models/code_format.dart';
import 'package:sreerajp_qr_studio/services/barcode_content_classifier.dart';

void main() {
  const classifier = BarcodeContentClassifier();

  CodeContentType qr(String value) =>
      classifier.classify(value, CodeFormat.qrCode);

  group('BarcodeContentClassifier', () {
    test('empty or null input is unknown', () {
      expect(
        classifier.classify(null, CodeFormat.qrCode),
        CodeContentType.unknown,
      );
      expect(qr(''), CodeContentType.unknown);
      expect(qr('   '), CodeContentType.unknown);
    });

    test('web links', () {
      expect(qr('https://example.com/a?b=c'), CodeContentType.url);
      expect(qr('HTTP://EXAMPLE.COM'), CodeContentType.url);
      expect(qr('URLTO:example.com'), CodeContentType.url);
      expect(
        qr('MEBKM:TITLE:x;URL:https://example.com;;'),
        CodeContentType.url,
      );
      expect(qr('www.example.co.in/path'), CodeContentType.url);
    });

    test('structured payloads', () {
      expect(qr('WIFI:T:WPA;S:home;P:secret;;'), CodeContentType.wifi);
      expect(
        qr('BEGIN:VCARD\nVERSION:3.0\nFN:A\nEND:VCARD'),
        CodeContentType.contactInfo,
      );
      expect(qr('MECARD:N:Doe,John;;'), CodeContentType.contactInfo);
      expect(
        qr('BEGIN:VEVENT\nSUMMARY:x\nEND:VEVENT'),
        CodeContentType.calendarEvent,
      );
      expect(
        qr('BEGIN:VCALENDAR\nBEGIN:VEVENT\nEND:VEVENT\nEND:VCALENDAR'),
        CodeContentType.calendarEvent,
      );
      expect(qr('mailto:a@b.com'), CodeContentType.email);
      expect(qr('MATMSG:TO:a@b.com;;'), CodeContentType.email);
      expect(qr('someone@example.org'), CodeContentType.email);
      expect(qr('tel:+911234567890'), CodeContentType.phone);
      expect(qr('SMSTO:+91123:hello'), CodeContentType.sms);
      expect(qr('sms:+91123'), CodeContentType.sms);
      expect(qr('geo:10.0,76.3'), CodeContentType.geo);
    });

    test('plain text and look-alikes stay text', () {
      expect(qr('hello world'), CodeContentType.text);
      expect(qr('upi://pay?pa=x@upi'), CodeContentType.text);
      expect(qr('not an email @ all'), CodeContentType.text);
      expect(qr('www. example .com'), CodeContentType.text);
    });

    test('retail formats are products, 978/979 EAN-13 is ISBN', () {
      expect(
        classifier.classify('9780306406157', CodeFormat.ean13),
        CodeContentType.isbn,
      );
      expect(
        classifier.classify('9791234567896', CodeFormat.ean13),
        CodeContentType.isbn,
      );
      expect(
        classifier.classify('4006381333931', CodeFormat.ean13),
        CodeContentType.product,
      );
      expect(
        classifier.classify('96385074', CodeFormat.ean8),
        CodeContentType.product,
      );
      expect(
        classifier.classify('036000291452', CodeFormat.upcA),
        CodeContentType.product,
      );
      expect(
        classifier.classify('01234565', CodeFormat.upcE),
        CodeContentType.product,
      );
    });

    test('a URL in a 1D barcode is still a URL', () {
      expect(
        classifier.classify('https://example.com', CodeFormat.code128),
        CodeContentType.url,
      );
    });

    test('AAMVA driver licence in PDF417', () {
      const aamva = '@\n\x1e\rANSI 636014040002DL00410278ZC03190008DLDAQ123';
      expect(
        classifier.classify(aamva, CodeFormat.pdf417),
        CodeContentType.driverLicense,
      );
      expect(
        classifier.classify(aamva, CodeFormat.qrCode),
        CodeContentType.text,
      );
    });

    test('never throws on hostile input', () {
      final inputs = [
        '\u0000\u0001\u0002',
        'https://' * 10000,
        '\uD800',
        '@' * 5,
        'WIFI:${';' * 5000}',
      ];
      for (final input in inputs) {
        expect(() => qr(input), returnsNormally);
      }
    });
  });
}
