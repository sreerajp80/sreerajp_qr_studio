import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sreerajp_qr_studio/models/scan_record.dart';
import 'package:sreerajp_qr_studio/providers/air_qr_provider.dart';
import 'package:sreerajp_qr_studio/providers/history_provider.dart';
import 'package:sreerajp_qr_studio/providers/locale_provider.dart';
import 'package:sreerajp_qr_studio/providers/scan_provider.dart';
import 'package:sreerajp_qr_studio/providers/theme_provider.dart';
import 'package:sreerajp_qr_studio/screens/air_qr_screen.dart';
import 'package:sreerajp_qr_studio/services/air_qr_service.dart';
import 'package:sreerajp_qr_studio/services/history_database_service.dart';

import '../helpers/test_app.dart';

class _MemoryHistoryDatabaseService extends Fake
    implements HistoryDatabaseService {
  final List<ScanRecord> saved = [];

  @override
  Future<List<ScanRecord>> getRecords({
    String? category,
    bool? onlyFavorites,
    String? searchQuery,
  }) async => List.of(saved);

  @override
  Future<void> insertRecord(ScanRecord record) async => saved.add(record);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    FlutterSecureStorage.setMockInitialValues({});
  });

  /// Opens the receiver. Camera permission is denied unless [granted]; even
  /// when granted there is no real camera in a widget test, so the camera
  /// fails to start. The HUD and the stream logic still work.
  Future<({AirQrProvider airQr, ValueNotifier<int> requests})> pumpScreen(
    WidgetTester tester, {
    Locale locale = const Locale('en'),
    bool granted = false,
  }) async {
    final requests = fakeCameraPlatform(granted: granted);
    final airQr = AirQrProvider();
    await tester.pumpWidget(
      buildTestApp(
        locale: locale,
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => LocaleProvider()),
          ChangeNotifierProvider(create: (_) => ScanProvider()),
          ChangeNotifierProvider(
            create: (_) =>
                HistoryProvider(dbService: _MemoryHistoryDatabaseService()),
          ),
          ChangeNotifierProvider.value(value: airQr),
        ],
        home: const AirQrScreen(),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    return (airQr: airQr, requests: requests);
  }

  /// The camera plugin answers on real async work, not the fake clock.
  Future<void> letCameraSettle(WidgetTester tester) async {
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 500)),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
  }

  for (final locale in appTestLocales) {
    testWidgets('permission denied shows the message and button in '
        '${locale.languageCode}', (tester) async {
      final l10n = l10nFor(locale);
      await pumpScreen(tester, locale: locale);

      expect(find.text(l10n.airQrReceiverTitle), findsOneWidget);
      expect(find.text(l10n.scanCameraPermissionRequired), findsOneWidget);
      expect(find.text(l10n.grantPermission), findsOneWidget);
      // No endless "initializing" when the camera is blocked.
      expect(find.text(l10n.airQrInitializing), findsNothing);
      // The HUD still works.
      expect(find.text(l10n.airQrStatusIdle), findsOneWidget);
      expect(find.byTooltip(l10n.airQrResetStream), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('"Grant permission" asks for camera permission again', (
    tester,
  ) async {
    final l10n = l10nFor(const Locale('en'));
    final (airQr: _, :requests) = await pumpScreen(tester);
    expect(requests.value, 1);

    await tester.tap(find.text(l10n.grantPermission));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(requests.value, 2);
    expect(find.text(l10n.scanCameraPermissionRequired), findsOneWidget);
  });

  testWidgets('camera that cannot start shows a message and "Try again"', (
    tester,
  ) async {
    final l10n = l10nFor(const Locale('ml'));
    await pumpScreen(tester, locale: const Locale('ml'), granted: true);
    await letCameraSettle(tester);

    expect(find.text(l10n.scanCameraPermissionRequired), findsNothing);
    expect(find.text(l10n.cameraStartFailed), findsOneWidget);
    expect(find.text(l10n.cameraRetryButton), findsOneWidget);

    await tester.tap(find.text(l10n.cameraRetryButton));
    await letCameraSettle(tester);

    // Still no camera, so the same clear message comes back.
    expect(find.text(l10n.cameraStartFailed), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('progress area follows the stream and shows the result', (
    tester,
  ) async {
    final l10n = l10nFor(const Locale('en'));
    final (:airQr, requests: _) = await pumpScreen(tester);

    const payload = 'Hello from the AirQR widget test';
    final frames = AirQrService.encodePayload(payload, blockSize: 8);

    airQr.processScannedCode(frames.first.toQrString());
    await tester.pump();
    expect(find.text(l10n.airQrStatusCapturing), findsOneWidget);

    for (final frame in frames.skip(1)) {
      airQr.processScannedCode(frame.toQrString());
    }
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(airQr.isCompleted, isTrue);
    expect(find.text(l10n.airQrStatusReassembled), findsOneWidget);
    expect(find.textContaining(payload), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('reset button clears the stream', (tester) async {
    final l10n = l10nFor(const Locale('en'));
    final (:airQr, requests: _) = await pumpScreen(tester);

    final frames = AirQrService.encodePayload('Reset me please', blockSize: 8);
    airQr.processScannedCode(frames.first.toQrString());
    await tester.pump();
    expect(airQr.isReceiving, isTrue);

    await tester.tap(find.byTooltip(l10n.airQrResetStream));
    await tester.pump();

    expect(airQr.isReceiving, isFalse);
    expect(find.text(l10n.airQrStatusIdle), findsOneWidget);
  });
}
