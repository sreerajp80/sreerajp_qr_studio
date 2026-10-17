import 'package:flutter/services.dart';
import 'package:sreerajp_qr_studio/core/logging/app_logger.dart';

/// Turns Android's `FLAG_SECURE` on while at least one sensitive screen is
/// open (docs/security.md §10.1). Screenshots and screen recording of those
/// screens are then blocked, and the recent-apps preview is blank.
///
/// A counter is used so nested screens and sheets work: the flag goes off only
/// when the last sensitive screen closes. The user can turn the guard off in
/// Settings ([setEnabled]); the counter keeps running so turning it back on
/// applies at once. Calls never throw.
class ScreenSecurityService {
  ScreenSecurityService({MethodChannel? channel})
    : _channel = channel ?? _defaultChannel;

  static const MethodChannel _defaultChannel = MethodChannel(
    'in.sreerajp.qr_studio/window',
  );

  /// The app-wide instance used by `SecureScreen`.
  static ScreenSecurityService instance = ScreenSecurityService();

  final MethodChannel _channel;
  int _secureScreens = 0;
  bool _enabled = true;
  bool _flagOn = false;

  /// Number of sensitive screens open now.
  int get openSecureScreens => _secureScreens;

  /// Whether the screenshot guard is on (the user's setting).
  bool get enabled => _enabled;

  /// A sensitive screen opened.
  Future<void> acquire() async {
    _secureScreens++;
    await _sync();
  }

  /// A sensitive screen closed.
  Future<void> release() async {
    if (_secureScreens == 0) return;
    _secureScreens--;
    await _sync();
  }

  /// Turns the guard on or off. Applies at once to any open sensitive screen.
  Future<void> setEnabled(bool enabled) async {
    _enabled = enabled;
    await _sync();
  }

  Future<void> _sync() async {
    final wanted = _enabled && _secureScreens > 0;
    if (wanted == _flagOn) return;
    _flagOn = wanted;
    try {
      await _channel.invokeMethod<bool>('setSecure', {'secure': wanted});
    } catch (e) {
      AppLogger.warning('Setting screen security failed', error: e);
    }
  }
}
