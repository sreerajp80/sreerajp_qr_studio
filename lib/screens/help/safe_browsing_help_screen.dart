import 'package:material_ui/material_ui.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/screens/help/widgets/help_page_widgets.dart';

class SafeBrowsingHelpScreen extends StatelessWidget {
  const SafeBrowsingHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return HelpGuidePage(
      title: l10n.titleHelpSafeBrowsing,
      intro: l10n.helpGuideSafeBrowsingIntro,
      sections: [
        HelpSection(
          icon: Icons.toggle_on_outlined,
          title: l10n.helpGuideSafeBrowsingBuiltInTitle,
          bullets: [
            l10n.helpGuideSafeBrowsingBuiltInBullet1,
            l10n.helpGuideSafeBrowsingBuiltInBullet2,
            l10n.helpGuideSafeBrowsingBuiltInBullet3,
          ],
        ),
        HelpSection(
          icon: Icons.vpn_key_outlined,
          title: l10n.helpGuideSafeBrowsingKeyTitle,
          bullets: [
            l10n.helpGuideSafeBrowsingKeyStep1,
            l10n.helpGuideSafeBrowsingKeyStep2,
            l10n.helpGuideSafeBrowsingKeyStep3,
            l10n.helpGuideSafeBrowsingKeyStep4,
            l10n.helpGuideSafeBrowsingKeyStep5,
          ],
        ),
        HelpSection(
          icon: Icons.key_outlined,
          title: l10n.helpGuideSafeBrowsingOtherTitle,
          bullets: [
            l10n.helpGuideSafeBrowsingOtherBullet1,
            l10n.helpGuideSafeBrowsingOtherBullet2,
            l10n.helpGuideSafeBrowsingOtherBullet3,
          ],
        ),
        HelpSection(
          icon: Icons.lock_outline,
          title: l10n.helpGuideSafeBrowsingPrivacyTitle,
          bullets: [
            l10n.helpGuideSafeBrowsingPrivacyBullet1,
            l10n.helpGuideSafeBrowsingPrivacyBullet2,
            l10n.helpGuideSafeBrowsingPrivacyBullet3,
          ],
        ),
      ],
      tip: l10n.helpGuideSafeBrowsingTip,
    );
  }
}
