import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sreerajp_qr_studio/models/scan_record.dart';
import 'package:sreerajp_qr_studio/providers/batch_scan_provider.dart';
import 'package:sreerajp_qr_studio/providers/camera_settings_provider.dart';
import 'package:sreerajp_qr_studio/providers/history_provider.dart';
import 'package:sreerajp_qr_studio/providers/locale_provider.dart';
import 'package:sreerajp_qr_studio/providers/multi_code_selection_provider.dart';
import 'package:sreerajp_qr_studio/providers/scan_bubble_provider.dart';
import 'package:sreerajp_qr_studio/providers/scan_provider.dart';
import 'package:sreerajp_qr_studio/providers/theme_provider.dart';
import 'package:sreerajp_qr_studio/screens/scanner_screen.dart';
import 'package:sreerajp_qr_studio/services/history_database_service.dart';
import 'package:sreerajp_qr_studio/services/light_sensor_service.dart';

import '../helpers/test_app.dart';

class _EmptyHistoryDatabaseService extends Fake
    implements HistoryDatabaseService {
  @override
  Future<List<ScanRecord>> getRecords({
    String? category,
    bool? onlyFavorites,
    String? searchQuery,
  }) async => const [];
}

class _SilentLightSensorService extends LightSensorService {
  @override
  Stream<double> get luxStream => const Stream<double>.empty();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    FlutterSecureStorage.setMockInitialValues({});
  });

  Future<ValueNotifier<int>> pumpScreen(
    WidgetTester tester, {
    Locale locale = const Locale('en'),
  }) async {
    final requests = fakeCameraPlatform();
    await tester.pumpWidget(
      buildTestApp(
        locale: locale,
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => LocaleProvider()),
          ChangeNotifierProvider(create: (_) => ScanProvider()),
          ChangeNotifierProvider(
            create: (_) =>
                HistoryProvider(dbService: _EmptyHistoryDatabaseService()),
          ),
          ChangeNotifierProvider(
            create: (_) => CameraSettingsProvider(
              lightSensorService: _SilentLightSensorService(),
            ),
          ),
          ChangeNotifierProvider(create: (_) => BatchScanProvider()),
          ChangeNotifierProvider(create: (_) => MultiCodeSelectionProvider()),
          ChangeNotifierProvider(create: (_) => ScanBubbleProvider()),
        ],
        home: const ScannerScreen(),
      ),
    );
    await tester.pumpAndSettle();
    return requests;
  }

  for (final locale in appTestLocales) {
    testWidgets('camera permission denied shows the friendly message in '
        '${locale.languageCode}', (tester) async {
      final l10n = l10nFor(locale);
      final requests = await pumpScreen(tester, locale: locale);

      // Permission is asked at point of use, when the scanner opens.
      expect(requests.value, greaterThanOrEqualTo(1));
      expect(find.text(l10n.scanCameraPermissionRequired), findsOneWidget);
      expect(find.text(l10n.grantPermission), findsOneWidget);
      // No camera, so no pause/resume button.
      expect(find.byType(FloatingActionButton), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('"Grant permission" asks for camera permission again', (
    tester,
  ) async {
    final l10n = l10nFor(const Locale('en'));
    final requests = await pumpScreen(tester);
    final before = requests.value;

    await tester.tap(find.text(l10n.grantPermission));
    await tester.pumpAndSettle();

    expect(requests.value, before + 1);
    expect(find.text(l10n.scanCameraPermissionRequired), findsOneWidget);
  });

  testWidgets('every icon button in the app bar has a tooltip', (tester) async {
    await pumpScreen(tester);

    final buttons = tester.widgetList<IconButton>(
      find.descendant(
        of: find.byType(AppBar),
        matching: find.byType(IconButton),
      ),
    );
    for (final button in buttons) {
      expect(button.tooltip, isNotNull);
      expect(button.tooltip, isNotEmpty);
    }
  });
}
