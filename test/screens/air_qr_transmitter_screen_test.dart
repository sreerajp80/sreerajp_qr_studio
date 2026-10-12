import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sreerajp_qr_studio/models/scan_record.dart';
import 'package:sreerajp_qr_studio/providers/history_provider.dart';
import 'package:sreerajp_qr_studio/screens/air_qr_transmitter_screen.dart';
import 'package:sreerajp_qr_studio/services/history_database_service.dart';

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

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  Future<void> pumpScreen(
    WidgetTester tester, {
    Locale locale = const Locale('en'),
  }) async {
    tester.view.physicalSize = const Size(1080, 3200);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      buildTestApp(
        locale: locale,
        providers: [
          ChangeNotifierProvider(
            create: (_) =>
                HistoryProvider(dbService: _EmptyHistoryDatabaseService()),
          ),
        ],
        home: const AirQrTransmitterScreen(),
      ),
    );
    await tester.pumpAndSettle();
  }

  /// The visible texts, to see whether the frame label has moved on.
  List<String?> visibleTexts(WidgetTester tester) =>
      tester.widgetList<Text>(find.byType(Text)).map((t) => t.data).toList();

  for (final locale in appTestLocales) {
    testWidgets(
      'starts with sample text and frames in ${locale.languageCode}',
      (tester) async {
        final l10n = l10nFor(locale);
        await pumpScreen(tester, locale: locale);

        expect(find.text(l10n.airQrTransmitterTitle), findsOneWidget);
        expect(find.text(l10n.airQrSamplePayload), findsOneWidget);
        final start = tester.widget<ElevatedButton>(
          find.widgetWithText(ElevatedButton, l10n.airQrStartStream),
        );
        expect(start.onPressed, isNotNull);
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets('empty text disables the start button', (tester) async {
    final l10n = l10nFor(const Locale('en'));
    await pumpScreen(tester);

    await tester.enterText(
      find.widgetWithText(TextField, l10n.airQrPayloadLabel),
      '',
    );
    await tester.pumpAndSettle();

    final start = tester.widget<ElevatedButton>(
      find.widgetWithText(ElevatedButton, l10n.airQrStartStream),
    );
    expect(start.onPressed, isNull);
  });

  testWidgets('start shows frames moving, stop ends the stream', (
    tester,
  ) async {
    final l10n = l10nFor(const Locale('en'));
    await pumpScreen(tester);

    // Long text so the stream has several frames.
    await tester.enterText(
      find.widgetWithText(TextField, l10n.airQrPayloadLabel),
      'AirQR test payload. ' * 120,
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text(l10n.airQrStartStream));
    await tester.pump();
    expect(find.text(l10n.airQrStopStream), findsOneWidget);

    final before = visibleTexts(tester);
    await tester.pump(const Duration(milliseconds: 500));
    expect(visibleTexts(tester), isNot(equals(before)));

    await tester.tap(find.text(l10n.airQrStopStream));
    await tester.pump();
    expect(find.text(l10n.airQrStartStream), findsOneWidget);
  });

  testWidgets('speed slider is limited to 5–25 FPS', (tester) async {
    await pumpScreen(tester);

    final slider = tester.widget<Slider>(find.byType(Slider));
    expect(slider.min, 5);
    expect(slider.max, 25);
    expect(slider.divisions, 20);
  });
}
