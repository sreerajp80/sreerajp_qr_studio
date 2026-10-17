import 'package:sreerajp_qr_studio/widgets/app_restart_scope.dart';
import 'package:sreerajp_qr_studio/services/data_wipe_service.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/providers/app_lock_provider.dart';
import 'package:sreerajp_qr_studio/providers/locale_provider.dart';
import 'package:sreerajp_qr_studio/providers/scan_provider.dart';
import 'package:sreerajp_qr_studio/providers/screen_security_provider.dart';
import 'package:sreerajp_qr_studio/providers/theme_provider.dart';
import 'package:sreerajp_qr_studio/screens/about_screen.dart';
import 'package:sreerajp_qr_studio/screens/appearance_screen.dart';
import 'package:sreerajp_qr_studio/screens/features_screen.dart';
import 'package:sreerajp_qr_studio/screens/help/help_home_screen.dart';
import 'package:sreerajp_qr_studio/screens/settings_screen.dart';
import 'package:sreerajp_qr_studio/services/screen_security_service.dart';

import '../helpers/accessibility_checks.dart';
import '../helpers/fake_biometric_service.dart';
import '../helpers/test_app.dart';

class _FakeDataWipeService extends Fake implements DataWipeService {
  _FakeDataWipeService({this.failed = const {}});

  final Set<DataWipeStep> failed;
  int calls = 0;

