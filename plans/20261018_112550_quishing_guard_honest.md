# QuishingGuard: stop showing a made-up tamper score

**Status:** completed

## What the issue is

QuishingGuard is sold in the app as a camera check that spots a fake QR sticker
glued over a real one. The code does not do this.

1. **The camera image never reaches it.** `lib/screens/scanner_screen.dart`
   (`_processSingleBarcode`) calls `scanProvider.setScanResult(rawValue, format)`
   with no frame bytes. So `QuishingGuardService.analyzeQrContext` always falls
   back to `_analyzePayloadContentCharacteristics(rawContent)`.
2. **That fallback is a hash of the text.** It turns the decoded text into a
   number and maps it to an edge score and a grain score between 0.05 and 0.25.
   The average is always below 0.35, so **every scan shows "🟢 Authentic Printed
   Code"**, plus two fixed signals: "Substrate reflection profile verified" and
   "Halftone dot density consistent across QR matrix perimeter". Nothing was
   looked at. A real fake sticker gets the same green badge.
3. **The frame math would not work either.** `analyzeFrameBytes` exists but is
   not a real detector:
   - The "double edge" test (`d1 > 45 && d2 > 45`) fires on every black/white
     module edge of any QR code. A sharp 720p frame gives thousands of hits, so
     the edge score hits 1.0.
   - The "grain" score is just the spread of brightness over the whole frame.
     A QR code is black and white, so the spread is always high.
   - "Chromatic aberration" is `stdDev % 30`, a made-up number. And the camera
     path only has the grey (Y) plane, so there is no colour to check at all.
   - It ignores `rowStride` and looks at the whole frame, not the code area.
   So feeding real frames in would turn almost **every** scan **red**
   ("Physical Overlay Sticker Detected!"), and `_openRiskFor` in
   `lib/screens/result_screen.dart` would then mark every link as danger.
