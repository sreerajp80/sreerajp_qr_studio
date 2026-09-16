import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Single source of truth for the app language.
/// A `null` locale means "follow the system", resolved by MaterialApp against supportedLocales.
class LocaleProvider extends ChangeNotifier {
  static const String prefKey = 'app_language';
  static const String systemValue = 'system';
  static const List<String> supportedLanguages = ['en', 'ml', 'sa'];

  SharedPreferences? _prefs;
  Locale? _locale;

  LocaleProvider({SharedPreferences? prefs}) {
    if (prefs != null) {
      _prefs = prefs;
      _loadFromPrefs();
    } else {
      _init();
    }
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
    _loadFromPrefs();
  }

  void _loadFromPrefs() {
    final saved = _prefs?.getString(prefKey) ?? systemValue;
    if (supportedLanguages.contains(saved)) {
      _locale = Locale(saved);
    } else {
      _locale = null;
    }
    notifyListeners();
  }

  /// null => follow the system locale.
  Locale? get locale => _locale;

  /// Returns 'system', 'en', 'ml', or 'sa'
  String get languageCode => _locale?.languageCode ?? systemValue;

  bool get isSystem => _locale == null;

  Future<void> setLanguage(String value) async {
    if (value == systemValue) {
      _locale = null;
    } else if (supportedLanguages.contains(value)) {
      _locale = Locale(value);
    } else {
      return;
    }

    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setString(prefKey, value);
    notifyListeners();
  }
}
