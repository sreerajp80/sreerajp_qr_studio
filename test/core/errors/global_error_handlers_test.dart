import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/core/errors/global_error_handlers.dart';
import 'package:sreerajp_qr_studio/core/logging/app_logger.dart';
import 'package:sreerajp_qr_studio/widgets/safe_error_fallback.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FlutterExceptionHandler? savedOnError;
  late bool Function(Object, StackTrace)? savedPlatformOnError;
  late ErrorWidgetBuilder savedBuilder;
  late List<String> logged;

  setUp(() {
    savedOnError = FlutterError.onError;
    savedPlatformOnError = PlatformDispatcher.instance.onError;
    savedBuilder = ErrorWidget.builder;
    logged = [];
    AppLogger.overrideForTesting(
      verbose: false,
      sink: (level, message, {error, stackTrace}) => logged.add(message),
    );
  });

  tearDown(() {
    FlutterError.onError = savedOnError;
    PlatformDispatcher.instance.onError = savedPlatformOnError;
    ErrorWidget.builder = savedBuilder;
    AppLogger.resetForTesting();
  });

  test('framework errors are logged', () {
    GlobalErrorHandlers.install(releaseMode: true);
    FlutterError.onError!(FlutterErrorDetails(exception: StateError('boom')));
    expect(logged, ['Flutter framework error']);
  });

  test('uncaught async errors are logged and handled', () {
    GlobalErrorHandlers.install(releaseMode: true);
    final handled = PlatformDispatcher.instance.onError!(
      StateError('boom'),
      StackTrace.current,
    );
    expect(handled, isTrue);
    expect(logged, ['Uncaught async error']);
  });

  test('release builds show SafeErrorFallback for a failed widget', () {
    GlobalErrorHandlers.install(releaseMode: true);
    final widget = ErrorWidget.builder(
      FlutterErrorDetails(exception: StateError('boom')),
    );
    expect(widget, isA<SafeErrorFallback>());
  });

  test('debug builds keep the default error widget', () {
    GlobalErrorHandlers.install(); // tests run outside release mode
    final widget = ErrorWidget.builder(
      FlutterErrorDetails(exception: StateError('boom')),
    );
    expect(widget, isNot(isA<SafeErrorFallback>()));
  });
}
