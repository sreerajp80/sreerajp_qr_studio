import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:sreerajp_qr_studio/core/logging/app_logger.dart';
import 'package:sreerajp_qr_studio/widgets/safe_error_fallback.dart';

/// Installs the app-wide error handlers (engineering standard §11.1).
///
/// - Framework errors are logged; debug builds also keep Flutter's console
///   dump and red error box.
/// - Uncaught async errors are logged and do not crash the app.
/// - Release builds show [SafeErrorFallback] instead of the raw error box.
abstract final class GlobalErrorHandlers {
  static void install({bool releaseMode = kReleaseMode}) {
    FlutterError.onError = (FlutterErrorDetails details) {
      AppLogger.error(
        'Flutter framework error',
        error: details.exception,
        stackTrace: details.stack,
      );
      if (!releaseMode) {
        FlutterError.dumpErrorToConsole(details);
      }
    };

    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      AppLogger.error('Uncaught async error', error: error, stackTrace: stack);
      return true;
    };

    if (releaseMode) {
      ErrorWidget.builder = (FlutterErrorDetails details) =>
          const SafeErrorFallback();
    }
  }
}
