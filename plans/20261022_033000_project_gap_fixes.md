# Project gap fixes (gaps 1–6 and 8)

**Status:** completed

## Background

A full project review on 22 Oct 2026 found that `flutter analyze` is clean, `dart format`
changes no files and all 810 tests pass. It also found a few gaps. This plan fixes gaps 1–6
and 8. Gap 7 (an end-to-end scanning test on a phone or emulator) is **not** in this plan,
because it needs a device.

Nothing in `docs/guidelines/` or `native/zxing-cpp/` is changed.

## Gaps and fixes

Work order: gap 8 first (so the old work and the new work are in separate commits), then
gaps 1–6. `flutter analyze` and `flutter test` run after each code step.

### Gap 8 — finished work from 20 Oct is not committed

**Issue:** 6 changed files, 2 plans and 2 change logs from 20 Oct (settings button on tabs,
and the scanner camera taking the camera away from AirQR and AR CodeVision) are not
committed.

**Fix:** Before any new change, commit that work on `main` as two commits, one per plan.
Each commit holds its plan, its change log and its code and test files. I read each diff
first to put each file in the right commit. If one file holds changes for both plans, it
goes in one commit and the message says so. Nothing is pushed.

### Gap 1 — driver licence / ID codes have no proper view

**Issue:** The classifier detects US/Canadian ID cards (PDF417 data with `ANSI ` or
`AAMVA`) as `CodeContentType.driverLicense`. But the payload parser has no ID-card type, so
the result screen shows only raw text. The raw ID data (name, address, date of birth, ID
number) is also saved to scan history. History is encrypted, but this is personal ID data
that most people would not expect to be kept.

**Fix:**

1. **Model** (`models`): add `PayloadType.idCard` and an immutable `IdCardPayload` in
   `lib/models/parsed_payload.dart`. Fields: first name, last name, date of birth, expiry
   date, document number, issuer, and address. All are optional.
2. **Service** (`services`): in `PayloadParserService.parse`, detect AAMVA data (the
   same `ANSI ` / `AAMVA` check) and read the standard element codes (`DCS`, `DAC`, `DBB`,
   `DBA`, `DAQ`, `DAJ`, `DAG`, `DAI`, `DAK`, and so on). Any missing or broken field is left
   empty. Never throw. Fall back to `GenericPayload` on any error.
3. **Widget** (`screens/widgets`): a new `IdCardActionCard` shows the fields. The document
   number is masked (only the last 4 characters shown) and has a "Show" button. The card has
   a Copy action. No network use.
4. **Result screen:** show `IdCardActionCard` for `IdCardPayload`.
5. **History:** ID-card scans are **not saved** to history. The check goes in one place,
   `HistoryProvider.addScanRecord`, so it covers every save point (single scan, batch scan,
   PDF scan, AirQR). The result screen shows a short note: "ID data is not saved to history."
   *(Your choice: if you would rather save ID scans like other scans, tell me and I will drop
   step 5.)*
6. **Text:** new ARB keys for the card title, field labels, the Show button and the
   history note, in `en`, `ml` and `sa`, each with an `@` description, within the label
   length limits. Run `flutter gen-l10n`. The new Malayalam and Sanskrit text is flagged
   for native-reader review in the change log.
7. **Docs:** add a line about ID cards to `PRIVACY_POLICY.md` §3 (data stored on your
   phone) and to the Smart payloads help text.
8. **Tests:** parser tests (full sample, missing fields, broken data), widget test for the
   card in all three languages (with the tooltip and accessibility helpers), and a
   history-provider test that an ID-card record is not saved.

### Gap 2 — live scanning can stop silently if the decoder worker dies

**Issue:** `_DecoderWorker` in `barcode_decoder_service.dart` does not watch for its
background isolate (a separate Dart worker) exiting or failing. If it dies, the waiting
`decode` futures never finish. `ScanCameraController` keeps `_decoding = true` forever, so
the camera keeps running but nothing is scanned again, with no error shown.

**Fix:**

1. Pass `onExit` and `onError` ports to `Isolate.spawn`. When the worker exits or fails,
   complete every waiting decode with an empty result, mark the worker as dead, and log a
   warning with `AppLogger` (no scanned data in the log).
2. The next decode call starts a fresh worker.
3. Add a timeout (for example 5 seconds) to each decode. On timeout, return an empty
   result, so `_decoding` is always reset.
4. Tests: a fake worker that never answers returns an empty result after the timeout, and
   a worker that exits finishes its waiting decodes.

### Gap 3 — CHANGELOG is out of date

**Issue:** `pubspec.yaml` is at `4.1.6+40`, but `CHANGELOG.md` → Unreleased does not list the
user-facing changes from 17–20 Oct.

