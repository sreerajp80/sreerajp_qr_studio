# Change log: Fix stale backup format name in security doc

Plan: [plans/20261106_073417_security_doc_backup_header_fix.md](../plans/20261106_073417_security_doc_backup_header_fix.md)

## What changed

- `docs/security.md` §6 Rules: the "Encrypted formats are versioned" line named
  `SREERAJ_QR_BACKUP_V1` as the backup format. It now names `SREERAJ_QR_BACKUP_V2` and
  `SREERAJ_AIRQR_SYNC_V2`, and says the `_V1` headers are read only. This matches
  `history_export_service.dart` (`backupHeaderV2`), `device_sync_service.dart`
  (`syncHeaderV2`) and §6.3.

## Why

A reader of the old line could think backups still use the weak v1 scheme (unsalted SHA-256
key, AES-CBC, no tag). Found while checking the other §6 crypto claims against the code;
everything else in §6 already matched.

## Checks

Documentation only; no code changed, so no build or test run was needed.
