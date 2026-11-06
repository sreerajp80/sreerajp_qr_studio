import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sreerajp_qr_studio/l10n/app_message_text.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/models/ar_code_target.dart';
import 'package:sreerajp_qr_studio/providers/ar_codevision_provider.dart';
import 'package:url_launcher/url_launcher.dart';

/// Non-blocking floating action sheet for examining tapped AR targets.
class ArActionSheet extends StatelessWidget {
  final ArCodeTarget target;
  final VoidCallback onClose;

  const ArActionSheet({super.key, required this.target, required this.onClose});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final provider = Provider.of<ArCodevisionProvider>(context, listen: false);

    return Positioned(
      bottom: 20 + MediaQuery.viewPaddingOf(context).bottom,
      left: 16,
      right: 16,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(24),
        color: theme.colorScheme.surface,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: theme.colorScheme.outlineVariant),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        target.isUrl ? Icons.link : Icons.qr_code,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        appMessageText(l10n, target.formatName),
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: onClose,
                    tooltip: l10n.tooltipArCloseSheet,
                  ),
                ],
              ),
              const Divider(height: 12),
              const SizedBox(height: 4),
              // Safety HUD Badge Indicator
              if (target.isUrl) ...[
                Row(
                  children: [
                    _getSafetyIcon(target.safetyStatus),
                    const SizedBox(width: 8),
                    Text(
                      _getSafetyText(l10n, target.safetyStatus),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _getSafetyColor(target.safetyStatus),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
              // Raw Value content display
              SelectableText(
                target.rawValue,
                style: theme.textTheme.bodyMedium,
                maxLines: 4,
              ),
              const SizedBox(height: 8),
              if (provider.hudMode == ArHudMode.warehouse)
                Text(
                  l10n.bodyArItemPriceTag(target.priceTag),
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const SizedBox(height: 12),
              // Action Buttons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: target.rawValue));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.bodyArContentCopied),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: const Icon(Icons.copy, size: 18),
                    label: Text(l10n.actionArCopy),
                  ),
                  const SizedBox(width: 8),
                  if (target.isUrl)
                    FilledButton.icon(
                      onPressed: () => _openUrl(context),
                      icon: const Icon(Icons.open_in_browser, size: 18),
                      label: Text(l10n.actionArOpenUrl),
                    )
                  else
                    FilledButton.icon(
                      onPressed: () {
                        provider.toggleTargetSelection(target.id);
                        onClose();
                      },
                      icon: Icon(
                        target.isSelected
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        size: 18,
                      ),
                      label: Text(
                        target.isSelected
                            ? l10n.actionArDeselect
                            : l10n.actionArSelect,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Opens the link. Unless the verdict is "safe", asks first, the same way
  /// the result screen does ("Open anyway"), so AR mode is not a shortcut
  /// around the safety warning.
  Future<void> _openUrl(BuildContext context) async {
    final uri = Uri.tryParse(target.rawValue);
    if (uri == null) return;

    final status = target.safetyStatus;
    if (status != TargetSafetyStatus.safe) {
      final confirmed = await _confirmOpen(context, status);
      if (confirmed != true) return;
    }

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<bool?> _confirmOpen(BuildContext context, TargetSafetyStatus status) {
    final l10n = AppLocalizations.of(context);
    final isWarning = status == TargetSafetyStatus.warning;
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              isWarning ? Icons.warning : Icons.info_outline,
              color: isWarning ? Colors.red : Colors.orange,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                isWarning ? l10n.titleWarningDialog : l10n.titleCautionDialog,
              ),
            ),
          ],
        ),
        content: Text(
          isWarning ? l10n.bodyWarningDialog : l10n.bodyCautionDialog,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.actionCancel),
          ),
          // For a warning, keep "Open anyway" plain so Cancel is the easy
          // choice.
          if (isWarning)
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text(l10n.actionOpenAnyway),
            )
          else
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              child: Text(l10n.actionOpenAnyway),
            ),
        ],
      ),
    );
  }

  Icon _getSafetyIcon(TargetSafetyStatus status) {
    switch (status) {
      case TargetSafetyStatus.safe:
        return const Icon(Icons.verified_user, color: Colors.green);
      case TargetSafetyStatus.warning:
        return const Icon(Icons.gpp_maybe, color: Colors.red);
      case TargetSafetyStatus.unknown:
        return const Icon(Icons.help_outline, color: Colors.amber);
    }
  }

  String _getSafetyText(AppLocalizations l10n, TargetSafetyStatus status) {
    switch (status) {
      case TargetSafetyStatus.safe:
        return l10n.bodyArSafetyStatusSafe;
      case TargetSafetyStatus.warning:
        return l10n.bodyArSafetyStatusWarning;
      case TargetSafetyStatus.unknown:
        return l10n.bodyArSafetyStatusUnknown;
    }
  }

  Color _getSafetyColor(TargetSafetyStatus status) {
    switch (status) {
      case TargetSafetyStatus.safe:
        return Colors.green;
      case TargetSafetyStatus.warning:
        return Colors.red;
      case TargetSafetyStatus.unknown:
        return Colors.amber.shade800;
    }
  }
}
