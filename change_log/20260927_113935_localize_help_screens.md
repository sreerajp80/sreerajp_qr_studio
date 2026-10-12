# Localize all help screens (English, Malayalam, Sanskrit)

Implements plan: `plans/20260926_221449_localize_help_screens.md`

## Summary

All help screens under `lib/screens/help/` now read their text from the ARB files
through `AppLocalizations`. Users who pick Malayalam or Sanskrit now see the whole
Help Center in their language. No hard-coded user-visible text is left in that
folder.

## What changed

### ARB files and generated code

- `lib/l10n/app_en.arb`, `lib/l10n/app_ml.arb`, `lib/l10n/app_sa.arb`: added 143
  new keys, in the same order at the end of each file. Every key has an `@key`
  description in `app_en.arb`.
  - 9 short app-bar titles: `titleHelp<Topic>` (for example `titleHelpAirQr`).
  - 3 hub group headers: `helpGuideGroupScanning`, `helpGuideGroupSecurity`,
    `helpGuideGroupPayloads`.
  - 131 body strings: `helpGuide<Topic><Part>` (name, summary, intro, section
    titles, bullets, tip) for the topics `Barcode`, `ArCodeVision`, `AirQr`,
    `UrlSafety`, `Quishing`, `SafeBrowsing`, `SmartPayloads`, `History`, `Faq`.
- `lib/l10n/gen/*`: regenerated with `flutter gen-l10n`.

### Screens

- The 9 topic screens (`air_qr_help_screen.dart`, `ar_codevision_help_screen.dart`,
  `barcode_scanning_help_screen.dart`, `faq_troubleshooting_help_screen.dart`,
  `history_privacy_help_screen.dart`, `quishing_guard_help_screen.dart`,
  `safe_browsing_help_screen.dart`, `smart_payloads_help_screen.dart`,
  `url_safety_help_screen.dart`): all text now comes from `l10n.<key>`. The
  `children: const [...]` lists are no longer `const`; the `SizedBox` spacers
  still are.
- `help_home_screen.dart`: the 3 group headers and the 9 card titles and
  subtitles now come from `l10n.<key>`.

### Tests

- New `test/screens/help/help_screens_test.dart`:
  - Builds all 10 help screens in `en`, `ml` and `sa` at a small phone size
    (360 × 800), and checks that there is no error (including layout overflow)
    and that the app bar shows the localized title.
  - Checks that the 9 short app-bar titles fit the §8.6 budget (English ≤ 20,
    Malayalam and Sanskrit ≤ 22 characters, counted as visible characters).

## Changes that differ from the plan

1. **Key prefix.** The ARB files already had `help…` keys used by the Settings
   screen (for example `helpAirQrDesc`, `helpUrlTitle`). To avoid clashes, the
   new keys use `helpGuide…` instead of the plan's `help<Topic>…`. The plan was
   updated to say so.
2. **Two small layout fixes** (found by the new phone-size widget test):
   - In all 9 topic screens, the section heading `Text` inside `_Section` was in
     a `Row` without `Expanded`. Long Malayalam headings ran off the right edge.
     The `Text` is now wrapped in `Expanded`, so it wraps to a second line.
   - In `help_home_screen.dart`, the group header had the same problem. This bug
     already existed in English: "SCANNING & INGESTION GUIDES" (in capitals with
     letter spacing) overflowed on a 360 px wide screen. Same fix.

   No other layout, icon or style changes were made.

## English text

- The English body text is copied word for word from the old screens. A script
  checked that every old string literal has an exactly matching English ARB
  value.
- The AirQR text keeps the corrected facts from
  `plans/20260926_220121_airqr_fountain_and_block_size_fixes.md`: LT fountain-code
  repair frames (not Reed-Solomon), frame rate 5 to 25 FPS, and no chunk-size
  control.
- The app bar titles are now short (the option chosen at plan approval):

  | Screen | Old app bar title | New app bar title |
  | ------ | ----------------- | ----------------- |
  | Barcode | Barcode & Media Scanning | Barcode scanning |
  | AR CodeVision | AR CodeVision™ Spatial HUD | AR CodeVision |
  | AirQR | AirQR™ Optical Air-Gap Stream | AirQR guide |
  | URL safety | 6-Layer URL Safety Engine | URL safety |
  | QuishingGuard | QuishingGuard™ Tamper Detection | QuishingGuard |
  | Safe Browsing | Google Safe Browsing Setup | Safe Browsing |
  | Smart actions | Smart Actions & Payments | Smart actions |
  | History | History, Backups & Privacy | History & privacy |
  | FAQ | FAQ & Troubleshooting | FAQ & help |

  The full long names are still shown on the Help Center hub cards.

## Translation notes

- Trademarked names (AirQR™, AR CodeVision™, QuishingGuard™), third-party names
  (Google Safe Browsing, Google Cloud Console, UPI, BHIM, Google Pay, PhonePe,
  Paytm, Bitcoin, Ethereum, Solana), barcode format names and technical tokens
  (`WIFI:`, `otpauth://`, `FLAG_SECURE`, JSON, CSV, SQLite, TOTP, FPS, `.xyz`,
  `bit.ly`, `console.cloud.google.com`) are kept in Latin script in body text.
- Google Cloud Console menu names ("APIs & Services", "+ CREATE CREDENTIALS",
  "API key", "Enable") stay in English in quotes, because the console shows
  them in English.
- Where the help text quotes an in-app button, the translation quotes the
  existing translated label: `quishingViewSignals`, `wifiConnectButton`,
  `totpImportButton`. The Settings → Appearance path uses `settingsTitle` and
  `settingsAppearanceTitle`.
- The Layer 2 example keeps the real Cyrillic letter "а" (U+0430) in all three
  languages.
- FAQ camera-permission path: Malayalam uses the Malayalam names that Android
  shows. Sanskrit keeps the English Android menu names (Settings -> Apps -> … ->
  Allow), because Android has no Sanskrit system language.
- Sanskrit uses the existing ARB spelling `कुञ्चिका` for "key" and the existing
  app name `श्रीराज् पि क्यू-आर-पाठकः`. Two first-draft words were changed to
  pass the Hindi marker gate (`सङ्ग्रहे` contained `रहे`; `ग्रहीतुं` contained `रही`).

**Needs native-reader review (standard §8.5.4):** all 143 new Malayalam and
Sanskrit strings are new text and should be read by a fluent reader before
release. The new technical Sanskrit terms need the most care, for example
`वितन्तु` (wireless), `निर्झर-सङ्केत` (fountain code), `आवर्धन-सर्पकः` (zoom
slider), `समरूपलिपि` (homograph), `देशिक-HUD` (spatial HUD), `जैवमापन`
(biometrics), `पटलचित्र` (screenshot) and `दत्तांशकोशः` (database).

## Checks run

- `flutter gen-l10n`: OK
- `dart format .`: no changes needed
- `flutter analyze`: no issues found
- `flutter test`: all 408 tests pass, including the ARB parity, placeholder and
  Sanskrit Hindi-marker gate tests and the new help screen tests
- Search in `lib/screens/help/` for leftover user-visible string literals: none

## Not done (out of scope, as in the plan)

- The four small private widgets (`_Intro`, `_Section`, `_Bullet`, `_Footer`)
  are still copied into each of the 9 topic screens.
- No project-wide `label_length_test.dart` for the §8.6 budget. The new test only
  checks the 9 help app-bar titles.
- The older Settings-screen help keys (`helpAirQrPoint1`, `helpAirQrPoint2`) still
  talk about "chunks". They were not touched here.
