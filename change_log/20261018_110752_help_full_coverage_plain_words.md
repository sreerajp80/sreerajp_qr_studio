# Help section: cover every feature, in plain words

Implements plan: [plans/20261018_103919_help_full_coverage_plain_words.md](../plans/20261018_103919_help_full_coverage_plain_words.md)

## What changed

### Help text rewritten in plain words (English, Malayalam, Sanskrit)

- Every help guide was rewritten with short sentences and everyday words. Technical and
  marketing words ("forensic", "heuristic", "entropy", "zero-trust", "FLAG_SECURE",
  "FlutterSecureStorage" and similar) were removed or explained.
- Each guide names the real button to tap, using the same words the app shows.
- Simpler group names on the Help hub: Scanning · Making and sending codes · Staying
  safe · Using what you scan · Your app and settings.
- The Help card subtitle in Settings now reads "Simple guides for every feature".

### Facts fixed while rewriting (old text did not match the app)

- AR CodeVision: the old text listed zoom, camera flip and "export to history" controls
  that do not exist. It now describes the real Safety and Warehouse modes, Batch Copy,
  Clear and the flashlight.
- QuishingGuard: the button is "Show signals" (old text said "View Forensic Analysis").
- 2FA codes: the button is "Add to authenticator" (old text said "Import into
  Authenticator App").
- History: the old text said a JSON export is a full backup that can be restored. Only
  the encrypted backup can be restored; CSV / JSON / TXT / PDF exports are plain copies.
- Safe Browsing key steps: removed "Web Risk API", which is a different Google API from
  the one the app calls.
- Barcode formats: the list now matches the decoder (adds Micro QR, rMQR, MaxiCode,
  Code 93, UPC-E, EAN-8, ITF, DataBar).

### New guide pages (screens layer)

- `lib/screens/help/code_forge_help_screen.dart` — Making codes (CodeForge): code types,
  QR content types, read from file, use my location, shapes, colours, centre badge,
  error correction in plain words, check, share PNG / SVG, copy.
- `lib/screens/help/hidden_codes_help_screen.dart` — Hidden and locked codes: StegoQR,
  passphrase and biometric unlock, AirQR session code, encrypted JSON, Advanced
  (Salt / IV). It also says that the app can open these codes but does not make them.
- `lib/screens/help/settings_help_screen.dart` — Settings guide: theme, accent colours,
  font, scan frame, language picker, scan feedback, Privacy & probing, Delete all data,
  URL Safety Providers, AirQR sync, Scan bubble, Permissions, Features, Welcome Tour,
  About, and battery tips.

### New sections in existing guides

- Scanning codes: switch camera, pause, scan from clipboard, batch scan mode, sharing a
  PDF into the app, and the full Camera adjustments sheet (brightness, contrast, invert,
  resolution, Distance Scan Assist, Multi-Code Selection, reset).
- Scan bubble guide → now "Scan from other apps": adds GhostScan and its Quick Settings
  tile, and the "Start after restart" switch.
- AirQR: how to open the transmitter and receiver, and moving history and settings to a
  new phone with AirQR Optical Sync.
- Link safety: private mode vs. Active online checks, the safe page preview, and the
  extra online checkers (PhishTank, OpenPhish, Safe Browsing, VirusTotal, URLhaus).
- Safe Browsing guide → now "Online checker setup": PhishTank and OpenPhish (no account),
  Google Safe Browsing key steps, VirusTotal and URLhaus keys, daily limits.
- Smart actions: SEPA and crypto codes, phone, SMS, email, location, app links, product
  barcodes, book (ISBN) barcodes.
- History: Export / Backup, plain exports vs. encrypted backup, restore, Clear All.
- FAQ: 8 questions (was 3), 5 camera fixes, and a new "Other problems" section.

### Code tidy-up

- New `lib/screens/help/widgets/help_page_widgets.dart` (screens layer, UI only) with
  `HelpGuidePage`, `HelpSection`, `HelpIntro`, `HelpBullet` and `HelpTip`. Every help
  page had its own identical copy of these widgets; all 13 pages now use the shared
  ones. The look and layout are the same as before.
- `lib/screens/help/help_home_screen.dart`: lists all 13 guides in 5 groups through a
  small `_buildGroup` helper.
- No services, providers or models were changed. No new packages.

### Localization

- `lib/l10n/app_en.arb`, `app_ml.arb`, `app_sa.arb`: all old `helpGuide…` keys were
  replaced by the new set (295 `helpGuide…` keys per language, each with an `@`
  description in English). New app bar titles: `titleHelpScanBubble`,
  `titleHelpCodeForge`, `titleHelpHiddenCodes`, `titleHelpSettings`. Changed values:
  `titleHelpBarcode`, `titleHelpUrlSafety`, `titleHelpSafeBrowsing`,
  `helpCenterHeaderTitle`, `helpCenterHeaderSubtitle`, `descSettingsHelp`.
- Only help keys changed; every other line of the ARB files is unchanged.
- `lib/l10n/gen/*` regenerated with `flutter gen-l10n`.
- `lib/screens/scan_bubble_settings_screen.dart` (not changed) reuses the help
  sections "How to use" and "Good to know". Their new text reads well there too; the
  section title is now "How to use the Scan bubble".

### Tests

- `test/screens/help/help_screens_test.dart`: added the 3 new pages, so each of the 14
  screens is checked in en, ml and sa (builds at phone width, localized title, tooltips,
  title length). Added "the hub opens every help guide": it taps each hub card and checks
  that the right guide opens, so a guide cannot be left off the hub.
- `test/screens/scan_bubble_settings_screen_test.dart` and
  `test/screens/settings_screen_test.dart`: updated the expected help text.

### Docs

- `docs/project_structure.md`: lists the help hub, the guide pages and the shared
  help widgets.

## Checks

- `dart format` — no changes needed.
- `flutter analyze` — no issues.
- `flutter test` — all 807 tests pass, including ARB key parity, placeholder parity,
  the Sanskrit Hindi-marker gate, "no translation is a copy of English" and the
  short-label length test.
- No device install and no release build.

## Needs native-reader review

All new Malayalam and Sanskrit help text is new translation and should be read by a
fluent reader before release. Points I am least sure about:

- Sanskrit: technical words made for this text — `दूरवाणी` (phone), `पटलचित्रम्`
  (screenshot), `प्रतिलिपिफलकम्` (clipboard), `गणविधिः` (batch mode),
  `सङ्क्षिप्तानुबन्धाः` (short links), `संयुक्तपरीक्षकाः` (online checkers),
  `गूढमुद्रा` (crypto currency), `उत्प्लव-गवाक्ष` (pop-up window), `कोशः` (secure store).
- Sanskrit: five words were changed to pass the Hindi-marker gate, because the gate
  matches letters inside real Sanskrit words (`शक्याः` contains `क्या`, `ग्रहीतुम्`
  contains `रही`, `सङ्ग्रहे` contains `रहे`). The new wording is `शक्यते`, `अपहर्तुम्`
  and `कोशे`.
- Malayalam: common loanwords kept where people use them (ബാച്ച്, സ്ക്രീൻഷോട്ട്,
  ക്വിക്ക് സെറ്റിങ്സ്, പ്രിവ്യൂ). Please confirm these read naturally.
- Help text quotes the app's existing button labels. A few of those existing labels may
  need their own review (for example, the Sanskrit "Scan Now" label `स्कैन् क्रियताम्`
  is an English loan in Devanagari).

## Found but not changed (out of scope)

- QuishingGuard: the Features page and the old help text say it checks the camera
  image. In the code, the scanner never passes camera frames to it
  (`ScanProvider.setScanResult` is called without frame bytes), so the score comes only
  from the code's text. The new help text describes only what the user sees (a score,
  colours and signals) and calls it "a helper, not a promise". The feature itself, and
  how the Features page and the welcome tour describe it, should be looked at separately.
