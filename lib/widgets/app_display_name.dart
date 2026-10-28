import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sreerajp_qr_studio/core/config/app_config.dart';

/// Reads the localized app name (guideline.md §1.8).
extension AppDisplayName on BuildContext {
  /// The app name from `app_config.json` in the active language, plus the
  /// flavor suffix. Uses the built-in config when none is provided (tests).
  String get appDisplayName {
    AppConfig config;
    try {
      config = Provider.of<AppConfig>(this, listen: false);
    } on ProviderNotFoundException {
      config = AppConfig.fallback;
    }
    return config.displayName(Localizations.localeOf(this).languageCode);
  }
}
