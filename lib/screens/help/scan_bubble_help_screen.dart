import 'package:material_ui/material_ui.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/screens/help/widgets/help_page_widgets.dart';

class ScanBubbleHelpScreen extends StatelessWidget {
  const ScanBubbleHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return HelpGuidePage(
      title: l10n.titleHelpScanBubble,
      intro: l10n.helpGuideScanBubbleIntro,
      sections: [
        HelpSection(
          icon: Icons.screenshot_monitor,
          title: l10n.helpGuideScanBubbleGhostTitle,
          bullets: [
            l10n.helpGuideScanBubbleGhostBullet1,
            l10n.helpGuideScanBubbleGhostBullet2,
            l10n.helpGuideScanBubbleGhostBullet3,
          ],
        ),
        HelpSection(
          icon: Icons.bubble_chart_outlined,
          title: l10n.helpGuideScanBubbleUseTitle,
          bullets: [
            l10n.helpGuideScanBubbleUseBullet1,
            l10n.helpGuideScanBubbleUseBullet2,
            l10n.helpGuideScanBubbleUseBullet3,
            l10n.helpGuideScanBubbleUseBullet4,
            l10n.helpGuideScanBubbleUseBullet5,
          ],
        ),
        HelpSection(
          icon: Icons.lock_outline,
          title: l10n.helpGuideScanBubblePrivacyTitle,
          bullets: [
            l10n.helpGuideScanBubblePrivacyBullet1,
            l10n.helpGuideScanBubblePrivacyBullet2,
            l10n.helpGuideScanBubblePrivacyBullet3,
          ],
        ),
        HelpSection(
          icon: Icons.info_outline,
          title: l10n.helpGuideScanBubbleLimitsTitle,
          bullets: [
            l10n.helpGuideScanBubbleLimitsBullet1,
            l10n.helpGuideScanBubbleLimitsBullet2,
            l10n.helpGuideScanBubbleLimitsBullet3,
          ],
        ),
      ],
      tip: l10n.helpGuideScanBubbleTip,
    );
  }
}
