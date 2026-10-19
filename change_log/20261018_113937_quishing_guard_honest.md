# QuishingGuard: stop showing a made-up tamper score

Implements plan: `plans/20261018_112550_quishing_guard_honest.md` (option b).
Approval: the user said "go ahead" after the plan was explained; it was passed on
to this session by the session that started it.

## Why

QuishingGuard claimed to look at the camera image for fake stickers. It never
got the image. Its score came from a hash of the decoded text, so every scan
showed "🟢 Authentic Printed Code" with fixed "verified" signals. The unused
image math could not tell a sticker from a normal QR code either; wiring it up
would have turned almost every scan red. So the score is gone, and QuishingGuard
is now an honest reminder to check by hand.

## What changed

### What the user sees
- **Result screen:** the old QuishingGuard score card is replaced by a small
  card, "QuishingGuard · Fake sticker check". It is shown only for **links and
  payment codes scanned live with the camera**. Tapping it opens three hand
  checks: feel for raised sticker edges, check the payee name before paying,
  ask staff or type the address yourself. No score, no colours, no "verified".
- **Open button risk:** QuishingGuard no longer feeds into the Open button's
  risk level. (It never changed it before, because the fake score was always
  green.)
- **Features page, welcome tour (slide 2), Help page:** text rewritten so it no
  longer talks about computer vision, edges, shadows or print grain.
- **History:** new scan records no longer store a `quishingRisk` value. Old
  records keep it; nothing reads it.

### Code
- Deleted `lib/services/quishing_guard_service.dart`,
  `lib/models/quishing_analysis_result.dart`,
  `lib/screens/widgets/quishing_risk_bar_widget.dart`.
- `lib/models/app_message.dart`, `lib/l10n/app_message_text.dart`: removed the
  21 `quishing*` message keys.
- `lib/providers/scan_provider.dart`: removed the QuishingGuard service, result,
  `runQuishingAnalysis` and the unused frame parameters. `setScanResult` now
  takes `fromCamera`. New getter `showStickerReminder` (camera scan, and the
  content is a link or a payment code). `clearScan` resets it.
- `lib/screens/scanner_screen.dart`: live camera scans and the multi-code pick
  pass `fromCamera: true`. Photo, PDF, clipboard and screen scans do not.
- New `lib/screens/widgets/sticker_check_card.dart` (screens/widgets layer).
  The open/close button has a localized tooltip.
- `lib/screens/result_screen.dart`: shows the new card; QuishingGuard removed
  from `_openRiskFor`.
- `lib/screens/onboarding_screen.dart`: doc comment only.

### Text (`app_en.arb`, `app_ml.arb`, `app_sa.arb`, then `flutter gen-l10n`)
- Removed: `labelQuishingTamperBadge`, `labelQuishingRiskScore`,
  `labelQuishingMetricEdge`, `descQuishingMetricEdge`,
  `labelQuishingMetricGrain`, `descQuishingMetricGrain`, `titleQuishingSignals`,
  `actionQuishingViewSignals`, `actionQuishingHideSignals`,
  `labelQuishingCompactGenuine`, and all `bodyQuishingSummary*`,
  `bodyQuishingStatus*`, `bodyQuishingSignal*` keys.
- Added (with `@` descriptions in English): `titleStickerCheck`,
  `tooltipStickerCheckExpand`, `tooltipStickerCheckCollapse`,
  `bodyStickerCheckIntro`, `bodyStickerCheckEdges`, `bodyStickerCheckPayee`,
  `bodyStickerCheckAsk`.
- Rewritten: `descFeatureQuishingGuard`, `labelFeatureQuishingGuardChip1..3`,
  `labelOnboardingSlide2Badge`, `titleOnboardingSlide2`, `bodyOnboardingSlide2`,
  `bodyOnboardingSlide2Bullet1..3`, `helpGuideQuishingCvBullet1..3`; updated
  the `@` descriptions of these and of `titleQuishingGuard`.
- `app_sa.arb` passes `tool/check_sanskrit_hindi_markers.sh`.

### Docs
- `README.md`: overview line, the QuishingGuard feature section, the plain
  summary, the result-screen note and the welcome-tour line.
- `assets/config/app_config.json`: About description in English and Malayalam
  (the Sanskrit one did not mention it).
- `docs/architecture.md`: goal line, `ScanProvider` row, removed the
  `QuishingAnalysisResult` row.
- `docs/PROJECT_PROFILE.md`: short description now says "fake-sticker
  reminders" instead of "tamper detection".
- `docs/implementation_plan.md`: added a dated note above the QuishingGuard
  section; the old text is kept as history.
- `docs/project_structure.md` had no QuishingGuard entries, so it needed no change.

### Tests
- Deleted `test/services/quishing_guard_service_test.dart` and
  `test/providers/scan_provider_quishing_test.dart`.
- Removed the old card test from `test/screens/widgets/result_sheets_test.dart`
  and the two quishing args from `test/l10n/app_message_text_test.dart`.
- New `test/providers/scan_provider_sticker_reminder_test.dart` (shown for
  camera link/payment scans; hidden for plain text, non-camera scans and after
  `clearScan`; no `quishingRisk` in new records).
- New `test/screens/widgets/sticker_check_card_test.dart` (en, ml, sa: starts
  closed with no score, opens and closes, tooltips present).
- `test/screens/onboarding_screen_test.dart`: this file was not in the plan, but
  it checks slide 2's English text, so I updated it to the new title and first
  bullet.

## Checks
- `dart format` — clean.
- `flutter analyze` — no issues.
- `flutter test` — all 808 tests pass.
- Not checked on a device.

## For you to do
- **Store listing:** `play_store_private/store_listing.md` (private, gitignored)
  was not edited. The line "Quishing Guard looks for signs that a fake QR
  sticker was pasted over a real one…" overclaims. Please reword it before the
  next store update, for example: "Quishing Guard reminds you to check printed
  codes for fake stickers before you pay." The Play short description in
  `docs/PROJECT_PROFILE.md` changed too; update the console when you next
  publish.
- **Native-reader review:** please have a Malayalam and a Sanskrit reader check
  the new and rewritten lines listed above. In particular: Sanskrit
  `कृतकपत्रिका` (fake sticker), `जालबन्धः` (link), `हस्तपरीक्षाः` (hand checks);
  Malayalam `കൈ പരിശോധന` (hand check) and `വ്യാജ സ്റ്റിക്കർ ഓർമ്മപ്പെടുത്തൽ` (About text).
- This change sits on top of the uncommitted Help rewrite in the same files
  (ARB files, help screen text, README). Nothing was committed.
