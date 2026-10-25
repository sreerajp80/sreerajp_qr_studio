import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sreerajp_qr_studio/models/camera_settings.dart';
import 'package:sreerajp_qr_studio/providers/camera_settings_provider.dart';
import 'package:sreerajp_qr_studio/services/light_sensor_service.dart';
import 'package:sreerajp_qr_studio/widgets/camera_adjustments_sheet.dart';

import '../helpers/accessibility_checks.dart';
import '../helpers/test_app.dart';

class _FakeLightSensorService extends LightSensorService {
  final StreamController<double> controller =
      StreamController<double>.broadcast();

  @override
  Stream<double> get luxStream => controller.stream;

  void close() => controller.close();
}

/// A phone-wide, very tall view, so the whole sheet is built without
/// scrolling.
void _useTallView(WidgetTester tester) {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = const Size(360, 4000);
  addTearDown(tester.view.reset);
}

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  Future<CameraSettingsProvider> pumpSheet(
    WidgetTester tester,
    Locale locale, {
    VoidCallback? onResolutionChanged,
    double textScale = 1.0,
  }) async {
    _useTallView(tester);
    final sensor = _FakeLightSensorService();
    addTearDown(sensor.close);
    final provider = CameraSettingsProvider(lightSensorService: sensor);
    await tester.pumpWidget(
      ChangeNotifierProvider<CameraSettingsProvider>.value(
        value: provider,
        child: buildTestApp(
          locale: locale,
          home: Builder(
            builder: (context) => MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: TextScaler.linear(textScale)),
              child: Scaffold(
                body: SingleChildScrollView(
                  child: CameraAdjustmentsSheet(
                    onResolutionChanged: onResolutionChanged,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    return provider;
  }

  for (final locale in appTestLocales) {
    testWidgets('shows every adjustment in ${locale.languageCode}', (
      tester,
    ) async {
      await pumpSheet(tester, locale);
      final l10n = l10nFor(locale);

      expect(find.text(l10n.titleCameraTune), findsOneWidget);
      expect(find.text(l10n.actionCameraReset), findsOneWidget);
      expect(find.text(l10n.labelCameraBrightness), findsOneWidget);
      expect(find.text(l10n.labelCameraContrast), findsOneWidget);
      expect(find.text(l10n.labelCameraInvert), findsOneWidget);
      expect(find.text(l10n.labelCameraResolution), findsOneWidget);
      expect(find.text(l10n.labelCameraDistanceEnhance), findsOneWidget);
      expect(find.text(l10n.labelMultiCodeSelection), findsOneWidget);
      expectAllIconButtonsHaveTooltips(tester);
      expect(tester.takeException(), isNull);
    });
  }

  for (final locale in appTestLocales) {
    testWidgets('every row fits with large text in ${locale.languageCode}', (
      tester,
    ) async {
      final provider = await pumpSheet(tester, locale, textScale: 2.0);
      // The distance sliders only show while distance mode is on.
      await provider.setDistanceEnhanceMode(true);
      await tester.pumpAndSettle();
      final l10n = l10nFor(locale);

      expect(find.text(l10n.titleCameraTune), findsOneWidget);
      expect(find.text(l10n.actionCameraReset), findsOneWidget);
      expect(find.text(l10n.labelCameraBrightness), findsOneWidget);
      expect(find.text(l10n.labelCameraDistanceZoom), findsOneWidget);
      expect(find.text(l10n.labelCameraUnsharp), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('invert switch updates the provider', (tester) async {
    final provider = await pumpSheet(tester, const Locale('en'));
    final l10n = l10nFor(const Locale('en'));
    expect(provider.invertColors, isFalse);

    await tester.tap(find.text(l10n.labelCameraInvert));
    await tester.pumpAndSettle();

    expect(provider.invertColors, isTrue);
  });

  testWidgets('choosing a resolution saves it and calls back', (tester) async {
    var changes = 0;
    final provider = await pumpSheet(
      tester,
      const Locale('en'),
      onResolutionChanged: () => changes++,
    );

    await tester.tap(find.text('720p'));
    await tester.pumpAndSettle();

    expect(provider.resolutionPreset, CameraResolutionPreset.hd);
    expect(changes, 1);
  });
}
