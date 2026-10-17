import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/providers/batch_scan_provider.dart';
import 'package:sreerajp_qr_studio/providers/camera_settings_provider.dart';
import 'package:sreerajp_qr_studio/providers/code_forge_provider.dart';
import 'package:sreerajp_qr_studio/providers/history_provider.dart';
import 'package:sreerajp_qr_studio/providers/locale_provider.dart';
import 'package:sreerajp_qr_studio/providers/scan_provider.dart';
import 'package:sreerajp_qr_studio/providers/theme_provider.dart';
import 'package:sreerajp_qr_studio/screens/code_forge_screen.dart';
import 'package:sreerajp_qr_studio/screens/main_shell_screen.dart';

import '../helpers/accessibility_checks.dart';
import '../helpers/test_app.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'MainShellScreen renders bottom NavigationBar and switches tabs',
    (tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ThemeProvider()),
            ChangeNotifierProvider(create: (_) => LocaleProvider()),
            ChangeNotifierProvider(create: (_) => ScanProvider()),
            ChangeNotifierProvider(create: (_) => HistoryProvider()),
            ChangeNotifierProvider(create: (_) => CameraSettingsProvider()),
            ChangeNotifierProvider(create: (_) => CodeForgeProvider()),
            ChangeNotifierProvider(create: (_) => BatchScanProvider()),
          ],
          child: const MaterialApp(
            localizationsDelegates: [
              AppLocalizations.delegate,
              ...GlobalMaterialLocalizations.delegates,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: MainShellScreen(initialTabIndex: 1),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      // Verify NavigationBar is rendered with destinations
      expect(find.byType(NavigationBar), findsOneWidget);
      expect(find.text('Scan'), findsOneWidget);
      expect(find.text('CodeForge'), findsAtLeastNWidgets(1));
      expect(find.text('History'), findsOneWidget);

      // CodeForgeScreen should be active
      expect(find.byType(CodeForgeScreen), findsOneWidget);
      expect(find.text('Barcode & QR Studio'), findsOneWidget);
    },
  );

  for (final locale in appTestLocales) {
    testWidgets(
      'renders in ${locale.languageCode} without overflow; icon buttons have '
      'tooltips',
      (tester) async {
        await tester.pumpWidget(
          buildTestApp(
            locale: locale,
            home: const MainShellScreen(initialTabIndex: 1),
            providers: [
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
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 200));
        expect(tester.takeException(), isNull);
        expectAllIconButtonsHaveTooltips(tester);
      },
    );
  }
}
