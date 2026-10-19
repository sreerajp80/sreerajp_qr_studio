import 'package:material_ui/material_ui.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/screens/help/widgets/help_page_widgets.dart';

class SettingsHelpScreen extends StatelessWidget {
  const SettingsHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return HelpGuidePage(
      title: l10n.titleHelpSettings,
      intro: l10n.helpGuideSettingsIntro,
      sections: [
        HelpSection(
          icon: Icons.palette_outlined,
          title: l10n.helpGuideSettingsLookTitle,
          bullets: [
            l10n.helpGuideSettingsLookBullet1,
            l10n.helpGuideSettingsLookBullet2,
            l10n.helpGuideSettingsLookBullet3,
            l10n.helpGuideSettingsLookBullet4,
            l10n.helpGuideSettingsLookBullet5,
          ],
        ),
        HelpSection(
          icon: Icons.vibration,
          title: l10n.helpGuideSettingsFeedbackTitle,
          bullets: [l10n.helpGuideSettingsFeedbackBullet1],
        ),
        HelpSection(
          icon: Icons.privacy_tip_outlined,
          title: l10n.helpGuideSettingsPrivacyTitle,
          bullets: [
            l10n.helpGuideSettingsPrivacyBullet1,
            l10n.helpGuideSettingsPrivacyBullet2,
            l10n.helpGuideSettingsPrivacyBullet3,
          ],
        ),
        HelpSection(
          icon: Icons.settings_outlined,
          title: l10n.helpGuideSettingsOtherTitle,
          bullets: [
            l10n.helpGuideSettingsOtherBullet1,
            l10n.helpGuideSettingsOtherBullet2,
            l10n.helpGuideSettingsOtherBullet3,
            l10n.helpGuideSettingsOtherBullet4,
            l10n.helpGuideSettingsOtherBullet5,
          ],
        ),
        HelpSection(
          icon: Icons.battery_saver_outlined,
          title: l10n.helpGuideSettingsBatteryTitle,
          bullets: [
            l10n.helpGuideSettingsBatteryBullet1,
            l10n.helpGuideSettingsBatteryBullet2,
            l10n.helpGuideSettingsBatteryBullet3,
            l10n.helpGuideSettingsBatteryBullet4,
          ],
        ),
      ],
      tip: l10n.helpGuideSettingsTip,
    );
  }
}
