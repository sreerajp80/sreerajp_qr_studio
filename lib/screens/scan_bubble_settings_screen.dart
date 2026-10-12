import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/providers/scan_bubble_provider.dart';

/// Settings for the floating Scan bubble that scans codes shown in other apps.
class ScanBubbleSettingsScreen extends StatefulWidget {
  static const String routeName = '/scan_bubble';

  const ScanBubbleSettingsScreen({super.key});

  @override
  State<ScanBubbleSettingsScreen> createState() =>
      _ScanBubbleSettingsScreenState();
}

class _ScanBubbleSettingsScreenState extends State<ScanBubbleSettingsScreen>
    with WidgetsBindingObserver {
  /// Set when the user went to the system permission page from the switch,
  /// so the bubble can start as soon as they come back with it allowed.
  bool _startAfterPermission = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _refresh());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _onResumed();
    }
  }

  Future<void> _refresh() async {
    if (!mounted) return;
    await context.read<ScanBubbleProvider>().refresh();
  }

  Future<void> _onResumed() async {
    if (!mounted) return;
    final provider = context.read<ScanBubbleProvider>();
    await provider.refresh();
    if (_startAfterPermission && provider.hasOverlayPermission) {
      _startAfterPermission = false;
      await _turnOn();
    }
  }

  Future<void> _onSwitchChanged(bool value) async {
    final provider = context.read<ScanBubbleProvider>();
    if (value) {
      await _turnOn();
    } else {
      await provider.turnOff();
    }
  }

  Future<void> _turnOn() async {
    final provider = context.read<ScanBubbleProvider>();
    final l10n = AppLocalizations.of(context);
    final result = await provider.turnOn();
    if (!mounted) return;
    switch (result) {
      case ScanBubbleStartResult.started:
        break;
      case ScanBubbleStartResult.needsPermission:
        await _showPermissionDialog(startAfter: true);
      case ScanBubbleStartResult.failed:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.scanBubbleStartFailed),
            behavior: SnackBarBehavior.floating,
          ),
        );
    }
  }

  Future<void> _showPermissionDialog({required bool startAfter}) async {
    final l10n = AppLocalizations.of(context);
    final provider = context.read<ScanBubbleProvider>();
    final open = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.layers_outlined),
        title: Text(l10n.scanBubblePermissionDialogTitle),
        content: Text(l10n.scanBubblePermissionDialogBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancelButton),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.scanBubbleOpenSettings),
          ),
        ],
      ),
    );
    if (open == true) {
      _startAfterPermission = startAfter;
      await provider.openOverlayPermissionSettings();
    }
  }

  Future<void> _addTile() async {
    final l10n = AppLocalizations.of(context);
    final added = await context.read<ScanBubbleProvider>().requestAddTile();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          added ? l10n.scanBubbleTileAdded : l10n.scanBubbleTileManual,
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final provider = context.watch<ScanBubbleProvider>();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.scanBubbleTitle)),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          children: [
            Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Column(
                children: [
                  SwitchListTile(
                    secondary: const Icon(Icons.bubble_chart_outlined),
                    title: Text(
                      l10n.scanBubbleSwitchTitle,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(l10n.scanBubbleSwitchSubtitle),
                    value: provider.isRunning,
                    onChanged: provider.isLoaded ? _onSwitchChanged : null,
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: Icon(
                      provider.hasOverlayPermission
                          ? Icons.check_circle_outline
                          : Icons.error_outline,
                      color: provider.hasOverlayPermission
                          ? Colors.green
                          : theme.colorScheme.error,
                    ),
                    title: Text(l10n.permissionOverlayTitle),
                    subtitle: Text(
                      provider.hasOverlayPermission
                          ? l10n.scanBubblePermissionGranted
                          : l10n.scanBubblePermissionMissing,
                    ),
                    trailing: provider.hasOverlayPermission
                        ? null
                        : TextButton(
                            onPressed: () =>
                                _showPermissionDialog(startAfter: false),
                            child: Text(l10n.scanBubbleAllowButton),
                          ),
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    secondary: const Icon(Icons.restart_alt),
                    title: Text(l10n.scanBubbleStartOnBootTitle),
                    subtitle: Text(l10n.scanBubbleStartOnBootSubtitle),
                    value: provider.startOnBoot,
                    onChanged: provider.isLoaded
                        ? (value) => provider.setStartOnBoot(value)
                        : null,
                  ),
                ],
              ),
            ),
            if (provider.isTileRequestSupported)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: OutlinedButton.icon(
                  onPressed: _addTile,
                  icon: const Icon(Icons.add_to_home_screen),
                  label: Text(l10n.scanBubbleAddTileButton),
                ),
              ),
            _InfoCard(
              icon: Icons.touch_app_outlined,
              title: l10n.helpGuideScanBubbleUseTitle,
              points: [
                l10n.helpGuideScanBubbleUseBullet1,
                l10n.helpGuideScanBubbleUseBullet2,
                l10n.helpGuideScanBubbleUseBullet3,
                l10n.helpGuideScanBubbleUseBullet4,
              ],
            ),
            _InfoCard(
              icon: Icons.info_outline,
              title: l10n.helpGuideScanBubbleLimitsTitle,
              points: [
                l10n.helpGuideScanBubbleLimitsBullet1,
                l10n.helpGuideScanBubbleLimitsBullet2,
                l10n.helpGuideScanBubbleLimitsBullet3,
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<String> points;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.colorScheme.primary;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: accent),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            for (final point in points)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 7, right: 10),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: accent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        point,
                        style: TextStyle(
                          fontSize: 13.5,
                          color: theme.colorScheme.onSurfaceVariant,
                          height: 1.4,
                        ),
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
}
