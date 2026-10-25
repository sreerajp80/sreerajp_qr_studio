# Change log: project gap fixes (gaps 1–6 and 8)

Implements plan: [plans/20261022_033000_project_gap_fixes.md](../plans/20261022_033000_project_gap_fixes.md)

Gap 7 (an end-to-end scanning test on a device) was not in the plan and is still open.

## Gap 8 — 20 Oct work committed

The finished work from 20 Oct was committed first, as two local commits (nothing pushed):

- "Add a Settings button to the CodeForge and History tabs" — the two screens, their tests,
  `test/helpers/test_app.dart` (new `routes` parameter used by those tests), plan and change log.
- "Stop the scanner camera taking the camera from AirQR and AR CodeVision" —
  `lib/screens/scanner_screen.dart`, plan and change log.

## Gap 1 — driving licence / ID card view, never saved to history

- `lib/models/parsed_payload.dart`: new `PayloadType.idCard` and immutable `IdCardPayload`
  (names, document number, birth and expiry dates, issuer, country, street, city, postal
  code; all optional). `fullName` and `address` join the non-empty parts.
- `lib/services/payload_parser_service.dart`:
  - New public `PayloadParserService.isIdCardData(raw)`: the same `@` + `ANSI ` / `AAMVA`
    check the barcode classifier uses.
  - New AAMVA parser, run first. It reads the standard element codes (`DCS`/`DAB`,
    `DAC`/`DCT`, `DAD`, `DAQ`, `DBB`, `DBA`, `DAJ`, `DCG`, `DAG`, `DAI`, `DAK`), strips the
    `DL`/`ID` subfile marker, skips `NONE`/`unavl` values, reads US dates as MMDDCCYY and
    Canadian dates as CCYYMMDD, and rejects impossible dates. It never throws; with no
    fields found it falls back to plain text.
- `lib/screens/widgets/id_card_action_card.dart` (new): shows the fields. The document
  number is masked (last 4 characters shown) with a Show / Hide button. "Copy details"
  copies what is shown. A note says ID data is not saved to history. No network use. Dates
  are formatted with `formattingLocale(...)`.
- `lib/screens/result_screen.dart`: shows the new card, with a badge icon in the type card.
- `lib/providers/history_provider.dart`: `addScanRecord` skips any record whose content is
  ID card data. This one check covers every save point (single scan, batch scan, PDF scan,
  AirQR). Restoring an encrypted backup is not changed.
- `lib/screens/help/smart_payloads_help_screen.dart`: one more bullet about ID cards.
- `PRIVACY_POLICY.md` §3: new line, "ID cards are not stored".
- ARB files (`en`, `ml`, `sa`), with `@` descriptions in `app_en.arb`: `titleIdCard`,
  `labelIdCardName`, `labelIdCardBirthDate`, `labelIdCardExpiry`, `labelIdCardNumber`,
  `labelIdCardIssuer`, `labelIdCardAddress`, `actionIdCardShowNumber`,
  `actionIdCardHideNumber`, `actionIdCardCopy`, `bodyIdCardNotSaved`,
  `helpGuideSmartPayloadsOtherBullet7`. `flutter gen-l10n` was run.

**Native-reader review needed** for the new Malayalam and Sanskrit text, especially:
- ml: `labelIdCardExpiry` "കാലാവധി തീരുന്നത്", `labelIdCardNumber` "രേഖയുടെ നമ്പർ",
  and the long help bullet.
- sa: `titleIdCard` "परिचयपत्रम्", `labelIdCardExpiry` "अवधिसमाप्तिः",
  `labelIdCardNumber` "पत्रसङ्ख्या", `actionIdCardHideNumber` "सङ्ख्यां गोपयतु", and the
  help bullet ("वाहनचालन-अनुज्ञापत्रम्" for driving licence).

Tests: `test/helpers/id_card_samples.dart` (made-up US and Canadian samples), new parser
tests (full US card, Canadian card, broken fields, header only, detection), the ID card
added to the shared `payload_action_cards_test.dart`, a new
`test/screens/widgets/id_card_action_card_test.dart` (masking, Show/Hide, all three
languages), and a history-provider test that an ID card scan is not saved.

