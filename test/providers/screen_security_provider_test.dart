import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sreerajp_qr_studio/providers/screen_security_provider.dart';
import 'package:sreerajp_qr_studio/services/screen_security_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('test/window');
  late List<bool> calls;
  late ScreenSecurityService service;

  setUp(() {
    calls = [];
    service = ScreenSecurityService(channel: channel);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
          calls.add((call.arguments as Map)['secure'] as bool);
          return true;
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  Future<ScreenSecurityProvider> provider(Map<String, Object> values) async {
    SharedPreferences.setMockInitialValues(values);
    final prefs = await SharedPreferences.getInstance();
    return ScreenSecurityProvider(prefs: prefs, service: service);
  }

  test('on by default', () async {
    final guard = await provider({});
    expect(guard.enabled, isTrue);
    expect(service.enabled, isTrue);
  });

  test('loads a saved "off" and passes it to the service', () async {
    final guard = await provider({ScreenSecurityProvider.prefKey: false});
    expect(guard.enabled, isFalse);
    expect(service.enabled, isFalse);
  });

  test('setEnabled saves the choice and updates the service', () async {
    final guard = await provider({});
    await service.acquire();
    expect(calls, [true]);

    await guard.setEnabled(false);
    expect(guard.enabled, isFalse);
    expect(service.enabled, isFalse);
    expect(calls, [true, false]);
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getBool(ScreenSecurityProvider.prefKey), isFalse);

    await guard.setEnabled(true);
    expect(prefs.getBool(ScreenSecurityProvider.prefKey), isTrue);
    expect(calls, [true, false, true]);
  });

  test('notifies listeners on change', () async {
    final guard = await provider({});
    var notified = 0;
    guard.addListener(() => notified++);
    await guard.setEnabled(false);
    expect(notified, 1);
  });
}
