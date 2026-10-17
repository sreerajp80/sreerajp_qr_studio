# Phase 7 — Localization and accessibility tests (and the strings they flag)

**Status:** completed

Part of [plans/20261012_191914_guidelines_compliance_roadmap.md](20261012_191914_guidelines_compliance_roadmap.md)
(gaps F1–F4). Target layers: `test/` (new checks), `l10n/` (ARB fixes), `screens/` (one
missing tooltip).

## What the issue is

The engineering standard and the Sanskrit/Malayalam language pack ask for checks the project
does not have yet:

1. **Parity test is incomplete (§8.7).** `test/l10n/l10n_parity_test.dart` checks keys,
   placeholders and the Hindi markers, but not:
   - "no translation is a copy of the English value";
   - the `{heart}` marker in `madeWithLove` in every language;
   - `assets/config/app_config.json` having every language for `appName`, `description` and
     each `details` value, with an `aboutDetail<Key>` label in the ARB;
   - content assets (`*_en.*`) having a twin per language.
2. **No label-length test (§8.6, language pack §5).** Short keys (`action…`, `label…`,
   `title…`, `tab…`, `nav…`, `tooltip…`) must stay within 20 characters in English and 22 in
   Malayalam and Sanskrit, counted as visible characters (`package:characters`).
3. **No tooltip check (§7.8).** No test fails when an `IconButton`,
   `FloatingActionButton` or `PopupMenuButton` has no tooltip, and screens are not checked in
   every language.
4. **No Sanskrit date-picker/dialog widget test (§8.3.1, language pack §1.1).** The fallback
   delegates are unit-tested, but no test opens a date picker and a dialog under `sa`.
5. `test/helpers/test_app.dart` still lists the three global delegates one by one instead of
   `...GlobalMaterialLocalizations.delegates` (the shape used in `main.dart` since Phase 5).

### What a dry run of these checks finds today

- **Copies of the English value:** 21 keys in `ml`, 19 in `sa`. Most are fine to keep the same
  (placeholders/symbols such as `{value}%`, `{fps} FPS`, `{value}x`, `{date} • {time}`,
  `🛡️ {score}%`; names such as VirusTotal, URLhaus, PhishTank, OpenPhish, ISBN, EAN/UPC,
  Reed-Solomon FEC, vCard 4.0, AES-GCM, AES-CBC, OLED in `ml`; the language endonyms). Two
  are real gaps:
  - `aboutMadeWithLove` is English in all three files — and it is **not used** in code (the
    About badge uses `madeWithLove`). → remove the key from all three ARB files.
  - `aboutCopyright` (`© {year} Sreeraj P. All rights reserved.`) is English in `ml` and `sa`.
    → translate "All rights reserved." (the name stays).
- **Over the label budget:** `tooltipToggleSecretVisibility` (en 24, ml 23) and
  `tooltipAirQrTransmitter` (en 27, ml 24). `tooltipAirQrTransmitter` is **not used** in code.
  → shorten the first in all three languages; remove the unused second.
- **Missing tooltip:** the `PopupMenuButton` in `lib/screens/widgets/history_card.dart`.
- `{heart}` marker and `app_config.json`: all present already. No content assets with `_en`.

## Files to be changed

- `test/l10n/l10n_parity_test.dart` — the four new checks.
- `test/l10n/label_length_test.dart` — new.
- `test/helpers/accessibility_checks.dart` — new: `expectAllIconButtonsHaveTooltips` (§7.8
  code, plus `PopupMenuButton`).
- `test/helpers/test_app.dart` — delegate list shape.
- Screen tests that pump a full screen — add one test each: "renders in en, ml and sa without
  overflow, and every icon-only control has a tooltip": `about_screen_test.dart`,
  `air_qr_screen_test.dart`, `air_qr_transmitter_screen_test.dart`,
  `appearance_screen_test.dart`, `ar_codevision_screen_test.dart`,
  `code_forge_screen_test.dart`, `features_screen_test.dart`, `history_screen_test.dart`,
  `main_shell_screen_test.dart`, `onboarding_screen_test.dart`, `result_screen_test.dart`,
  `scan_bubble_settings_screen_test.dart`, `scanner_screen_test.dart`,
  `settings_screen_test.dart`, `help/help_screens_test.dart` (each uses its existing set-up;
  where a screen test cannot build the screen in a locale today, that is fixed in the test
  set-up only).
