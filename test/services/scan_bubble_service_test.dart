import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/services/scan_bubble_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('in.sreerajp.qr_studio/scan_bubble');
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  final calls = <MethodCall>[];
  late ScanBubbleService service;

  setUp(() {
    calls.clear();
    service = ScanBubbleService(channel: channel);
  });

  tearDown(() {
    messenger.setMockMethodCallHandler(channel, null);
  });

  void mockReturning(Object? value) {
    messenger.setMockMethodCallHandler(channel, (call) async {
      calls.add(call);
      return value;
    });
  }

  test('passes platform results through', () async {
    mockReturning(true);
    expect(await service.canDrawOverlays(), isTrue);
    expect(await service.startBubble(), isTrue);
    expect(await service.stopBubble(), isTrue);
    expect(await service.isBubbleRunning(), isTrue);
    expect(await service.isStartOnBoot(), isTrue);
    expect(await service.isTileRequestSupported(), isTrue);
    expect(await service.requestAddTile(), isTrue);
    expect(await service.openOverlayPermissionSettings(), isTrue);
    expect(calls.map((c) => c.method), [
      'canDrawOverlays',
      'startBubble',
      'stopBubble',
      'isBubbleRunning',
      'isStartOnBoot',
      'isTileRequestSupported',
      'requestAddTile',
      'openOverlayPermissionSettings',
    ]);
  });

  test('setStartOnBoot sends the value', () async {
    mockReturning(true);
    await service.setStartOnBoot(true);
    expect(calls.single.method, 'setStartOnBoot');
    expect(calls.single.arguments, {'value': true});
  });

  test('null result becomes false', () async {
    mockReturning(null);
    expect(await service.canDrawOverlays(), isFalse);
    expect(await service.startBubble(), isFalse);
  });

  test('platform errors become false and never throw', () async {
    messenger.setMockMethodCallHandler(channel, (call) async {
      throw PlatformException(code: 'TEST_ERROR');
    });
    expect(await service.canDrawOverlays(), isFalse);
    expect(await service.startBubble(), isFalse);
    expect(await service.setStartOnBoot(true), isFalse);
  });

  test('missing plugin becomes false', () async {
    expect(await service.isBubbleRunning(), isFalse);
    expect(await service.requestNotificationPermission(), isFalse);
  });
}
