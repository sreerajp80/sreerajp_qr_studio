import 'package:material_ui/material_ui.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/services/ghost_scan_service.dart';

/// Modal bottom sheet displaying the GhostScan screen content detector guide,
/// quick-action screen scan trigger, and Quick Settings tile setup.
class GhostScanSheet extends StatefulWidget {
  final GhostScanService ghostScanService;
  final VoidCallback? onScanTriggered;

  const GhostScanSheet({
    super.key,
    required this.ghostScanService,
    this.onScanTriggered,
  });

  @override
  State<GhostScanSheet> createState() => _GhostScanSheetState();
}

class _GhostScanSheetState extends State<GhostScanSheet> {
  bool _isTileRequestSupported = false;

  @override
  void initState() {
    super.initState();
    _checkTileSupport();
  }

  Future<void> _checkTileSupport() async {
    final supported = await widget.ghostScanService.isTileRequestSupported();
    if (mounted) {
      setState(() {
        _isTileRequestSupported = supported;
      });
    }
  }

  Future<void> _handleScanNow() async {
    if (mounted && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
    widget.onScanTriggered?.call();
    await widget.ghostScanService.startGhostScan();
  }

  Future<void> _handleAddTile() async {
    final l10n = AppLocalizations.of(context);
    final success = await widget.ghostScanService.requestAddTile();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success ? l10n.bodyGhostScanTileAdded : l10n.helpGhostScanStep1,
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 36,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // Header with icon
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.screenshot_monitor,
                    color: colorScheme.onPrimaryContainer,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.labelGhostScan,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l10n.descGhostScan,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Description
            Text(
              l10n.bodyGhostScan,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20),

            // Step-by-step instructions card
            Card(
              elevation: 0,
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: colorScheme.outlineVariant.withValues(alpha: 0.6),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.titleGhostScanHowItWorks,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildStepRow(
                      number: '1',
                      text: l10n.helpGhostScanStep1,
                      colorScheme: colorScheme,
                      theme: theme,
                    ),
                    const SizedBox(height: 10),
                    _buildStepRow(
                      number: '2',
                      text: l10n.helpGhostScanStep2,
                      colorScheme: colorScheme,
                      theme: theme,
                    ),
                    const SizedBox(height: 10),
                    _buildStepRow(
                      number: '3',
                      text: l10n.helpGhostScanStep3,
                      colorScheme: colorScheme,
                      theme: theme,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Primary Action: Scan Screen Now
            FilledButton.icon(
              onPressed: _handleScanNow,
              icon: const Icon(Icons.fullscreen),
              label: Text(l10n.actionGhostScanNow),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            // Secondary Action: Add Tile (if supported on Android 13+)
            if (_isTileRequestSupported) ...[
              const SizedBox(height: 10),
              OutlinedButton.icon(
                onPressed: _handleAddTile,
                icon: const Icon(Icons.add_to_home_screen),
                label: Text(l10n.actionGhostScanAddTile),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStepRow({
    required String number,
    required String text,
    required ColorScheme colorScheme,
    required ThemeData theme,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 22,
          height: 22,
          margin: const EdgeInsets.only(top: 1, right: 12),
          decoration: BoxDecoration(
            color: colorScheme.primary,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: theme.textTheme.labelSmall?.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}
