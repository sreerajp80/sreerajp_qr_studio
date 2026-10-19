import 'package:material_ui/material_ui.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/screens/help/widgets/help_page_widgets.dart';

class HistoryPrivacyHelpScreen extends StatelessWidget {
  const HistoryPrivacyHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return HelpGuidePage(
      title: l10n.titleHelpHistory,
      intro: l10n.helpGuideHistoryIntro,
      sections: [
        HelpSection(
          icon: Icons.manage_search,
          title: l10n.helpGuideHistoryManageTitle,
          bullets: [
            l10n.helpGuideHistoryManageBullet1,
            l10n.helpGuideHistoryManageBullet2,
            l10n.helpGuideHistoryManageBullet3,
            l10n.helpGuideHistoryManageBullet4,
          ],
        ),
        HelpSection(
          icon: Icons.backup_outlined,
          title: l10n.helpGuideHistoryBackupTitle,
          bullets: [
            l10n.helpGuideHistoryBackupBullet1,
            l10n.helpGuideHistoryBackupBullet2,
            l10n.helpGuideHistoryBackupBullet3,
            l10n.helpGuideHistoryBackupBullet4,
          ],
        ),
        HelpSection(
          icon: Icons.fingerprint,
          title: l10n.helpGuideHistoryBiometricsTitle,
          bullets: [
            l10n.helpGuideHistoryBiometricsBullet1,
            l10n.helpGuideHistoryBiometricsBullet2,
            l10n.helpGuideHistoryBiometricsBullet3,
          ],
        ),
      ],
      tip: l10n.helpGuideHistoryTip,
    );
  }
}
