import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/l10n/sa_material_localizations.dart';
import 'package:sreerajp_qr_studio/screens/help/air_qr_help_screen.dart';
import 'package:sreerajp_qr_studio/screens/help/ar_codevision_help_screen.dart';
import 'package:sreerajp_qr_studio/screens/help/barcode_scanning_help_screen.dart';
import 'package:sreerajp_qr_studio/screens/help/faq_troubleshooting_help_screen.dart';
import 'package:sreerajp_qr_studio/screens/help/help_home_screen.dart';
import 'package:sreerajp_qr_studio/screens/help/history_privacy_help_screen.dart';
import 'package:sreerajp_qr_studio/screens/help/quishing_guard_help_screen.dart';
import 'package:sreerajp_qr_studio/screens/help/safe_browsing_help_screen.dart';
import 'package:sreerajp_qr_studio/screens/help/smart_payloads_help_screen.dart';
import 'package:sreerajp_qr_studio/screens/help/url_safety_help_screen.dart';

/// A help screen, plus the localized app bar title it must show.
class _HelpCase {
  final String name;
  final Widget screen;
  final String Function(AppLocalizations l10n) title;

  const _HelpCase(this.name, this.screen, this.title);
}

final _cases = <_HelpCase>[
  _HelpCase('hub', const HelpHomeScreen(), (l) => l.settingsHelpTitle),
  _HelpCase(
    'barcode',
    const BarcodeScanningHelpScreen(),
    (l) => l.titleHelpBarcode,
  ),
  _HelpCase(
    'ar codevision',
    const ArCodeVisionHelpScreen(),
    (l) => l.titleHelpArCodeVision,
  ),
  _HelpCase('airqr', const AirQrHelpScreen(), (l) => l.titleHelpAirQr),
  _HelpCase(
    'url safety',
    const UrlSafetyHelpScreen(),
    (l) => l.titleHelpUrlSafety,
  ),
  _HelpCase(
    'quishing',
    const QuishingGuardHelpScreen(),
    (l) => l.titleHelpQuishing,
  ),
  _HelpCase(
    'safe browsing',
    const SafeBrowsingHelpScreen(),
    (l) => l.titleHelpSafeBrowsing,
  ),
  _HelpCase(
    'smart payloads',
    const SmartPayloadsHelpScreen(),
    (l) => l.titleHelpSmartPayloads,
  ),
  _HelpCase(
    'history',
    const HistoryPrivacyHelpScreen(),
    (l) => l.titleHelpHistory,
  ),
  _HelpCase('faq', const FaqTroubleshootingHelpScreen(), (l) => l.titleHelpFaq),
];

const _locales = [Locale('en'), Locale('ml'), Locale('sa')];

/// Short-label budget for app bar titles (engineering standard §8.6).
const _titleLimits = {'en': 20, 'ml': 22, 'sa': 22};

Widget _wrap(Widget screen, Locale locale) {
  return MaterialApp(
    locale: locale,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      SaMaterialLocalizationsDelegate(),
      SaCupertinoLocalizationsDelegate(),
      SaWidgetsLocalizationsDelegate(),
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
          expect(
            find.descendant(
              of: find.byType(AppBar),
              matching: find.text(helpCase.title(l10n)),
            ),
            findsOneWidget,
          );
        });
      }

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