**Fix:** Read the change logs from 17 Oct onward and add short, user-facing lines under
Unreleased (Added / Changed / Fixed). For example: full permissions list in Settings, Help
rewritten in plain words, more honest Quishing guard wording, Settings button on the main
tabs, AirQR and AR CodeVision no longer lose the camera to the scanner, and lower battery
use. Also add the ID-card view (gap 1) and the scanner recovery fix (gap 2).

### Gap 4 — settings save errors are ignored with no log

**Issue:** 10 empty `catch (_) {}` blocks in `camera_settings_provider.dart` (7) and
`theme_provider.dart` (3). If saving a setting fails, nothing is logged.

**Fix:** Keep the app from crashing, but log each failure with
`AppLogger.warning('…could not be saved', error: e)`. Log only the setting name, never the
value. No change for the user.

### Gap 5 — models import the full UI library

**Issue:** `ar_code_target.dart` (`Offset`, `Rect`), `code_forge_config.dart` (`Color`) and
`dom_sandbox_result.dart` (`Color`) import `package:material_ui/material_ui.dart`. These
types come from `dart:ui`. Models should not pull in UI widgets.

**Fix:** Replace the import with `import 'dart:ui';` in those three files. If a file also
needs `@immutable`, import `package:flutter/foundation.dart`.

`onboarding_slide.dart` is **not** changed: it uses `IconData`, which is not in `dart:ui`.

### Gap 6 — some widgets and one model have no tests

**Issue:** No tests for `ScanCameraView`, `CameraAdjustmentsSheet`, `FocusRingWidget`,
`ArFloatingChipWidget`, `MultiCodeBoundingBoxWidget`, `CodeForgeBarcodePainter`, the help
page widgets (`help_page_widgets.dart`) and the `StegoQrData` model.

**Fix:** Add tests that mirror the `lib/` layout:

- Widgets: each one renders in `en`, `ml` and `sa` with sample data and throws no
  exception. Icon-only controls have tooltips (existing accessibility helpers). Main
  actions call their callbacks.
- `ScanCameraView`: tested with a fake camera controller only, with no real camera. If
  the widget cannot be built without a real camera, I test its "no camera" and error states
  and note the rest in the change log.
- `CodeForgeBarcodePainter`: paints each supported format into a test canvas without error.
- `StegoQrData`: build, equality and copy tests.

## Files to be changed

Gap 8 (commit only, no edits):
- the 6 changed files, 2 plans and 2 change logs from 20 Oct

Gap 1:
- `lib/models/parsed_payload.dart`
- `lib/services/payload_parser_service.dart`
- `lib/screens/widgets/id_card_action_card.dart` (new)
- `lib/screens/result_screen.dart`
- `lib/providers/history_provider.dart`
- `lib/l10n/app_en.arb`, `lib/l10n/app_ml.arb`, `lib/l10n/app_sa.arb`, `lib/l10n/gen/*` (generated)
- `PRIVACY_POLICY.md`
- help text keys in the ARB files (Smart payloads help)
- `test/services/payload_parser_service_test.dart`
- `test/screens/widgets/id_card_action_card_test.dart` (new)
- `test/providers/history_provider_test.dart`

Gap 2:
- `lib/services/barcode_decoder/barcode_decoder_service.dart`
- `test/services/media_scan_decoder_test.dart` or a new `test/services/barcode_decoder/barcode_decoder_service_test.dart`

Gap 3:
- `CHANGELOG.md`

Gap 4:
- `lib/providers/camera_settings_provider.dart`
- `lib/providers/theme_provider.dart`

Gap 5:
- `lib/models/ar_code_target.dart`
- `lib/models/code_forge_config.dart`
- `lib/models/dom_sandbox_result.dart`

Gap 6 (new tests):
- `test/screens/widgets/scan_camera_view_test.dart`
- `test/screens/widgets/ar_floating_chip_widget_test.dart`
- `test/screens/widgets/multi_code_bounding_box_widget_test.dart`
- `test/screens/help/help_page_widgets_test.dart`
- `test/widgets/camera_adjustments_sheet_test.dart`
- `test/widgets/focus_ring_widget_test.dart`
- `test/widgets/code_forge_barcode_widget_test.dart`
- `test/models/stego_qr_data_test.dart`

Change log:
- `change_log/20261022_<time>_project_gap_fixes.md` (new).

## Checks at the end

- `flutter gen-l10n`, `dart format .`, `flutter analyze` (0 issues), `flutter test` (all pass).
- ARB key parity and label length tests pass.
- No Gradle build is run, so no Gradle daemons need stopping. If one is run, stop the
  daemons afterwards.
- Nothing is installed on a phone.
