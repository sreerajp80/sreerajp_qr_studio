import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/core/logging/app_logger.dart';
import 'package:sreerajp_qr_studio/services/screen_security_service.dart';
import 'package:sreerajp_qr_studio/widgets/secure_screen.dart';

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
          expect(call.method, 'setSecure');
          calls.add((call.arguments as Map)['secure'] as bool);
          return true;
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('the flag stays on until the last secure screen closes', () async {
    await service.acquire();
    await service.acquire();
    expect(calls, [true]);
    await service.release();
    expect(calls, [true], reason: 'one secure screen is still open');
    await service.release();
    expect(calls, [true, false]);
    expect(service.openSecureScreens, 0);
  });

  test('an extra release does nothing', () async {
    await service.release();
    expect(calls, isEmpty);
    expect(service.openSecureScreens, 0);
  });

  test('when turned off, opening a secure screen sets no flag', () async {
    await service.setEnabled(false);
    await service.acquire();
    expect(calls, isEmpty);
    expect(service.openSecureScreens, 1);
    await service.release();
    expect(calls, isEmpty);
    expect(service.openSecureScreens, 0);
  });

  test('turning it off and on applies to an open secure screen', () async {
    await service.acquire();
    expect(calls, [true]);
    await service.setEnabled(false);
    expect(calls, [true, false]);
    await service.setEnabled(true);
    expect(calls, [true, false, true]);
    await service.release();
    expect(calls, [true, false, true, false]);
  });

  test(
    'changing the setting with no secure screen open sets no flag',
    () async {
      await service.setEnabled(false);
      await service.setEnabled(true);
      expect(calls, isEmpty);
    },
  );

  test('a platform error is logged, never thrown', () async {
    AppLogger.overrideForTesting(
      verbose: false,
      sink: (level, message, {error, stackTrace}) {},
    );
    addTearDown(AppLogger.resetForTesting);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          channel,
          (call) async => throw PlatformException(code: 'x'),
        );
    await expectLater(service.acquire(), completes);
  });

  testWidgets('SecureScreen turns the flag on while shown', (tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: SecureScreen(service: service, child: const SizedBox()),
      ),
    );
    await tester.pump();
    expect(calls, [true]);

    await tester.pumpWidget(const SizedBox());
    await tester.pump();
    expect(calls, [true, false]);
  });
}
