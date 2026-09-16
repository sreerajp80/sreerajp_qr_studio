import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sreeraj_qr_reader/l10n/gen/app_localizations.dart';
import 'package:sreeraj_qr_reader/providers/batch_scan_provider.dart';
import 'package:sreeraj_qr_reader/providers/camera_settings_provider.dart';
import 'package:sreeraj_qr_reader/providers/code_forge_provider.dart';
import 'package:sreeraj_qr_reader/providers/history_provider.dart';
import 'package:sreeraj_qr_reader/providers/locale_provider.dart';
import 'package:sreeraj_qr_reader/providers/scan_provider.dart';
import 'package:sreeraj_qr_reader/providers/theme_provider.dart';
import 'package:sreeraj_qr_reader/screens/code_forge_screen.dart';
import 'package:sreeraj_qr_reader/screens/main_shell_screen.dart';

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
            localizationsDelegates: AppLocalizations.localizationsDelegates,
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
}
