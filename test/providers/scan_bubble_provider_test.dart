import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/providers/scan_bubble_provider.dart';
import 'package:sreerajp_qr_studio/services/scan_bubble_service.dart';

/// In-memory stand-in for the native Scan bubble.
class FakeScanBubbleService extends ScanBubbleService {
  bool permission;
  bool running = false;
  bool startOnBoot = false;
  bool startSucceeds = true;
  int permissionPageOpened = 0;
  int notificationRequests = 0;

  FakeScanBubbleService({this.permission = false});

  @override
  Future<bool> canDrawOverlays() async => permission;

  @override
  Future<bool> openOverlayPermissionSettings() async {
    permissionPageOpened++;
    return true;
  }

  @override
  Future<bool> startBubble() async {
    if (!permission || !startSucceeds) return false;
    running = true;
    return true;
  }

  @override
  Future<bool> stopBubble() async {
    running = false;
    return true;
  }

  @override
  Future<bool> isBubbleRunning() async => running;

  @override
  Future<bool> isStartOnBoot() async => startOnBoot;

  @override
  Future<bool> setStartOnBoot(bool value) async {
    startOnBoot = value;
    return true;
  }

  @override
  Future<bool> isTileRequestSupported() async => true;

  @override
  Future<bool> requestAddTile() async => true;

  @override
  Future<bool> requestNotificationPermission() async {
    notificationRequests++;
    return true;
  }
}

void main() {
  group('ScanBubbleProvider', () {
    test('starts off and not loaded', () {
      final provider = ScanBubbleProvider(service: FakeScanBubbleService());
      expect(provider.isRunning, isFalse);
      expect(provider.isLoaded, isFalse);
      expect(provider.startOnBoot, isFalse);
    });

    test('refresh reads platform state', () async {
      final fake = FakeScanBubbleService(permission: true)
        ..running = true
        ..startOnBoot = true;
      final provider = ScanBubbleProvider(service: fake);
      await provider.refresh();
      expect(provider.isLoaded, isTrue);
      expect(provider.isRunning, isTrue);
      expect(provider.hasOverlayPermission, isTrue);
      expect(provider.startOnBoot, isTrue);
      expect(provider.isTileRequestSupported, isTrue);
    });

    test('turnOn without permission asks for permission', () async {
      final fake = FakeScanBubbleService();
      final provider = ScanBubbleProvider(service: fake);
      final result = await provider.turnOn();
      expect(result, ScanBubbleStartResult.needsPermission);
      expect(provider.isRunning, isFalse);
      expect(fake.notificationRequests, 0);
    });

    test('turnOn with permission starts the bubble', () async {
      final fake = FakeScanBubbleService(permission: true);
      final provider = ScanBubbleProvider(service: fake);
      var notified = 0;
      provider.addListener(() => notified++);
      final result = await provider.turnOn();
      expect(result, ScanBubbleStartResult.started);
      expect(provider.isRunning, isTrue);
      expect(fake.running, isTrue);
      expect(fake.notificationRequests, 1);
      expect(notified, greaterThan(0));
    });

    test('turnOn reports failure when Android refuses', () async {
      final fake = FakeScanBubbleService(permission: true)
        ..startSucceeds = false;
      final provider = ScanBubbleProvider(service: fake);
      expect(await provider.turnOn(), ScanBubbleStartResult.failed);
      expect(provider.isRunning, isFalse);
    });

    test('turnOff stops the bubble', () async {
      final fake = FakeScanBubbleService(permission: true);
      final provider = ScanBubbleProvider(service: fake);
      await provider.turnOn();
      await provider.turnOff();
      expect(provider.isRunning, isFalse);
      expect(fake.running, isFalse);
    });

    test('setStartOnBoot saves and reloads the choice', () async {
      final fake = FakeScanBubbleService();
      final provider = ScanBubbleProvider(service: fake);
      await provider.setStartOnBoot(true);
      expect(provider.startOnBoot, isTrue);

      final reloaded = ScanBubbleProvider(service: fake);
      await reloaded.refresh();
      expect(reloaded.startOnBoot, isTrue);
    });

    test('openOverlayPermissionSettings opens the system page', () async {
      final fake = FakeScanBubbleService();
      final provider = ScanBubbleProvider(service: fake);
      await provider.openOverlayPermissionSettings();
      expect(fake.permissionPageOpened, 1);
    });
  });
}
