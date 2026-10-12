# Change log: Compact URL result screen

Implements plan: `plans/20260928_124309_result_screen_compact_layout.md`

## Why

On a URL scan the result screen was about three screens long, and the
"Open in Browser" button was at the very bottom. The user had to scroll all
the way down to act.

## What changed

### Part 1: Fixed action bar at the bottom
- `lib/screens/result_screen.dart`: the action buttons moved out of the
  scrolling list into `Scaffold.bottomNavigationBar` (inside `SafeArea`).
  - Row 1 (URLs only): Open in Browser.
  - Row 2: Copy, Share, and a More (⋮) icon button with a localized tooltip.
  - The More sheet holds Decrypt (same rule as before), Recheck (only after a
    network error, same rule as before) and Scan another.
- The old in-list Recheck button (`_buildRecheckButton`) was removed. Recheck
  now lives in the More sheet.

### Part 2: Verdict summary card
- New widget `lib/screens/widgets/url_verdict_card.dart` (layer: screens/widgets).
  It shows a spinner while checking, then "N issues found" + the first failed
  check's name, or "No issues found". A second line shows
  "X of Y checks passed · Private mode / Active probing". "See details"
  scrolls to the full safety card.
- New card order: type card, content card (the URL), verdict card, Quishing
  Guard, StegoQR, smart payload, sandbox preview, full safety card.

### Part 3: Long lists fold by default
- `lib/models/safety_check_result.dart`: new `skipped` field (default `false`).
  A skipped check still has `passed: true`, so the safety verdict logic did
  not change.
- `lib/services/url_safety_service.dart`: `skipped: true` is set at the 6
  places that return a "skipped" result (redirect in private mode,
  malicious-content no key, VirusTotal no key, URLhaus no key, PhishTank
  off, OpenPhish off).
- Full safety card: failed checks always shown; passed checks behind
  "Show N passed checks"; skipped checks grouped as "N checks skipped", which
  unfolds to the list and a "Set up in Settings" button.
- The three stacked banners (trust hint, privacy mode, issues found) became
  one info box: trust hint + privacy mode. The red "issues found" banner was
  removed, since the verdict card says it.
- `lib/screens/widgets/dom_sandbox_preview_card.dart`: now a StatefulWidget.
  It starts folded to its address bar row, with an expand arrow (localized
  tooltip). It starts open when the sandbox found the page unsafe. The
  "sandboxed" badge can now shrink with "…", so long Malayalam/Sanskrit text
  no longer pushes the URL out (found by the new overflow test).
- `lib/screens/widgets/quishing_risk_bar_widget.dart`: when the level is
  `authentic`, it shows one compact row ("Genuine print · 12%"). A tap opens
  the full card. Warning levels still show the full card.

### Part 4: Open button follows the risk
- `_openRiskFor()` in the screen picks safe / warning / danger from results
  the provider already has:
  - danger: Quishing `highWarning`, sandbox unsafe, or 2+ failed checks →
    outlined red button with a warning icon;
  - warning: 1 failed check, Quishing `wearAndTear`, or the check errored →
    amber button with a warning icon;
  - safe: normal primary button.
- The confirm dialog is kept for every case. It now says "This link has N
  issues. Open it anyway?" when checks failed. For danger, "Open anyway" is a
  plain text button so Cancel is the easy choice.
- Fixed: the dialog title row could overflow on a phone-width screen. The
  title text is now `Flexible`.

### Localization
- New keys in `app_en.arb`, `app_ml.arb`, `app_sa.arb` (with `@` descriptions
  in English): `resultMoreActions`, `verdictChecking`, `verdictNoIssues`,
  `verdictIssuesFound`, `verdictChecksPassed`, `verdictSeeDetails`,
  `verdictModePrivate`, `verdictModeActive`, `safetyShowPassed`,
  `safetyHidePassed`, `safetySkippedGroup`, `safetySkippedSetup`,
  `openRiskDialogIssues`, `sandboxShowPreview`, `sandboxHidePreview`,
  `quishingCompactGenuine`.
- Change from plan: the plan listed `sandboxCompactTitle`. It was not needed,
  because the folded sandbox row already shows the URL and the badge. The
  show/hide tooltips (`sandboxShowPreview` / `sandboxHidePreview`) were added
  instead.
- Removed the now-unused key `safetyIssuesWarning` from all three files.
- Regenerated `lib/l10n/gen/*` with `flutter gen-l10n`.

### Tests
- New `test/screens/result_screen_test.dart`: actions visible without
  scrolling on a phone-sized screen; verdict text; passed/skipped folded and
  unfold; More sheet items; dialog names the issue count; no-issues verdict;
  no layout overflow in Malayalam and Sanskrit.
- New `test/screens/widgets/url_verdict_card_test.dart`: loading, no issues,
  and issues states.
- `test/services/url_safety_service_test.dart`: now also checks
  `skipped == true` for the skipped cases.

### Docs
- `docs/features.md`: added a short "Result screen layout" section under
  URL safety.

## Results
- `flutter analyze`: no issues.
- `dart format`: no changes needed.
- `flutter test`: all 444 tests pass.
- Not yet checked on a real device.

## Not done (out of scope)
- The manual decrypt sheet still has some hard-coded English labels
  ("Show Advanced (Salt / IV)" and the Salt / IV field labels). This needs its
  own plan.
