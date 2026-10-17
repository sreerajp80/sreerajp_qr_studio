import 'package:material_ui/material_ui.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/screens/help/air_qr_help_screen.dart';
import 'package:sreerajp_qr_studio/screens/help/ar_codevision_help_screen.dart';
import 'package:sreerajp_qr_studio/screens/help/barcode_scanning_help_screen.dart';
import 'package:sreerajp_qr_studio/screens/help/faq_troubleshooting_help_screen.dart';
import 'package:sreerajp_qr_studio/screens/help/history_privacy_help_screen.dart';
import 'package:sreerajp_qr_studio/screens/help/quishing_guard_help_screen.dart';
import 'package:sreerajp_qr_studio/screens/help/safe_browsing_help_screen.dart';
import 'package:sreerajp_qr_studio/screens/help/scan_bubble_help_screen.dart';
import 'package:sreerajp_qr_studio/screens/help/smart_payloads_help_screen.dart';
import 'package:sreerajp_qr_studio/screens/help/url_safety_help_screen.dart';
import 'package:sreerajp_qr_studio/screens/onboarding_screen.dart';

/// Help Center hub reached from Settings -> Help.
class HelpHomeScreen extends StatelessWidget {
  const HelpHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.labelSettingsHelp)),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          children: [
            _buildHeaderCard(context, l10n),
            const SizedBox(height: 16),
            _HelpTopicCard(
              icon: Icons.auto_stories_outlined,
              title: l10n.labelSettingsOnboardingTour,
              subtitle: l10n.descSettingsOnboardingTour,
              onTap: () =>
                  _push(context, const OnboardingScreen(isReplay: true)),
            ),
            const SizedBox(height: 20),

            _buildSectionHeader(
              context,
              l10n.helpGuideGroupScanning,
              Icons.qr_code_scanner,
            ),
            const SizedBox(height: 10),
            _HelpTopicCard(
              icon: Icons.document_scanner_outlined,
              title: l10n.helpGuideBarcodeName,
              subtitle: l10n.helpGuideBarcodeSummary,
              onTap: () => _push(context, const BarcodeScanningHelpScreen()),
            ),
            const SizedBox(height: 10),
            _HelpTopicCard(
              icon: Icons.view_in_ar,
              title: l10n.helpGuideArCodeVisionName,
              subtitle: l10n.helpGuideArCodeVisionSummary,
              onTap: () => _push(context, const ArCodeVisionHelpScreen()),
            ),
            const SizedBox(height: 10),
            _HelpTopicCard(
              icon: Icons.stream,
              title: l10n.helpGuideAirQrName,
              subtitle: l10n.helpGuideAirQrSummary,
              onTap: () => _push(context, const AirQrHelpScreen()),
            ),
            const SizedBox(height: 10),
            _HelpTopicCard(
              icon: Icons.bubble_chart_outlined,
              title: l10n.helpGuideScanBubbleName,
              subtitle: l10n.helpGuideScanBubbleSummary,
              onTap: () => _push(context, const ScanBubbleHelpScreen()),
            ),
            const SizedBox(height: 22),

            _buildSectionHeader(
              context,
              l10n.helpGuideGroupSecurity,
              Icons.security_outlined,
            ),
            const SizedBox(height: 10),
            _HelpTopicCard(
              icon: Icons.shield_outlined,
              title: l10n.helpGuideUrlSafetyName,
              subtitle: l10n.helpGuideUrlSafetySummary,
              onTap: () => _push(context, const UrlSafetyHelpScreen()),
            ),
            const SizedBox(height: 10),
            _HelpTopicCard(
              icon: Icons.policy_outlined,
              title: l10n.helpGuideQuishingName,
              subtitle: l10n.helpGuideQuishingSummary,
              onTap: () => _push(context, const QuishingGuardHelpScreen()),
            ),
            const SizedBox(height: 10),
            _HelpTopicCard(
              icon: Icons.vpn_key_outlined,
              title: l10n.helpGuideSafeBrowsingName,
              subtitle: l10n.helpGuideSafeBrowsingSummary,
              onTap: () => _push(context, const SafeBrowsingHelpScreen()),
            ),
            const SizedBox(height: 22),

            _buildSectionHeader(
              context,
              l10n.helpGuideGroupPayloads,
              Icons.inventory_2_outlined,
            ),
            const SizedBox(height: 10),
            _HelpTopicCard(
              icon: Icons.touch_app_outlined,
              title: l10n.helpGuideSmartPayloadsName,
              subtitle: l10n.helpGuideSmartPayloadsSummary,
              onTap: () => _push(context, const SmartPayloadsHelpScreen()),
            ),
            const SizedBox(height: 10),
            _HelpTopicCard(
              icon: Icons.history_edu_outlined,
              title: l10n.helpGuideHistoryName,
              subtitle: l10n.helpGuideHistorySummary,
              onTap: () => _push(context, const HistoryPrivacyHelpScreen()),
            ),
            const SizedBox(height: 10),
            _HelpTopicCard(
              icon: Icons.help_center_outlined,
              title: l10n.helpGuideFaqName,
              subtitle: l10n.helpGuideFaqSummary,
              onTap: () => _push(context, const FaqTroubleshootingHelpScreen()),
            ),
          ],
        ),
      ),
    );
  }

  void _push(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  Widget _buildHeaderCard(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              primary.withValues(alpha: 0.14),
              theme.colorScheme.secondary.withValues(alpha: 0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primary, primary.withValues(alpha: 0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: primary.withValues(alpha: 0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Icon(
                Icons.help_center_rounded,
                color: Colors.white,
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.helpCenterHeaderTitle,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.helpCenterHeaderSubtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: primary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title.toUpperCase(),
              style: theme.textTheme.labelLarge?.copyWith(
                color: primary,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A single help topic row, styled to match the Settings cards.
class _HelpTopicCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _HelpTopicCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.colorScheme.primary;

    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(icon, color: accent, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontSize: 13,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
