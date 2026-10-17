import 'package:flutter/services.dart';
import 'package:sreerajp_qr_studio/core/logging/app_logger.dart';

/// Turns Android's `FLAG_SECURE` on while at least one sensitive screen is
/// open (docs/security.md §10.1). Screenshots and screen recording of those
/// screens are then blocked, and the recent-apps preview is blank.
///
/// A counter is used so nested screens and sheets work: the flag goes off only
/// when the last sensitive screen closes. Calls never throw.
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

  /// Number of sensitive screens open now.
  int get openSecureScreens => _secureScreens;

  /// A sensitive screen opened.
  Future<void> acquire() async {
    _secureScreens++;
    if (_secureScreens == 1) await _setSecure(true);
  }

  /// A sensitive screen closed.
  Future<void> release() async {
    if (_secureScreens == 0) return;
    _secureScreens--;
    if (_secureScreens == 0) await _setSecure(false);
  }

  Future<void> _setSecure(bool secure) async {
    try {
      await _channel.invokeMethod<bool>('setSecure', {'secure': secure});
    } catch (e) {
      AppLogger.warning('Setting screen security failed', error: e);
    }
  }
}