- `test/l10n/fallback_localizations_test.dart` — widget test: under `sa`, open
  `showDatePicker` and an `AlertDialog`; no exception.
- `lib/l10n/app_en.arb`, `app_ml.arb`, `app_sa.arb` — remove `aboutMadeWithLove` and
  `tooltipAirQrTransmitter`; translate `aboutCopyright` in `ml` and `sa`; shorten
  `tooltipToggleSecretVisibility` in all three; then `flutter gen-l10n`.
- `lib/screens/widgets/history_card.dart` — `tooltip:` on the `PopupMenuButton` (reuse an
  existing "More options" style key if one exists; otherwise add `tooltipMoreActions` in all
  three languages).
- Anything else the new screen checks find (missing tooltip, overflow in `ml`/`sa`) — fixed
  the same way and listed in the change log. If they find more than about 10 problems, stop and
  report first.
- `change_log/<timestamp>_phase7_localization_tests.md` — new.

## Plan for the fix

1. **Parity checks** (in `l10n_parity_test.dart`, following §8.7):
   - copy-of-template check with a short, commented allow-list
     (`sameAsTemplateAllowed`): placeholder/symbol strings, product and standard names, the
     endonyms — the keys listed above, per language (so `themeChipOled` is allowed only in
     `ml`, where "OLED" is the normal term);
   - `madeWithLove` contains `{heart}` in every language;
   - `app_config.json`: `appName`, `description` and every map value in `details` have
     non-empty `en`, `ml`, `sa`; every `details` key has an `aboutDetail<Key>` ARB key;
   - content assets: every `assets/**/*_en.*` has `_ml` and `_sa` twins (passes today; guards
     the future).
2. **Label-length test** — `test/l10n/label_length_test.dart`: for each ARB, every key that
   starts with a short prefix must be at most 20 (`en`) or 22 (`ml`, `sa`) characters, counted
   with `value.characters.length`. Note: today only 20 keys use these prefixes; the other keys
   get prefixes in Phase 10, and this test then covers them automatically.
3. **Tooltip helper** — `expectAllIconButtonsHaveTooltips(tester)` checks every `IconButton`,
   `FloatingActionButton` and `PopupMenuButton` in the tree has a non-empty tooltip.
4. **Screen checks** — in each screen test listed above, one new test that loops over
   `appTestLocales` (`en`, `ml`, `sa`): pump the screen with the test's existing set-up, assert
   `tester.takeException()` is null (catches overflow) and run the tooltip helper.
5. **Sanskrit framework test** — pump a small app under `sa`, open a date picker and an
   `AlertDialog`, close both, assert no exception (§8.3.1).
6. **String fixes** (all marked "needs native-reader review" in the change log):
   - `aboutCopyright` — `ml`: `© {year} Sreeraj P. എല്ലാ അവകാശങ്ങളും നിക്ഷിപ്തം.`;
     `sa`: `© {year} Sreeraj P. सर्वे अधिकाराः सुरक्षिताः।` (checked against the Hindi-marker gate);
   - `tooltipToggleSecretVisibility` — `en`: `Show or hide secret`; `ml` and `sa`: a shorter
     wording within 22 characters, using the language-pack glossary words for show/hide;
   - remove the two unused keys; run `flutter gen-l10n`.
7. **Verify** — `flutter gen-l10n`, format check, `flutter analyze`, `flutter test` (all pass),
   Sanskrit gate. No Android build is needed (no native or dependency change).

## Out of scope

- Renaming the other ~1,035 keys to the standard prefixes (Phase 10).
- A localized, visible error state for a failed history load (noted in Phase 6b; planned with
  Phase 8 "Delete all data", which touches the same screens).
- Screenshots in every language (release task).
