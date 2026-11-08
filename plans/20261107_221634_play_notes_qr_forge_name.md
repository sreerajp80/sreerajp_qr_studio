# Plan — Use the "QR Forge" name in the local Play Console notes

**Status:** completed

Follow-up to [plans/20261107_220156_rename_app_qr_forge.md](20261107_220156_rename_app_qr_forge.md).

## Issue

After the rename, some local Play Console notes (gitignored folder `play_store_private/`) still
say "SreerajP QR Studio". The one that matters is the reviewer instructions in the foreground
service declaration: step 1 tells Google's reviewer to "Open SreerajP QR Studio", a name the
app no longer shows. If pasted again as it is, a reviewer may not find the app.

## Files to change (all in the gitignored `play_store_private/` folder)

1. `foreground_service_declaration.md` line 118: "Open SreerajP QR Studio → Settings →
   **Scan bubble** → turn it on." → "Open QR Forge → Settings → **Scan bubble** → turn it on."
2. `data_safety_answers.md` title → "(QR Forge)".
3. `PUBLISHING_GUIDE.md` title → "(QR Forge)".

## Not changed

- Past release names such as `SreerajP_QRStudio-v4.1.9_43` in `PRODUCTION_ACCESS_APPLICATION.md`
  and `PUBLISHING_GUIDE.md`. These are the real names of releases already in Play Console, so
  they must stay as they are.
- `SUBMISSION_RECORD.md` (record of past submissions).
- The internal log tag `QRStudio` in `lib/core/logging/app_logger.dart` (developers only; users
  never see it).

## Steps

1. Make the three edits.
2. Write the change log.

Nothing in the app changes, so no build or test run is needed.

## Security impact

None. Local notes only; no code, permissions, storage or network change.
