import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/providers/batch_scan_provider.dart';
import 'package:sreerajp_qr_studio/providers/camera_settings_provider.dart';
import 'package:sreerajp_qr_studio/providers/code_forge_provider.dart';
import 'package:sreerajp_qr_studio/providers/history_provider.dart';
import 'package:sreerajp_qr_studio/providers/locale_provider.dart';
import 'package:sreerajp_qr_studio/providers/onboarding_provider.dart';
import 'package:sreerajp_qr_studio/providers/scan_provider.dart';
import 'package:sreerajp_qr_studio/providers/theme_provider.dart';
import 'package:sreerajp_qr_studio/screens/main_shell_screen.dart';
import 'package:sreerajp_qr_studio/screens/onboarding_screen.dart';

import '../helpers/accessibility_checks.dart';
import '../helpers/test_app.dart';

Widget _createTestWidget({
  required OnboardingProvider onboardingProvider,
  bool isReplay = false,
  VoidCallback? onCompleted,
}) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: onboardingProvider),
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ChangeNotifierProvider(create: (_) => ScanProvider()),
      ChangeNotifierProvider(create: (_) => HistoryProvider()),
      ChangeNotifierProvider(create: (_) => CameraSettingsProvider()),
      ChangeNotifierProvider(create: (_) => CodeForgeProvider()),
      ChangeNotifierProvider(create: (_) => BatchScanProvider()),
    ],
    child: MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: OnboardingScreen(isReplay: isReplay, onCompleted: onCompleted),
    ),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('OnboardingScreen', () {
    testWidgets('renders first slide with 6-layer link safety', (tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final provider = OnboardingProvider(prefs: prefs);

      await tester.pumpWidget(_createTestWidget(onboardingProvider: provider));
      await tester.pumpAndSettle();

      expect(find.text('6-layer link safety'), findsOneWidget);
      expect(find.text('Protocol & Homograph Shield'), findsOneWidget);
      expect(find.text('Skip'), findsOneWidget);
      expect(find.text('Next'), findsOneWidget);
    });

    testWidgets('navigates through all 3 slides to Start Scanning', (
      tester,
    ) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final provider = OnboardingProvider(prefs: prefs);

      await tester.pumpWidget(_createTestWidget(onboardingProvider: provider));
      await tester.pumpAndSettle();

      // Slide 1
      expect(find.text('6-layer link safety'), findsOneWidget);

      // Tap Next -> Slide 2
      await tester.tap(find.byKey(const Key('onboarding_action_button')));
      await tester.pumpAndSettle();

      expect(find.text('Fake sticker check'), findsOneWidget);
      expect(find.text('Feel for raised sticker edges'), findsOneWidget);

      // Tap Next -> Slide 3
      await tester.tap(find.byKey(const Key('onboarding_action_button')));
      await tester.pumpAndSettle();

      expect(find.text('100% offline privacy'), findsOneWidget);
      expect(find.text('Start Scanning'), findsOneWidget);

      // Tap Start Scanning
      await tester.tap(find.byKey(const Key('onboarding_action_button')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(provider.hasSeenOnboarding, isTrue);
      // The app's home switches to the main shell through the provider; the
      // screen must not push a second shell (two scanner screens).
      expect(find.byType(MainShellScreen), findsNothing);
    });

    testWidgets('skip button completes onboarding', (tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final provider = OnboardingProvider(prefs: prefs);

      await tester.pumpWidget(_createTestWidget(onboardingProvider: provider));
      await tester.pumpAndSettle();

      expect(provider.hasSeenOnboarding, isFalse);

      await tester.tap(find.text('Skip'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(provider.hasSeenOnboarding, isTrue);
      expect(find.byType(MainShellScreen), findsNothing);
    });

    testWidgets('custom onCompleted callback is called', (tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final provider = OnboardingProvider(prefs: prefs);

      bool completedCalled = false;
      await tester.pumpWidget(
        _createTestWidget(
          onboardingProvider: provider,
          onCompleted: () => completedCalled = true,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Skip'));
      await tester.pump();

      expect(completedCalled, isTrue);
    });

    testWidgets('replay mode shows back button', (tester) async {
      SharedPreferences.setMockInitialValues({
        OnboardingProvider.prefHasSeenOnboardingKey: true,
      });
      final prefs = await SharedPreferences.getInstance();
      final provider = OnboardingProvider(prefs: prefs);

      await tester.pumpWidget(
        _createTestWidget(onboardingProvider: provider, isReplay: true),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      expect(find.text('6-layer link safety'), findsOneWidget);
    });
  });

  for (final locale in appTestLocales) {
    testWidgets(
      'renders in ${locale.languageCode} without overflow; icon buttons have '
      'tooltips',
      (tester) async {
        SharedPreferences.setMockInitialValues({});
        final prefs = await SharedPreferences.getInstance();
        await tester.pumpWidget(
          buildTestApp(
            locale: locale,
            home: const OnboardingScreen(),
            providers: [
              ChangeNotifierProvider(
                create: (_) => OnboardingProvider(prefs: prefs),
              ),
              ChangeNotifierProvider(create: (_) => ThemeProvider()),
              ChangeNotifierProvider(create: (_) => LocaleProvider()),
              ChangeNotifierProvider(create: (_) => ScanProvider()),
              ChangeNotifierProvider(create: (_) => HistoryProvider()),
              ChangeNotifierProvider(create: (_) => CameraSettingsProvider()),
              ChangeNotifierProvider(create: (_) => CodeForgeProvider()),
              ChangeNotifierProvider(create: (_) => BatchScanProvider()),
            ],
          ),
        );
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        expectAllIconButtonsHaveTooltips(tester);
      },
    );
  }
}
