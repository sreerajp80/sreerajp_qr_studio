# Scan bubble: dropping on the X does not close it

**Status:** completed

## The issue

When you drag the floating Scan bubble (the GhostScan bubble) onto the round X
at the bottom of the screen and let go, the bubble does not close. It just snaps
back to the side. The X also does not grow when the bubble is over it.

### Why it happens

`isOverCloseTarget()` in `ScanBubbleService.kt` works out where the X is with
maths, not by asking Android where the X really is:

- It takes the **full** screen height (`currentWindowMetrics.bounds`, which
  includes the status bar and the navigation bar) and subtracts the X's margin.
- But Android places overlay windows **inside** the status bar and navigation
  bar by default. So the bubble's `y = 0` is just under the status bar, and the
  X sits just above the navigation bar.

The two numbers use different starting points. The gap is the height of the
status bar plus the navigation bar (often 50–100 dp). The "hit" circle is only
64 dp, so the code thinks the X is lower than it really is. When the bubble is
dropped right on the X, the code says "not over the X".

## The fix

Ask Android where things really are on the screen, instead of guessing:

1. When the X appears, read its real on-screen position with
   `getLocationOnScreen()` once it is laid out.
2. During the drag and on release, compare the **finger position**
   (`event.rawX` / `event.rawY`, which are real screen positions) with the
   real centre of the X. If the finger is within the hit distance, the bubble
   is "over the X".
3. If the X has not been laid out yet (width 0), treat it as "not over the X"
   (safe: the bubble just snaps to the side, never crashes).

Nothing else changes: release on the X still calls `stopBubble()`, which turns
the bubble off, saves "off", removes the notification and refreshes the Quick
Settings tile. The app's switch already updates when you come back to the app.

## About the Quick Settings tile

A **"Scan bubble" Quick Settings tile already exists** (`ScanBubbleTileService.kt`,
registered in `AndroidManifest.xml`). Tapping it turns the bubble on or off. You
can add it in two ways:

- In the app: Settings → Scan bubble → **Add tile** button (Android 13 and newer).
- Or: pull down Quick Settings → edit (pencil) → drag **Scan bubble** into place.

So this plan does **not** add a new tile. If you already tried the tile and it
does not work (or you want it named differently, e.g. "GhostScan bubble"), tell
me what you see and I will plan that as a change.

## Files to change

- `android/app/src/main/kotlin/in/sreerajp/qr_studio/ScanBubbleService.kt`
  - `isOverCloseTarget()` — use the real X position and the finger position.
  - `BubbleTouchListener` — pass the finger position to the check.

No Dart, ARB, manifest or test file changes. (This is native Android UI code;
there are no unit tests for it. It needs a check on a device.)

## Checks

- `flutter analyze` and `flutter test` stay clean.
- Build the dev flavor to make sure the Kotlin compiles, then stop the Gradle
  daemons (`android\gradlew --stop`) and end any left-over daemon processes.
- I will **not** install on your phone unless you say yes. To test by hand:
  turn the bubble on, drag it onto the X, let go → the bubble and its
  notification disappear, and the tile shows "off".
