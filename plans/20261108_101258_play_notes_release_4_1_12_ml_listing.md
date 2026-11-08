# Plan — Save the 4.1.12+46 release notes and the Malayalam store listing in the Play notes

**Status:** completed

## Issue

The release notes for 4.1.12+46 (en-IN and ml-IN) and a new Malayalam (ml-IN) store listing were
written in chat. They are not saved anywhere, so they could be lost, and the local Play notes
still show the 4.1.5+39 release details.

## Files to change (gitignored `play_store_private/` folder, local only)

1. `store_listing.md`
   - New section **"3a. Malayalam store listing (ml-IN)"** after section 3, with:
     - where to add it (Default store listing → Manage translations → Add your own
       translations → Malayalam – ml-IN),
     - App name `QR Forge` (8 / 30),
     - Short description (76 / 80),
     - Full description (2,882 / 4,000),
     - a note: feature names follow the app's Malayalam words (നാൾവഴി, സ്കാൻ ബബിൾ,
       ആപ്പ് ലോക്ക്, സ്ക്രീൻഷോട്ട് സംരക്ഷണം); brand names (AirQR, StegoQR, Quishing Guard, UPI)
       stay in Latin letters; the launcher shows ക്യുആർ ഫോർജ് on Malayalam phones; graphics
       fall back to the English ones; **native-reader check needed before publishing**.
   - In the "Notes before pasting" list, change "Malayalam and Sanskrit listings can be added
     later" to say the Malayalam listing is in section 3a and Sanskrit can be added later.
   - Add the 8 November 2026 entry to the "Updated" line.

2. `PUBLISHING_GUIDE.md`
   - "Prepared / Updated" line: add 8 November 2026, version 4.1.12+46.
   - Step 0 example file name → `SreerajP_QRStudio-v4.1.12_46-prod-release.aab` (the name of
     the bundle already built for this release; the file name pattern is not changed).
   - Step 1 release name → `QRForge-v4.1.12_46`.
   - Step 1 release notes block → the new en-IN (365 / 500) and ml-IN (453 / 500) text.
   - Add one line under the block: the notes list only changes since 4.1.9+43, the last
     release recorded in the submission record; trim them if 4.1.10 or 4.1.11 was uploaded.
   - Step 5 Malayalam listing note → point to `store_listing.md` section 3a.

## Not changed

- `SUBMISSION_RECORD.md` — filled in by the user after the submission.
- Past release names and the bundle file name pattern.
- No app code, so no build or test run is needed.

## Steps

1. Make the edits above, pasting the exact texts already checked for length.
2. Count the characters again after saving.
3. Write the change log.

## Security impact

None. Local store text only.
