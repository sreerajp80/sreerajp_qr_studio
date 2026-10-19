# Help section: cover every feature, in plain words

**Status:** completed

## What the issue is

The Help Center (Settings › Help) has 10 guide pages. Two problems:

1. **Some features have no help at all.** Users cannot learn how to use them:
   - **CodeForge** (the whole third tab — making your own QR codes and barcodes,
     styles, colours, centre badge, saving and sharing).
   - **StegoQR and locked (encrypted) codes** — hidden messages, passphrase and
     fingerprint unlock.
   - **GhostScan** and the **Quick Settings tile** (scan a code that is on your screen).
   - **Scan from clipboard**.
   - **Batch scan mode** and the batch review sheet (save / export many codes at once).
   - **Camera tuning sheet** — brightness, contrast, invert colours, edge sharpness,
     resolution, Distance Scan Assist, Multi-Code Selection.
   - **Extra link checkers** — OpenPhish and PhishTank, and the "active checks"
     switch in Settings › Privacy & probing.
   - **Safe page preview** (the sandboxed page preview card on the result screen).
   - **Phone-to-phone sync** — moving history and settings to a new phone with AirQR.
   - **Smart actions not mentioned** — phone calls, SMS, email, location / maps,
     app links, product barcodes and book (ISBN) codes.
   - **History exports** — PDF and TXT, passphrase-protected backups.
   - **Settings** — theme, accent colour, fonts, scan frame style, language,
     sound / vibration / animation, permissions screen, app lock, "Delete all data",
     battery use.
2. **The wording is hard for normal users.** Many lines use technical or marketing
   words, for example "forensic", "heuristic", "entropy", "chromatic halftone",
   "zero-trust", "surgical precision", "semantic type", "fountain-code repair frames",
   "FLAG_SECURE", "FlutterSecureStorage". Group names are also heavy
   ("Scanning & Ingestion Guides", "Security & Threat Defense").
   Some claims may also be out of date with what the code really does — each line will
   be checked against the code while rewriting.

## The plan for the fix

### A. Rewrite all existing help text in plain words (en, ml, sa)

- Short sentences, everyday words, "you" form, tell the user what to tap.
- Remove jargon and marketing words. Where a technical word is needed (for example
  "phishing", "UPI", "2FA"), explain it in a few words the first time.
- Check every fact against the code (formats supported, frame rates, quotas, where a
  button is) and fix anything wrong.
- Simpler group names, for example: "Scanning", "Making codes", "Staying safe",
  "Using what you scan", "Your data & settings".
- Change the Settings › Help subtitle (`descSettingsHelp`) from the feature list
  ("AR CodeVision, AirQR, Quishing Guard & URL Safety") to something like
  "Simple guides for every feature".
- Existing keys keep their names where the meaning stays the same; only the values
  change. Keys that are no longer used are removed from all three ARB files.

### B. Add missing topics

New guide pages (each with an intro, 2–4 sections of bullets, and a tip):

| New page | Covers |
|---|---|
| Making codes (CodeForge) | Pick a type (text, link, Wi-Fi, contact, UPI, SMS, email, location), fill the fields, "use my location", change shapes and colours, centre badge, error correction in plain words, save / share / copy |
| Hidden & locked codes | What StegoQR is, how a hidden message is found, unlocking with a passphrase or fingerprint, other locked codes the app can open (AirQR text, encrypted JSON) |
| Settings & personal touch | Theme, accent colour, fonts, scan frame style, language picker, sound / vibration / animation, permissions screen, app lock, screenshot guard, Delete all data, battery tips |

Extra sections added to existing pages:

