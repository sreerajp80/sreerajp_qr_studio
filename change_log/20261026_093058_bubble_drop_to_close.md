# Scan bubble: dropping on the X now closes it

Plan: `plans/20261026_092454_bubble_drop_to_close.md`

## What was wrong

The check "is the bubble over the X?" worked out the X's place from the full
screen height. Android places overlay windows inside the status bar and the
navigation bar, so the X was really higher than the code thought. A drop right
on the X was treated as a miss, and the bubble snapped back to the side.

## What changed

- `android/app/src/main/kotlin/in/sreerajp/qr_studio/ScanBubbleService.kt`
  - `isOverCloseTarget()` now takes the finger's screen position
    (`event.rawX`, `event.rawY`) and compares it with the X's real on-screen
    centre from `getLocationOnScreen()`. If the X is not laid out yet, it
    returns false (the bubble just snaps to the side).
  - The drag (X grows when hovered) and the release (bubble turns off) both use
    the new check.

No change to the Quick Settings tile. A "Scan bubble" tile already exists
(`ScanBubbleTileService.kt`); add it from Settings → Scan bubble → Add tile, or
from the Quick Settings edit panel.

## Checks

- `flutter analyze`: no issues.
- `flutter test`: all 888 tests passed.
- `flutter build apk --flavor dev --debug`: built fine (Kotlin compiles).
- Gradle daemons stopped afterwards.
- Not tested on a device yet. To test: turn the bubble on, drag it onto the X
  (the X should grow), let go. The bubble and its notification should go away.
