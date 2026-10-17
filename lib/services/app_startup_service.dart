import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sreerajp_qr_studio/core/config/app_flavor_config.dart';
import 'package:sreerajp_qr_studio/core/constants/app_version.g.dart';
import 'package:sreerajp_qr_studio/core/errors/global_error_handlers.dart';
import 'package:sreerajp_qr_studio/core/logging/app_logger.dart';
import 'package:sreerajp_qr_studio/services/open_source_licenses.dart';

/// What startup loaded for the first frame.
class AppStartupResult {
  const AppStartupResult({this.prefs});

  /// Preloaded preferences, so the saved language and onboarding flag apply
  /// before the first frame. `null` if loading failed; providers then load
  /// them on their own.
  final SharedPreferences? prefs;
}

/// Runs app startup in the order of engineering standard §4.5.
///
/// The barcode decoder, secure storage and the history database stay lazy
/// (they start on first use, §10.6). Every step catches its own failure, so
/// startup never stops the app from opening.
abstract final class AppStartupService {
  static Future<AppStartupResult> run({
    Future<SharedPreferences> Function()? loadPrefs,
  }) async {
    // 1. Framework binding.
    WidgetsFlutterBinding.ensureInitialized();

    // 2. Logging and the global error handlers.
    GlobalErrorHandlers.install();
    AppLogger.info(
      'App start: flavor=${AppFlavorConfig.instance.flavor.name}, '
      'version=$kAppVersion',
    );

    // 6. Licences of bundled native code, and the saved preferences
    //    (app language, onboarding flag).
    try {
      OpenSourceLicenses.register();
    } catch (e, st) {
      AppLogger.error('Registering licences failed', error: e, stackTrace: st);
    }

    SharedPreferences? prefs;
    try {
      prefs = await (loadPrefs ?? SharedPreferences.getInstance)();
    } catch (e, st) {
      AppLogger.error('Loading preferences failed', error: e, stackTrace: st);
    }

    return AppStartupResult(prefs: prefs);
  }
}
