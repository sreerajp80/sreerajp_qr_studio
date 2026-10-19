import 'package:material_ui/material_ui.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/screens/help/widgets/help_page_widgets.dart';

class FaqTroubleshootingHelpScreen extends StatelessWidget {
  const FaqTroubleshootingHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return HelpGuidePage(
      title: l10n.titleHelpFaq,
      intro: l10n.helpGuideFaqIntro,
      sections: [
        HelpSection(
          icon: Icons.help_outline,
          title: l10n.helpGuideFaqQuestionsTitle,
          bullets: [
            l10n.helpGuideFaqQuestion1,
            l10n.helpGuideFaqQuestion2,
            l10n.helpGuideFaqQuestion3,
            l10n.helpGuideFaqQuestion4,
            l10n.helpGuideFaqQuestion5,
            l10n.helpGuideFaqQuestion6,
            l10n.helpGuideFaqQuestion7,
            l10n.helpGuideFaqQuestion8,
          ],
        ),
        HelpSection(
          icon: Icons.build_outlined,
          title: l10n.helpGuideFaqCameraTitle,
          bullets: [
            l10n.helpGuideFaqCameraBullet1,
            l10n.helpGuideFaqCameraBullet2,
            l10n.helpGuideFaqCameraBullet3,
            l10n.helpGuideFaqCameraBullet4,
            l10n.helpGuideFaqCameraBullet5,
          ],
        ),
        HelpSection(
          icon: Icons.report_problem_outlined,
          title: l10n.helpGuideFaqFixTitle,
          bullets: [
            l10n.helpGuideFaqFixBullet1,
            l10n.helpGuideFaqFixBullet2,
            l10n.helpGuideFaqFixBullet3,
            l10n.helpGuideFaqFixBullet4,
            l10n.helpGuideFaqFixBullet5,
          ],
        ),
      ],
      tip: l10n.helpGuideFaqTip,
    );
  }
}
