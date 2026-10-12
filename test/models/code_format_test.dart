import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/models/code_content_type.dart';
import 'package:sreerajp_qr_studio/models/code_format.dart';

void main() {
  group('CodeFormat', () {
    test('native bits are unique single bits', () {
      final bits = <int>{};
      for (final format in CodeFormat.values) {
        if (format == CodeFormat.unknown) {
          expect(format.nativeBit, 0);
          continue;
        }
        expect(
          format.nativeBit & (format.nativeBit - 1),
          0,
          reason: format.name,
        );
        expect(bits.add(format.nativeBit), isTrue, reason: format.name);
      }
    });

    test('fromNativeBit round-trips and rejects unknown bits', () {
      for (final format in CodeFormat.allReadable) {
        expect(CodeFormat.fromNativeBit(format.nativeBit), format);
      }
      expect(CodeFormat.fromNativeBit(0), CodeFormat.unknown);
      expect(CodeFormat.fromNativeBit(1 << 30), CodeFormat.unknown);
      expect(CodeFormat.fromNativeBit(3), CodeFormat.unknown);
    });

    test('maskOf combines bits', () {
      expect(CodeFormat.maskOf(const []), 0);
      expect(
        CodeFormat.maskOf(const [CodeFormat.qrCode, CodeFormat.ean13]),
        CodeFormat.qrCode.nativeBit | CodeFormat.ean13.nativeBit,
      );
    });

    test('standard scan formats keep the ten formats the app always read', () {
      expect(CodeFormat.standardScanFormats, hasLength(10));
      expect(CodeFormat.standardScanFormats, contains(CodeFormat.qrCode));
      expect(CodeFormat.standardScanFormats, contains(CodeFormat.dataMatrix));
    });

    test('retail formats', () {
      expect(CodeFormat.ean13.isRetail, isTrue);
      expect(CodeFormat.upcE.isRetail, isTrue);
      expect(CodeFormat.qrCode.isRetail, isFalse);
      expect(CodeFormat.code128.isRetail, isFalse);
    });

    test('names used in ids stay stable', () {
      expect(CodeFormat.qrCode.name, 'qrCode');
      expect(CodeFormat.ean13.name, 'ean13');
      expect(CodeFormat.dataMatrix.name, 'dataMatrix');
    });
  });

  group('CodeContentType', () {
    test('names stored in history stay stable', () {
      expect(CodeContentType.values.map((t) => t.name).toList(), [
        'unknown',
        'contactInfo',
        'email',
        'isbn',
        'phone',
        'product',
        'sms',
        'text',
        'url',
        'wifi',
        'geo',
        'calendarEvent',
        'driverLicense',
      ]);
    });

    test('fromName', () {
      expect(CodeContentType.fromName('wifi'), CodeContentType.wifi);
      expect(CodeContentType.fromName('nope'), CodeContentType.unknown);
      expect(CodeContentType.fromName(null), CodeContentType.unknown);
    });
  });
}
