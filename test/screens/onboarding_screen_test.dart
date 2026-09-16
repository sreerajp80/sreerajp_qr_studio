import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sreeraj_qr_reader/l10n/gen/app_localizations.dart';
import 'package:sreeraj_qr_reader/providers/batch_scan_provider.dart';
import 'package:sreeraj_qr_reader/providers/camera_settings_provider.dart';
import 'package:sreeraj_qr_reader/providers/code_forge_provider.dart';
import 'package:sreeraj_qr_reader/providers/history_provider.dart';
import 'package:sreeraj_qr_reader/providers/locale_provider.dart';
import 'package:sreeraj_qr_reader/providers/onboarding_provider.dart';
import 'package:sreeraj_qr_reader/providers/scan_provider.dart';
import 'package:sreeraj_qr_reader/providers/theme_provider.dart';
import 'package:sreeraj_qr_reader/screens/onboarding_screen.dart';

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
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: OnboardingScreen(isReplay: isReplay, onCompleted: onCompleted),
    ),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('OnboardingScreen', () {
    testWidgets('renders first slide with 6-Layer URL Safety Engine', (
      tester,
    ) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final provider = OnboardingProvider(prefs: prefs);

      await tester.pumpWidget(_createTestWidget(onboardingProvider: provider));
      await tester.pumpAndSettle();

      expect(find.text('6-Layer URL Safety Engine'), findsOneWidget);
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
      expect(find.text('6-Layer URL Safety Engine'), findsOneWidget);

      // Tap Next -> Slide 2
      await tester.tap(find.byKey(const Key('onboarding_action_button')));
      await tester.pumpAndSettle();

      expect(find.text('QuishingGuard™ Tamper Detection'), findsOneWidget);
      expect(find.text('Physical sticker overlay detection'), findsOneWidget);

      // Tap Next -> Slide 3
      await tester.tap(find.byKey(const Key('onboarding_action_button')));
      await tester.pumpAndSettle();

      expect(find.text('100% Offline Privacy Model'), findsOneWidget);
      expect(find.text('Start Scanning'), findsOneWidget);

      // Tap Start Scanning (MainShellScreen has continuous camera animations, so use pump())
      await tester.tap(find.byKey(const Key('onboarding_action_button')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(provider.hasSeenOnboarding, isTrue);
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
      expect(find.text('6-Layer URL Safety Engine'), findsOneWidget);
    });
  });
}
