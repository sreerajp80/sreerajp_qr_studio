import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sreerajp_qr_studio/core/logging/app_logger.dart';
import 'package:sreerajp_qr_studio/services/app_startup_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FlutterExceptionHandler? savedOnError;
  late bool Function(Object, StackTrace)? savedPlatformOnError;
  late List<String> logged;

  setUp(() {
    savedOnError = FlutterError.onError;
    savedPlatformOnError = PlatformDispatcher.instance.onError;
    logged = [];
    AppLogger.overrideForTesting(
      verbose: false,
      sink: (level, message, {error, stackTrace}) => logged.add(message),
    );
  });

  tearDown(() {
    FlutterError.onError = savedOnError;
    PlatformDispatcher.instance.onError = savedPlatformOnError;
    AppLogger.resetForTesting();
  });

  test('loads preferences before the first frame', () async {
    SharedPreferences.setMockInitialValues({'app_language': 'ml'});
    final result = await AppStartupService.run();
    expect(result.prefs, isNotNull);
    expect(result.prefs!.getString('app_language'), 'ml');
    expect(logged.first, startsWith('App start: flavor=prod'));
  });

  test('installs the global error handlers', () async {
    SharedPreferences.setMockInitialValues({});
    await AppStartupService.run();
    expect(PlatformDispatcher.instance.onError, isNotNull);
    expect(FlutterError.onError, isNot(same(savedOnError)));
  });

  test('a preferences failure is logged and does not stop startup', () async {
    final result = await AppStartupService.run(
      loadPrefs: () async => throw StateError('disk'),
    );
    expect(result.prefs, isNull);
    expect(logged, contains('Loading preferences failed'));
  });
}
