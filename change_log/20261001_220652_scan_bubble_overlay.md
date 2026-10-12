# Change log: Scan bubble — scan codes shown in other apps

Implements plan: [plans/20261001_214414_scan_bubble_overlay.md](../plans/20261001_214414_scan_bubble_overlay.md)

## What changed

A new, optional **Scan bubble**: a small round button that floats over
other apps. Tapping it runs the existing GhostScan one-frame screen capture
(Android asks for consent every time), reads the code on the phone, opens
the normal result screen, and saves it to history.

Ways to turn it on or off:

1. Settings > **Scan bubble** (new screen).
2. New **Scan bubble** Quick Settings tile (shows on/off state).
3. App icon long-press shortcut **Start scan bubble**.
4. New **Scan bubble** item in the scanner screen menu (opens the settings screen).

Plus the **Start after restart** switch (off by default).

### Native Android (`android/app/src/main/`)

- New `kotlin/.../ScanBubbleService.kt`. A special-use foreground service.
  - Draws the bubble (`TYPE_APPLICATION_OVERLAY`).
  - Drag moves the bubble, and it snaps to the nearest side edge. Its
    position is remembered.
  - Dragging it onto an X target at the bottom turns it off.
  - A tap hides the bubble and starts `GhostScanActivity`.
  - Shows a "Scan bubble is on" notification with a **Turn off** action.
- New `ScanBubbleTileService.kt`. The Quick Settings toggle tile.
- New `ScanBubbleShortcutActivity.kt`. An invisible starter, used by the
  app shortcut and by the tile. If the overlay permission is missing, it
  opens the system permission page.
- New `ScanBubbleBootReceiver.kt`. Starts the bubble after a restart, but
  only when all three are true: "Start after restart" is on, the bubble was
  on before the restart, and the permission is still granted.
- New `ScanBubblePrefs.kt`. A small native store that holds on/off flags
  and the bubble position.
- `GhostScanActivity.kt` and `GhostScanCaptureService.kt` changes:
  - They pass a `from_bubble` flag through the capture.
  - They show the bubble again after a capture, a cancel, or a failure.
  - New check: a frame that is almost all black is flagged as `blocked`
    (the app on screen blocks screen capture).
- `MainActivity.kt` changes:
  - New `in.sreeraj.qr_reader/scan_bubble` method channel.
  - GhostScan results now go to Dart as a map (path, fromBubble, blocked).
  - Publishes the "Start scan bubble" app shortcut.
- `AndroidManifest.xml` changes:
  - New permissions: `SYSTEM_ALERT_WINDOW`, `FOREGROUND_SERVICE_SPECIAL_USE`,
    `RECEIVE_BOOT_COMPLETED`, `POST_NOTIFICATIONS`.
  - Declares the new service (with the special-use subtype text), the tile,
    the boot receiver and the starter activity.
- New drawables: `ic_scan_bubble.xml`, `ic_bubble_close_target.xml`,
  `ic_shortcut_scan_bubble.xml`.
- Native strings for the tile, shortcut and notification in
  `values/strings.xml`, new `values-ml/strings.xml` and new
  `values-sa/strings.xml`.

### Flutter (`lib/`)

- New model `models/ghost_scan_capture.dart` (immutable). It safely reads
  both the old string form and the new map form.
- `services/ghost_scan_service.dart` changes:
  - New `onCapture` stream and `getInitialCapture()`.
  - New `deleteCapture()`: the cached screen picture is now deleted after
    decoding.
  - The old `onGhostScanImage` and `getInitialGhostScanImage` still work.
- New `services/scan_bubble_service.dart`. It wraps the channel and asks
  for the notification permission. It never throws.
- New `providers/scan_bubble_provider.dart`.
- New `screens/scan_bubble_settings_screen.dart`. It has:
  - the on/off switch,
  - a permission status row with an **Allow** button,
  - a dialog that explains the permission before opening the system page,
  - the "Start after restart" switch,
  - an "Add to Quick Settings" button (Android 13+),
  - "How to use it" and "Good to know" cards.
- `screens/scanner_screen.dart` changes:
  - Uses `GhostScanCapture`.
  - Shows "This app blocks screen capture…" for black frames.
  - Tags history records with source `screen` or `screen_bubble`.
  - Deletes the cached picture after decoding.
  - New menu item.
