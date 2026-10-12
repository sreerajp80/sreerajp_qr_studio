import 'package:flutter/material.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';

/// Short safety verdict for a scanned link, shown near the top of the result
/// screen so the user sees it next to the actions. The full check list lives
/// further down; [onSeeDetails] scrolls to it.
class UrlVerdictCard extends StatelessWidget {
  final bool isLoading;

  /// Number of checks that failed.
  final int failedCount;

  /// Number of checks that ran and passed (skipped checks not counted).
  final int passedCount;

  /// Number of checks that actually ran (skipped checks not counted).
  final int ranCount;

  /// Localized name of the first failed check, if any.
  final String? firstFailedName;

  final bool activeProbing;
  final VoidCallback? onSeeDetails;

  const UrlVerdictCard({
    super.key,
    required this.isLoading,
    required this.failedCount,
    required this.passedCount,
    required this.ranCount,
    required this.activeProbing,
    this.firstFailedName,
    this.onSeeDetails,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasIssues = failedCount > 0;

    final MaterialColor tone = isLoading
        ? Colors.blue
        : (hasIssues ? Colors.red : Colors.green);
    final Color background = isDark
        ? (isLoading
              ? const Color(0xFF0D253F)
              : hasIssues
              ? const Color(0xFF3F0D0D)
              : const Color(0xFF0D3F1B))
        : tone[50]!;
    final Color border = isDark ? tone[700]! : tone[200]!;
    final Color strong = isDark ? tone[200]! : tone[800]!;
    final Color soft = isDark ? tone[300]! : tone[700]!;

    final headline = isLoading
        ? l10n.verdictChecking
        : hasIssues
        ? l10n.verdictIssuesFound(failedCount)
        : l10n.verdictNoIssues;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: border, width: 1.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(2),
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else
            Icon(
              hasIssues ? Icons.warning_amber_rounded : Icons.verified_user,
              color: soft,
              size: 28,
            ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  headline,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: strong,
                  ),
                ),
                if (!isLoading && firstFailedName != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    firstFailedName!,
                    style: TextStyle(fontSize: 13, color: soft),
                  ),
                ],
                if (!isLoading) ...[
                  const SizedBox(height: 4),
                  Text(
                    '${l10n.verdictChecksPassed(passedCount, ranCount)}'
                    ' · '
                    '${activeProbing ? l10n.verdictModeActive : l10n.verdictModePrivate}',
                    style: TextStyle(fontSize: 12, color: soft),
                  ),
                ],
                if (!isLoading && onSeeDetails != null)
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: TextButton(
                      onPressed: onSeeDetails,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 36),
                        foregroundColor: strong,
                      ),
                      child: Text(l10n.verdictSeeDetails),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
