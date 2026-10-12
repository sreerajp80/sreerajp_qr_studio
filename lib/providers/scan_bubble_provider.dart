import 'package:flutter/foundation.dart';
import 'package:sreerajp_qr_studio/services/scan_bubble_service.dart';

/// Result of asking to turn the Scan bubble on.
enum ScanBubbleStartResult {
  /// The bubble is now on screen.
  started,

  /// "Display over other apps" is not allowed yet.
  needsPermission,

  /// Android refused to start the bubble.
  failed,
}

/// State for the floating Scan bubble settings.
///
/// The bubble can also be turned on or off from outside the app (Quick
/// Settings tile, notification, drag to close), so screens call [refresh]
/// when they are shown or resumed.
class ScanBubbleProvider extends ChangeNotifier {
  final ScanBubbleService _service;

  bool _isRunning = false;
  bool _hasOverlayPermission = false;
  bool _startOnBoot = false;
  bool _isTileRequestSupported = false;
  bool _isLoaded = false;

  ScanBubbleProvider({ScanBubbleService? service})
    : _service = service ?? ScanBubbleService();

  bool get isRunning => _isRunning;
  bool get hasOverlayPermission => _hasOverlayPermission;
  bool get startOnBoot => _startOnBoot;
  bool get isTileRequestSupported => _isTileRequestSupported;
  bool get isLoaded => _isLoaded;

  /// Reads the current state from the platform.
  Future<void> refresh() async {
    _hasOverlayPermission = await _service.canDrawOverlays();
    _isRunning = await _service.isBubbleRunning();
    _startOnBoot = await _service.isStartOnBoot();
    _isTileRequestSupported = await _service.isTileRequestSupported();
    _isLoaded = true;
    notifyListeners();
  }

  /// Tries to show the bubble.
  Future<ScanBubbleStartResult> turnOn() async {
    _hasOverlayPermission = await _service.canDrawOverlays();
    if (!_hasOverlayPermission) {
      notifyListeners();
      return ScanBubbleStartResult.needsPermission;
    }
    await _service.requestNotificationPermission();
    final started = await _service.startBubble();
    _isRunning = started;
    notifyListeners();
    return started
        ? ScanBubbleStartResult.started
        : ScanBubbleStartResult.failed;
  }

  /// Removes the bubble.
  Future<void> turnOff() async {
    await _service.stopBubble();
    _isRunning = false;
    notifyListeners();
  }

  /// Opens the system "Display over other apps" page for this app.
  Future<void> openOverlayPermissionSettings() async {
    await _service.openOverlayPermissionSettings();
  }

  /// Saves the "Start after phone restart" choice.
  Future<void> setStartOnBoot(bool value) async {
    final saved = await _service.setStartOnBoot(value);
    if (saved) {
      _startOnBoot = value;
      notifyListeners();
    }
  }

  /// Asks Android to add the "Scan bubble" Quick Settings tile.
  Future<bool> requestAddTile() => _service.requestAddTile();
}
