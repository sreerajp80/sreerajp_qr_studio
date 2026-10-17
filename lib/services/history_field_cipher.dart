import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as enc;

/// Encrypts and decrypts one scan-history field (docs/security.md §6).
///
/// Format v2: `h2:` + base64url(nonce ‖ ciphertext ‖ tag), AES-256-GCM with a
/// new random 12-byte nonce for every value. The `h2:` prefix is the format
/// version.
///
/// Values without the prefix are legacy: they were written by the old
/// AES-CBC scheme with a key-derived fixed IV, or stored as plain text when
/// that scheme failed. They are only read, so old rows can be upgraded.
class HistoryFieldCipher {
  HistoryFieldCipher(List<int> keyBytes, {Random? random})
    : _key = enc.Key(Uint8List.fromList(_checkKey(keyBytes))),
      _legacyIv = enc.IV(
        Uint8List.fromList(List<int>.generate(16, (i) => keyBytes[i % 32])),
      ),
      _random = random ?? Random.secure();

  static const String formatPrefix = 'h2:';
  static const int nonceLength = 12;
  static const int tagLength = 16;

  final enc.Key _key;
  final enc.IV _legacyIv;
  final Random _random;

  static List<int> _checkKey(List<int> keyBytes) {
    if (keyBytes.length < 32) {
      throw ArgumentError('History key must be 32 bytes');
    }
    return keyBytes.take(32).toList();
  }

  /// True when [stored] is already in the current format (or empty).
  static bool isCurrentFormat(String stored) =>
      stored.isEmpty || stored.startsWith(formatPrefix);

  /// Encrypts [plainText]. Throws if encryption fails; never returns the
  /// plain text.
  String encrypt(String plainText) {
    if (plainText.isEmpty) return plainText;
    final nonce = Uint8List.fromList(
      List<int>.generate(nonceLength, (_) => _random.nextInt(256)),
    );
    final encrypter = enc.Encrypter(enc.AES(_key, mode: enc.AESMode.gcm));
    final sealed = encrypter.encrypt(plainText, iv: enc.IV(nonce)).bytes;
    final out = Uint8List(nonce.length + sealed.length)
      ..setAll(0, nonce)
      ..setAll(nonce.length, sealed);
    return '$formatPrefix${base64Url.encode(out)}';
  }

  /// Decrypts a stored value. A current-format value whose tag does not
  /// match (changed or damaged data, wrong key) throws.
  String decrypt(String stored) {
    if (stored.isEmpty) return stored;
    if (stored.startsWith(formatPrefix)) {
      final bytes = base64Url.decode(stored.substring(formatPrefix.length));
      if (bytes.length < nonceLength + tagLength) {
        throw const FormatException('History field is too short');
      }
      final encrypter = enc.Encrypter(enc.AES(_key, mode: enc.AESMode.gcm));
      return encrypter.decrypt(
        enc.Encrypted(Uint8List.sublistView(bytes, nonceLength)),
        iv: enc.IV(Uint8List.sublistView(bytes, 0, nonceLength)),
      );
    }
    return decryptLegacy(stored);
  }

  /// Reads a value written before format v2: old AES-CBC with the
  /// key-derived fixed IV, or plain text left by the old fallback.
  String decryptLegacy(String stored) {
    if (stored.isEmpty) return stored;
    try {
      final encrypter = enc.Encrypter(enc.AES(_key, mode: enc.AESMode.cbc));
      return encrypter.decrypt64(stored, iv: _legacyIv);
    } catch (_) {
      return stored;
    }
  }
}
