import 'package:material_ui/material_ui.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';

/// Warns that a CSV, JSON, TXT or PDF export is not encrypted and asks the
/// user to confirm (engineering standard §15.2). Returns `true` to continue.
///
/// [suggestBackup] adds a line pointing to the encrypted backup, for the
/// history export dialog where that option is right next to it.
Future<bool> confirmPlainTextExport(
  BuildContext context, {
  bool suggestBackup = false,
}) async {
  final l10n = AppLocalizations.of(context);
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      icon: const Icon(Icons.lock_open_outlined),
      title: Text(l10n.titlePlainExport),
      content: Text(
        suggestBackup
            ? '${l10n.bodyPlainExport}\n\n${l10n.bodyPlainExportBackupHint}'
            : l10n.bodyPlainExport,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.actionCancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(l10n.actionExportAnyway),
        ),
      ],
    ),
  );
  return result ?? false;
}
