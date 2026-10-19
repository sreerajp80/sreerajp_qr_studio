import 'package:material_ui/material_ui.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/screens/help/widgets/help_page_widgets.dart';

class UrlSafetyHelpScreen extends StatelessWidget {
  const UrlSafetyHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return HelpGuidePage(
      title: l10n.titleHelpUrlSafety,
      intro: l10n.helpGuideUrlSafetyIntro,
      sections: [
        HelpSection(
          icon: Icons.layers_outlined,
          title: l10n.helpGuideUrlSafetyLayersTitle,
          bullets: [
            l10n.helpGuideUrlSafetyLayersBullet1,
            l10n.helpGuideUrlSafetyLayersBullet2,
            l10n.helpGuideUrlSafetyLayersBullet3,
            l10n.helpGuideUrlSafetyLayersBullet4,
            l10n.helpGuideUrlSafetyLayersBullet5,
            l10n.helpGuideUrlSafetyLayersBullet6,
          ],
        ),
        HelpSection(
          icon: Icons.fact_check_outlined,
          title: l10n.helpGuideUrlSafetyVerdictsTitle,
          bullets: [
            l10n.helpGuideUrlSafetyVerdictsBullet1,
            l10n.helpGuideUrlSafetyVerdictsBullet2,
            l10n.helpGuideUrlSafetyVerdictsBullet3,
            l10n.helpGuideUrlSafetyVerdictsBullet4,
          ],
        ),
        HelpSection(
          icon: Icons.visibility_off_outlined,
          title: l10n.helpGuideUrlSafetyPrivacyTitle,
          bullets: [
            l10n.helpGuideUrlSafetyPrivacyBullet1,
            l10n.helpGuideUrlSafetyPrivacyBullet2,
            l10n.helpGuideUrlSafetyPrivacyBullet3,
          ],
        ),
        HelpSection(
          icon: Icons.add_moderator_outlined,
          title: l10n.helpGuideUrlSafetyProvidersTitle,
          bullets: [
            l10n.helpGuideUrlSafetyProvidersBullet1,
            l10n.helpGuideUrlSafetyProvidersBullet2,
            l10n.helpGuideUrlSafetyProvidersBullet3,
          ],
        ),
      ],
      tip: l10n.helpGuideUrlSafetyTip,
    );
  }
}
