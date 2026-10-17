import 'dart:convert';

import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sreerajp_qr_studio/l10n/app_message_text.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/models/batch_scan_item.dart';
import 'package:sreerajp_qr_studio/models/history_report_labels.dart';
import 'package:sreerajp_qr_studio/providers/batch_scan_provider.dart';
import 'package:sreerajp_qr_studio/providers/history_provider.dart';
import 'package:sreerajp_qr_studio/widgets/plain_text_export_confirm.dart';
import 'package:sreerajp_qr_studio/widgets/secure_screen.dart';

/// Modal bottom sheet allowing review, management, detail inspection, and multi-format export
/// of codes queued in Continuous Batch Scan Mode.
class BatchReviewSheet extends StatelessWidget {
  const BatchReviewSheet({super.key});

  /// Shows the batch review sheet as a modal bottom sheet.
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const BatchReviewSheet(),
    );
  }

  HistoryReportLabels _reportLabels(AppLocalizations l10n) {
    return HistoryReportLabels(
      reportHeading: l10n.bodyReportHeading,
      reportTitle: l10n.bodyReportTitle,
      exportDateLabel: l10n.labelReportExportDate,
      totalScansLabel: l10n.labelReportTotalScans,
      scanNumberLabel: l10n.labelReportScanNumber,
      idLabel: l10n.labelReportId,
      timestampLabel: l10n.labelReportTimestamp,
      formatLabel: l10n.labelReportFormat,
      categoryLabel: l10n.labelReportCategory,
      safetyScoreLabel: l10n.labelReportSafetyScore,
      starredLabel: l10n.labelReportStarred,
      starredYes: l10n.labelReportStarredYes,
      starredNo: l10n.labelReportStarredNo,
      locationLabel: l10n.labelReportLocation,
      notesLabel: l10n.labelReportNotes,
      contentLabel: l10n.labelReportContent,
      columnDateTime: l10n.labelReportColumnDateTime,
      columnFormat: l10n.labelReportColumnFormat,
      columnCategory: l10n.labelReportColumnCategory,
      columnSafety: l10n.labelReportColumnSafety,
      columnContent: l10n.labelReportColumnContent,
      columnNotes: l10n.labelReportColumnNotes,
    );
  }

  Future<void> _handleExport(
    BuildContext context,
    BatchScanProvider provider,
    ExportFormat format,
  ) async {
    if (!await confirmPlainTextExport(context)) return;
    if (!context.mounted) return;
    final l10n = AppLocalizations.of(context);
    final result = await provider.exportBatch(format, _reportLabels(l10n));

    if (format == ExportFormat.pdf) {
      final pdfBytes = result as Uint8List;
      // ignore: deprecated_member_use
      await Share.shareXFiles([
        XFile.fromData(
          pdfBytes,
          mimeType: 'application/pdf',
          name: 'Sreeraj_QR_Batch_Scans.pdf',
        ),
      ], text: l10n.bodyExportSharePdf);
    } else {
      final textResult = result as String;
      final mimeType = switch (format) {
        ExportFormat.csv => 'text/csv',
        ExportFormat.json => 'application/json',
        _ => 'text/plain',
      };
      final fileName = switch (format) {
        ExportFormat.csv => 'batch_scans.csv',
        ExportFormat.json => 'batch_scans.json',
        _ => 'batch_scans.txt',
      };

      // ignore: deprecated_member_use
      await Share.shareXFiles([
        XFile.fromData(
          utf8.encode(textResult),
          mimeType: mimeType,
          name: fileName,
        ),
      ], text: l10n.bodyExportShare);
    }
  }

  void _showExportFormatDialog(
    BuildContext context,
    BatchScanProvider provider,
  ) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.titleBatchExport),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.table_chart_outlined),
              title: Text(l10n.labelExportCsv),
              subtitle: Text(l10n.descExportCsv),
              onTap: () {
                Navigator.pop(ctx);
                _handleExport(context, provider, ExportFormat.csv);
              },
            ),
            ListTile(
              leading: const Icon(Icons.data_object_outlined),
              title: Text(l10n.labelExportJson),
              subtitle: Text(l10n.descExportJson),
              onTap: () {
                Navigator.pop(ctx);
                _handleExport(context, provider, ExportFormat.json);
              },
            ),
            ListTile(
              leading: const Icon(Icons.description_outlined),
              title: Text(l10n.labelExportTxt),
              subtitle: Text(l10n.descExportTxt),
              onTap: () {
                Navigator.pop(ctx);
                _handleExport(context, provider, ExportFormat.txt);
              },
            ),
            ListTile(
              leading: const Icon(Icons.picture_as_pdf_outlined),
              title: Text(l10n.labelExportPdf),
              subtitle: Text(l10n.descExportPdf),
              onTap: () {
                Navigator.pop(ctx);
                _handleExport(context, provider, ExportFormat.pdf);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.actionCancel),
          ),
        ],
      ),
    );
  }

  void _confirmClearBatch(BuildContext context, BatchScanProvider provider) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.titleBatchClearConfirm),
        content: Text(l10n.bodyBatchClearConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.actionCancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            onPressed: () {
              provider.clearBatch();
              Navigator.pop(ctx);
            },
            child: Text(l10n.actionBatchClear),
          ),
        ],
      ),
    );
  }

  void _showItemDetails(BuildContext context, BatchScanItem item) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.55,
        minChildSize: 0.35,
        maxChildSize: 0.85,
        expand: false,
        builder: (ctx, scrollController) => SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.titleBatchItemDetails,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy),
                    tooltip: l10n.tooltipHistoryCopyString,
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: item.rawValue));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.bodyCopiedToClipboard),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  Chip(
                    avatar: const Icon(Icons.qr_code, size: 16),
                    label: Text(item.format.name.toUpperCase()),
                    visualDensity: VisualDensity.compact,
                  ),
                  if (item.parsedPayload != null)
                    Chip(
                      avatar: const Icon(Icons.category_outlined, size: 16),
                      label: Text(item.parsedPayload!.type.name.toUpperCase()),
                      visualDensity: VisualDensity.compact,
                    ),
                  Chip(
                    avatar: const Icon(Icons.access_time, size: 16),
                    label: Text(
                      TimeOfDay.fromDateTime(item.timestamp).format(context),
                    ),
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                l10n.labelReportContent,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest.withValues(
                    alpha: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: theme.dividerColor),
                ),
                child: SelectableText(
                  item.rawValue,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              if (item.isUrl) ...[
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(
                      item.isSafeUrl == true
                          ? Icons.verified_user_outlined
                          : Icons.gpp_maybe_outlined,
                      color: item.isSafeUrl == true
                          ? Colors.green
                          : Colors.amber,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      l10n.titleSafetyAnalysis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color:
                            (item.isSafeUrl == true
                                    ? Colors.green
                                    : Colors.amber)
                                .withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${item.safetyScore}%',
                        style: TextStyle(
                          color: item.isSafeUrl == true
                              ? Colors.green
                              : Colors.amber,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (item.isAnalyzing)
                  Row(
                    children: [
                      const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      const SizedBox(width: 10),
                      Text(l10n.bodyBatchAnalyzingUrl),
                    ],
                  )
                else if (item.safetyChecks.isNotEmpty)
                  ...item.safetyChecks.map(
                    (check) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Icon(
                            check.passed
                                ? Icons.check_circle
                                : Icons.error_outline,
                            size: 18,
                            color: check.passed ? Colors.green : Colors.red,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              appMessageText(l10n, check.message),
                              style: theme.textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final batchProvider = Provider.of<BatchScanProvider>(context);

    return SecureScreen(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.82,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            // Drag handle
            Container(
              width: 44,
              height: 4,
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Header Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.inventory_2_outlined,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              l10n.labelBatchReview,
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${batchProvider.count}',
                                style: TextStyle(
                                  color: theme.colorScheme.onPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          l10n.descBatchReview,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                    tooltip: l10n.actionClose,
                  ),
                ],
              ),
            ),
            // URL Safety & Stats Banner
            if (batchProvider.totalUrls > 0)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color:
                      (batchProvider.suspiciousUrlsCount > 0
                              ? Colors.amber
                              : Colors.green)
                          .withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color:
                        (batchProvider.suspiciousUrlsCount > 0
                                ? Colors.amber
                                : Colors.green)
                            .withValues(alpha: 0.35),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      batchProvider.suspiciousUrlsCount > 0
                          ? Icons.gpp_maybe_outlined
                          : Icons.verified_user_outlined,
                      color: batchProvider.suspiciousUrlsCount > 0
                          ? Colors.amber
                          : Colors.green,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        l10n.bodyBatchUrlSafetySummary(
                          batchProvider.safeUrlsCount,
                          batchProvider.suspiciousUrlsCount,
                          batchProvider.totalUrls,
                        ),
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: batchProvider.suspiciousUrlsCount > 0
                              ? Colors.amber[800]
                              : Colors.green[800],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            // Action Buttons Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.ios_share, size: 18),
                      label: Text(l10n.titleBatchExport),
                      onPressed: batchProvider.items.isEmpty
                          ? null
                          : () =>
                                _showExportFormatDialog(context, batchProvider),
                    ),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.delete_sweep_outlined, size: 18),
                    label: Text(l10n.actionBatchClear),
                    onPressed: batchProvider.items.isEmpty
                        ? null
                        : () => _confirmClearBatch(context, batchProvider),
                  ),
                ],
              ),
            ),
            // Deduplication Toggle Chip
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              child: Row(
                children: [
                  FilterChip(
                    selected: batchProvider.preventDuplicates,
                    onSelected: (val) =>
                        batchProvider.setPreventDuplicates(val),
                    avatar: Icon(
                      batchProvider.preventDuplicates
                          ? Icons.check
                          : Icons.filter_none,
                      size: 16,
                    ),
                    label: Text(l10n.labelBatchPreventDuplicates),
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
            ),
            const Divider(height: 16),
            // Batch List
            Expanded(
              child: batchProvider.items.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.qr_code_scanner,
                              size: 64,
                              color: theme.colorScheme.onSurfaceVariant
                                  .withValues(alpha: 0.4),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              l10n.emptyBatchTitle,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              l10n.emptyBatchBody,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant
                                    .withValues(alpha: 0.7),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                      itemCount: batchProvider.items.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final item = batchProvider.items[index];
                        return Card(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                            side: BorderSide(
                              color: theme.dividerColor.withValues(alpha: 0.3),
                            ),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(14),
                            onTap: () => _showItemDetails(context, item),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  // Format Icon / Tag
                                  Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.primaryContainer
                                          .withValues(alpha: 0.6),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        item.isUrl
                                            ? Icons.link
                                            : Icons.qr_code_2,
                                        color: theme.colorScheme.primary,
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  // Content summary
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.rawValue,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Text(
                                              item.format.name.toUpperCase(),
                                              style: theme.textTheme.labelSmall
                                                  ?.copyWith(
                                                    color: theme
                                                        .colorScheme
                                                        .onSurfaceVariant,
                                                  ),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              '•',
                                              style: TextStyle(
                                                color: theme
                                                    .colorScheme
                                                    .onSurfaceVariant,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              TimeOfDay.fromDateTime(
                                                item.timestamp,
                                              ).format(context),
                                              style: theme.textTheme.labelSmall
                                                  ?.copyWith(
                                                    color: theme
                                                        .colorScheme
                                                        .onSurfaceVariant,
                                                  ),
                                            ),
                                            if (item.isUrl) ...[
                                              const SizedBox(width: 8),
                                              if (item.isAnalyzing)
                                                const SizedBox(
                                                  width: 12,
                                                  height: 12,
                                                  child:
                                                      CircularProgressIndicator(
                                                        strokeWidth: 1.5,
                                                      ),
                                                )
                                              else
                                                Icon(
                                                  item.isSafeUrl == true
                                                      ? Icons.verified_user
                                                      : Icons.warning_amber,
                                                  size: 14,
                                                  color: item.isSafeUrl == true
                                                      ? Colors.green
                                                      : Colors.amber,
                                                ),
                                            ],
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Remove button
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      size: 20,
                                    ),
                                    tooltip: l10n.actionHistoryDelete,
                                    onPressed: () =>
                                        batchProvider.removeItem(item.id),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
