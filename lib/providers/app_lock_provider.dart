import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sreerajp_qr_studio/core/logging/app_logger.dart';
import 'package:sreerajp_qr_studio/services/biometric_service.dart';

/// Result of turning the app lock on or off.
enum AppLockChange { done, unavailable, failed }

/// Optional app lock (docs/security.md §7).
///
/// When enabled, the app is locked at start and after it has been in the
/// background for at least [backgroundGrace]. Unlocking uses fingerprint,
/// face or the phone's screen lock (`BiometricService`). A short trip to the
/// background (gallery, file picker, share sheet, permission screens) does
/// not lock, so those flows stay usable.
class AppLockProvider extends ChangeNotifier {
  AppLockProvider({
    SharedPreferences? prefs,
    BiometricService? biometricService,
    DateTime Function()? clock,
    this.backgroundGrace = const Duration(seconds: 30),
  }) : _biometric = biometricService ?? BiometricService(),
       _clock = clock ?? DateTime.now {
    if (prefs != null) {
      _prefs = prefs;
      _load();
    } else {
      _init();
    }
  }

  static const String prefKey = 'app_lock_enabled';

  final BiometricService _biometric;
  final DateTime Function() _clock;

  /// How long the app may stay in the background without locking.
  final Duration backgroundGrace;

  SharedPreferences? _prefs;
  bool _enabled = false;
  bool _locked = false;
  bool _authInProgress = false;
  DateTime? _backgroundSince;

  bool get enabled => _enabled;
  bool get locked => _locked;
  bool get authInProgress => _authInProgress;

  Future<void> _init() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      _load();
    } catch (e, st) {
      AppLogger.error(
        'Loading app lock setting failed',
        error: e,
        stackTrace: st,
      );
    }
  }

  void _load() {
    _enabled = _prefs?.getBool(prefKey) ?? false;
    _locked = _enabled;
    notifyListeners();
  }

  /// The app went to the background.
  void onBackground() {
    if (!_enabled || _authInProgress) return;
    _backgroundSince ??= _clock();
  }

  /// The app came back. Locks if it was away for [backgroundGrace] or more.
  void onForeground() {
    final since = _backgroundSince;
    _backgroundSince = null;
    if (!_enabled || _authInProgress || since == null) return;
    if (_clock().difference(since) >= backgroundGrace) {
      _locked = true;
      notifyListeners();
    }
  }

  /// Asks the user to confirm it is them. [reason] is shown by the system
  /// prompt and must already be localized.
  Future<bool> unlock(String reason) async {
    if (!_locked) return true;
    final ok = await _authenticate(reason);
    if (ok) {
      _locked = false;
      notifyListeners();
    }
    return ok;
  }

  /// Turns the lock on after one successful authentication.
  Future<AppLockChange> enable(String reason) async {
    if (!await _biometric.isBiometricAvailable()) {
      return AppLockChange.unavailable;
    }
    if (!await _authenticate(reason)) return AppLockChange.failed;
    await _save(true);
    return AppLockChange.done;
  }

  /// Turns the lock off; also needs authentication.
  Future<AppLockChange> disable(String reason) async {
    if (!await _authenticate(reason)) return AppLockChange.failed;
    await _save(false);
    return AppLockChange.done;
  }

  Future<bool> _authenticate(String reason) async {
    if (_authInProgress) return false;
    _authInProgress = true;
    notifyListeners();
    try {
      return await _biometric.authenticate(localizedReason: reason);
    } finally {
      _authInProgress = false;
      // The system prompt itself pauses the app; that must not lock it.
      _backgroundSince = null;
      notifyListeners();
    }
  }

  Future<void> _save(bool value) async {
    _enabled = value;
    _locked = false;
    try {
      _prefs ??= await SharedPreferences.getInstance();
      await _prefs!.setBool(prefKey, value);
    } catch (e, st) {
      AppLogger.error(
        'Saving app lock setting failed',
        error: e,
        stackTrace: st,
      );
    }
    notifyListeners();
  }
}
