import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/l10n/fallback_localizations.dart';
import 'package:sreerajp_qr_studio/providers/app_lock_provider.dart';
import 'package:sreerajp_qr_studio/widgets/app_lock_gate.dart';

import '../helpers/accessibility_checks.dart';
import '../helpers/fake_biometric_service.dart';
import '../helpers/test_app.dart';

void main() {
  Future<FakeBiometricService> pumpLockedApp(
    WidgetTester tester, {
    Locale locale = const Locale('en'),
    bool succeeds = true,
  }) async {
    SharedPreferences.setMockInitialValues({AppLockProvider.prefKey: true});
    final prefs = await SharedPreferences.getInstance();
    final biometric = FakeBiometricService(succeeds: succeeds);
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) =>
            AppLockProvider(prefs: prefs, biometricService: biometric),
        child: MaterialApp(
          locale: locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            FallbackMaterialLocalizationsDelegate(),
            FallbackCupertinoLocalizationsDelegate(),
            FallbackWidgetsLocalizationsDelegate(),
            ...GlobalMaterialLocalizations.delegates,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          builder: (context, child) => AppLockGate(child: child!),
          home: const Scaffold(body: Text('secret history')),
        ),
      ),
    );
    return biometric;
  }

  testWidgets('a successful prompt at start unlocks the app', (tester) async {
    final biometric = await pumpLockedApp(tester);
    await tester.pumpAndSettle();
    expect(biometric.prompts, 1, reason: 'the prompt opens by itself once');
    expect(find.text('secret history'), findsOneWidget);
  });

  testWidgets('while locked only the lock screen is shown', (tester) async {
    final l10n = l10nFor(const Locale('en'));
    final biometric = await pumpLockedApp(tester, succeeds: false);
    await tester.pumpAndSettle();

    expect(find.text(l10n.titleAppLocked), findsOneWidget);
    expect(find.text(l10n.errorAppLockFailed), findsOneWidget);
    expect(find.text('secret history'), findsNothing);

    biometric.succeeds = true;
    await tester.tap(find.text(l10n.actionUnlock));
    await tester.pumpAndSettle();
    expect(find.text('secret history'), findsOneWidget);
    expect(find.text(l10n.titleAppLocked), findsNothing);
  });

  for (final locale in appTestLocales) {
    testWidgets('lock screen fits in ${locale.languageCode}', (tester) async {
      final l10n = l10nFor(locale);
      await pumpLockedApp(tester, locale: locale, succeeds: false);
      await tester.pumpAndSettle();
      expect(find.text(l10n.titleAppLocked), findsOneWidget);
      expect(tester.takeException(), isNull);
      expectAllIconButtonsHaveTooltips(tester);
    });
  }
}
