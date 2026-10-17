import 'package:material_ui/material_ui.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/screens/appearance/accent_color_settings_screen.dart';
import 'package:sreerajp_qr_studio/screens/appearance/scan_overlay_settings_screen.dart';
import 'package:sreerajp_qr_studio/screens/appearance/theme_mode_settings_screen.dart';
import 'package:sreerajp_qr_studio/screens/appearance/typography_settings_screen.dart';

/// Appearance preferences hub reached from Settings -> Appearance.
class AppearanceScreen extends StatelessWidget {
  const AppearanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.titleAppearanceHub)),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          children: [
            _AppearanceCard(
              icon: Icons.brightness_6_outlined,
              title: l10n.labelAppearanceThemeModeCard,
              subtitle: l10n.descAppearanceThemeModeCard,
              onTap: () => _push(context, const ThemeModeSettingsScreen()),
            ),
            const SizedBox(height: 12),
            _AppearanceCard(
              icon: Icons.layers_outlined,
              title: l10n.labelAppearanceOverlayCard,
              subtitle: l10n.descAppearanceOverlayCard,
              onTap: () => _push(context, const ScanOverlaySettingsScreen()),
            ),
            const SizedBox(height: 12),
            _AppearanceCard(
              icon: Icons.color_lens_outlined,
              title: l10n.labelAppearanceAccentCard,
              subtitle: l10n.descAppearanceAccentCard,
              onTap: () => _push(context, const AccentColorSettingsScreen()),
            ),
            const SizedBox(height: 12),
            _AppearanceCard(
              icon: Icons.font_download_outlined,
              title: l10n.labelAppearanceTypographyCard,
              subtitle: l10n.descAppearanceTypographyCard,
              onTap: () => _push(context, const TypographySettingsScreen()),
            ),
          ],
        ),
      ),
    );
  }

  void _push(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }
}

class _AppearanceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _AppearanceCard({
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
                child: Icon(icon, color: accent),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
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
