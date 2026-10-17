import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sreerajp_qr_studio/models/app_message.dart';
import 'package:sreerajp_qr_studio/models/safety_check_result.dart';
import 'package:sreerajp_qr_studio/services/code_forge_service.dart';
import 'package:sreerajp_qr_studio/models/location_result.dart';
import 'package:sreerajp_qr_studio/providers/code_forge_provider.dart';
import 'package:sreerajp_qr_studio/screens/code_forge_screen.dart';
import 'package:sreerajp_qr_studio/services/location_service.dart';

import '../helpers/accessibility_checks.dart';
import '../helpers/test_app.dart';

class _FakeLocationService extends LocationService {
  final LocationResult result;

  _FakeLocationService(this.result);

  @override
  Future<LocationResult> getCurrentLocation() async => result;
}

class _FakeSafetyCodeForgeService extends CodeForgeService {
  final List<SafetyCheckResult> results;

  _FakeSafetyCodeForgeService(this.results);

  @override
  Future<List<SafetyCheckResult>> verifyUrlSafety(String url) async => results;
}

SafetyCheckResult _check({required bool passed, bool skipped = false}) =>
    SafetyCheckResult(
      checkName: const AppMessage(AppMessageKey.checkNamePattern),
      passed: passed,
      message: const AppMessage(AppMessageKey.patternNone),
      skipped: skipped,
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  Future<void> pumpScreen(
    WidgetTester tester, {
    Locale locale = const Locale('en'),
    LocationResult location = const LocationResult.failed(),
    CodeForgeService? service,
    Size size = const Size(540, 2000),
  }) async {
    // Default: a tall surface keeps most of the long form on screen.
    tester.view.physicalSize = size * 2.0;
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      buildTestApp(
        locale: locale,
        providers: [
          ChangeNotifierProvider(
            create: (_) => CodeForgeProvider(
              service: service,
              locationService: _FakeLocationService(location),
            ),
          ),
        ],
        home: const CodeForgeScreen(),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> tapVisible(WidgetTester tester, Finder finder) async {
    await tester.ensureVisible(finder);
    await tester.pumpAndSettle();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  for (final locale in appTestLocales) {
    testWidgets('builds without errors in ${locale.languageCode}', (
      tester,
    ) async {
      final l10n = l10nFor(locale);
      await pumpScreen(tester, locale: locale);

      expect(find.text(l10n.titleCodeForge), findsOneWidget);
      expect(find.text(l10n.labelCodeForgePresetWifi), findsOneWidget);
      expect(tester.takeException(), isNull);
      expectAllIconButtonsHaveTooltips(tester);
    });
  }

  testWidgets('Wi-Fi preset: missing SSID shows a localized error', (
    tester,
  ) async {
    final l10n = l10nFor(const Locale('ml'));
    await pumpScreen(tester, locale: const Locale('ml'));

    await tapVisible(tester, find.text(l10n.labelCodeForgePresetWifi));
    final ssidField = find.widgetWithText(
      TextField,
      l10n.labelCodeForgeWifiSsid,
    );
    await tester.ensureVisible(ssidField);
    await tester.enterText(ssidField, '');
    await tester.pumpAndSettle();

    expect(find.text(l10n.errorCodeForgeWifiSsidRequired), findsOneWidget);
  });

  testWidgets('Wi-Fi password show/hide button has a changing tooltip', (
    tester,
  ) async {
    final l10n = l10nFor(const Locale('en'));
    await pumpScreen(tester);

    await tapVisible(tester, find.text(l10n.labelCodeForgePresetWifi));
    final showButton = find.byTooltip(l10n.tooltipWifiShowPassword);
    expect(showButton, findsOneWidget);

    await tapVisible(tester, showButton);
    expect(find.byTooltip(l10n.tooltipWifiHidePassword), findsOneWidget);
  });

  testWidgets('EAN-13 with letters shows the localized barcode error', (
    tester,
  ) async {
    final l10n = l10nFor(const Locale('en'));
    await pumpScreen(tester);

    await tapVisible(tester, find.text('EAN-13'));
    expect(find.text(l10n.labelCodeForgeBarcodeContent), findsOneWidget);

    final field = find.widgetWithText(
      TextField,
      l10n.helpCodeForgeBarcodeContent,
    );
    await tester.ensureVisible(field);
    await tester.enterText(field, 'ABC');
    await tester.pumpAndSettle();

    final prefix = l10n
        .errorCodeForgeBarcodeInvalid('')
        .replaceAll('()', '')
        .trim();
    expect(find.textContaining(prefix), findsOneWidget);
  });

  testWidgets('"Use my location" fills latitude and longitude', (tester) async {
    final l10n = l10nFor(const Locale('en'));
    await pumpScreen(
      tester,
      location: const LocationResult.success(latitude: 9.5, longitude: 76.25),
    );

    await tapVisible(tester, find.text(l10n.labelCodeForgePresetGeo));
    await tapVisible(tester, find.text(l10n.actionCodeForgeGeoUseMyLocation));

    expect(find.widgetWithText(TextField, '9.500000'), findsOneWidget);
    expect(find.widgetWithText(TextField, '76.250000'), findsOneWidget);
  });

  testWidgets('"Use my location" shows a message when permission is denied', (
    tester,
  ) async {
    final l10n = l10nFor(const Locale('en'));
    await pumpScreen(tester, location: const LocationResult.permissionDenied());

    await tapVisible(tester, find.text(l10n.labelCodeForgePresetGeo));
    await tapVisible(tester, find.text(l10n.actionCodeForgeGeoUseMyLocation));

    expect(find.text(l10n.errorCodeForgeGeoPermissionDenied), findsOneWidget);
  });

  for (final locale in appTestLocales) {
    testWidgets('style editor chips fit and can be tapped on a 360 dp phone in '
        '${locale.languageCode}', (tester) async {
      // A typical narrow phone. Any overflow fails the test.
      await pumpScreen(tester, locale: locale, size: const Size(360, 800));

      // The Wrap widgets that hold choice chips, each counted once:
      // eye shape, eye ball shape, error correction, center badge.
      final wrapElements = find
          .ancestor(of: find.byType(ChoiceChip), matching: find.byType(Wrap))
          .evaluate()
          .toSet()
          .toList();
      expect(wrapElements, hasLength(4));

      var tapped = 0;
      for (final wrap in wrapElements) {
        final chips = find.descendant(
          of: find.byElementPredicate((e) => e == wrap),
          matching: find.byType(ChoiceChip),
        );
        final count = chips.evaluate().length;
        for (var c = 0; c < count; c++) {
          await tester.ensureVisible(chips.at(c));
          await tester.pumpAndSettle();
          await tester.tap(chips.at(c));
          await tester.pumpAndSettle();
          expect(tester.widget<ChoiceChip>(chips.at(c)).selected, isTrue);
          tapped++;
        }
      }
      expect(tapped, 15);
      expect(tester.takeException(), isNull);
    });
  }

  group('link safety banner', () {
    testWidgets('not checked: prompt and Check button', (tester) async {
      final l10n = l10nFor(const Locale('en'));
      await pumpScreen(tester);

      expect(find.text(l10n.bodyCodeForgeSafetyPrompt), findsOneWidget);
      expect(
        find.widgetWithText(TextButton, l10n.actionCodeForgeSafetyCheck),
        findsOneWidget,
      );
    });

    testWidgets('safe: verified text and no button', (tester) async {
      final l10n = l10nFor(const Locale('en'));
      await pumpScreen(
        tester,
        service: _FakeSafetyCodeForgeService([_check(passed: true)]),
      );

      await tapVisible(
        tester,
        find.widgetWithText(TextButton, l10n.actionCodeForgeSafetyCheck),
      );

      expect(find.text(l10n.bodyCodeForgeSafeVerified), findsOneWidget);
      expect(find.text(l10n.actionCodeForgeSafetyCheck), findsNothing);
      expect(find.text(l10n.actionCodeForgeSafetyCheckAgain), findsNothing);
    });

    for (final locale in appTestLocales) {
      testWidgets(
        'problems found: count and Check again in ${locale.languageCode}',
        (tester) async {
          final l10n = l10nFor(locale);
          await pumpScreen(
            tester,
            locale: locale,
            size: const Size(360, 800),
            service: _FakeSafetyCodeForgeService([
              _check(passed: false),
              _check(passed: true),
              _check(passed: false),
            ]),
          );

          await tapVisible(
            tester,
            find.widgetWithText(TextButton, l10n.actionCodeForgeSafetyCheck),
          );

          expect(
            find.text(l10n.bodyCodeForgeSafetyProblems(2)),
            findsOneWidget,
          );
          expect(
            find.widgetWithText(
              TextButton,
              l10n.actionCodeForgeSafetyCheckAgain,
            ),
            findsOneWidget,
          );
          expect(find.text(l10n.bodyCodeForgeSafetyPrompt), findsNothing);
          expect(tester.takeException(), isNull);
        },
      );
    }
  });
}
