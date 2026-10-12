# Plan: Make the URL result screen short and quick to act on

**Status:** completed

## The issue

On a URL scan, the result screen is about three phone screens long. The main
action ("Open in Browser") is the last item in one long scrolling list, so the
user has to scroll all the way down to use it.

Why it is so long (order in `lib/screens/result_screen.dart`, `build()`):

1. Result type card
2. Quishing Guard card (full size, even when the print looks genuine)
3. Sandbox preview card (full size: fake browser bar, page header, 3 chips,
   status line, "Inspect sandbox" button)
4. Content card (the URL)
5. URL safety card, which holds:
   - 3 banners stacked on top of each other ("open only if you trust the
     source", "private mode", "issues found"). They repeat each other.
   - All 10 checks as big tiles, including 4 to 6 "skipped (no API key /
     disabled)" tiles that tell the user nothing
6. Action buttons: Open, Recheck, Copy, Share, Decrypt, Scan another

The verdict (safe or not) and the Open button are both at the bottom, far
away from the top of the screen.

## Goal

When the screen opens, the user sees the type, the URL, a one-line safety
verdict, and the action buttons, with no scrolling. All the detail is still
there, one tap away.

## The fix (four parts)

### Part 1: Fixed action bar at the bottom

- Move the actions out of the scrolling list into `Scaffold.bottomNavigationBar`
  (wrapped in `SafeArea` so it clears the system nav bar, in line with plan
  `20260928_123413_bottom_inset_edge_to_edge.md`).
- Layout:
  - **Row 1 (URLs only):** `Open in Browser`, full width. For non-URL scans this
    row is not shown.
  - **Row 2:** `Copy` and `Share` as buttons with short labels, plus a `More`
    (⋮) icon button with a localized tooltip.
- The `More` menu (a bottom sheet) holds: `Decrypt` (when it shows today),
  `Recheck` (only when there is a network error, same rule as today), and
  `Scan another`.
- A small thin divider/elevated surface on top of the bar so it reads as
  separate from the content.
- The body keeps its bottom padding so the last card is not hidden behind the
  bar.

### Part 2: Verdict summary card near the top

- New widget `UrlVerdictCard` (layer: `screens/widgets`), shown for URLs right
  under the content card. The order becomes: type card, content card (URL),
  verdict card, then the detail cards.
- It shows:
  - While checking: a small spinner and "Checking link safety…".
  - When done: an icon + colour + one headline:
    - no failed checks → "No issues found" (green / neutral)
    - failed checks → "N issues found", plus the name of the first failed
      check (e.g. "URL shortener check"), in red/amber.
  - A second line: "X of Y checks passed" and the privacy mode in a few words
    ("Private mode" / "Active probing").
  - A "See details" link that scrolls to the full safety card (using a
    `GlobalKey` + `Scrollable.ensureVisible`).
- The three banners in the full safety card become one short line at the
  top of that card (see Part 3), because the verdict card now carries the
  main message.

### Part 3: Fold the long lists by default

- **Safety checks list** (in `_buildSafetyCard`):
  - Show failed checks always, as today.
  - Put passed checks behind a toggle: "Show N passed checks ▾".
  - Group skipped checks (no API key / service turned off / skipped in
    private mode) into one line: "N checks skipped. Set up in Settings",
    with a tap that opens Settings (`/settings` route). The line expands to
    list them.
  - To know which checks are "skipped" without matching message keys in the
    UI, add a `skipped` field to the `SafetyCheckResult` model
    (layer: `models`, default `false`, `const` constructor kept). Set
    `skipped: true` in `UrlSafetyService` at the 6 places that return a
    "skipped" message today (redirect skipped in private mode, malicious
    content no key, VirusTotal no key, URLhaus no key, PhishTank disabled,
    OpenPhish disabled). `passed` stays as it is today, so the safety verdict
    logic in `ScanProvider` does not change.
- **Merge the 3 banners** into one compact info row: trust hint + privacy
  mode in one or two short lines. The red "issues found" banner is removed
  here, because the verdict card already says it.
- **Sandbox preview card** (`DomSandboxPreviewCard`): turn it into a
  StatefulWidget that starts folded. The folded state is one row: lock icon,
  host name, the "sandboxed" chip, and an expand arrow. It starts open only
  when the sandbox result is not safe (`result.isSafe == false`).
- **Quishing Guard card** (`QuishingRiskBarWidget`): when the level is
  `authentic`, show one compact row (green tick, title, "Genuine print · 12%",
  expand arrow). For `wearAndTear` and `highWarning` keep the full card as
  today.

### Part 4: Open button follows the risk

