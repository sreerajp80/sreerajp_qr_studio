import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/services/history_field_cipher.dart';

/// Fixed test key: bytes 0..31.
final List<int> _key = List<int>.generate(32, (i) => i);

/// The exact pre-v2 scheme: AES-CBC, PKCS7, IV = first 16 key bytes.
String _legacyEncrypt(List<int> keyBytes, String plain) {
  final key = enc.Key(Uint8List.fromList(keyBytes.take(32).toList()));
  final iv = enc.IV(
    Uint8List.fromList(
      List<int>.generate(16, (i) => keyBytes[i % keyBytes.length]),
    ),
  );
  return enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc))
      .encrypt(plain, iv: iv)
      .base64;
}

String _flipByte(String stored, int index) {
  final bytes = base64Url.decode(stored.substring(3));
  bytes[index] ^= 0x01;
  return 'h2:${base64Url.encode(bytes)}';
}

void main() {
  final cipher = HistoryFieldCipher(_key);

  group('format v2 (AES-256-GCM)', () {
    test('round trips normal, Malayalam, Devanagari and long text', () {
      final samples = [
        'https://example.org/path?q=1',
        'മലയാളം സ്കാൻ',
        'संस्कृतम् पाठः',
        'x' * 200000,
      ];
      for (final plain in samples) {
        final stored = cipher.encrypt(plain);
        expect(stored, startsWith(HistoryFieldCipher.formatPrefix));
        expect(stored, isNot(contains(plain.substring(0, 5))));
        expect(cipher.decrypt(stored), plain);
      }
    });

    test('empty text stays empty', () {
      expect(cipher.encrypt(''), '');
      expect(cipher.decrypt(''), '');
    });

    test('the same text gives a different value each time', () {
      final a = cipher.encrypt('same scan');
      final b = cipher.encrypt('same scan');
      expect(a, isNot(b));
      expect(cipher.decrypt(a), cipher.decrypt(b));
    });

    test('stored value holds a 12-byte nonce and a 16-byte tag', () {
      final stored = cipher.encrypt('abc');
      final bytes = base64Url.decode(stored.substring(3));
      expect(bytes.length, 12 + 3 + 16);
    });

    test('a changed byte in the ciphertext or the tag is rejected', () {
      final stored = cipher.encrypt('do not change me');
      final length = base64Url.decode(stored.substring(3)).length;
      expect(() => cipher.decrypt(_flipByte(stored, 13)), throwsA(anything));
      expect(
        () => cipher.decrypt(_flipByte(stored, length - 1)),
        throwsA(anything),
      );
    });

    test('a wrong key is rejected', () {
      final stored = cipher.encrypt('secret');
      final other = HistoryFieldCipher(List<int>.generate(32, (i) => 255 - i));
      expect(() => other.decrypt(stored), throwsA(anything));
    });

    test('a too-short value is rejected', () {
      expect(() => cipher.decrypt('h2:AAAA'), throwsA(isA<FormatException>()));
    });

    test('a key shorter than 32 bytes is refused', () {
      expect(() => HistoryFieldCipher([1, 2, 3]), throwsArgumentError);
    });
  });

  group('legacy values', () {
    test('old AES-CBC fixed-IV values decrypt correctly', () {
      final legacy = _legacyEncrypt(_key, 'old scan text');
      expect(HistoryFieldCipher.isCurrentFormat(legacy), isFalse);
      expect(cipher.decrypt(legacy), 'old scan text');
      expect(cipher.decryptLegacy(legacy), 'old scan text');
    });

    test('plain text left by the old fallback is returned as is', () {
      expect(cipher.decrypt('plain fallback text'), 'plain fallback text');
    });
  });
}
