# Project gap review — fixes

**Status:** completed

## What was checked

A full review of the app against `CLAUDE.md`, `docs/PROJECT_PROFILE.md` and the guidelines
compliance roadmap ([20261012_191914_guidelines_compliance_roadmap.md](20261012_191914_guidelines_compliance_roadmap.md)).

Results that are **already good** (no work needed):

- `flutter analyze`: no issues. `dart format`: 0 files changed. `flutter test`: all 690 tests pass.
- All 122 plans are `completed`. All roadmap phases (1–10) are done.
- No `package:flutter/material.dart` imports left; no `debugPrint`/`print`; no TODO/FIXME.
- No HTTP or secure-storage use in screens, widgets or providers. API keys are in secure storage.
- ARB files: same keys in `en`, `ml`, `sa`; every key has an `@` description; only the two
  required badge keys (`madeWithLove`, `madeWithLoveA11y`) have no standard prefix. Values that
  equal English are only brand names and format tokens (VirusTotal, ISBN, AES-GCM, `{value}%`).
- `CLAUDE.md` and `AGENTS.md` are in step. Dependabot, CI permissions, `.gitignore`,
  `FLAG_SECURE`, `proguard-rules.pro`, release-key check and `allowBackup="false"` are in place.
- No absolute paths or local machine details in `plans/` or `change_log/`.
- Scanned-text parsing is wrapped in `try/catch` and falls back to plain text.
- Online checks (site probing, page preview, RDAP lookup) only run when "Active online checks"
  is on; it is off by default.

## Gaps found

| # | Gap | Where | Size |
|---|---|---|---|
| 1 | **Privacy policy says the page preview runs "only when you tap to preview a page".** In the code it runs on its own after every URL scan when "Active online checks" is on (`ScanProvider.checkUrlSafety` → `DomSandboxService.analyzeAndRender`). The policy text is wrong. | `PRIVACY_POLICY.md` §4 | small |
| 2 | **"Private mode" banner text is not always true.** `bodyProbingBannerPrivate` says the link was checked "using local rules and Google Safe Browsing only". Google Safe Browsing may be off, and VirusTotal, URLhaus, PhishTank or OpenPhish may be on. | `lib/l10n/app_en.arb`, `app_ml.arb`, `app_sa.arb` | small |
| 3 | **A service depends on a widget.** `CodeForgeService` imports `lib/widgets/code_forge_qr_painter.dart`. The rule is `screens → providers → services → models`; services must not use the widget layer. | `lib/services/code_forge_service.dart` | small |
| 4 | **Services import the full Material library just for basic types.** `ArSpatialService` (`Offset`, `Size`, `Rect`) and `DomSandboxService` (`Color`) import `package:material_ui/material_ui.dart`. These types come from `dart:ui`; a service should not pull in UI widgets. | `lib/services/ar_spatial_service.dart`, `lib/services/dom_sandbox_service.dart` | small |
| 5 | **A model builds user-visible text.** `OnboardingSlide.buildSlides(AppLocalizations l10n)` lives in `models/` and imports `AppLocalizations`. Models should be pure data; building the slide list from strings is screen/provider work. | `lib/models/onboarding_slide.dart`, `lib/screens/onboarding_screen.dart` (or the onboarding provider) | small |
| 6 | **`withUpiAmount` can throw.** It uses `double.parse` on the amount. The only caller checks the amount first, so it does not crash today, but the hard rule says "never crash on malformed input". Use `double.tryParse` and keep the link unchanged when the amount is bad. | `lib/services/payload_action_service.dart` | tiny |
| 7 | **No widget tests for the result action cards and some sheets.** 20 widgets have no test: the Wi-Fi, contact, calendar, email, SMS, phone, geo, payment, ISBN, product-barcode, TOTP and app-link action cards; `DomSandboxPreviewCard`, `QuishingRiskBarWidget`, `MultiCodeHintBanner`, `ExportImportDialog`, `HistoryDetailSheet`, `PdfScanResultsSheet`, `ArActionSheet`; and `ScanBubbleHelpScreen` (missing from `help_screens_test.dart`). | `test/screens/widgets/` (new), `test/screens/help/help_screens_test.dart` | medium |
| 8 | **The end-to-end scanning integration test is still open** (`docs/implementation_progress.md` line 47). Only the native decoder has an on-device test. | `integration_test/` | medium — needs a device |
| 9 | **About 264 files of finished work are not committed** (all of the roadmap phases). Nothing is lost yet, but it is one large risk. | git | — your call |

## Plan for the fix

Done as separate steps, with `flutter analyze` and `flutter test` after each code step.

1. **Gap 1** — Change the "Page preview" row in `PRIVACY_POLICY.md` §4 to say it runs
   automatically after a link scan, only when "Active online checks" is on (off by default).
   Add a line to `CHANGELOG.md` under Unreleased → Changed.
2. **Gap 2** — Reword `bodyProbingBannerPrivate` in all three ARB files so it does not name a
   single provider, for example: "Private mode: the site itself was not contacted, so it did not
   see your IP address. Only local rules and the safety services you turned on were used."
   New Malayalam and Sanskrit text, flagged for native-reader review in the change log. Run
   `flutter gen-l10n`.
3. **Gap 3** — Move the QR-to-image drawing call out of the service: the service receives a
   ready painter (or a draw callback) from the provider, or the PNG export moves into the
   widget layer. Pick the smallest change that keeps `CodeForgeService` free of `widgets/`
   imports. Keep the existing `code_forge_service_test.dart` passing.
4. **Gap 4** — Replace the `material_ui` import with `dart:ui` in the two services.
5. **Gap 5** — Move `buildSlides(...)` out of the model into the onboarding screen (or
   provider). The model keeps only fields and the `const` constructor. Update
   `onboarding_screen_test.dart` if it calls `buildSlides`.
6. **Gap 6** — Use `double.tryParse` in `withUpiAmount`; return `raw` unchanged when the amount
   is not a number. Add a unit test for a bad amount.
7. **Gap 7** — Add widget tests for the 20 untested widgets: each renders in `en`, `ml` and
   `sa` with sample payloads, shows its main action, and passes the existing tooltip and
   accessibility check helpers. Add `ScanBubbleHelpScreen` to `help_screens_test.dart`.
8. **Gap 8** — **Not in this plan.** It needs a phone or emulator. I will propose it as a
   separate task. (I will not install anything on your phone without asking.)
9. **Gap 9** — **Not in this plan.** I will ask you separately whether to commit, and how to
   split the commits.
10. Write the change log in `change_log/`.

## Files to be changed

- `PRIVACY_POLICY.md`, `CHANGELOG.md`
- `lib/l10n/app_en.arb`, `lib/l10n/app_ml.arb`, `lib/l10n/app_sa.arb`, `lib/l10n/gen/*` (generated)
- `lib/services/code_forge_service.dart`, `lib/providers/code_forge_provider.dart` (if the painter is passed in), `lib/widgets/code_forge_qr_painter.dart` (only if needed)
- `lib/services/ar_spatial_service.dart`, `lib/services/dom_sandbox_service.dart`
- `lib/models/onboarding_slide.dart`, `lib/screens/onboarding_screen.dart`
- `lib/services/payload_action_service.dart`
- `test/services/payload_action_service_test.dart`, `test/screens/help/help_screens_test.dart`,
  `test/screens/onboarding_screen_test.dart` (if needed), new tests under `test/screens/widgets/`
- `change_log/<timestamp>_project_gap_review.md` (new)

Not changed: anything in `docs/guidelines/` or `native/zxing-cpp/`.
