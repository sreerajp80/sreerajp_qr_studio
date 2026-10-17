import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/providers/theme_provider.dart';

/// Configuration screen for scanner viewport frame overlay styles.
class ScanOverlaySettingsScreen extends StatelessWidget {
  const ScanOverlaySettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.labelAppearanceOverlayCard)),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          children: [
            Card(
              margin: EdgeInsets.zero,
              child: Column(
                children: [
                  _buildOverlayTile(
                    context: context,
                    themeProvider: themeProvider,
                    style: ScanOverlayStyle.laserLine,
                    icon: Icons.linear_scale,
                    title: l10n.labelOverlayLaserLine,
                    subtitle: l10n.descOverlayLaserLine,
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  _buildOverlayTile(
                    context: context,
                    themeProvider: themeProvider,
                    style: ScanOverlayStyle.pulsingCorners,
                    icon: Icons.crop_free,
                    title: l10n.labelOverlayPulsingCorners,
                    subtitle: l10n.descOverlayPulsingCorners,
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  _buildOverlayTile(
                    context: context,
                    themeProvider: themeProvider,
                    style: ScanOverlayStyle.cyberneticGrid,
                    icon: Icons.grid_4x4,
                    title: l10n.labelOverlayCyberneticGrid,
                    subtitle: l10n.descOverlayCyberneticGrid,
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  _buildOverlayTile(
                    context: context,
                    themeProvider: themeProvider,
                    style: ScanOverlayStyle.subtleDotMatrix,
                    icon: Icons.grain,
                    title: l10n.labelOverlaySubtleDotMatrix,
                    subtitle: l10n.descOverlaySubtleDotMatrix,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverlayTile({
    required BuildContext context,
    required ThemeProvider themeProvider,
    required ScanOverlayStyle style,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final isSelected = themeProvider.scanOverlayStyle == style;
    final accent = Theme.of(context).colorScheme.primary;

    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: accent.withValues(alpha: isSelected ? 0.16 : 0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: isSelected ? accent : Colors.grey, size: 22),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
          fontSize: 15,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 13,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
      trailing: Icon(
        isSelected ? Icons.check_circle : Icons.circle_outlined,
        color: isSelected ? accent : Colors.grey,
      ),
      onTap: () => themeProvider.setScanOverlayStyle(style),
    );
  }
}