| Page | New sections |
|---|---|
| Barcode & media scanning | Scan from clipboard; Batch scan mode and review sheet; Camera tuning sheet (each slider explained); Distance Scan Assist and Multi-Code Selection |
| Scan bubble → renamed "Scan from other apps" | GhostScan and the Quick Settings tile, alongside the existing bubble text |
| URL safety | Extra link checkers (OpenPhish, PhishTank) and how to turn them on; the "active checks" privacy switch; the safe page preview card |
| AirQR | Moving history and settings to another phone (AirQR sync) |
| Smart actions | Phone, SMS, email, location / maps, app links, product and ISBN codes |
| History, backups & privacy | PDF / TXT exports, passphrase-protected backups, plain-text export warning |
| FAQ | More questions: why a permission is needed, how to change language, how to delete everything, battery use, a code that will not scan, a link marked unsafe that I trust |

### C. Tidy the code behind the help pages

- Every help page has its own copy of the same four small widgets (`_Intro`,
  `_Section`, `_Bullet`, `_Footer`) — 10 copies today, 13 after this change.
  Move them into one shared file `lib/screens/help/widgets/help_page_widgets.dart`
  (layer: `screens`, UI only) and use it from every help page. Look and layout stay
  the same.
- Add the 3 new pages to the Help hub in the right groups, with icons.
- No new packages. No changes to services, providers or models.

### D. Translations

- Every new or changed key gets a real Malayalam and Sanskrit translation, following
  `docs/guidelines/language_packs/sanskrit_malayalam.md` (pure Sanskrit, no Hindi
  markers; natural Malayalam). Page titles (`titleHelp…`) stay within 20 / 22
  characters. Every new key gets an `@key` description in `app_en.arb`.
- Run `flutter gen-l10n`.
- Lines I am unsure about will be listed in the change log for native-reader review.

### E. Tests and checks

- Add the 3 new pages to `test/screens/help/help_screens_test.dart` (renders in en,
  ml, sa; shows the right title; accessibility checks).
- Add a test that the hub lists every help page (so a page cannot be forgotten).
- Run `dart format .`, `flutter analyze` (clean), `flutter test` (all pass),
  including the ARB key parity and Sanskrit Hindi-marker tests.
- No device install or build on the phone.

## Files to be changed

New:
- `lib/screens/help/widgets/help_page_widgets.dart`
- `lib/screens/help/code_forge_help_screen.dart`
- `lib/screens/help/hidden_codes_help_screen.dart`
- `lib/screens/help/settings_help_screen.dart`

Changed:
- `lib/screens/help/help_home_screen.dart`
- `lib/screens/help/barcode_scanning_help_screen.dart`
- `lib/screens/help/ar_codevision_help_screen.dart`
- `lib/screens/help/air_qr_help_screen.dart`
- `lib/screens/help/scan_bubble_help_screen.dart`
- `lib/screens/help/url_safety_help_screen.dart`
- `lib/screens/help/quishing_guard_help_screen.dart`
- `lib/screens/help/safe_browsing_help_screen.dart`
- `lib/screens/help/smart_payloads_help_screen.dart`
- `lib/screens/help/history_privacy_help_screen.dart`
- `lib/screens/help/faq_troubleshooting_help_screen.dart`
- `lib/l10n/app_en.arb`, `lib/l10n/app_ml.arb`, `lib/l10n/app_sa.arb`
- `lib/l10n/gen/*` (generated by `flutter gen-l10n`)
- `test/screens/help/help_screens_test.dart`

Not changed: `docs/guidelines/` (read-only submodule), any service / provider / model.

## Notes

- The working tree already has other uncommitted changes (battery usage, permissions
  screen, menu icon contrast). This work touches the same ARB files; I will only add
  or edit help-related keys and leave the other changes as they are.
- This is a large text change (around 150 existing help strings rewritten and about
  100–130 new ones, times three languages).

## Changes made during implementation

- Also changed (small, needed): `test/screens/scan_bubble_settings_screen_test.dart`,
  `test/screens/settings_screen_test.dart` (expected help text) and
  `docs/project_structure.md` (lists the new help files).
- The extra online checkers are explained in the Link safety guide, and their full setup
  is in the Safe Browsing guide, which is now called "Online checker setup".
- Change log: `change_log/20261018_110752_help_full_coverage_plain_words.md`.
