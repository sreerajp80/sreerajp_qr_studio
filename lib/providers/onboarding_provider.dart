import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider managing first-launch onboarding status and state persistence.
class OnboardingProvider extends ChangeNotifier {
  static const String prefHasSeenOnboardingKey = 'has_seen_onboarding';

  SharedPreferences? _prefs;
  bool _hasSeenOnboarding = false;
  bool _isInitialized = false;

  OnboardingProvider({SharedPreferences? prefs}) {
    if (prefs != null) {
      _prefs = prefs;
      _loadFromPrefs();
    } else {
      _init();
    }
  }

  bool get hasSeenOnboarding => _hasSeenOnboarding;
  bool get isInitialized => _isInitialized;

  Future<void> _init() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      _loadFromPrefs();
    } catch (_) {
      // If SharedPreferences fails, treat as initialized so the user isn't blocked
      _isInitialized = true;
      notifyListeners();
    }
  }

  void _loadFromPrefs() {
    _hasSeenOnboarding = _prefs?.getBool(prefHasSeenOnboardingKey) ?? false;
    _isInitialized = true;
    notifyListeners();
  }

  /// Marks the onboarding tour as completed and persists to SharedPreferences.
  Future<void> completeOnboarding() async {
    _hasSeenOnboarding = true;
    try {
      _prefs ??= await SharedPreferences.getInstance();
      await _prefs!.setBool(prefHasSeenOnboardingKey, true);
    } catch (_) {
      // Ignore storage failure; in-memory state updated
    }
    notifyListeners();
  }

  /// Resets the onboarding flag, enabling the welcome tour to show again.
  Future<void> resetOnboarding() async {
    _hasSeenOnboarding = false;
    try {
      _prefs ??= await SharedPreferences.getInstance();
      await _prefs!.setBool(prefHasSeenOnboardingKey, false);
    } catch (_) {
      // Ignore storage failure; in-memory state updated
    }
    notifyListeners();
  }
}
