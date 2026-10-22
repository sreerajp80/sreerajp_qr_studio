# Fix: AirQR Receiver and AR CodeVision camera stays black after opening from Scan

**Status:** completed

## The issue

When the user opens **AirQR Receiver** or **AR CodeVision** from the Scan screen's
menu, the camera often shows nothing. Switching the camera (back/front) makes it work.
It does not happen every time, but most of the time.

### Cause

The Scan screen restarts its own camera in the background while the new screen is
already open. Two camera users then fight for the same camera.

Step by step:

1. The user taps the menu button. The popup menu is a route too. The app's
   `routeObserver` watches all `ModalRoute`s, so the Scan screen gets `didPushNext`
   and stops its camera.
2. The user picks "AirQR Receiver". The menu closes. The Scan screen gets
   `didPopNext`. This waits **300 ms**, then starts the Scan camera again.
3. At the same time, `_navigateToRoute` pushes the AirQR (or AR) screen. That
   screen creates its own camera controller and opens the back camera.
4. When the 300 ms wait ends, `didPopNext` still sees "camera not running" and
   starts the Scan screen's camera — **behind** the AirQR screen.
5. Android gives the camera to the newest opener. The hidden Scan screen takes the
   camera away from the AirQR/AR screen, so its preview goes black.
6. Switching the camera on the AirQR/AR screen opens the camera again and takes it
   back. That is why switching "fixes" it.

It is a timing race, so it does not happen every single time.

The same kind of problem can also happen when the app comes back from the
background (`didChangeAppLifecycleState` → `resumed`): the Scan screen restarts its
camera even when another camera screen is on top.

## Files to change

- `lib/screens/scanner_screen.dart`

## The fix

Make the Scan screen start its camera **only when it is the screen on top**.

1. Add a small helper in `_ScannerScreenState`:
   `bool get _isTopRoute => ModalRoute.of(context)?.isCurrent ?? true;`
2. In `didPopNext`, check `_isTopRoute` again **after** the 300 ms wait, and again
   before the retry. If another page is on top, do not start the camera.
3. In `_navigateToRoute`, after the pushed page returns, check `_isTopRoute` before
   starting the camera (same check, before the first start and the retry).
4. In `didChangeAppLifecycleState` → `resumed`, start the camera only if
   `_isTopRoute`.
5. In `_resumeCamera` (tab becomes active), start only if `_isTopRoute`.

No change to `ScanCameraController`, the AirQR screen, or the AR screen is needed.
When the user comes back to the Scan screen, `didPopNext` / `_navigateToRoute` still
restart its camera as before, because the Scan screen is then on top.

## Testing

- `flutter analyze` and `flutter test` must pass.
- The camera cannot run in widget tests, so the fix must be checked by hand on a
  device (I will not install anything on your phone without asking):
  - Scan → menu → AirQR Receiver: camera shows right away. Repeat about 10 times.
  - Scan → menu → AR CodeVision: same.
  - Go back to Scan: Scan camera works again.
  - Open AirQR, send app to background, come back: AirQR camera still works.

## Change log

After the fix, write `change_log/<timestamp>_scanner_camera_steals_airqr_ar.md`.
