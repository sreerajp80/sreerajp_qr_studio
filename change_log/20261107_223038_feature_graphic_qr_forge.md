# Change log — New Play Store feature graphic with the "QR Forge" name

Implements plan: [plans/20261107_222035_feature_graphic_qr_forge.md](../plans/20261107_222035_feature_graphic_qr_forge.md)

## What changed

Both files are in the gitignored `play_store_private/` folder (local only, not committed).

- `graphics/feature_graphic_1024x500.png`: replaced. The icon card and background gradient are
  kept from the old graphic; the old text area was cleared by blending the clean background
  above and below it (tested colour error under 1 step out of 255). New text in Segoe UI:
  "QR Forge", "Scan safely. Stay private.", and "Link checks • Works offline • Encrypted
  history" ("No ads" removed, as the plan describes).
- `store_listing.md`: the "Updated" line now records the 7 November 2026 rename (app name,
  description, feature graphic).

## Checks

- The new file is 1024 × 500, RGB (no transparency), as Play requires.
- No app code changed, so no build or test run was needed.
- Still to do in Play Console: upload the new graphic under **Store presence → Store listings →
  Default store listing → Graphics**.
