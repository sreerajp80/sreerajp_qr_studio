import 'dart:async';
import 'dart:convert';

import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/models/app_message.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sreerajp_qr_studio/l10n/app_message_text.dart';
import 'package:sreerajp_qr_studio/models/backup_exception.dart';
import 'package:sreerajp_qr_studio/models/history_report_labels.dart';
import 'package:sreerajp_qr_studio/providers/history_provider.dart';
import 'package:sreerajp_qr_studio/widgets/plain_text_export_confirm.dart';
import 'package:sreerajp_qr_studio/widgets/secure_screen.dart';

/// Modal dialog for choosing export format (CSV, JSON, TXT, PDF) or performing password-encrypted local backup/restore.
class ExportImportDialog extends StatefulWidget {
  const ExportImportDialog({super.key});

  @override
  State<ExportImportDialog> createState() => _ExportImportDialogState();
}

class _ExportImportDialogState extends State<ExportImportDialog> {
  final _passphraseController = TextEditingController();
  final _backupPayloadController = TextEditingController();
  bool _isRestoreMode = false;

  @override
  void dispose() {
    _passphraseController.dispose();
    _backupPayloadController.dispose();
    super.dispose();
  }

  Future<void> _handleExport(BuildContext context, ExportFormat format) async {
    if (!await confirmPlainTextExport(context, suggestBackup: true)) return;
    if (!context.mounted) return;
    final l10n = AppLocalizations.of(context);
    final provider = Provider.of<HistoryProvider>(context, listen: false);
    final result = await provider.exportData(format, _reportLabels(l10n));

    if (!mounted) return;

    if (format == ExportFormat.pdf) {
      final pdfBytes = result as Uint8List;
      // ignore: deprecated_member_use
      await Share.shareXFiles([
        XFile.fromData(
          pdfBytes,
          mimeType: 'application/pdf',
          name: 'Sreeraj_QR_History.pdf',
        ),
      ], text: l10n.bodyExportSharePdf);
    } else {
      final textResult = result as String;
      final mimeType = format == ExportFormat.csv
          ? 'text/csv'
          : format == ExportFormat.json
          ? 'application/json'
          : 'text/plain';
      final fileName = format == ExportFormat.csv
          ? 'history.csv'
          : format == ExportFormat.json
          ? 'history.json'
          : 'history.txt';

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

  /// Shows a non-dismissable progress dialog while [work] runs (the backup
  /// key derivation takes a few seconds on a phone).
  Future<T> _withProgress<T>(
    BuildContext context,
    String message,
    Future<T> Function() work,
  ) async {
    final navigator = Navigator.of(context, rootNavigator: true);
    unawaited(
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => PopScope(
          canPop: false,
          child: AlertDialog(
            content: Row(
              children: [
                const CircularProgressIndicator(),
                const SizedBox(width: 16),
                Expanded(child: Text(message)),
              ],
            ),
          ),
        ),
      ),
    );
    try {
      return await work();
    } finally {
      navigator.pop();
    }
  }

  Future<void> _handleEncryptedBackup(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final passphrase = _passphraseController.text.trim();
    if (passphrase.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.errorExportPassphraseRequired)),
      );
      return;
    }

    final provider = Provider.of<HistoryProvider>(context, listen: false);
    final navigator = Navigator.of(context);
    final backupContainer = await _withProgress(
      context,
      l10n.bodyEncryptingBackup,
      () => provider.createEncryptedBackup(passphrase),
    );

    // ignore: deprecated_member_use
    await Share.shareXFiles([
      XFile.fromData(
        utf8.encode(backupContainer),
        mimeType: 'application/json',
        name: 'sreeraj_qr_backup.sreerajqr',
      ),
    ], text: l10n.bodyExportShareBackup);

    if (mounted) navigator.pop();
  }

  Future<void> _handleRestore(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final passphrase = _passphraseController.text.trim();
    final backupData = _backupPayloadController.text.trim();
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    if (passphrase.isEmpty || backupData.isEmpty) {
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.errorRestoreFieldsRequired)),
      );
      return;
    }

    final provider = Provider.of<HistoryProvider>(context, listen: false);
    try {
      final count = await _withProgress(
        context,
        l10n.bodyOpeningBackup,
        () => provider.restoreEncryptedBackup(backupData, passphrase),
      );
      if (mounted) {
        messenger.showSnackBar(
          SnackBar(content: Text(l10n.bodyRestoreSuccess(count))),
        );
        navigator.pop();
      }
    } on BackupException catch (e) {
      if (mounted) {
        messenger.showSnackBar(
          SnackBar(
            content: Text(
              l10n.errorRestoreFailed(appMessageText(l10n, e.message)),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        messenger.showSnackBar(
          SnackBar(
            content: Text(
              l10n.errorRestoreFailed(
                appMessageText(
                  l10n,
                  const AppMessage(AppMessageKey.backupInvalidFormat),
                ),
              ),
            ),
          ),
        );
      }
    }
  }

  /// Collects the localized wording the report builders need.
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return SecureScreen(
      child: AlertDialog(
        title: Row(
          children: [
            Icon(
              _isRestoreMode ? Icons.settings_backup_restore : Icons.ios_share,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(width: 8),
            Text(
              _isRestoreMode ? l10n.titleRestoreDialog : l10n.titleExportDialog,
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: FilterChip(
                      label: Text(l10n.tabExportRecords),
                      selected: !_isRestoreMode,
                      onSelected: (val) =>
                          setState(() => _isRestoreMode = false),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FilterChip(
                      label: Text(l10n.tabRestoreBackup),
                      selected: _isRestoreMode,
                      onSelected: (val) =>
                          setState(() => _isRestoreMode = true),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (!_isRestoreMode) ...[
                Text(
                  l10n.titleExportFormat,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ListTile(
                  leading: const Icon(Icons.table_chart, color: Colors.green),
                  title: Text(l10n.labelExportCsv),
                  subtitle: Text(l10n.descExportCsv),
                  onTap: () => _handleExport(context, ExportFormat.csv),
                ),
                ListTile(
                  leading: const Icon(Icons.code, color: Colors.blue),
                  title: Text(l10n.labelExportJson),
                  subtitle: Text(l10n.descExportJson),
                  onTap: () => _handleExport(context, ExportFormat.json),
                ),
                ListTile(
                  leading: const Icon(Icons.description, color: Colors.orange),
                  title: Text(l10n.labelExportTxt),
                  subtitle: Text(l10n.descExportTxt),
                  onTap: () => _handleExport(context, ExportFormat.txt),
                ),
                ListTile(
                  leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
                  title: Text(l10n.labelExportPdf),
                  subtitle: Text(l10n.descExportPdf),
                  onTap: () => _handleExport(context, ExportFormat.pdf),
                ),
                const Divider(height: 24),
                Text(
                  l10n.titleExportBackup,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _passphraseController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: l10n.labelExportPassphrase,
                    hintText: l10n.helpExportPassphrase,
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.security),
                    label: Text(l10n.actionExportCreateBackup),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primaryContainer,
                      foregroundColor: theme.colorScheme.onPrimaryContainer,
                    ),
                    onPressed: () => _handleEncryptedBackup(context),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.stream),
                    label: Text(l10n.actionAirQrSyncBeam),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                        context,
                        '/air_qr_transmitter',
                        arguments: {'syncMode': true},
                      );
                    },
                  ),
                ),
              ] else ...[
                Text(
                  l10n.titleRestore,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _passphraseController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: l10n.labelRestorePassphrase,
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _backupPayloadController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: l10n.labelRestorePayload,
                    hintText: l10n.helpRestorePayload,
                    prefixIcon: const Icon(Icons.paste),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.content_paste),
                      tooltip: l10n.helpRestorePayload,
                      onPressed: () async {
                        final data = await Clipboard.getData(
                          Clipboard.kTextPlain,
                        );
                        if (data?.text != null) {
                          _backupPayloadController.text = data!.text!;
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.restore),
                    label: Text(l10n.actionRestore),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                    ),
                    onPressed: () => _handleRestore(context),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.qr_code_scanner),
                    label: Text(l10n.titleAirQrReceiver),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/air_qr');
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.actionClose),
          ),
        ],
      ),
    );
  }
}
