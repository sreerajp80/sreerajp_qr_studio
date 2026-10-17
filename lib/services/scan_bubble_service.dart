import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

/// Service for the floating Scan bubble (native overlay over other apps).
///
/// Wraps the `scan_bubble` platform channel. Every call is safe: on any
/// platform error it returns a neutral default and never throws.
class ScanBubbleService {
  static const MethodChannel _defaultChannel = MethodChannel(
    'in.sreerajp.qr_studio/scan_bubble',
  );

  final MethodChannel _channel;

  ScanBubbleService({MethodChannel? channel})
    : _channel = channel ?? _defaultChannel;

  Future<bool> _invokeBool(String method, [Object? arguments]) async {
    try {
      final bool? result = await _channel.invokeMethod<bool>(method, arguments);
      return result ?? false;
    } catch (_) {
      return false;
    }
  }

  /// True when the app may draw over other apps ("Display over other apps").
  Future<bool> canDrawOverlays() => _invokeBool('canDrawOverlays');

  /// Opens the system "Display over other apps" page for this app.
  Future<bool> openOverlayPermissionSettings() =>
      _invokeBool('openOverlayPermissionSettings');

  /// Shows the bubble. Returns false when the permission is missing.
  Future<bool> startBubble() => _invokeBool('startBubble');

  /// Removes the bubble.
  Future<bool> stopBubble() => _invokeBool('stopBubble');

  /// Stops the bubble and removes its native settings (on/off, start on
  /// boot, position). Used by "Delete all data".
  Future<bool> clearNativeData() => _invokeBool('clearData');

  /// True while the bubble is on screen.
  Future<bool> isBubbleRunning() => _invokeBool('isBubbleRunning');

  /// True when the bubble should come back after a phone restart.
  Future<bool> isStartOnBoot() => _invokeBool('isStartOnBoot');

  /// Saves the "Start after phone restart" choice.
  Future<bool> setStartOnBoot(bool value) =>
      _invokeBool('setStartOnBoot', {'value': value});

  /// True on Android 13+, where the app can ask to add its tile.
  Future<bool> isTileRequestSupported() =>
      _invokeBool('isTileRequestSupported');

  /// Asks Android to add the "Scan bubble" Quick Settings tile.
  Future<bool> requestAddTile() => _invokeBool('requestAddTile');

  /// Asks for the notification permission (Android 13+), so the
  /// "Scan bubble is on" notification with its Turn off button is visible.
  /// The bubble works without it; the result is only informative.
  Future<bool> requestNotificationPermission() async {
    try {
      final status = await Permission.notification.request();
      return status.isGranted;
    } catch (_) {
      return false;
    }
  }
}
