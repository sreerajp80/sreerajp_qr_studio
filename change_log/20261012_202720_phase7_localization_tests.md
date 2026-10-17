# Phase 7 — Localization and accessibility tests (and the strings they flagged)

Plan: [plans/20261012_201906_phase7_localization_tests.md](../plans/20261012_201906_phase7_localization_tests.md)
Roadmap: [plans/20261012_191914_guidelines_compliance_roadmap.md](../plans/20261012_191914_guidelines_compliance_roadmap.md) (gaps F1–F4)

## What changed

### New and extended tests
- `test/l10n/l10n_parity_test.dart` — new group "Translation completeness (§8.7)":
  - no `ml`/`sa` value equals the English value, except a short, commented per-language
    allow-list (placeholders and symbols, product and standard names, the endonyms;
    `themeChipOled` is allowed only in `ml`);
  - `madeWithLove` keeps `{heart}` in every language;
  - `assets/config/app_config.json`: `appName` and `description` are per-language maps, every
    `details` map value has `en`, `ml`, `sa`, and every `details` key has an
    `aboutDetail<Key>` ARB key;
  - every `assets/**/*_en.*` file has `_ml` and `_sa` twins (none exist today; guards the
    future).
- `test/l10n/label_length_test.dart` (new) — keys starting with `action`, `label`, `title`,
  `tab`, `nav`, `tooltip` must be at most 20 visible characters in `en` and 22 in `ml`/`sa`,
  counted with `characters`.
- `test/helpers/accessibility_checks.dart` (new) — `expectAllIconButtonsHaveTooltips`
  (`IconButton`, `FloatingActionButton`, `PopupMenuButton`).
- Screen checks in en, ml and sa (no overflow/exception + tooltip check):
  - added to the existing language loops in `air_qr`, `air_qr_transmitter`, `appearance`,
    `ar_codevision`, `code_forge`, `features`, `history`, `scanner` screen tests and in
    `help/help_screens_test.dart` (every help screen);
  - `result_screen_test.dart` and `scan_bubble_settings_screen_test.dart`: their `ml`/`sa`
    loops now also run `en` and check tooltips;
  - new language loops in `about`, `main_shell`, `onboarding`, `settings` screen tests (built
    with `buildTestApp`, so the Sanskrit fallback delegates are included; the About test reads
    the real `app_config.json`).
- `test/l10n/fallback_localizations_test.dart` — widget test: under `sa`, a date picker and an
  `AlertDialog` open and close with no exception (§8.3.1).
- `test/helpers/test_app.dart` — delegates now `...GlobalMaterialLocalizations.delegates`.
- Check of the check: removing the history-card tooltip on purpose made the history screen
  test fail with "PopupMenuButton has no tooltip"; the tooltip was then restored.

### Strings and code fixed
- Removed `aboutMadeWithLove` (English in all three files; not used — the badge uses
  `madeWithLove`) and `tooltipAirQrTransmitter` (too long; not used) from all three ARB files.
- `aboutCopyright` translated (the name stays as is):
  - `ml`: `© {year} Sreeraj P. എല്ലാ അവകാശങ്ങളും നിക്ഷിപ്തം.` — **needs native-reader review**
  - `sa`: `© {year} Sreeraj P. सर्वे अधिकाराः सुरक्षिताः।` — **needs native-reader review**
    (passes the Hindi-marker gate)
- `tooltipToggleSecretVisibility` shortened:
  - `en`: `Toggle secret visibility` → `Show or hide secret`
  - `ml`: `രഹസ്യവിവരങ്ങൾ കാണിക്കുക/മറയ്ക്കുക` → `രഹസ്യം കാണിക്കുക/മറയ്ക്കുക` — **needs
    native-reader review**
  - `sa`: unchanged (`गूढप्रदर्शनं परिवर्तयतु` was already within 22 characters).
- `lib/screens/widgets/history_card.dart` — the `PopupMenuButton` now has
  `tooltip: l10n.moreOptions` (existing key, already translated).
- `flutter gen-l10n` re-run; `lib/l10n/gen/` updated.

The new screen checks found no other missing tooltip and no overflow in any language.

## Checks

- `dart format --output=none --set-exit-if-changed .` — no changes.
- `flutter analyze` — no issues.
- `flutter test` — all 641 tests passed (+22).
- Sanskrit Hindi-marker gate — passed.
- No Android build (no native, manifest or dependency change).

## Notes

- Only 20 ARB keys use the short-label prefixes today, so the length test covers only those
  until Phase 10 renames the rest.
- An editing slip while removing ARB keys left doubled carriage returns at two line ends per
  file; found in the diff and fixed before testing. The final ARB diff holds only the intended
  lines.
