import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sreerajp_qr_studio/core/logging/app_logger.dart';
import 'package:sreerajp_qr_studio/services/screen_security_service.dart';

/// The user's "Screenshot guard" setting (docs/security.md §10.1).
///
/// On by default. The value is saved in `SharedPreferences` and pushed to
/// [ScreenSecurityService], which sets `FLAG_SECURE` on sensitive screens.
class ScreenSecurityProvider extends ChangeNotifier {
  ScreenSecurityProvider({
    SharedPreferences? prefs,
    ScreenSecurityService? service,
  }) : _service = service ?? ScreenSecurityService.instance {
    if (prefs != null) {
      _prefs = prefs;
      _load();
    } else {
      _init();
    }
  }

  static const String prefKey = 'screen_security_enabled';

  final ScreenSecurityService _service;
  SharedPreferences? _prefs;
  bool _enabled = true;

  bool get enabled => _enabled;

  Future<void> _init() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      _load();
    } catch (e, st) {
      AppLogger.error(
        'Loading screenshot guard setting failed',
        error: e,
        stackTrace: st,
      );
    }
  }

  void _load() {
    _enabled = _prefs?.getBool(prefKey) ?? true;
    _service.setEnabled(_enabled);
    notifyListeners();
  }

  /// Turns the screenshot guard on or off and saves the choice.
  Future<void> setEnabled(bool value) async {
    if (value == _enabled) return;
    _enabled = value;
    notifyListeners();
    await _service.setEnabled(value);
    try {
      final prefs = _prefs ??= await SharedPreferences.getInstance();
      await prefs.setBool(prefKey, value);
    } catch (e, st) {
      AppLogger.error(
        'Saving screenshot guard setting failed',
        error: e,
        stackTrace: st,
      );
    }
  }
}
