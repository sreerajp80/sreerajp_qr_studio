# Change log — Save the 4.1.12+46 release notes and the Malayalam store listing

Implements plan: [plans/20261108_101258_play_notes_release_4_1_12_ml_listing.md](../plans/20261108_101258_play_notes_release_4_1_12_ml_listing.md)

## What changed

Both files are in the gitignored `play_store_private/` folder (local only, not committed).

### `store_listing.md`
- New section **3a. Malayalam store listing (ml-IN)**: where to add it, App name `QR Forge`
  (8 / 30), Short description (76 / 80), Full description (2882 / 4000), and notes on feature
  names, Latin brand names, the Malayalam launcher name and the English graphics.
- "Notes before pasting": the Malayalam listing is now in section 3a; Sanskrit can be added
  later.
- "Updated" line: 8 November 2026 entry.

### `PUBLISHING_GUIDE.md`
- "Updated" line: 8 November 2026, version 4.1.12+46.
- Step 0 example bundle name: `SreerajP_QRStudio-v4.1.12_46-prod-release.aab`.
- Step 1 release name: `QRForge-v4.1.12_46`.
- Step 1 release notes: new en-IN (365 / 500) and ml-IN (453 / 500) block, plus a note that it
  lists only changes since 4.1.9+43 and must be trimmed if 4.1.10+44 or 4.1.11+45 was uploaded.
- Step 5 Malayalam listing: points to `store_listing.md` §3a.

Different from the plan: the menu path in section 3a uses the path already in the publishing
guide ("Default – English – en-IN" menu → Manage languages), not "Manage translations", so both
files say the same.

## Checks

- Characters counted again from the saved files: listing 8 / 76 / 2882; release notes en-IN 365,
  ml-IN 453. All within Play limits.
- No app code changed, so no build or test run was needed.

## Native-reader review needed

- The Malayalam listing and the ml-IN release notes. Please have a native Malayalam reader check
  them before publishing.
- Open question for the user: was 4.1.10+44 or 4.1.11+45 uploaded to Play? If yes, trim the
  release notes.
