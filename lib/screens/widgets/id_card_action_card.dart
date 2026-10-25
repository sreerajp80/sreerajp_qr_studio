import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sreerajp_qr_studio/l10n/formatting_locale.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/models/parsed_payload.dart';

/// Shows the fields of a scanned driving licence / ID card.
///
/// The document number is masked until the user taps Show. Nothing here
/// goes online, and ID-card scans are never saved to history.
class IdCardActionCard extends StatefulWidget {
  final IdCardPayload payload;

  const IdCardActionCard({super.key, required this.payload});

  /// Hides all but the last 4 characters of [number].
  static String maskNumber(String number) {
    if (number.length <= 4) return '•' * number.length;
    return '${'•' * (number.length - 4)}${number.substring(number.length - 4)}';
  }

  @override
  State<IdCardActionCard> createState() => _IdCardActionCardState();
}

class _IdCardActionCardState extends State<IdCardActionCard> {
  bool _showNumber = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final payload = widget.payload;
    final dateFormat = DateFormat.yMMMd(
      formattingLocale(Localizations.localeOf(context)),
    );

    final issuer = [
      payload.issuer,
      payload.country,
    ].where((part) => part.isNotEmpty).join(', ');
    final number = _showNumber
        ? payload.documentNumber
        : IdCardActionCard.maskNumber(payload.documentNumber);

    final rows = <(String, String)>[
      if (payload.fullName.isNotEmpty) (l10n.labelIdCardName, payload.fullName),
      if (payload.dateOfBirth != null)
        (l10n.labelIdCardBirthDate, dateFormat.format(payload.dateOfBirth!)),
      if (payload.expiryDate != null)
        (l10n.labelIdCardExpiry, dateFormat.format(payload.expiryDate!)),
      if (payload.documentNumber.isNotEmpty) (l10n.labelIdCardNumber, number),
      if (issuer.isNotEmpty) (l10n.labelIdCardIssuer, issuer),
      if (payload.address.isNotEmpty)
        (l10n.labelIdCardAddress, payload.address),
    ];

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.indigo[300]!, width: 1.5),
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
                    color: isDark ? const Color(0xFF1A1F3B) : Colors.indigo[50],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.badge,
                    color: isDark ? Colors.indigo[200] : Colors.indigo[700],
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    l10n.titleIdCard,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.indigo[200] : Colors.indigo[800],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            for (final (label, value) in rows)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: theme.textTheme.bodySmall),
                    SelectableText(value, style: theme.textTheme.bodyLarge),
                  ],
                ),
              ),

            const SizedBox(height: 8),

            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                if (payload.documentNumber.isNotEmpty)
                  OutlinedButton.icon(
                    icon: Icon(
                      _showNumber ? Icons.visibility_off : Icons.visibility,
                    ),
                    label: Text(
                      _showNumber
                          ? l10n.actionIdCardHideNumber
                          : l10n.actionIdCardShowNumber,
                    ),
                    onPressed: () => setState(() => _showNumber = !_showNumber),
                  ),
                TextButton.icon(
                  icon: const Icon(Icons.copy, size: 16),
                  label: Text(l10n.actionIdCardCopy),
                  onPressed: () {
                    final text = rows
                        .map((row) => '${row.$1}: ${row.$2}')
                        .join('\n');
                    Clipboard.setData(ClipboardData(text: text));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.bodyCopiedToClipboard)),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                Icon(
                  Icons.history_toggle_off,
                  size: 16,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    l10n.bodyIdCardNotSaved,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
