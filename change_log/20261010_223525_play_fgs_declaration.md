# Change log — Google Play foreground service declaration answers

Implements plan: [plans/20261010_223025_play_fgs_declaration.md](../plans/20261010_223025_play_fgs_declaration.md)

## What changed

- **New (gitignored, not committed):** `play_store_private/foreground_service_declaration.md`
  - Ready-to-paste answers for the Play Console form
    (App content → Foreground service permissions), matched to Google's current
    help page: use case, description, and "impact if deferred or interrupted" for each type.
  - `mediaProjection` → GhostScan (one-frame screen capture after the system consent prompt).
  - `specialUse` → Scan bubble (a floating button the user turns on). The file also has
    a short note on why no standard type fits, in case the reviewer asks.
  - A placeholder for the video link (the video will be made later) and a shot list for recording it.
- **`docs/release_process.md`** — added one checklist line in "Google Play Declarations"
  pointing to the private answers file.

No app code, manifest, or translation (ARB) changes, so `flutter analyze` and `flutter test`
are not affected.

## Still to do

- Record the demo video, upload it (unlisted), and paste the link into both form entries.
