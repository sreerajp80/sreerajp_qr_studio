import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sreerajp_qr_studio/providers/theme_provider.dart';
import 'package:sreerajp_qr_studio/screens/appearance/accent_color_settings_screen.dart';
import 'package:sreerajp_qr_studio/screens/appearance/scan_overlay_settings_screen.dart';
import 'package:sreerajp_qr_studio/screens/appearance/theme_mode_settings_screen.dart';
import 'package:sreerajp_qr_studio/screens/appearance/typography_settings_screen.dart';
import 'package:sreerajp_qr_studio/screens/appearance_screen.dart';

import '../helpers/test_app.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  Widget app({Locale locale = const Locale('en')}) => buildTestApp(
    locale: locale,
    providers: [ChangeNotifierProvider(create: (_) => ThemeProvider())],
    home: const AppearanceScreen(),
  );

  for (final locale in appTestLocales) {
    testWidgets('shows all four appearance rows in ${locale.languageCode}', (
      tester,
    ) async {
      final l10n = l10nFor(locale);
      await tester.pumpWidget(app(locale: locale));
      await tester.pumpAndSettle();

      expect(find.text(l10n.appearanceHubTitle), findsOneWidget);
      expect(find.text(l10n.appearanceThemeModeCardTitle), findsOneWidget);
      expect(find.text(l10n.appearanceOverlayCardTitle), findsOneWidget);
      expect(find.text(l10n.appearanceAccentCardTitle), findsOneWidget);
      expect(find.text(l10n.appearanceTypographyCardTitle), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  final rows = <String, Type>{
    'theme': ThemeModeSettingsScreen,
    'overlay': ScanOverlaySettingsScreen,
    'accent': AccentColorSettingsScreen,
    'typography': TypographySettingsScreen,
  };

  for (final entry in rows.entries) {
    testWidgets('tapping the ${entry.key} row opens ${entry.value}', (
      tester,
    ) async {
      final l10n = l10nFor(const Locale('en'));
      final titles = {
        'theme': l10n.appearanceThemeModeCardTitle,
        'overlay': l10n.appearanceOverlayCardTitle,
        'accent': l10n.appearanceAccentCardTitle,
        'typography': l10n.appearanceTypographyCardTitle,
      };
      await tester.pumpWidget(app());
      await tester.pumpAndSettle();

      await tester.tap(find.text(titles[entry.key]!));
      await tester.pumpAndSettle();

      expect(find.byType(entry.value), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }
}
