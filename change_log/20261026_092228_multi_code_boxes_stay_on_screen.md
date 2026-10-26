# Multi-code tap boxes now clear when the codes leave the view

Implements plan: `plans/20261026_091950_multi_code_boxes_stay_on_screen.md`

## What was wrong

On the Scan tab, after "Multiple codes detected" showed up, pointing the camera away
left the banner and all tap boxes on screen until the user switched tabs and came back.
Stale boxes were only removed when a new camera frame arrived, and the camera sends no
frame when it sees no codes.

## What changed

- `lib/providers/multi_code_selection_provider.dart`
  - Added a repeating cleanup timer (every 250 ms) that runs only while multi-code mode
    is active. Each tick removes boxes not seen for 1.5 s (same rule as before). When
    none are left, multi-code mode ends and the banner and boxes go away.
  - It notifies listeners only when a box was actually removed.
  - The timer stops in `dismiss()`, `reset()` (also used when the feature is turned
    off) and in a new `dispose()` override.
  - New optional constructor values `staleAfter` and `cleanupInterval` (defaults:
    1.5 s and 250 ms) so tests can use short times. App behaviour uses the defaults.
- `test/providers/multi_code_selection_provider_test.dart`
  - Added 5 tests: boxes clear on their own, boxes stay while codes keep arriving,
    cleanup notifies only on change, and `reset()` / `dismiss()` stop the timer.

The camera controller was not changed (it is shared with AirQR and AR CodeVision).

## Checks

- `dart format` — no changes needed.
- `flutter analyze` — no issues.
- `flutter test` — all 888 tests pass.
- Not yet checked on a device.

## Not covered

The tap boxes being drawn lower than the real codes (seen in a screenshot) is a separate
issue and was not changed here.
