import 'package:material_ui/material_ui.dart';
import 'package:cupertino_ui/cupertino_ui.dart'
    show GlobalCupertinoLocalizations;
import 'package:flutter_localizations/flutter_localizations.dart'
    show GlobalWidgetsLocalizations;
import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/l10n/fallback_localizations.dart';
import 'package:sreerajp_qr_studio/screens/help/air_qr_help_screen.dart';
import 'package:sreerajp_qr_studio/screens/help/ar_codevision_help_screen.dart';
import 'package:sreerajp_qr_studio/screens/help/barcode_scanning_help_screen.dart';
import 'package:sreerajp_qr_studio/screens/help/code_forge_help_screen.dart';
import 'package:sreerajp_qr_studio/screens/help/faq_troubleshooting_help_screen.dart';
import 'package:sreerajp_qr_studio/screens/help/help_home_screen.dart';
import 'package:sreerajp_qr_studio/screens/help/hidden_codes_help_screen.dart';
import 'package:sreerajp_qr_studio/screens/help/history_privacy_help_screen.dart';
import 'package:sreerajp_qr_studio/screens/help/quishing_guard_help_screen.dart';
import 'package:sreerajp_qr_studio/screens/help/safe_browsing_help_screen.dart';
import 'package:sreerajp_qr_studio/screens/help/scan_bubble_help_screen.dart';
import 'package:sreerajp_qr_studio/screens/help/settings_help_screen.dart';
import 'package:sreerajp_qr_studio/screens/help/smart_payloads_help_screen.dart';
import 'package:sreerajp_qr_studio/screens/help/url_safety_help_screen.dart';

import '../../helpers/accessibility_checks.dart';

/// A help screen, plus the localized app bar title it must show.
class _HelpCase {
  final String name;
  final Widget screen;
  final String Function(AppLocalizations l10n) title;

  /// The title of this guide's card on the Help hub (null for the hub).
  final String Function(AppLocalizations l10n)? hubCard;

  const _HelpCase(this.name, this.screen, this.title, [this.hubCard]);
}

final _cases = <_HelpCase>[
  _HelpCase('hub', const HelpHomeScreen(), (l) => l.labelSettingsHelp),
  _HelpCase(
    'barcode',
    const BarcodeScanningHelpScreen(),
    (l) => l.titleHelpBarcode,
    (l) => l.helpGuideBarcodeName,
  ),
  _HelpCase(
    'ar codevision',
    const ArCodeVisionHelpScreen(),
    (l) => l.titleHelpArCodeVision,
    (l) => l.helpGuideArCodeVisionName,
  ),
  _HelpCase(
    'scan from other apps',
    const ScanBubbleHelpScreen(),
    (l) => l.titleHelpScanBubble,
    (l) => l.helpGuideScanBubbleName,
  ),
  _HelpCase(
    'codeforge',
    const CodeForgeHelpScreen(),
    (l) => l.titleHelpCodeForge,
    (l) => l.helpGuideCodeForgeName,
  ),
  _HelpCase(
    'airqr',
    const AirQrHelpScreen(),
    (l) => l.titleHelpAirQr,
    (l) => l.helpGuideAirQrName,
  ),
  _HelpCase(
    'url safety',
    const UrlSafetyHelpScreen(),
    (l) => l.titleHelpUrlSafety,
    (l) => l.helpGuideUrlSafetyName,
  ),
  _HelpCase(
    'quishing',
    const QuishingGuardHelpScreen(),
    (l) => l.titleHelpQuishing,
    (l) => l.helpGuideQuishingName,
  ),
  _HelpCase(
    'online checkers',
    const SafeBrowsingHelpScreen(),
    (l) => l.titleHelpSafeBrowsing,
    (l) => l.helpGuideSafeBrowsingName,
  ),
  _HelpCase(
    'smart payloads',
    const SmartPayloadsHelpScreen(),
    (l) => l.titleHelpSmartPayloads,
    (l) => l.helpGuideSmartPayloadsName,
  ),
  _HelpCase(
    'hidden codes',
    const HiddenCodesHelpScreen(),
    (l) => l.titleHelpHiddenCodes,
    (l) => l.helpGuideHiddenName,
  ),
  _HelpCase(
    'history',
    const HistoryPrivacyHelpScreen(),
    (l) => l.titleHelpHistory,
    (l) => l.helpGuideHistoryName,
  ),
  _HelpCase(
    'settings',
    const SettingsHelpScreen(),
    (l) => l.titleHelpSettings,
    (l) => l.helpGuideSettingsName,
  ),
  _HelpCase(
    'faq',
    const FaqTroubleshootingHelpScreen(),
    (l) => l.titleHelpFaq,
    (l) => l.helpGuideFaqName,
  ),
];

const _locales = [Locale('en'), Locale('ml'), Locale('sa')];

/// Short-label budget for app bar titles (engineering standard §8.6).
const _titleLimits = {'en': 20, 'ml': 22, 'sa': 22};

Widget _wrap(Widget screen, Locale locale) {
  return MaterialApp(
    locale: locale,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      FallbackMaterialLocalizationsDelegate(),
      FallbackCupertinoLocalizationsDelegate(),
      FallbackWidgetsLocalizationsDelegate(),
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: screen,
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  for (final locale in _locales) {
    group('Help screens in ${locale.languageCode}', () {
      for (final helpCase in _cases) {
        testWidgets('${helpCase.name} builds with a localized title', (
          tester,
        ) async {
          // A small phone width, so long translated text must wrap.
          await tester.binding.setSurfaceSize(const Size(360, 800));
          addTearDown(() => tester.binding.setSurfaceSize(null));

          await tester.pumpWidget(_wrap(helpCase.screen, locale));
          await tester.pumpAndSettle();

          final l10n = await AppLocalizations.delegate.load(locale);
          expect(tester.takeException(), isNull);
          expectAllIconButtonsHaveTooltips(tester);
          expect(
            find.descendant(
              of: find.byType(AppBar),
              matching: find.text(helpCase.title(l10n)),
            ),
            findsOneWidget,
          );
        });
      }

      testWidgets('the hub opens every help guide', (tester) async {
        await tester.binding.setSurfaceSize(const Size(360, 800));
        addTearDown(() => tester.binding.setSurfaceSize(null));
        final l10n = await AppLocalizations.delegate.load(locale);

        for (final helpCase in _cases.skip(1)) {
          // Start from a fresh app each time, so no guide is left open.
          await tester.pumpWidget(const SizedBox());
          await tester.pumpWidget(_wrap(const HelpHomeScreen(), locale));
          await tester.pumpAndSettle();

          final card = find.text(helpCase.hubCard!(l10n));
          await tester.scrollUntilVisible(
            card,
            200,
            scrollable: find.byType(Scrollable).first,
          );
          await tester.ensureVisible(card);
          await tester.pumpAndSettle();
          await tester.tap(card);
          await tester.pumpAndSettle();

          expect(
            find.byType(helpCase.screen.runtimeType),
            findsOneWidget,
            reason: 'The hub card for ${helpCase.name} must open its guide',
          );
        }
      });

      test('help app bar titles fit the short-label budget', () async {
        final l10n = await AppLocalizations.delegate.load(locale);
        final limit = _titleLimits[locale.languageCode]!;
        for (final helpCase in _cases.skip(1)) {
          final title = helpCase.title(l10n);
          expect(
            title.characters.length,
            lessThanOrEqualTo(limit),
            reason: '"$title" (${helpCase.name}) is longer than $limit',
          );
        }
      });
    });
  }
}