  @override
  Future<Set<DataWipeStep>> deleteAll() async {
    calls++;
    return failed;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    FlutterSecureStorage.setMockInitialValues({});
  });

  Widget buildTestableWidget() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ScanProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: const MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          ...GlobalMaterialLocalizations.delegates,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: SettingsScreen(),
      ),
    );
  }

  group('SettingsScreen Card Navigation Tests', () {
    testWidgets('Renders all main settings cards', (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Appearance'), findsOneWidget);
      expect(find.text('Language'), findsOneWidget);
      expect(find.text('Features'), findsOneWidget);
      expect(find.text('Scan feedback'), findsOneWidget);
      expect(find.text('Privacy & probing'), findsOneWidget);
      expect(find.text('URL Safety Providers'), findsOneWidget);
      expect(find.text('Scan bubble'), findsOneWidget);
      expect(find.text('Permissions'), findsOneWidget);
      expect(find.text('Help & guides'), findsOneWidget);
      expect(find.text('About'), findsOneWidget);
    });

    testWidgets('Opens Language dialog on card tap', (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      await tester.tap(find.text('Language'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('System default'), findsNWidgets(2));
      expect(find.text('English'), findsOneWidget);
      expect(find.text('മലയാളം'), findsOneWidget);
      expect(find.text('संस्कृतम्'), findsOneWidget);

      final radioGroup = tester.widget<RadioGroup<String>>(
        find.byType(RadioGroup<String>),
      );
      final systemTile = tester.widget<RadioListTile<String>>(
        find.widgetWithText(RadioListTile<String>, 'System default'),
      );
      expect(systemTile.value, equals(LocaleProvider.systemValue));
      expect(radioGroup.groupValue, equals(LocaleProvider.systemValue));
    });

    testWidgets('Navigates to Appearance page on card tap', (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      await tester.tap(find.text('Appearance'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.byType(AppearanceScreen), findsOneWidget);
      expect(find.text('Theme Mode'), findsOneWidget);
      expect(find.text('Scan Overlay Style'), findsOneWidget);
      expect(find.text('Accent & colors'), findsOneWidget);
      expect(find.text('Text size & font'), findsOneWidget);
    });

    testWidgets('Navigates to Features page on card tap', (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      await tester.tap(find.text('Features'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.byType(FeaturesScreen), findsOneWidget);
      expect(find.text('All features'), findsOneWidget);
      expect(find.text('SCANNING'), findsOneWidget);
    });

    testWidgets('Navigates to Scan Feedback page on card tap', (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      await tester.tap(find.text('Scan feedback'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.byType(ScanFeedbackSettingsScreen), findsOneWidget);
      expect(find.text('Vibration Feedback'), findsOneWidget);
      expect(find.text('Audible Beep Sound'), findsOneWidget);
      expect(find.text('Success animation'), findsOneWidget);
    });

    testWidgets('Navigates to Permissions page on card tap', (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      final target = find.text('Permissions');
      await tester.ensureVisible(target);
      await tester.pump();
      await tester.tap(target);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.byType(PermissionsSettingsScreen), findsOneWidget);
      expect(find.text('Permissions Overview'), findsOneWidget);
      expect(
        find.text('Explicit Permissions (Runtime / Manifest)'),
        findsOneWidget,
      );
    });

    testWidgets('Navigates to Help Center page on card tap', (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      final target = find.text('Help & guides');
      await tester.ensureVisible(target);
      await tester.pump();
      await tester.tap(target);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.byType(HelpHomeScreen), findsOneWidget);
      expect(find.text('Help Center & User Guides'), findsOneWidget);
      expect(find.text('Barcode & Media Scanning'), findsOneWidget);
      expect(find.text('AR CodeVision™ Spatial HUD'), findsOneWidget);
      expect(find.text('AirQR™ Optical Air-Gap Stream'), findsOneWidget);
    });

    testWidgets('Navigates to About screen on card tap', (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      final target = find.text('About');
      await tester.ensureVisible(target);
      await tester.pump();
      await tester.tap(target);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.byType(AboutScreen), findsOneWidget);
    });
  });

  for (final locale in appTestLocales) {
    testWidgets(
      'renders in ${locale.languageCode} without overflow; icon buttons have '
      'tooltips',
      (tester) async {
        await tester.pumpWidget(
          buildTestApp(
            locale: locale,
            home: const SettingsScreen(),
            providers: [
              ChangeNotifierProvider(create: (_) => ThemeProvider()),
              ChangeNotifierProvider(create: (_) => ScanProvider()),
              ChangeNotifierProvider(create: (_) => LocaleProvider()),
            ],
          ),
        );
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        expectAllIconButtonsHaveTooltips(tester);
      },
    );
  }

  group('Delete all data', () {
    Widget privacyApp({
      required _FakeDataWipeService wipe,
      required ValueNotifier<int> builds,
      Locale locale = const Locale('en'),
    }) {
      return AppRestartScope(
        builder: (_) {
          builds.value++;
          return buildTestApp(
            locale: locale,
            home: PrivacySettingsScreen(dataWipeServiceBuilder: (_) => wipe),
            providers: [
              ChangeNotifierProvider(
                create: (_) =>
                    AppLockProvider(biometricService: FakeBiometricService()),
              ),
              ChangeNotifierProvider(
                create: (_) => ScreenSecurityProvider(
                  service: ScreenSecurityService(
                    channel: const MethodChannel('test/window'),
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

    Future<void> openConfirm(WidgetTester tester, AppLocalizations l10n) async {
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
        find.text(l10n.labelDeleteAllData),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(find.text(l10n.labelDeleteAllData));
      await tester.pumpAndSettle();
      expect(find.text(l10n.titleDeleteAllDataConfirm), findsOneWidget);
    }

    testWidgets('the App lock switch turns the lock on after unlocking', (
      tester,
    ) async {
      final l10n = l10nFor(const Locale('en'));
      final builds = ValueNotifier<int>(0);
      await tester.pumpWidget(
        privacyApp(wipe: _FakeDataWipeService(), builds: builds),
      );
      await tester.pumpAndSettle();
      final tile = find.widgetWithText(SwitchListTile, l10n.labelAppLock);
      expect(tester.widget<SwitchListTile>(tile).value, isFalse);

      await tester.tap(tile);
      await tester.pumpAndSettle();
      expect(tester.widget<SwitchListTile>(tile).value, isTrue);
    });

    testWidgets('the Screenshot guard switch is on and can be turned off', (
      tester,
    ) async {
      final l10n = l10nFor(const Locale('en'));
      final builds = ValueNotifier<int>(0);
      await tester.pumpWidget(
        privacyApp(wipe: _FakeDataWipeService(), builds: builds),
      );
      await tester.pumpAndSettle();
      final tile = find.widgetWithText(
        SwitchListTile,
        l10n.labelScreenshotGuard,
      );
      expect(tester.widget<SwitchListTile>(tile).value, isTrue);

      await tester.scrollUntilVisible(
        tile,
        200,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(tile);
      await tester.pumpAndSettle();
      expect(tester.widget<SwitchListTile>(tile).value, isFalse);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool(ScreenSecurityProvider.prefKey), isFalse);
    });

    testWidgets('Cancel deletes nothing', (tester) async {
      final l10n = l10nFor(const Locale('en'));
      final wipe = _FakeDataWipeService();
      final builds = ValueNotifier<int>(0);
      await tester.pumpWidget(privacyApp(wipe: wipe, builds: builds));
      await openConfirm(tester, l10n);

      await tester.tap(find.text(l10n.actionCancel));
      await tester.pumpAndSettle();
      expect(wipe.calls, 0);
      expect(builds.value, 1);
    });

    testWidgets('Delete all wipes and restarts the app', (tester) async {
      final l10n = l10nFor(const Locale('en'));
      final wipe = _FakeDataWipeService();
      final builds = ValueNotifier<int>(0);
      await tester.pumpWidget(privacyApp(wipe: wipe, builds: builds));
      await openConfirm(tester, l10n);

      await tester.tap(find.text(l10n.actionDeleteAll));
      await tester.pumpAndSettle();
      expect(wipe.calls, 1);
      expect(builds.value, 2, reason: 'the app tree was rebuilt');
      expect(tester.takeException(), isNull);
    });

    testWidgets('a partial failure is reported before the restart', (
      tester,
    ) async {
      final l10n = l10nFor(const Locale('en'));
      final wipe = _FakeDataWipeService(failed: {DataWipeStep.scanBubble});
      final builds = ValueNotifier<int>(0);
      await tester.pumpWidget(privacyApp(wipe: wipe, builds: builds));
      await openConfirm(tester, l10n);

      await tester.tap(find.text(l10n.actionDeleteAll));
      await tester.pumpAndSettle();
      expect(find.text(l10n.errorDeleteAllDataPartial), findsOneWidget);
      expect(builds.value, 1);

      await tester.tap(find.byType(TextButton).last);
      await tester.pumpAndSettle();
      expect(builds.value, 2);
    });

    for (final locale in appTestLocales) {
      testWidgets(
        'the tile and dialog fit in ${locale.languageCode}; tooltips present',
        (tester) async {
          final l10n = l10nFor(locale);
          final builds = ValueNotifier<int>(0);
          await tester.pumpWidget(
            privacyApp(
              wipe: _FakeDataWipeService(),
              builds: builds,
              locale: locale,
            ),
          );
          await openConfirm(tester, l10n);
          expect(find.text(l10n.actionDeleteAll), findsOneWidget);
          expect(tester.takeException(), isNull);
          expectAllIconButtonsHaveTooltips(tester);
        },
      );
    }
  });
}
