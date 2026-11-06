# Plan: Fix stale backup format name in security doc

**Status:** completed

## The issue

`docs/security.md` §6 "Rules" says:

> Encrypted formats are versioned (`h2:` for history; `SREERAJ_QR_BACKUP_V1` for backups).

New backups are written as `SREERAJ_QR_BACKUP_V2` (`lib/services/history_export_service.dart`,
`backupHeaderV2`), and AirQR sync packages as `SREERAJ_AIRQR_SYNC_V2`
(`lib/services/device_sync_service.dart`). V1 is read only (§6.3). A reader of the old line could
think backups still use the weak v1 scheme (unsalted SHA-256 key, AES-CBC, no tag).

## The fix

Change that one line to:

> Encrypted formats are versioned (`h2:` for history; `SREERAJ_QR_BACKUP_V2` and
> `SREERAJ_AIRQR_SYNC_V2` for backups and sync packages; the `_V1` headers are read only).

## Files to change

- `docs/security.md` (one line in §6 Rules)

## Security impact

None. Documentation only; no code change.

## Checks after the change

None needed beyond reading the line (no code touched).
