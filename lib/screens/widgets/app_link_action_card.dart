import 'package:flutter/material.dart';
import 'package:sreeraj_qr_reader/l10n/gen/app_localizations.dart';
import 'package:sreeraj_qr_reader/models/parsed_payload.dart';
import 'package:sreeraj_qr_reader/services/payload_action_service.dart';

class AppLinkActionCard extends StatelessWidget {
  final AppLinkPayload payload;

  const AppLinkActionCard({super.key, required this.payload});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final iconData = _getAppIcon();
    final accentColor = _getAccentColor();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: accentColor.withValues(alpha: 0.5), width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: isDark ? 0.2 : 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(iconData, color: accentColor, size: 28),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.appLinkCardTitle,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: accentColor,
                        ),
                      ),
                      Text(
                        payload.appName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                if (payload.storeName != AppStoreName.generic)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: isDark ? 0.3 : 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _getStoreLabel(l10n),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: accentColor,
                      ),
                    ),
                  ),
              ],
            ),

            if (payload.packageId.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                payload.packageId,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],

            const SizedBox(height: 16),

            // Open Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.open_in_new),
                label: Text(l10n.appLinkOpenButton),
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  final launched = await PayloadActionService.openAppLink(
                    payload,
                  );
                  if (!launched && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.appLinkLaunchFailed)),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getAppIcon() {
    switch (payload.storeName) {
      case AppStoreName.playStore:
        return Icons.shop;
      case AppStoreName.whatsApp:
        return Icons.chat;
      case AppStoreName.telegram:
        return Icons.send;
      case AppStoreName.youTube:
        return Icons.play_circle_filled;
      case AppStoreName.generic:
        return Icons.launch;
    }
  }

  Color _getAccentColor() {
    switch (payload.storeName) {
      case AppStoreName.playStore:
        return Colors.green[700]!;
      case AppStoreName.whatsApp:
        return const Color(0xFF25D366);
      case AppStoreName.telegram:
        return const Color(0xFF0088CC);
      case AppStoreName.youTube:
        return Colors.red[700]!;
      case AppStoreName.generic:
        return Colors.blueGrey[700]!;
    }
  }

  String _getStoreLabel(AppLocalizations l10n) {
    switch (payload.storeName) {
      case AppStoreName.playStore:
        return 'PLAY STORE';
      case AppStoreName.whatsApp:
        return 'WHATSAPP';
      case AppStoreName.telegram:
        return 'TELEGRAM';
      case AppStoreName.youTube:
        return 'YOUTUBE';
      case AppStoreName.generic:
        return l10n.appLinkCardTitle.toUpperCase();
    }
  }
}
