import 'dart:developer' as developer;

import 'package:sreerajp_qr_studio/core/config/app_flavor_config.dart';

/// Log levels (engineering standard §14.1).
enum LogLevel { trace, debug, info, warning, error, fatal }

/// Receives one finished log line. Tests replace it to capture output.
typedef LogSink = void Function(
  LogLevel level,
  String message, {
  Object? error,
  StackTrace? stackTrace,
});

/// The app's only logger (engineering standard §14).
///
/// - `trace` and `debug` print only when verbose logging is on (dev flavor).
/// - Logs go to the console only; nothing is written to disk.
/// - Outside verbose mode, an error is reduced to its type name and no stack
///   trace is printed, because exception text can hold scanned content or
///   other user data (§14.3). Callers pass a fixed operation message.
abstract final class AppLogger {
  static bool _verbose = AppFlavorConfig.instance.enableVerboseLogging;
  static LogSink _sink = _developerSink;

  static void trace(String message) => _log(LogLevel.trace, message);

  static void debug(String message) => _log(LogLevel.debug, message);

  static void info(String message) => _log(LogLevel.info, message);

  static void warning(String message, {Object? error}) =>
      _log(LogLevel.warning, message, error: error);

  static void error(String message, {Object? error, StackTrace? stackTrace}) =>
      _log(LogLevel.error, message, error: error, stackTrace: stackTrace);

  static void fatal(String message, {Object? error, StackTrace? stackTrace}) =>
      _log(LogLevel.fatal, message, error: error, stackTrace: stackTrace);

  static void _log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!_verbose && (level == LogLevel.trace || level == LogLevel.debug)) {
      return;
    }
    try {
      if (_verbose) {
        _sink(level, message, error: error, stackTrace: stackTrace);
      } else {
        _sink(level, message, error: error?.runtimeType.toString());
      }
    } catch (_) {
      // Logging must never break the app.
    }
  }

  static void _developerSink(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    developer.log(
      message,
      name: 'QRStudio.${level.name}',
      level: _severity(level),
      error: error,
      stackTrace: stackTrace,
    );
  }

  // Severity values follow package:logging, which dart:developer expects.
  static int _severity(LogLevel level) => switch (level) {
    LogLevel.trace => 300,
    LogLevel.debug => 500,
    LogLevel.info => 800,
    LogLevel.warning => 900,
    LogLevel.error => 1000,
    LogLevel.fatal => 1200,
  };

  /// Test hook: replaces the sink and the verbose switch.
  static void overrideForTesting({LogSink? sink, bool? verbose}) {
    if (sink != null) _sink = sink;
    if (verbose != null) _verbose = verbose;
  }

  /// Test hook: restores the default sink and the flavor-based verbose switch.
  static void resetForTesting() {
    _sink = _developerSink;
    _verbose = AppFlavorConfig.instance.enableVerboseLogging;
  }
}
