# Make "Distance Scan Assist" and its sliders actually work

**Status:** completed

## The issue

The camera settings sheet (`lib/widgets/camera_adjustments_sheet.dart`) has a
"Distance Scan Assist" switch. When it is on, an "Edge Sharpness" slider shows.
`CameraSettingsProvider` also has a "distance zoom" value. All three are saved to
`SharedPreferences`, but nothing uses them:

1. **Live camera ignores them.** `ScanCameraController._onFrame` sends each
   camera frame straight to the decoder. It never looks at the switch, the zoom,
   or the sharpness. Turning the switch on only restarts the camera (the sheet
   calls `onResolutionChanged`), and then nothing is different.
2. **Picked images ignore them.** `MediaScanService.scanImageFile` always runs the
   distance pipeline with the fixed defaults in `DistanceScanConfig`
   (zoom 2.5, sharpness 1.5). Pass 3 uses fixed values too (zoom 3.5,
   sharpness 2.0). Moving the slider changes nothing. This covers gallery
   images, shared images, and GhostScan screen captures.
3. **Distance zoom has no control.** `setDistanceZoomFactor` exists, but there is
   no slider for it, so the user can never change it.
4. **Reset is not saved.** `resetAdjustments()` sets zoom and sharpness back to
   defaults in memory only. After an app restart the old values come back.
   Its doc comment also says it resets "distance enhancement", but it does not
   touch the switch.