## Gap 2 — decoder worker recovers instead of hanging

`lib/services/barcode_decoder/barcode_decoder_service.dart`:

- The private worker class is now `DecoderWorker` (marked `@visibleForTesting`).
- The isolate is spawned with `onExit` and `onError` ports. When it exits, every waiting
  decode gets an empty result, the worker is marked dead and the isolate is killed. The
  service then drops it, so the next decode starts a fresh worker. An error report alone is
  only logged (the worker keeps running, as before).
- Each decode has a 10-second timeout and returns an empty result on timeout, so the
  camera's "decoding" flag is always reset. After 3 timeouts in a row the worker is treated
  as stuck and replaced.
- Log lines contain no scanned data.

Tests: new `test/services/barcode_decoder/barcode_decoder_service_test.dart` drives a
`DecoderWorker` through fake ports (no answer → empty after timeout; answer completes;
exit finishes waiting decodes; error report does not kill; repeated timeouts kill). The
real isolate spawn only runs on Android, so it is covered by the existing on-device decoder
test, not by unit tests.

## Gap 3 — CHANGELOG

`CHANGELOG.md` → Unreleased now lists the user-facing changes from 17–22 Oct: permissions
list, Settings button on tabs, ID card view, Help rewrite, honest fake sticker check, lower
battery use, AirQR/AR black camera fix, scanner recovery, dark-mode card and menu icon
contrast.

## Gap 4 — settings save errors are logged

`lib/providers/camera_settings_provider.dart` (7 places) and
`lib/providers/theme_provider.dart` (3 places): empty `catch (_) {}` blocks now call
`AppLogger.warning('<setting> could not be saved', error: e)`. Only the setting name is
logged, never its value. Nothing changes for the user.

## Gap 5 — models no longer import the UI library

`lib/models/ar_code_target.dart`, `lib/models/code_forge_config.dart`: `dart:ui` plus
`package:flutter/foundation.dart` (for `@immutable`). `lib/models/dom_sandbox_result.dart`:
`dart:ui` only. `onboarding_slide.dart` is unchanged (it needs `IconData`).

## Gap 6 — new tests

- `test/screens/widgets/scan_camera_view_test.dart` — fake controller with no real camera:
  auto start on/off, error builder, placeholder, `onDetect` stops after removal. The live
  camera preview itself is not tested (it needs a real camera).
- `test/widgets/camera_adjustments_sheet_test.dart` — all rows in three languages, invert
  switch, resolution choice and callback.
- `test/widgets/focus_ring_widget_test.dart`, `test/screens/widgets/ar_floating_chip_widget_test.dart`,
  `test/screens/widgets/multi_code_bounding_box_widget_test.dart`,
  `test/screens/help/help_page_widgets_test.dart`, `test/widgets/code_forge_barcode_widget_test.dart`,
  `test/models/stego_qr_data_test.dart`.
- `StegoQrData` has no `==`, so its test covers construction and `copyWith` only.

## Bugs the new tests found (not fixed — outside this plan)

1. **CodeForge 1D barcode preview.** `CodeForgeBarcodePainter` calls
   `barcode.make(drawText: true)` without a `fontHeight`. In debug and dev builds this fails
   an assert, which the painter catches, so Code 128 / EAN / UPC / Code 39 previews are
   blank when "text label" is on. In release builds the bars draw, but the digits get font
   size 0 and cannot be seen. The new painter test uses `includeTextLabel: false` for now.
2. **Camera adjustments sheet header.** The title and the Reset button sit in a `Row` with
   no `Flexible`/`Expanded`, so a long title (or large font size) overflows. The test uses a
   wide view for now.
3. **Multi-code box label.** The label `Text` in `MultiCodeBoundingBoxWidget` has no
   `Flexible` or ellipsis, so a long label overflows a small box. The test uses a wide box
   for now.

Each needs its own small plan and approval.

## Checks

- `flutter gen-l10n`, `dart format` (0 files changed), `flutter analyze` (no issues).
- `flutter test`: all 871 tests pass (was 810).
- `tool/check_sanskrit_hindi_markers.sh`: passes.
- No Gradle build was run. Nothing was installed on a phone.
