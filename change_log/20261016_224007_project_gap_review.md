# Change log — Project gap review fixes

Implements plan [../plans/20261016_222423_project_gap_review.md](../plans/20261016_222423_project_gap_review.md).

## What changed

### Gap 1 — Privacy policy wording
- `PRIVACY_POLICY.md` §4: the "Page preview" row said it runs "only when you tap to preview a
  page". It actually runs by itself after a link scan when "Active online checks" is on. The row
  now says that (and that the setting is off by default).
- `CHANGELOG.md`: one line under Unreleased → Changed.

### Gap 2 — "Private mode" banner text
- `bodyProbingBannerPrivate` reworded in `lib/l10n/app_en.arb`, `app_ml.arb` and `app_sa.arb`.
  It no longer says that only Google Safe Browsing was used. It now says the site was not
  contacted, and that only local rules and the safety services the user turned on were used.
- `flutter gen-l10n` re-run.
- **Needs native-reader review:** the new Malayalam and Sanskrit text of
  `bodyProbingBannerPrivate`.

### Gap 3 — Service no longer depends on a widget
- `lib/services/code_forge_service.dart`: removed the imports of
  `lib/widgets/code_forge_qr_painter.dart` and `material_ui`. Added a `QrCanvasPainter`
  typedef. `renderQrToPngBytes` now takes a required `paintQr` callback that draws the QR.
- `lib/providers/code_forge_provider.dart`: `exportPngAndShare` takes `paintQr` and passes it on.
- `lib/screens/code_forge_screen.dart`: passes a callback that uses `CodeForgeQrPainter`.
- `test/services/code_forge_service_test.dart`: the PNG test passes the painter.
- The exported PNG looks the same as before.

### Gap 4 — Services use `dart:ui`
- `lib/services/ar_spatial_service.dart` and `lib/services/dom_sandbox_service.dart` import
  `dart:ui` (for `Offset`, `Size`, `Rect`, `Color`) instead of the full Material library.

### Gap 5 — Model holds no UI text
- `lib/models/onboarding_slide.dart`: removed `buildSlides(AppLocalizations)` and the
  `AppLocalizations` import. The model is now plain data.
- `lib/screens/onboarding_screen.dart`: the same slide list is built by a private
  `_buildOnboardingSlides(l10n)` function in the screen.

### Gap 6 — `withUpiAmount` cannot throw
- `lib/services/payload_action_service.dart`: uses `double.tryParse`; returns the link unchanged
  when the amount is not a finite number.
- `test/services/payload_action_service_test.dart`: new test for bad amounts (`''`, `abc`,
  `1,5`, `NaN`, `Infinity`).

### Gap 7 — New widget tests (79 new tests)
- `test/screens/widgets/payload_action_cards_test.dart` (new): one real sample scan for each of
  the 12 smart-payload cards (Wi-Fi, contact, geo, calendar, payment, TOTP, email, phone, SMS,
  app link, ISBN, product barcode). Checks the parser picks the right type, and that each card
  renders without errors, shows at least one action, and has tooltips on icon buttons — in
  `en`, `ml` and `sa`.
- `test/screens/widgets/result_sheets_test.dart` (new), in all three languages:
  - `MultiCodeHintBanner`: shows the hint; dismiss button works.
  - `QuishingRiskBarWidget`: renders a high-risk result.
  - `DomSandboxPreviewCard`: built from a real `DomSandboxService` result with a fake network;
    unfolds, shows the page title, opens the Inspect view.
  - `HistoryDetailSheet`: edits notes and location; Save trims text and sends `null` for empty.
  - `PdfScanResultsSheet`: lists codes, selecting one closes the sheet; "Save all" stores every
    code in history.
  - `ExportImportDialog`: warns when the backup password is empty, and when restore fields are
    empty; Close works.
  - `ArActionSheet`: a link shows Open (not Select); a non-link target can be selected; close
    button works.
- `test/screens/help/help_screens_test.dart`: added `ScanBubbleHelpScreen`.

### Not done (as planned)
- Gap 8 (end-to-end scanning integration test) needs a phone or emulator — left for a separate
  task.
- Gap 9 (uncommitted work) — nothing committed; left for the user to decide.

## Checks
- `dart format`: clean.
- `flutter analyze`: no issues.
- `flutter test`: all 769 tests pass (was 690).

## Small things noticed (not changed)
- `lib/screens/widgets/multi_code_hint_banner.dart` sets `overflow` with an odd always-true
  expression (`TextEditingValue.empty.text.isEmpty ? ... : null`). It works, but could simply be
  `TextOverflow.ellipsis`.
- `ExportImportDialog` uses the same password field controller for both export and restore.
- The PNG/SVG share subject in `CodeForgeProvider` (`'CodeForge Generated QR Code'`) is an
  English literal, not from the ARB files.