So the sheet promises a feature ("Zoom-crop & unsharp mask for distant posters
& signs") that the live camera does not have.

## Decision: wire them up (not remove)

The pipeline itself already exists and is tested
(`DistanceEnhancementService`). Only the connection is missing. Wiring it up
gives users the feature the sheet already describes. Removing it would throw
away working code.

## The fix

### A. Picked images use the user's values

- `MediaScanService.scanImageFile` and `pickAndScanImage` get a new optional
  `DistanceScanConfig distanceConfig` parameter (default: today's defaults, so
  nothing else breaks). It is passed to `runMultiScaleDistanceScan` as
  `baseConfig`.
- In `DistanceEnhancementService.runMultiScaleDistanceScan`, pass 3 no longer
  uses fixed numbers. It goes one step stronger than the base config:
  zoom = base + 1.0 (max 4.0), sharpness = base + 0.5 (max 2.5),
  contrast 1.45. With the default values this gives exactly today's numbers
  (3.5 / 2.0), so default behaviour does not change.
- The image fallback stays **always on** for picked images, as it is today. It
  only runs when the normal decode finds nothing, so it costs nothing on good
  images. The switch is in the *camera* sheet, so it controls the live camera.
  Only the slider values are applied to images.
- `ScannerScreen` builds the config from `CameraSettingsProvider` and passes it
  in for gallery, shared-image, and GhostScan scans.

### B. Live camera runs the assist when the switch is on

- `CameraSettingsProvider` gets a getter `distanceScanConfig` that returns a
  `DistanceScanConfig` from the saved zoom and sharpness.
- `ScanCameraController` gets a settable `distanceAssist` field
  (`DistanceScanConfig?`; `null` means off). It can change while the camera
  runs, so moving a slider needs no camera restart.
- In `_onFrame`: if the normal decode finds no code, and assist is on, and no
  assist is already running, and at least ~600 ms have passed since the last
  assist try, then run one assist pass on that frame **in the background**:
  - Crop the centre region of the luminance (grey) plane first (the same
    centre area `calculateCandidateRoi` uses), so only the small crop is
    converted to a pixel buffer.
  - Run zoom → contrast → sharpen with the user's values, inside
    `Isolate.run`, so the UI stays smooth. The output size is capped (longest
    side about 1600 px) so slow phones are not overloaded.
  - Decode the result. If a code is found, map its corner points back from the
    enlarged crop to the upright camera frame, and emit it on the normal
    `barcodes` stream, so the overlay, multi-code, and scan flow work as usual.
  - Normal frame decoding keeps running while the assist works. The assist
    never queues up; extra tries are skipped.
- New code in `DistanceEnhancementService` (service layer, no UI):
  - `processLuminanceFrame(...)` — crop + enhance + decode one grey frame.
  - a small pure helper that maps corners from the enhanced crop back to frame
    coordinates (handles crop offset, zoom, and 90/180/270 rotation), so it can
    be unit-tested.
- `ScannerScreen`:
  - When it creates the controller, and in `_onCameraSettingsChanged`, it sets
    `controller.distanceAssist` to `distanceScanConfig` when the switch is on,
    or `null` when off.
  - The switch in the sheet no longer needs to restart the camera, so its call
    to `onResolutionChanged` is removed (resolution changes still restart it).

### C. Add the missing "Distance Zoom" slider

- In the sheet, under the switch and next to "Edge Sharpness", add a
  "Distance Zoom" slider: range 1.5x–4.0x (the range the provider already
  clamps to), shown only when the switch is on.
- New ARB key `cameraDistanceZoomLabel` in all three files, with an
  `@cameraDistanceZoomLabel` description in `app_en.arb`. Short labels
  (≤ 22 characters):
  - en: "Distance Zoom"
  - ml: "ദൂര സൂം"
  - sa: "दूरविस्तारः"
- Run `flutter gen-l10n`.
- Fix the doc comment on `setDistanceZoomFactor` (it says 2.0–4.0; the code
  clamps 1.5–4.0).

### D. Save the reset

- `resetAdjustments()` also writes the default zoom, sharpness, and multi-code
  values to `SharedPreferences`, so the reset survives a restart.
- Fix its doc comment so it says what it really resets (not the switch).

## Files to change

1. `lib/models/distance_enhanced_scan_result.dart` — no shape change expected;
   only touched if a small helper (for example a "stronger" copy for pass 3)
   fits better here.
2. `lib/services/distance_enhancement_service.dart` — pass 3 from base config;
   new `processLuminanceFrame`; corner-mapping helper.
3. `lib/services/media_scan_service.dart` — `distanceConfig` parameter.
4. `lib/services/scan_camera/scan_camera_controller.dart` — `distanceAssist`
   field; throttled background assist in `_onFrame`.
5. `lib/providers/camera_settings_provider.dart` — `distanceScanConfig` getter;
   save on reset; doc comment fixes.
6. `lib/screens/scanner_screen.dart` — pass config to image scans; keep
   `controller.distanceAssist` in step with settings.
7. `lib/widgets/camera_adjustments_sheet.dart` — "Distance Zoom" slider; switch
   no longer restarts the camera.
8. `lib/l10n/app_en.arb`, `lib/l10n/app_ml.arb`, `lib/l10n/app_sa.arb` — new
   key `cameraDistanceZoomLabel` (+ regenerated files in `lib/l10n/gen/`).
9. Tests:
   - `test/services/distance_enhancement_service_test.dart` — pass 3 is
     derived from the base config; luminance crop + enhance; corner mapping for
     0/90/180/270.
   - `test/services/media_scan_service_test.dart` (or
     `media_scan_decoder_test.dart`) — the config given to `scanImageFile`
     reaches the distance pipeline.
   - `test/providers/camera_settings_provider_test.dart` —
     `distanceScanConfig` getter; reset is saved to preferences.

## Risks

- **Speed on slow phones.** The assist is pure Dart. It runs in a background
  isolate, at most about once every 600 ms, only when no code is found, and on
  a capped image size. It is off by default (the switch defaults to off).
- **Corner positions.** If mapping is slightly off, the overlay box could be
  drawn in the wrong place. The mapping helper gets its own unit tests.
- **Real benefit needs a device test.** Unit tests prove the wiring, not how
  well it reads far-away codes. A test on a phone with a distant poster is
  needed. I will **not** install anything on a phone without asking first.

## Checks

- `flutter gen-l10n`
- `dart format .`
- `flutter analyze` — must be clean.
- `flutter test` — all tests must pass (including ARB key parity).

## Out of scope (noted for later)

- ARB key `scanDistanceModeTooltip` is not used anywhere in the code. It can be
  removed in a separate small cleanup.
- Brightness, contrast, and invert are not saved across restarts. That may be
  on purpose and is not changed here.
