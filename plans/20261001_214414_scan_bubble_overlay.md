# Plan: Scan bubble — scan QR codes and barcodes shown in other apps

**Status:** completed

## The issue

Today the user can scan a code that is shown on the phone screen (inside
another app) only through **GhostScan**:

- the GhostScan Quick Settings tile, or
- the GhostScan button on the scanner screen.

Both work, but the user has to pull down the shade or open this app first.
The user wants a small floating **bubble** that sits on top of other apps.
One tap on the bubble scans what is on the screen. The user must give
permission first, and can turn the bubble on and off easily.

## What already exists (we reuse it)

- `GhostScanActivity.kt` asks Android for screen capture consent
  (MediaProjection — the Android system for taking a picture of the screen).
- `GhostScanCaptureService.kt` takes **one** picture of the screen, saves it
  as a JPEG in the app cache, and opens `MainActivity` with the image path.
- `ghost_scan_service.dart` + `scanner_screen.dart` read that image with our
  own zxing-cpp decoder, open the result screen, and save it to history
  (`_processSingleBarcode` → `HistoryProvider.addScanRecord`).

The bubble only adds a **new way to start** this same capture. The decode,
the URL safety checks, and the result screen stay the same.

## Decisions (agreed in chat)

- The bubble is **off by default**. The user turns it on.
- **Ways to start and stop the bubble** (all four):
  1. Settings → **Scan bubble** → on/off switch.
  2. A new Quick Settings tile **"Scan bubble"** next to the GhostScan tile.
     One tap turns the bubble on or off from inside any app.
  3. App icon shortcut: long-press the app icon → **"Start scan bubble"**.
  4. A button on the scanner screen, next to the GhostScan button.
- **Restart after phone reboot:** an extra switch **"Start after phone
  restart"** inside the Scan bubble settings. **Off by default.**
- **History:** bubble scans are saved to the encrypted history like camera
  scans, and are marked as coming from the screen.

## How the bubble works (user view)

1. User turns the bubble on (any of the four ways).
2. If the app does not yet have **"Display over other apps"** permission,
   the app shows a short explanation, then opens the Android permission page
   for this app. Nothing happens until the user allows it.
3. A small round bubble (app icon style, 56 dp) appears on the screen edge.
   A small notification "Scan bubble is on" is shown while it runs (Android
   requires this). The notification has a **Turn off** button.
4. The user can **drag** the bubble. When let go, it snaps to the nearest
   left or right edge. Its position is remembered.
5. **Tap** the bubble:
   - the bubble hides itself (so it is not in the picture),
   - Android shows its screen capture prompt (on Android 14+ this shows on
     every tap — Android rule, we cannot skip it),
   - one picture is taken and sent to the app,
   - the bubble shows again.
6. The result screen opens with the normal safety checks. If there are many
   codes, the existing multi-code picker opens. If no code is found, a
   friendly message is shown.
7. To remove the bubble: drag it to an **✕** target at the bottom of the
   screen, or tap **Turn off** in the notification, or tap the tile, or use
   the Settings switch.

## Limits (will be shown in the Scan bubble settings screen and Help)

- Android 14 and newer ask for screen capture permission on every tap.
- Apps that block screen capture (banking, payment, some video apps) give a
  black picture. We detect an almost-all-black picture and show
  "This app blocks screen capture" instead of "No code found".
- Some phone makers (Xiaomi, Oppo, Vivo, etc.) have extra "pop-up window" or
  "battery" settings that can hide or stop the bubble. Help will mention it.
- Android Bubbles API (chat heads) is for chat apps only, so we use a normal
  overlay window (`TYPE_APPLICATION_OVERLAY`).
- We do **not** use an Accessibility Service (Google Play rejects it for
  this use, and it gives too much power to the app).

## Files to be changed

### Native Android (Kotlin, `android/app/src/main/`)

