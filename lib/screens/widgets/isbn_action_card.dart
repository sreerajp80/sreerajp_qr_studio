import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sreeraj_qr_reader/l10n/gen/app_localizations.dart';
import 'package:sreeraj_qr_reader/models/parsed_payload.dart';
import 'package:sreeraj_qr_reader/services/payload_action_service.dart';

class IsbnActionCard extends StatelessWidget {
  final IsbnPayload payload;

  const IsbnActionCard({super.key, required this.payload});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.brown[300]!, width: 1.5),
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
                    color: isDark ? const Color(0xFF3B2415) : Colors.brown[50],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.menu_book,
                    color: isDark ? Colors.brown[300] : Colors.brown[700],
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.isbnCardTitle,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.brown[300] : Colors.brown[800],
                        ),
                      ),
                      SelectableText(
                        _formatIsbn(payload.isbn),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace',
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.brown[900] : Colors.brown[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    payload.isIsbn13 ? 'ISBN-13' : 'ISBN-10',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.brown[100] : Colors.brown[900],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Action Buttons — Two lookup options
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.book),
                    label: Text(l10n.isbnGoogleBooksButton),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown[700],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () async {
                      final launched = await PayloadActionService.lookupBook(
                        payload,
                      );
                      if (!launched && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.isbnLaunchFailed)),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.public),
                    label: Text(l10n.isbnOpenLibraryButton),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () async {
                      final launched = await PayloadActionService.lookupBook(
                        payload,
                        useGoogleBooks: false,
                      );
                      if (!launched && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.isbnLaunchFailed)),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Copy ISBN
            Center(
              child: TextButton.icon(
                icon: const Icon(Icons.copy, size: 16),
                label: Text(l10n.isbnCopyButton),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: payload.isbn));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.copiedToClipboard)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Formats an ISBN for display with dashes.
  String _formatIsbn(String isbn) {
    if (isbn.length == 13) {
      return '${isbn.substring(0, 3)}-${isbn.substring(3, 4)}-${isbn.substring(4, 9)}-${isbn.substring(9, 12)}-${isbn.substring(12)}';
    } else if (isbn.length == 10) {
      return '${isbn.substring(0, 1)}-${isbn.substring(1, 5)}-${isbn.substring(5, 9)}-${isbn.substring(9)}';
    }
    return isbn;
  }
}