4. **The text over-promises.** These say it inspects edges, shadows, paper
   texture and print grain with "computer vision":
   - Features page: `descFeatureQuishingGuard`, chips
     `labelFeatureQuishingGuardChip2` ("Edge Discontinuity") and
     `labelFeatureQuishingGuardChip3` ("Print Grain Analysis").
   - Welcome tour: `labelOnboardingSlide2Badge` ("Computer Vision"),
     `bodyOnboardingSlide2`, `bodyOnboardingSlide2Bullet1..3`
     ("Real-time camera frame inspection").
   - Result card: `labelQuishingTamperBadge` ("Physical Tamper CV"),
     `labelQuishingRiskScore`, `labelQuishingMetricEdge/Grain`,
     `descQuishingMetricEdge/Grain`, `titleQuishingSignals`,
     `labelQuishingCompactGenuine`, all `bodyQuishingSummary*`,
     `bodyQuishingStatus*` and `bodyQuishingSignal*` keys.
   - Help page (rewritten in the last, still uncommitted, change):
     `helpGuideQuishingCvBullet1..3` still describe the score and "double edges".
   - Outside the app: `README.md` (lines about "computer vision forensic
     analysis"), `assets/config/app_config.json` About text ("physical tamper
     (quishing) detection"), `docs/architecture.md`, `docs/PROJECT_PROFILE.md`
     short description ("tamper detection"), and the private store listing
     (`play_store_private/store_listing.md`, gitignored).

This is a trust problem for a safety app: a green "Authentic" badge that is not
based on anything can make a user pay into a scam sticker.

## Option (a) or option (b)?

**(a) Feed real camera frames into the analysis.** Not recommended.
- The current math cannot tell a sticker from a normal code (point 3). Wiring it
  up makes things worse: almost every scan turns red.
- A real detector would need a new image method (find the code area, look for
  a step edge and shadow just outside the quiet zone, compare print texture
  inside and outside), plus a set of real photos of genuine and stickered codes
  to tune and test it. We have no such photos, so we could not show it works.
  A sticker printed well and pasted flat may leave no visible sign at all.
- Gallery, clipboard, GhostScan and generated codes have no "physical" side,
  so it could never apply to them.
- It is research work, not a fix. It can be a later project if wanted.

**(b) Make the feature honest.** Recommended. But changing words alone is not
enough: the result card would still show a made-up "Genuine · 85%" score and
"verified" signals. So the plan is:

- **Remove the fake score.** No more risk percentage, green/yellow/red level,
  metrics or "detected signals".
- **Keep the useful part: a sticker check reminder.** On the result screen,
  for codes scanned with the camera, show a small card "Check for a fake
  sticker" with the three hand checks the new help page already teaches
  (feel the edges, check the payee name before paying, ask staff or type the
  address yourself). It is shown for links and payment codes, where a sticker
  scam hurts; it is collapsed by default so it does not get in the way.
- **Keep the name QuishingGuard**, but describe it as "reminds you to check
  for fake stickers", never as a camera or computer-vision check.

## The plan for the fix (option b)

### Code

1. **Remove the fake engine** (layer: services, models).
   - Delete `lib/services/quishing_guard_service.dart` and
     `lib/models/quishing_analysis_result.dart`.
   - Remove the 21 `quishing*` values from `AppMessageKey`
     (`lib/models/app_message.dart`) and their cases in
     `lib/l10n/app_message_text.dart`.
2. **Provider** (`lib/providers/scan_provider.dart`).
   - Remove `_quishingGuardService`, `_quishingResult`, `quishingResult`,
     `runQuishingAnalysis`, and the unused `rawFrameBytes / frameWidth /
     frameHeight / quishingMetadata` parameters of `setScanResult`.
   - Add a simple getter `showStickerReminder` (true when the scan came from
     the camera and the content is a link or a payment code). The source is
     already passed to `createScanRecord(source:)`; I will pass it into
     `setScanResult` too so the provider knows it.
   - Stop writing `'quishingRisk'` into new history records. Old records that
     have it are left alone (nothing reads this field).
3. **Result screen** (`lib/screens/result_screen.dart`).
   - Replace `QuishingRiskBarWidget` with a new small widget
     `lib/screens/widgets/sticker_check_card.dart` (layer: screens/widgets),
     shown when `showStickerReminder` is true.
   - Remove the QuishingGuard part of `_openRiskFor` (it never fired, because
     the fake score was always green).
   - Delete `lib/screens/widgets/quishing_risk_bar_widget.dart`.
4. **Scanner** (`lib/screens/scanner_screen.dart`): pass the scan source to
   `setScanResult`. No camera change.
5. **Doc comments**: fix `lib/screens/onboarding_screen.dart` (slide 2 comment)
   and the `ScanProvider` class comment.

### Text (all in `app_en.arb`, `app_ml.arb`, `app_sa.arb`, then `flutter gen-l10n`)

6. **Remove** the result-card keys that only served the fake score:
   `labelQuishingTamperBadge`, `labelQuishingRiskScore`,
   `labelQuishingMetricEdge`, `descQuishingMetricEdge`,
   `labelQuishingMetricGrain`, `descQuishingMetricGrain`,
   `titleQuishingSignals`, `actionQuishingViewSignals`,
   `actionQuishingHideSignals`, `labelQuishingCompactGenuine`, and all
   `bodyQuishingSummary*`, `bodyQuishingStatus*`, `bodyQuishingSignal*`.
7. **Add** keys for the new card (short labels obey the 20/22 character rule):
   - `titleStickerCheck` — "Check for a fake sticker"
     (long title; if over the limit it becomes "Fake sticker check")
   - `bodyStickerCheckIntro` — "Scammers stick their own QR code over the real
     one. The app cannot see this from the camera, so check it yourself:"
   - `bodyStickerCheckEdges`, `bodyStickerCheckPayee`, `bodyStickerCheckAsk`
     — the three hand checks.
   - `tooltipStickerCheckExpand` / `tooltipStickerCheckCollapse` for the
     expand icon button.
8. **Rewrite** the claims to honest, plain text:
   - `descFeatureQuishingGuard` — "Reminds you to check printed QR codes for
     fake stickers before you open a link or pay."
   - Chips: `labelFeatureQuishingGuardChip1` "Fake stickers" (keep idea),
     `…Chip2` "Hand checks", `…Chip3` "Payment tips".
   - Welcome tour: `labelOnboardingSlide2Badge` "Scam stickers",
     `titleOnboardingSlide2` "Fake sticker check", `bodyOnboardingSlide2`
     explains the scam and that the app reminds you what to check;
     bullets: "Feel for raised sticker edges", "Check the payee name",
     "Ask staff when in doubt".
   - Help page: `helpGuideQuishingCvTitle` / `helpGuideQuishingCvBullet1..3`
     describe the new card instead of the score.
   - Malayalam and Sanskrit get real translations, following the language
     pack (pure Sanskrit, Hindi-marker gate). New lines will be flagged for
     native-reader review in the change log.

### Docs (not the guidelines submodule)

9. `README.md`, `assets/config/app_config.json` (About text in all three
   languages), `docs/architecture.md`, `docs/PROJECT_PROFILE.md` short
   description, `docs/project_structure.md` file list: replace "computer
   vision / tamper detection" with "fake-sticker check reminder".
   `docs/implementation_plan.md` is a history document; I will add a short
   note under the QuishingGuard section that the camera analysis was removed
   and why, rather than rewrite it.
10. `play_store_private/store_listing.md` is gitignored and private. I will
    **not** edit it; I will tell you which line ("Quishing Guard looks for
    signs…") needs new wording before the next store update.

### Tests

11. Delete `test/services/quishing_guard_service_test.dart` and
    `test/providers/scan_provider_quishing_test.dart`.
12. Remove the QuishingRiskBarWidget test in
    `test/screens/widgets/result_sheets_test.dart` and the two quishing args
    in `test/l10n/app_message_text_test.dart`.
13. Add:
    - `test/screens/widgets/sticker_check_card_test.dart` — renders in en, ml,
      sa; expand/collapse works; tooltips present.
    - Provider tests: `showStickerReminder` is true for a camera link/payment
      scan, false for gallery/clipboard/plain text, and reset by `clearScan`.
14. Run `flutter gen-l10n`, `dart format .`, `flutter analyze` (must be clean)
    and `flutter test` (all pass, including ARB key parity).

## Files to be changed

- Delete: `lib/services/quishing_guard_service.dart`,
  `lib/models/quishing_analysis_result.dart`,
  `lib/screens/widgets/quishing_risk_bar_widget.dart`,
  `test/services/quishing_guard_service_test.dart`,
  `test/providers/scan_provider_quishing_test.dart`
- New: `lib/screens/widgets/sticker_check_card.dart`,
  `test/screens/widgets/sticker_check_card_test.dart`
- Change: `lib/models/app_message.dart`, `lib/l10n/app_message_text.dart`,
  `lib/providers/scan_provider.dart`, `lib/screens/result_screen.dart`,
  `lib/screens/scanner_screen.dart`, `lib/screens/onboarding_screen.dart`,
  `lib/l10n/app_en.arb`, `lib/l10n/app_ml.arb`, `lib/l10n/app_sa.arb`,
  `lib/l10n/gen/*` (generated), `test/screens/widgets/result_sheets_test.dart`,
  `test/l10n/app_message_text_test.dart`, a provider test file under
  `test/providers/`, `README.md`, `assets/config/app_config.json`,
  `docs/architecture.md`, `docs/PROJECT_PROFILE.md`,
  `docs/project_structure.md`, `docs/implementation_plan.md`
- Not touched: `docs/guidelines/` (read-only submodule), `native/`,
  `play_store_private/` (private, only a note to you).

## Notes and risks

- **Overlap with uncommitted work.** The Help rewrite is finished but not
  committed, and it touches the same ARB files, help screen and README. This
  change builds on top of it. It is best to commit the Help work first, so the
  two changes stay separate.
- **A lighter choice.** If you prefer, I can do text only (steps 8–9) and keep
  the card. I do not recommend it: the card would still show a made-up
  "Genuine" score.
- **Later idea (not in this plan).** A real image check (option a) could be a
  separate research project, only if real test photos are collected first.
