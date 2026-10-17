import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sreerajp_qr_studio/providers/app_lock_provider.dart';

import '../helpers/fake_biometric_service.dart';

void main() {
  late SharedPreferences prefs;
  late FakeBiometricService biometric;
  late DateTime now;

  AppLockProvider provider() => AppLockProvider(
    prefs: prefs,
    biometricService: biometric,
    clock: () => now,
  );

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    biometric = FakeBiometricService();
    now = DateTime(2026, 10, 13, 12);
  });

  test('off by default and never locked', () {
    final lock = provider();
    expect(lock.enabled, isFalse);
    expect(lock.locked, isFalse);
  });

  test('enabling needs one successful authentication and is saved', () async {
    final lock = provider();
    expect(await lock.enable('reason'), AppLockChange.done);
    expect(lock.enabled, isTrue);
    expect(lock.locked, isFalse, reason: 'the user just authenticated');
    expect(prefs.getBool(AppLockProvider.prefKey), isTrue);
    expect(biometric.prompts, 1);
  });

  test('a failed authentication keeps it off', () async {
    biometric.succeeds = false;
    final lock = provider();
    expect(await lock.enable('reason'), AppLockChange.failed);
    expect(lock.enabled, isFalse);
  });

  test('no screen lock or biometrics: cannot enable', () async {
    biometric.available = false;
    final lock = provider();
    expect(await lock.enable('reason'), AppLockChange.unavailable);
    expect(lock.enabled, isFalse);
    expect(biometric.prompts, 0);
  });

  test('locked at start when enabled', () async {
    await prefs.setBool(AppLockProvider.prefKey, true);
    final lock = provider();
    expect(lock.locked, isTrue);
    expect(await lock.unlock('reason'), isTrue);
    expect(lock.locked, isFalse);
  });

  test(
    'locks after 30 seconds in the background, not after a short trip',
    () async {
      await prefs.setBool(AppLockProvider.prefKey, true);
      final lock = provider();
      await lock.unlock('reason');

      lock.onBackground();
      now = now.add(const Duration(seconds: 5));
      lock.onForeground();
      expect(lock.locked, isFalse, reason: 'a picker or share sheet trip');

      lock.onBackground();
      now = now.add(const Duration(seconds: 30));
      lock.onForeground();
      expect(lock.locked, isTrue);
    },
  );

  test('a failed unlock stays locked', () async {
    await prefs.setBool(AppLockProvider.prefKey, true);
    biometric.succeeds = false;
    final lock = provider();
    expect(await lock.unlock('reason'), isFalse);
    expect(lock.locked, isTrue);
  });

  test('disabling needs authentication', () async {
    await prefs.setBool(AppLockProvider.prefKey, true);
    final lock = provider();
    biometric.succeeds = false;
    expect(await lock.disable('reason'), AppLockChange.failed);
    expect(lock.enabled, isTrue);
    biometric.succeeds = true;
    expect(await lock.disable('reason'), AppLockChange.done);
    expect(lock.enabled, isFalse);
    expect(lock.locked, isFalse);
    expect(prefs.getBool(AppLockProvider.prefKey), isFalse);
  });
}
