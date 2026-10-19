# Permissions screen: list every permission in plain words

**Status:** completed

## The issue

The Permissions screen (Settings → Permissions) does not match what the app really asks
Android for. I compared it with the app's own manifest and the final merged manifest
(the one built into the APK, which also holds permissions added by plugins).

**Missing from the screen** (the app has them, the screen does not say so):

| Permission | Where it comes from | What it is really used for |
| --- | --- | --- |
| `ACCESS_FINE_LOCATION`, `ACCESS_COARSE_LOCATION` | app manifest | CodeForge "use my location" button when making a location (geo) QR code |
| `ACCESS_WIFI_STATE`, `CHANGE_WIFI_STATE` | app manifest | "Connect" button on a scanned Wi-Fi QR code (adds a network suggestion) |
| `ACCESS_NETWORK_STATE`, `CHANGE_NETWORK_STATE` | app manifest | checking if the phone is online, and the Wi-Fi connect flow |
| `FOREGROUND_SERVICE`, `FOREGROUND_SERVICE_MEDIA_PROJECTION` | app manifest | GhostScan: one-time screen capture to read a code shown on screen |
| `FOREGROUND_SERVICE_SPECIAL_USE` | app manifest | keeps the Scan bubble running while you have it on |
| `RECEIVE_BOOT_COMPLETED` | app manifest | turns the Scan bubble back on after a restart, only if you left it on |
| `USE_FINGERPRINT` | `local_auth` plugin | older-phone version of the biometric permission |
| `RECORD_AUDIO` | `camera` plugin | **not used** — the app opens the camera with audio off |
| `WRITE_EXTERNAL_STORAGE` (Android 9 and older), `READ_EXTERNAL_STORAGE` (implied) | `camera` plugin | **not used** — the app never saves camera files to shared storage |

**Wrong on the screen:**

- "Vibration & Haptics (`android.permission.VIBRATE`)" — the app does not have this
  permission. Flutter's haptic taps need no permission. The "Scan Feedback Vibrations"
  item is listed as if it were a permission too.
- Internet text says it is used *only* for probing and Safe Browsing. It is also needed
  by AirQR device sync (if it uses the network) and opening links is done by other apps.
  I will check each use before writing the final text.
- Titles mix plain words with raw Android names (`android.permission.CAMERA`), which an
  ordinary user does not understand. Section names like "Explicit / Implicit" are jargon.

## The fix

### Part A — rewrite the Permissions screen (main change)

New layout, three groups with plain headings:

1. **Asked only when you use a feature** (you see an Android prompt, you can say no)
   - Camera — scanning, AR CodeVision, AirQR receive.
   - Location — only the CodeForge "use my location" button. Never in the background.
   - Fingerprint / face unlock (`USE_BIOMETRIC` + `USE_FINGERPRINT`) — App lock and
     locked vault items. The app never sees your fingerprint; Android checks it.
   - Notifications — the "Scan bubble is on" notice with a Turn off button.
   - Display over other apps — only for the Scan bubble, after you turn it on.
   - Screen capture (GhostScan) — Android asks every time; one picture only, read on the
     phone, never saved or sent. Uses the foreground-service permissions.
2. **Given at install, used in the background of a feature** (no prompt on Android)
   - Internet — only for optional link checks (Active Online Probing, Safe Browsing).
   - Network status — to know if you are online before an online check.
   - Wi-Fi control — only when you tap "Connect" on a Wi-Fi QR code.
   - Keep running (foreground services) — GhostScan capture and Scan bubble; Android
     shows a notification while either runs.
   - Start after restart — only brings the Scan bubble back if you left it on.
3. **What the app does not use**
   - No storage permission: images and PDFs are picked through Android's own picker.
   - No microphone: audio and storage permissions added by the camera library are
     removed (see Part B). If Part B is not approved, this item says plainly that the
     camera library lists them but the app never uses them.

Keep the existing "depends on your settings" items for **Active Online Probing** and
**Google Safe Browsing**, inside group 2's Internet entry or as a short sub-list.
Remove the VIBRATE and "Scan Feedback Vibrations" items (not permissions).

Each item: plain title (≤ 20 chars English / 22 chars ml & sa), plain description
(`help…` key, may be long), and a small grey line with the Android name for people who
want to check it (`android.permission.CAMERA`) — this is a protocol token, kept as a
literal, not translated.

To keep the screen honest in future, the list of items will be a `const` list in the
screen, and a new test compares it with the permissions in
`android/app/src/main/AndroidManifest.xml`, so a new manifest permission without a screen
entry fails `flutter test`.

### Part B — remove unused permissions added by the camera plugin (recommended)

Add `xmlns:tools` and three `tools:node="remove"` lines for `RECORD_AUDIO`,
`WRITE_EXTERNAL_STORAGE` and `READ_EXTERNAL_STORAGE`. The camera is started with
`enableAudio: false` and only streams frames, so it needs none of them. This also makes
the Play Store permission list and the Data safety form smaller and more honest.
I will rebuild and check the merged manifest to confirm they are gone, and run the
on-device camera only if you say yes (I will not touch your phone without asking).

## Files to change

- `lib/screens/settings_screen.dart` — rebuild `PermissionsSettingsScreen`.
- `lib/l10n/app_en.arb`, `lib/l10n/app_ml.arb`, `lib/l10n/app_sa.arb` — new and
  reworded `labelPermission…` / `helpPermission…` keys with `@` descriptions; remove
  the unused VIBRATE / feedback keys; update `descSettingsPermissions` (drop "explicit,
  implicit" jargon). Then `flutter gen-l10n`.
- `lib/l10n/gen/*` — regenerated.
- `test/screens/settings_screen_test.dart` — screen shows every item.
- `test/screens/permissions_manifest_parity_test.dart` (new) — manifest vs screen list.
- `android/app/src/main/AndroidManifest.xml` — Part B only.
- `docs/security.md` — update its permission list if it has one.
- `change_log/<timestamp>_permissions_screen_full_list.md` — after the work.

Not touched: `docs/guidelines/` (read-only submodule).

## Checks

- `flutter gen-l10n`, `dart format .`, `flutter analyze` (clean), `flutter test`.
- ARB key parity, length limits, Sanskrit Hindi-marker gate.
- Part B: dev build, read merged manifest, then `android\gradlew --stop` and clear
  leftover Gradle/Kotlin daemons.
- Malayalam and Sanskrit wording flagged for native-reader review in the change log.
