import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/models/app_message.dart';
import 'package:sreerajp_qr_studio/models/stego_qr_data.dart';

void main() {
  const locked = StegoQrData(
    decoyText: 'Hello',
    version: '1',
    salt: 'c2FsdA==',
    iv: 'aXY=',
    ciphertext: 'Y2lwaGVy',
  );

  test('starts locked with no payload or error', () {
    expect(locked.isUnlocked, isFalse);
    expect(locked.decryptedPayload, isNull);
    expect(locked.error, isNull);
  });

  test('copyWith changes only the given fields', () {
    final unlocked = locked.copyWith(
      isUnlocked: true,
      decryptedPayload: 'secret',
    );

    expect(unlocked.isUnlocked, isTrue);
    expect(unlocked.decryptedPayload, 'secret');
    expect(unlocked.decoyText, locked.decoyText);
    expect(unlocked.version, locked.version);
    expect(unlocked.salt, locked.salt);
    expect(unlocked.iv, locked.iv);
    expect(unlocked.ciphertext, locked.ciphertext);
    // The original is not changed.
    expect(locked.isUnlocked, isFalse);
    expect(locked.decryptedPayload, isNull);
  });

  test('copyWith with no arguments keeps every field', () {
    const error = AppMessage(AppMessageKey.formatQrWifi);
    final withError = locked.copyWith(error: error);
    final copy = withError.copyWith();

    expect(copy.error, same(error));
    expect(copy.decoyText, 'Hello');
    expect(copy.ciphertext, 'Y2lwaGVy');
  });
}
