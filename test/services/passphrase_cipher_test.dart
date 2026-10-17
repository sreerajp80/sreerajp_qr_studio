import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/models/backup_exception.dart';
import 'package:sreerajp_qr_studio/services/passphrase_cipher.dart';

void main() {
  final cipher = PassphraseCipher(iterations: 10000);

  test('default iteration count is 600,000', () {
    expect(PassphraseCipher.defaultIterations, 600000);
  });

  test(
    'seal writes 16-byte salt and 12-byte nonce; open reads it back',
    () async {
      final fields = await cipher.seal('മലയാളം संस्कृतम् text', 'pass');
      expect(fields['kdf'], PassphraseCipher.kdfName);
      expect(base64Url.decode(fields['salt']! as String), hasLength(16));
      expect(base64Url.decode(fields['nonce']! as String), hasLength(12));
      expect(await cipher.open(fields, 'pass'), 'മലയാളം संस्कृतम् text');
    },
  );

  test('wrong passphrase and broken fields throw BackupException', () async {
    final fields = await cipher.seal('secret', 'pass');
    await expectLater(
      cipher.open(fields, 'other'),
      throwsA(isA<BackupException>()),
    );
    await expectLater(
      cipher.open({...fields, 'salt': 'AAAA'}, 'pass'),
      throwsA(isA<BackupException>()),
    );
    await expectLater(
      cipher.open({...fields, 'kdf': 'md5'}, 'pass'),
      throwsA(isA<BackupException>()),
    );
  });

  test('legacy v1 with a wrong passphrase throws BackupException', () {
    expect(
      () => PassphraseCipher.openLegacyV1('AAAAAAAAAAAAAAAAAAAAAA==', 'x'),
      throwsA(isA<BackupException>()),
    );
  });
}