- Use the result that already exists (`isSafeUrl`, `safetyChecks`,
  `quishingResult`, `domSandboxResult`) to pick one of three looks:
  - **Safe** (no failed checks, sandbox safe, quishing authentic or absent):
    normal filled primary button.
  - **Warning** (some failed checks, or quishing `wearAndTear`): filled amber
    button with a ⚠ icon.
  - **Danger** (quishing `highWarning`, or sandbox not safe, or 2+ failed
    checks): outlined red button with a ⚠ icon.
- The confirm dialog (`_showWarningDialog`) stays for all cases, as today.
  For warning and danger it names the issue count ("This link has N issues.
  Open anyway?"). For danger the "Open anyway" button is a plain text button,
  not a filled one, so the safe choice (Cancel) is the easy one.
- The risk choice is a small pure function in the screen file (no new
  business logic in a service): `_OpenRisk _openRiskFor(ScanProvider p)`.
- While checks are still running the button stays disabled, as today.

## Files to change

| File | Change |
| --- | --- |
| `lib/screens/result_screen.dart` | New layout order; bottom action bar; More sheet; fold passed/skipped checks; merged banner; risk-aware Open button and dialog text |
| `lib/screens/widgets/url_verdict_card.dart` | **New.** Verdict summary card (Part 2) |
| `lib/screens/widgets/dom_sandbox_preview_card.dart` | Start folded; compact header row; open by default when not safe |
| `lib/screens/widgets/quishing_risk_bar_widget.dart` | Compact row when `authentic` |
| `lib/models/safety_check_result.dart` | Add `final bool skipped` (default `false`) |
| `lib/services/url_safety_service.dart` | Set `skipped: true` at the 6 "skipped" results |
| `lib/l10n/app_en.arb`, `app_ml.arb`, `app_sa.arb` | New strings (below), with `@key` descriptions in `app_en.arb` |
| `lib/l10n/gen/*` | Regenerated by `flutter gen-l10n` |
| `test/screens/widgets/url_verdict_card_test.dart` | **New.** Loading / no issues / N issues states |
| `test/screens/result_screen_test.dart` | **New.** Open button is visible without scrolling; passed checks folded; skipped group line; More sheet items |
| `test/services/url_safety_service_test.dart` | Check `skipped` is set for the no-key / disabled cases (extend existing test if present) |
| `docs/features.md` | Short note on the new result screen layout |

### New l10n keys (all three languages, labels ≤ 22 chars where they are chrome)

- `resultMoreActions` (tooltip / sheet title: "More actions")
- `verdictChecking` ("Checking link safety…")
- `verdictNoIssues` ("No issues found")
- `verdictIssuesFound` ("{count} issues found", plural)
- `verdictChecksPassed` ("{passed} of {total} checks passed")
- `verdictSeeDetails` ("See details")
- `verdictModePrivate` / `verdictModeActive` (short mode labels)
- `safetyShowPassed` ("Show {count} passed checks", plural)
- `safetyHidePassed` ("Hide passed checks")
- `safetySkippedGroup` ("{count} checks skipped", plural)
- `safetySkippedSetup` ("Set up in Settings")
- `openRiskDialogIssues` ("This link has {count} issues. Open anyway?", plural)
- `sandboxCompactTitle` (folded sandbox row label)
- `quishingCompactGenuine` ("Genuine print · {percent}%")

Existing keys are reused where they fit (`resultOpenInBrowser`, `resultCopyText`,
`resultShareText`, `decryptPayloadAction`, `resultRecheckButton`,
`resultScanAnother`, `safetyTrustSourceHint`, `probingBannerPrivate/Active`).
Sanskrit and Malayalam text will follow the §8.5 quality rules (no Hindi
markers in Sanskrit; natural Malayalam). Unused keys left behind (e.g.
`safetyIssuesWarning` if nothing uses it any more) will be removed from all
three ARB files.

## What does not change

- No change to how safety is worked out (`ScanProvider`, check logic,
  `isSafeUrl`). Only the `skipped` flag is added.
- Non-URL scans (Wi-Fi, contact, payment, StegoQR…) keep their smart cards.
  They get the same bottom bar without the Open row.
- The confirm dialog before opening a link stays for every case.
- No new packages.

## Out of scope (noted, not fixed here)

- The manual decrypt sheet has some hard-coded English labels
  ("Show Advanced (Salt / IV)", "Salt (Base64 / Optional)", etc.). This breaks
  the l10n rule but is a separate fix. I can plan it next.

## Checks after the change

- `flutter gen-l10n`, `dart format .`, `flutter analyze` (0 issues),
  `flutter test` (all green, including ARB key parity and Sanskrit fallback
  tests).
- Visual check on a dev build: I will ask before installing on any phone.
