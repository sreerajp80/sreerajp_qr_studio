# Plan — New Play Store feature graphic with the "QR Forge" name

**Status:** completed

Follow-up to [plans/20261107_220156_rename_app_qr_forge.md](20261107_220156_rename_app_qr_forge.md).

## Issue

The Play Store feature graphic (1024 × 500) still shows "SreerajP QR Studio" in large letters.
After the rename, the store page would show two different names.

## Files to change (gitignored `play_store_private/` folder, local only)

1. `graphics/feature_graphic_1024x500.png` — replaced with the new version.
2. `store_listing.md` — note in the "Prepared / Updated" line that the feature graphic was
   remade for the QR Forge name.

## The fix

A draft was made outside the project from the current graphic:
- The icon card and the background gradient are kept from the current graphic. The old text
  area was cleared by blending the clean background above and below it (tested on a clean part
  of the image: colour error under 1 step out of 255, so no visible patch).
- New text in the same font family (Segoe UI): "QR Forge" (bold, large), the same tagline
  "Scan safely. Stay private.", and the line "Link checks • Works offline • Encrypted history".
- Same size (1024 × 500), PNG, no transparency, as Play requires.

**One wording change:** "No ads" was replaced with "Encrypted history". The project's own store
notes say Play flags "no ads" in the short description; keeping it out of the graphic too is the
safer choice. The user can ask to keep "No ads" instead.

## Steps

1. Copy the approved draft over `graphics/feature_graphic_1024x500.png`.
2. Update the note in `store_listing.md`.
3. Write the change log.

No app code changes, so no build or test run is needed.

## Security impact

None. Local store graphic only.
