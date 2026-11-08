# Change log — Use the "QR Forge" name in the local Play Console notes

Implements plan: [plans/20261107_221634_play_notes_qr_forge_name.md](../plans/20261107_221634_play_notes_qr_forge_name.md)

## What changed

All three files are in the gitignored `play_store_private/` folder (local only, not committed).

- `foreground_service_declaration.md`: step 1 of the reviewer instructions now says
  "Open QR Forge → Settings → **Scan bubble** → turn it on."
- `data_safety_answers.md`: title now says "(QR Forge)".
- `PUBLISHING_GUIDE.md`: title now says "(QR Forge)".

## Not changed (on purpose)

- Past release names such as `SreerajP_QRStudio-v4.1.9_43`, because they are the real names of
  releases already in Play Console.
- `SUBMISSION_RECORD.md` (record of past submissions).
- The internal log tag `QRStudio` in `lib/core/logging/app_logger.dart`.

## Checks

- A search of the folder finds "SreerajP QR Studio" only in `SUBMISSION_RECORD.md`.
- No app code changed, so no build or test run was needed.
- To update in Play Console: if the foreground service declaration is shown again, paste the new
  step 1.