- `providers/scan_provider.dart`: `createScanRecord()` takes an optional
  `source`.
- `models/scan_record.dart`: new source constants and an `isFromScreen`
  getter.
- `screens/widgets/history_card.dart` and `history_detail_sheet.dart` show a
  "From screen" chip.
- `screens/settings_screen.dart` changes:
  - New Scan bubble card between AirQR Sync and Permissions.
  - Two new rows on the Permissions screen: "Display over other apps" and
    "Notifications".
- New help page `screens/help/scan_bubble_help_screen.dart`, listed in
  `help_home_screen.dart` after AirQR.
- `screens/features_screen.dart`: the existing GhostScan card text now
  mentions the Scan bubble.
- `main.dart`: registers `ScanBubbleProvider` and the `/scan_bubble` route.
- `l10n/app_en.arb`, `app_ml.arb`, `app_sa.arb`: 39 new keys, each with an
  `@` description in English. Ran `flutter gen-l10n`.

### Tests (`test/`)

- New tests:
  - `models/ghost_scan_capture_test.dart`
  - `services/scan_bubble_service_test.dart`
  - `providers/scan_bubble_provider_test.dart`
  - `screens/scan_bubble_settings_screen_test.dart` (includes Malayalam and
    Sanskrit render checks)
- Updated tests:
  - `services/ghost_scan_service_test.dart`: map form, `onCapture`,
    `deleteCapture`.
  - `providers/scan_provider_test.dart`: source in metadata.
  - `screens/settings_screen_test.dart`: the new card.

### Docs

- Updated: `docs/features.md`, `docs/architecture.md`, `docs/security.md`
  (new permissions table rows and screen capture rules),
  `docs/project_structure.md`, `docs/release_process.md` (Play Console
  declaration step) and `README.md`.

## Differences from the plan

- **Start after restart is stored natively, not in `SharedPreferences`.**
  The boot receiver runs without Flutter, so it cannot read Flutter's
  preferences. Dart reads and writes the setting over the channel. It holds
  no sensitive data.
- **The app shortcut is published from code, not from `res/xml/shortcuts.xml`.**
  A resource XML file cannot use `${applicationId}`, so a static shortcut
  would point at the wrong package in the `dev` flavor.
- **The tile and the shortcut open the system permission page directly.**
  If the overlay permission is missing, they open Android's page instead of
  the app's own Scan bubble screen. The in-app switch still shows the
  explanation dialog first. The tile starts the bubble through the invisible
  starter activity, because newer Android versions do not let a tile start a
  foreground service directly.
- **The scanner screen has a menu item, not a toolbar button.** GhostScan
  itself is in the "more" menu, so the bubble entry sits next to it there.
- **The Permissions screen rows have no live status.** That screen is a
  static list of descriptions, so the new rows match it. The live status and
  the **Allow** button are on the Scan bubble screen.
- **The Features screen was not moved to ARB.** That whole screen is
  hard-coded English, and moving it is its own job. Only the existing
  GhostScan card text was updated, and no new hard-coded card was added.
- **No multi-code picker for screen captures.** As with gallery images, the
  first code found is used. Choosing among many codes on screen can be a
  later plan.

## Checks run

- `dart format lib test`: clean.
- `flutter analyze`: no issues.
- `flutter test`: all 472 tests pass. This includes key parity across the
  three ARB files and the Sanskrit Hindi-marker gate.
- `flutter build apk --flavor dev --debug`: builds, so the Kotlin code
  compiles.
- **Not tested on a real device yet.** Nothing was installed on a phone.

## Needs review

- **Sanskrit wording** (`app_sa.arb` scan bubble keys and
  `values-sa/strings.xml`). The new terms are:
  - `वीक्षण-बुद्बुदः` (Scan bubble)
  - `अन्यानुप्रयोगाणाम् उपरि प्रदर्शनम्` (Display over other apps)
  - `पुनरारम्भोत्तर-आरम्भः` (Start after restart)

  A Sanskrit reader should review them.
- **Malayalam wording** for the same keys.
- **Release step:** the Play Console declaration for
  `FOREGROUND_SERVICE_SPECIAL_USE` must be filled in before release. See
  `docs/release_process.md`.
