import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_localizations/flutter_localizations.dart'
    show GlobalWidgetsLocalizations;

/// Declared languages that Flutter has no framework translation for
/// (engineering standard §8.3.1). Keep in sync with docs/PROJECT_PROFILE.md.
const Set<String> kFrameworkFallbackLanguages = {'sa'};

/// Language that framework strings fall back to (the template language).
/// The app's own strings still come from AppLocalizations in the chosen
/// language.
const Locale kFrameworkFallbackLocale = Locale('en');

class FallbackMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      kFrameworkFallbackLanguages.contains(locale.languageCode);

  @override
  Future<MaterialLocalizations> load(Locale locale) =>
      GlobalMaterialLocalizations.delegate.load(kFrameworkFallbackLocale);

  @override
  bool shouldReload(covariant LocalizationsDelegate old) => false;
}

class FallbackCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      kFrameworkFallbackLanguages.contains(locale.languageCode);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      GlobalCupertinoLocalizations.delegate.load(kFrameworkFallbackLocale);

  @override
  bool shouldReload(covariant LocalizationsDelegate old) => false;
}

class FallbackWidgetsLocalizationsDelegate
    extends LocalizationsDelegate<WidgetsLocalizations> {
  const FallbackWidgetsLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      kFrameworkFallbackLanguages.contains(locale.languageCode);

  @override
  Future<WidgetsLocalizations> load(Locale locale) =>
      GlobalWidgetsLocalizations.delegate.load(kFrameworkFallbackLocale);

  @override
  bool shouldReload(covariant LocalizationsDelegate old) => false;
}
