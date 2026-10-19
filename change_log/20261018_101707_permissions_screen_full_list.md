# Permissions screen: list every permission in plain words

Implements plan: [plans/20261018_095606_permissions_screen_full_list.md](../plans/20261018_095606_permissions_screen_full_list.md)
(Part A and Part B, both approved).

## What changed

### Part A — Permissions screen (Settings → Permissions)

- `lib/screens/settings_screen.dart`: `PermissionsSettingsScreen` rebuilt.
  - A short intro explains what permissions are and where to change them in Android.
  - Three plain groups, each with a one-line note:
    1. **Asked when needed**: Camera, Location, Fingerprint or face (`USE_BIOMETRIC`,
       `USE_FINGERPRINT`), Notifications, Show over other apps, Screen capture.
    2. **Allowed at install**: Internet, Online link check (Active Online Probing),
       Link safety services (Safe Browsing, VirusTotal and the others), Wi-Fi connect
       (Wi-Fi and network state), Keep running (foreground services), Start after restart.
    3. **Not asked for**: Photos and files (storage), Microphone, Vibration.
  - Each row has a plain title, a plain description of what it is used for, when Android
    asks, and what happens if you say no. A small grey line shows the Android names
    (protocol tokens, not translated) for rows that are real permissions.
  - The rows come from a new list, `kPermissionGroups`, with two small immutable classes
    (`PermissionInfoGroup`, `PermissionInfoEntry`) in the same file (screens layer).
  - Removed the wrong VIBRATE row and the "Scan Feedback Vibrations" row (not permissions).
  - Uses a `ListView` instead of a `SingleChildScrollView` + `Column`.
- `lib/screens/scan_bubble_settings_screen.dart`: the overlay row title now uses the new
  `labelPermOverlay` key (the old `helpPermissionOverlayTitle` key was removed).
- `lib/l10n/app_en.arb`, `app_ml.arb`, `app_sa.arb`: removed the 23 old
  `helpPermission…` keys; added 37 new keys (`helpPermissionsIntro`, `labelPermGroup…`,
  `helpPermGroup…Note`, `labelPerm…`, `helpPerm…Desc`) with `@` descriptions in English;
  reworded `descSettingsPermissions` to "What the app uses, and why" (no more
  "explicit / implicit" jargon). `lib/l10n/gen/*` regenerated.

### Part B — unused permissions removed

- `android/app/src/main/AndroidManifest.xml`: added the `tools` namespace and
  `tools:node="remove"` for `RECORD_AUDIO`, `WRITE_EXTERNAL_STORAGE` and
  `READ_EXTERNAL_STORAGE`. The `camera` plugin added these, but the app opens the camera with
  `enableAudio: false` and never saves camera files.

### Tests and docs

- New `test/screens/permissions_manifest_parity_test.dart`: reads the app manifest and fails
  if a permission is not explained on the screen, if the screen lists a permission the app
  does not have, or if a removed permission is not shown under "Not asked for".
- New `test/screens/permissions_settings_screen_test.dart`: every group and row shows in
  English, Malayalam and Sanskrit with no layout errors; Android names are shown.
- `test/screens/settings_screen_test.dart` and `test/screens/scan_bubble_settings_screen_test.dart`:
  updated for the new heading and overlay label.
- `docs/security.md` §11: added `USE_FINGERPRINT`, a note on the removed camera-plugin
  permissions, and a pointer to the screen and the parity test.

## Small differences from the plan

- The overlay label is "Show over other apps", not Android's own "Display over other apps",
  because the Android wording is over the 20-character label limit.
- Probing and link safety services are their own rows right under Internet, not text inside
  the Internet row.
- The Scan bubble screen also used one of the removed keys, so it was updated too.

## Checks

- `flutter gen-l10n`, `dart format` (no changes left), `flutter analyze`: no issues.
- `tool/check_sanskrit_hindi_markers.sh`: pass. Label-length and ARB parity tests: pass.
- `flutter test`: all 795 tests pass.
- Part B: dev debug APK built; the merged manifest no longer has `RECORD_AUDIO`, `WRITE_EXTERNAL_STORAGE` or `READ_EXTERNAL_STORAGE`. It now has 16 Android permissions, all explained on the screen. Gradle daemons stopped afterwards.
- Not tested on a phone (needs your OK first).

## Needs native-reader review

All new Malayalam and Sanskrit text was written by an AI and should be checked by a native
reader before release. Points I am least sure of:

- Malayalam group headings: "ആവശ്യമുള്ളപ്പോൾ ചോദിക്കും" (Asked when needed),
  "സ്വയം ലഭിക്കുന്നവ" (Allowed at install — literally "got automatically"),
  "ചോദിക്കാത്തവ" (Not asked for).
- Malayalam "പശ്ചാത്തല പ്രവർത്തനം" (Keep running) and "സ്ക്രീൻ പകർത്തൽ" (Screen capture).
- Sanskrit group headings: "आवश्यकतायां प्रार्थिताः", "स्वतः प्रदत्ताः", "अप्रार्थिताः".
- Sanskrit "उपरिप्रदर्शनम्" (Show over other apps), "पटलग्रहणम्" (Screen capture),
  "पृष्ठभूमिकार्यम्" (Keep running), "ध्वनिग्राही" (Microphone).
- Sanskrit long descriptions, especially the dual forms in the Internet text
  ("उभे निष्क्रिये", "तयोः निष्क्रिययोः सतोः").