| File | Change |
| --- | --- |
| `kotlin/in/sreerajp/qr_reader/ScanBubbleService.kt` | **New.** Foreground service that draws the bubble with `WindowManager` (`TYPE_APPLICATION_OVERLAY`). Handles drag, snap to edge, ✕ remove target, tap → hide bubble and start `GhostScanActivity` with a "from bubble" extra. Shows the "Scan bubble is on" notification with a **Turn off** action. Saves bubble on/off and position in a small native `SharedPreferences` file (no sensitive data). Stops itself if overlay permission is removed. |
| `kotlin/in/sreerajp/qr_reader/ScanBubbleTileService.kt` | **New.** Quick Settings tile "Scan bubble". Shows active/inactive state. Tap = turn bubble on/off. If overlay permission is missing, opens the app's Scan bubble settings screen instead. |
| `kotlin/in/sreerajp/qr_reader/ScanBubbleBootReceiver.kt` | **New.** Listens for `BOOT_COMPLETED`. Starts the bubble **only if** both "bubble was on" and "Start after phone restart" are true **and** overlay permission is still granted. |
| `kotlin/in/sreerajp/qr_reader/ScanBubbleShortcutActivity.kt` | **New.** Tiny transparent activity used by the app icon shortcut. Checks permission, starts the bubble, closes. |
| `kotlin/in/sreerajp/qr_reader/GhostScanActivity.kt` | Pass a `from_bubble` flag through to the capture service. If the user cancels the capture prompt, tell the bubble service to show the bubble again. |
| `kotlin/in/sreerajp/qr_reader/GhostScanCaptureService.kt` | Pass `from_bubble` on to `MainActivity`. After capture (or failure/timeout), tell the bubble service to show the bubble again. Add a simple "almost all black" check and send a `blocked` flag. |
| `kotlin/in/sreerajp/qr_reader/MainActivity.kt` | New method channel `in.sreeraj.qr_reader/scan_bubble` with: `canDrawOverlays`, `openOverlayPermissionSettings`, `startBubble`, `stopBubble`, `isBubbleRunning`, `setStartOnBoot`, `isTileRequestSupported` / `requestAddTile` (for the new tile). Pass `from_bubble` and `blocked` flags to Dart with the GhostScan image. Open the Scan bubble settings screen when launched by the tile or shortcut with a "needs permission" action. |
| `AndroidManifest.xml` | Add `SYSTEM_ALERT_WINDOW`, `FOREGROUND_SERVICE_SPECIAL_USE`, `RECEIVE_BOOT_COMPLETED`, `POST_NOTIFICATIONS`. Declare `ScanBubbleService` (`foregroundServiceType="specialUse"` with the required `PROPERTY_SPECIAL_USE_FGS_SUBTYPE` explanation), `ScanBubbleTileService`, `ScanBubbleBootReceiver`, `ScanBubbleShortcutActivity`. Add `<meta-data android:name="android.app.shortcuts">` to `MainActivity`. |
| `res/xml/shortcuts.xml` | **New.** Static app shortcut "Start scan bubble". |
| `res/drawable/ic_scan_bubble.xml` | **New.** Vector icon for the bubble, tile, and shortcut. |
| `res/drawable/ic_bubble_close_target.xml` | **New.** ✕ remove target icon. |
| `res/values/strings.xml` | Add tile label, shortcut labels, notification title/text, "Turn off" action (English). |
| `res/values-ml/strings.xml`, `res/values-b+sa/strings.xml` | **New.** Malayalam and Sanskrit versions of the native strings above (tile, shortcut, notification are drawn by Android, not Flutter, so they cannot use ARB files). |

### Flutter / Dart (`lib/`)

Target layers are given in brackets.

| File | Change |
| --- | --- |
| `lib/services/scan_bubble_service.dart` | **New** [services]. Wraps the `scan_bubble` method channel. No `BuildContext`, no UI text. All calls catch errors and return safe defaults (never crash). |
| `lib/providers/scan_bubble_provider.dart` | **New** [providers]. `ChangeNotifier` with: `isRunning`, `hasOverlayPermission`, `startOnBoot`. Methods: `refresh()`, `turnOn()`, `turnOff()`, `setStartOnBoot()`, `requestAddTile()`. Persists `scan_bubble_start_on_boot` in `SharedPreferences` (not sensitive). |
| `lib/services/ghost_scan_service.dart` | Stream now carries a small result (`imagePath`, `fromBubble`, `blocked`) instead of just a path. Keep it backward compatible with the existing tile flow. |
| `lib/models/ghost_scan_capture.dart` | **New** [models]. Immutable `const` model for the above (`imagePath`, `fromBubble`, `blocked`). |
| `lib/screens/scan_bubble_settings_screen.dart` | **New** [screens]. On/off switch, permission status row with "Allow" button, "Start after phone restart" switch, "Add tile to Quick Settings" button (Android 13+), and a short "How it works / limits" card. |
| `lib/screens/settings_screen.dart` | New **Scan bubble** tile between *AirQR Sync* and *Permissions*. In `PermissionsSettingsScreen`, add "Display over other apps" and "Notifications" rows with status and a link to system settings. |
| `lib/screens/scanner_screen.dart` | New bubble button next to the GhostScan button (with tooltip). Handle the new capture model: when `blocked` is true show "This app blocks screen capture"; when `fromBubble` is true mark the history record source. |
| `lib/providers/scan_provider.dart` | `createScanRecord()` takes an optional `source` value and puts it into `metadata['source']` (`'screen_bubble'`, `'screen_tile'`, or camera default). |
| `lib/screens/widgets/history_card.dart`, `lib/screens/widgets/history_detail_sheet.dart` | Show a small "From screen" label when `metadata['source']` is a screen source. |
| `lib/screens/features_screen.dart` | Add the Scan bubble feature card (also move the existing hard-coded GhostScan title to ARB as part of this). |
| `lib/screens/help/` (new `scan_bubble_help_screen.dart` + entry in `help_home_screen.dart`) | Help page: how to turn on, permissions, Android 14 prompt, blocked apps, phone-maker settings. |
| `lib/main.dart` | Register `ScanBubbleProvider` and the new route only. Stays thin. |
| `lib/l10n/app_en.arb`, `app_ml.arb`, `app_sa.arb` (+ `@` descriptions in English) | All new texts. Chrome labels ≤ 22 characters. Sanskrit passes the Hindi marker gate; Malayalam uses natural wording. Run `flutter gen-l10n`. |

