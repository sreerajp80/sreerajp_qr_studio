import 'dart:convert';
import 'dart:isolate';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:pointycastle/export.dart'
    show HMac, PBKDF2KeyDerivator, Pbkdf2Parameters, SHA256Digest;
import 'package:sreerajp_qr_studio/models/app_message.dart';
import 'package:sreerajp_qr_studio/models/backup_exception.dart';

/// Passphrase encryption for `.sreerajqr` backups and AirQR sync packages
/// (docs/security.md §6.3).
///
/// v2 fields: `kdf` (`pbkdf2-hmac-sha256`), `iterations`, `salt` (16 random
/// bytes), `nonce` (12 random bytes), `data` (AES-256-GCM ciphertext + tag),
/// all base64url. The slow key derivation runs in a background isolate.
///
/// [openLegacyV1] reads the old v1 scheme (key = SHA-256 of the passphrase,
/// IV = first 16 key bytes, AES-CBC) so old files still open; it is never
/// used to write.
class PassphraseCipher {
  PassphraseCipher({this._iterations = defaultIterations, Random? random})
    : _random = random ?? Random.secure();

  /// PBKDF2-HMAC-SHA256 iterations for new files (OWASP 2023 value).
  static const int defaultIterations = 600000;

  static const String kdfName = 'pbkdf2-hmac-sha256';
  static const int _minIterations = 10000;
  static const int _maxIterations = 10000000;
  static const int _saltLength = 16;
  static const int _nonceLength = 12;

  final int _iterations;
  final Random _random;

  /// Encrypts [plain] and returns the v2 fields to store next to a header.
  Future<Map<String, Object>> seal(String plain, String passphrase) async {
    final salt = _randomBytes(_saltLength);
    final nonce = _randomBytes(_nonceLength);
    final iterations = _iterations;
    final data = await Isolate.run(
      () => _sealSync(plain, passphrase, salt, nonce, iterations),
    );
    return {
      'kdf': kdfName,
      'iterations': iterations,
      'salt': base64Url.encode(salt),
      'nonce': base64Url.encode(nonce),
      'data': data,
    };
  }

  /// Decrypts the v2 fields of [container].
  ///
  /// Throws [BackupException] with `backupInvalidFormat` for broken fields
  /// and `backupWrongPassphrase` when the tag check fails (wrong passphrase
  /// or a changed file).
  Future<String> open(Map<String, dynamic> container, String passphrase) async {
    final iterations = container['iterations'];
    final saltB64 = container['salt'];
    final nonceB64 = container['nonce'];
    final data = container['data'];
    if (container['kdf'] != kdfName ||
        iterations is! int ||
        iterations < _minIterations ||
        iterations > _maxIterations ||
        saltB64 is! String ||
        nonceB64 is! String ||
        data is! String) {
      throw _invalidFormat;
    }
    final Uint8List salt;
    final Uint8List nonce;
    try {
      salt = base64Url.decode(saltB64);
      nonce = base64Url.decode(nonceB64);
    } catch (_) {
      throw _invalidFormat;
    }
    if (salt.length != _saltLength || nonce.length != _nonceLength) {
      throw _invalidFormat;
    }
    try {
      return await Isolate.run(
        () => _openSync(data, passphrase, salt, nonce, iterations),
      );
    } catch (_) {
      throw _wrongPassphrase;
    }
  }

  /// Reads a v1 ciphertext (old scheme). Throws `backupWrongPassphrase`.
  static String openLegacyV1(String encryptedB64, String passphrase) {
    final digest = sha256.convert(utf8.encode(passphrase));
    final key = enc.Key(Uint8List.fromList(digest.bytes));
    final iv = enc.IV(Uint8List.fromList(digest.bytes.sublist(0, 16)));
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));
    try {
      return encrypter.decrypt64(encryptedB64, iv: iv);
    } catch (_) {
      throw _wrongPassphrase;
    }
  }

  static const BackupException _invalidFormat = BackupException(
    AppMessage(AppMessageKey.backupInvalidFormat),
  );
  static const BackupException _wrongPassphrase = BackupException(
    AppMessage(AppMessageKey.backupWrongPassphrase),
  );

  static Uint8List _deriveKey(String passphrase, Uint8List salt, int it) {
    final derivator = PBKDF2KeyDerivator(HMac(SHA256Digest(), 64))
      ..init(Pbkdf2Parameters(salt, it, 32));
    return derivator.process(Uint8List.fromList(utf8.encode(passphrase)));
  }

  static String _sealSync(
    String plain,
    String passphrase,
    Uint8List salt,
    Uint8List nonce,
    int iterations,
  ) {
    final key = enc.Key(_deriveKey(passphrase, salt, iterations));
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.gcm));
    return base64Url.encode(encrypter.encrypt(plain, iv: enc.IV(nonce)).bytes);
  }

  static String _openSync(
    String sealed,
    String passphrase,
    Uint8List salt,
    Uint8List nonce,
    int iterations,
  ) {
    final key = enc.Key(_deriveKey(passphrase, salt, iterations));
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.gcm));
    return encrypter.decrypt(
      enc.Encrypted(base64Url.decode(sealed)),
      iv: enc.IV(nonce),
    );
  }

  Uint8List _randomBytes(int length) => Uint8List.fromList(
    List<int>.generate(length, (_) => _random.nextInt(256)),
  );
}