### Tests (`test/`)

| File | Change |
| --- | --- |
| `test/services/scan_bubble_service_test.dart` | **New.** Mock method channel: success, errors, missing plugin → safe defaults. |
| `test/providers/scan_bubble_provider_test.dart` | **New.** State changes: turn on without permission, with permission, turn off, start-on-boot saved and loaded. |
| `test/models/ghost_scan_capture_test.dart` | **New.** Parsing from channel arguments, bad input does not crash. |
| `test/services/ghost_scan_service_test.dart` | Update for the new capture model; old string-only form still works. |
| `test/providers/scan_provider_test.dart` | `createScanRecord(source: ...)` puts the source into metadata. |
| `test/screens/settings_screen_test.dart` | The new Scan bubble tile and the new permission rows show up. |
| `test/screens/scan_bubble_settings_screen_test.dart` | **New.** Switches and buttons render in all three languages. |
| `test/l10n/l10n_parity_test.dart` | No change expected; must still pass with the new keys. |

### Docs

| File | Change |
| --- | --- |
| `docs/features.md` | Add Scan bubble. |
| `docs/architecture.md` | Add the new service, provider, screen, and native components. |
| `docs/security.md` | Explain the new permissions (`SYSTEM_ALERT_WINDOW`, special-use foreground service, boot receiver, notifications), why each is needed, and that screen images stay in the app cache and are deleted after decoding. |
| `docs/project_structure.md` | List the new files. |
| `docs/release_process.md` | Add the Play Console step for the `specialUse` foreground service reason. |
| `README.md` | One line in the feature list. |

`CLAUDE.md` and `AGENTS.md` need no change (no new rules, no new dependency).

## Plan for the fix (steps)

1. **Native bubble service** — `ScanBubbleService` with overlay window, drag,
   snap, ✕ target, notification with Turn off, show/hide around capture.
2. **Link to GhostScan** — pass `from_bubble`, re-show bubble after capture
   or cancel, add the black-picture check.
3. **Quick Settings tile** — `ScanBubbleTileService` with live on/off state;
   "Add tile" request through `StatusBarManager` on Android 13+.
4. **App shortcut** — `shortcuts.xml` + `ScanBubbleShortcutActivity`.
5. **Boot restart** — `ScanBubbleBootReceiver`, only when the user turned on
   "Start after phone restart" and the permission is still granted.
6. **Manifest and native strings** (English, Malayalam, Sanskrit).
7. **Dart layer** — model, service, provider, wire into `main.dart`.
8. **Screens** — Scan bubble settings screen, Settings tile, Permissions rows,
   scanner screen button, history "From screen" label, Features card, Help.
9. **ARB strings** in all three languages, then `flutter gen-l10n`.
10. **Tests** as listed above.
11. **Checks** — `dart format .`, `flutter analyze` (0 issues), `flutter test`
    (all pass), then `flutter build apk --flavor dev --debug` to make sure the
    native code compiles.
12. **Docs** and the change log in `change_log/`.

## Privacy and safety

- No new packages. Nothing goes online. Decoding stays on the phone.
- The screen picture is taken **only** when the user taps the bubble, and
  Android always shows its own consent prompt. No background or repeated
  capture.
- The screen picture is saved only in the app cache and is deleted right
  after decoding (add the delete if it is not already done).
- Nothing about the bubble is logged except plain state in debug builds.
- `android:allowBackup="false"` stays.

## Things to note

- **Google Play:** the `specialUse` foreground service type needs a short
  written reason in Play Console ("shows a floating button the user tapped
  to start; stays on until the user turns it off"). This is a manual step
  for you at release time. I will add it to `docs/release_process.md`.
- **Testing on a phone:** I will **not** install anything on your phone.
  When the build is ready I will ask you before any device test.
- Android 15 limits which services may start after reboot. A `specialUse`
  service with overlay permission is allowed, but phone makers may still
  block it. If it does not work on some phones, the user can still start
  the bubble with one tap on the tile.

## Out of scope

- Scanning the screen continuously or automatically.
- Choosing a part of the screen before scanning (can be a later plan).
