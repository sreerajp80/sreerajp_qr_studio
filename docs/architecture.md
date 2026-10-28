# Architecture — SreerajP QR Studio

This document describes how SreerajP QR Studio is built today: layers, folders, start-up,
lifecycle, state, data flow, errors, storage, the barcode engine, localization, build model,
UI system, logging, testing, decisions and known risks. Read it before changing the app's
structure, providers, services, models or screens.

**Read first:**
- [CLAUDE.md](../CLAUDE.md) / [AGENTS.md](../AGENTS.md)
- [PROJECT_PROFILE.md](PROJECT_PROFILE.md)
- [security.md](security.md)
- [dependencies.md](dependencies.md)
- [guidelines/architecture.md](guidelines/architecture.md) (template) and
  [guidelines/flutter_project_engineering_standard.md](guidelines/flutter_project_engineering_standard.md)

---

## 1. Scope

- Product: SreerajP QR Studio (`in.sreerajp.qr_studio`)
- Repository type: application
- Engineering standard profiles in force: `Core Baseline`, `Production App Extension`,
  `Sensitive Data Extension`
- Platforms: **Android** only (minSdk 24, targetSdk 36, compileSdk 37)

---

## 2. Goals And Non-Goals

### Goals
- Fast offline QR and barcode scanning (camera, gallery, PDF, share sheet, clipboard, screen
  capture) with camera controls (zoom, exposure, torch, lens switch, distance assist).
- Link safety: 6 offline checks (HTTPS, certificate, redirects, suspicious patterns, shorteners,
  homographs) plus optional online reputation checks with user-supplied API keys.
- A sandboxed page preview to inspect a link before opening it in a browser.
- Quishing Guard: a reminder to check printed codes for fake stickers by hand (no image analysis).
- StegoQR: hidden, encrypted QR content (AES-256-GCM), with optional biometric reveal.
- Smart payload actions (Wi-Fi, contact, calendar, phone, SMS, email, geo, UPI, TOTP, ISBN,
  products, app links).
- AirQR: offline screen-to-camera data transfer; AR CodeVision: live multi-code view.
- CodeForge: QR and barcode generator.
- Encrypted scan history with search, favorites, notes, export and encrypted backup.
- Three languages — English, Malayalam, Sanskrit — with an in-app picker.

### Non-Goals
- iOS, desktop or web.
- Accounts, cloud sync, tracking, analytics, ads.
- Closed or telemetry-bearing scanning SDKs (Google ML Kit, Firebase ML).

---

## 3. Architecture Summary

The app uses a Tier 1 layer-first structure with Provider (`ChangeNotifier`) for state. Screens
read providers; providers call services; services hold the business logic and talk to storage,
platform channels and the native decoder; models are immutable. Barcode decoding runs in the
app's own zxing-cpp engine on a background isolate through dart:ffi. Scan history is stored in
SQLite with AES-256-GCM field encryption and the key in Android KeyStore. The app works fully
offline; online link checks are optional and opt-in. All user-visible text comes from
`AppLocalizations` in English, Malayalam and Sanskrit.

---

## 4. Repository Structure

### Current structure tier
- **Tier 1 (layer-first).** One product area, one developer, and the layers stay clear; promote
  to Tier 2 only if boundaries start to blur (engineering standard §3.1).

### Top-level source layout

```text
lib/
|-- core/
|   |-- config/          # AppConfig + ConfigService (About), AppFlavorConfig
|   |-- constants/       # app_constants.dart, generated app_version.g.dart, build_date.g.dart
|   |-- errors/          # GlobalErrorHandlers
|   `-- logging/         # AppLogger
|-- l10n/                # app_en/ml/sa.arb, fallback_localizations.dart, formatting_locale.dart,
|                        # app_message_text.dart, gen/ (generated)
|-- models/              # immutable value types (ScanRecord, ScannedCode, AppMessage, ...)
|-- providers/           # ChangeNotifier state (13 providers)
|-- screens/             # full screens; screens/widgets/ (screen parts), help/, appearance/
|-- services/            # business logic, storage, channels; barcode_decoder/, scan_camera/
|-- widgets/             # shared widgets (MadeWithLove, SafeErrorFallback, AppRestartScope, ...)
`-- main.dart            # startup, provider tree, MaterialApp, routes
native/                  # own decoder: C bridge (sreeraj_barcode/) + vendored zxing-cpp
android/                 # Android app, Kotlin channels/services, flavors (dev/, prod/)
tool/                    # release build, Hindi-marker gate, icon generator, version generators
```

The full file tree is in [project_structure.md](project_structure.md).

### Ownership rules

| Path | Responsibility |
|---|---|
| `lib/core/config/` | About config (`AppConfig`, `ConfigService`, fixed path, `guideline.md` §1) and the build flavor |
| `lib/models/` | Immutable data; no I/O, no `BuildContext` |
| `lib/providers/` | UI-facing state and actions; call services; no widget imports |
| `lib/services/` | Business logic, storage, crypto, network, platform channels; no `BuildContext`, no UI text (they return `AppMessage` keys) |
| `lib/screens/`, `lib/widgets/` | UI only; no SQL, crypto, HTTP or storage details |
| `lib/l10n/` | ARB files and localization helpers; `gen/` is generated (`flutter gen-l10n`) |
| `native/zxing-cpp/` | Vendored upstream — never edited (`native/zxing-cpp/UPSTREAM.md`) |

### Launcher icons

`assets/app_icon.png` (1024 × 1024) is the one source. `tool/generate_launcher_icons.py`
(Python 3 + Pillow, build-time only) makes from it the Android adaptive icon layers
(engineering standard §17.5):

- `mipmap-*/ic_launcher_foreground.png` — the emblem centred in the 66 dp safe circle;
- `@color/ic_launcher_background` — white;
- `mipmap-*/ic_launcher_monochrome.png` — one-colour shape for themed icons (Android 13+);
- `android/app/src/dev/res/mipmap-*/` — the same foreground and the legacy square icon with a
  red "DEV" badge, so the dev flavor is easy to tell apart.

`mipmap-anydpi-v26/ic_launcher.xml` combines the layers; Android 7 uses the square
`mipmap-*/ic_launcher.png`. After changing `assets/app_icon.png`, run
`python tool/generate_launcher_icons.py` from the project root and commit the new PNGs.

---

## 5. App Initialization Sequence

`main()` calls `AppStartupService.run()` and then
`runApp(AppRestartScope(builder: (_) => SreerajQRReaderApp(prefs: ...)))`
(engineering standard §4.5).

| Step | Code / call | Notes |
|---|---|---|
| 1 | `WidgetsFlutterBinding.ensureInitialized()` | Always first |
| 2 | `GlobalErrorHandlers.install()`, then one `AppLogger.info` with flavor and version | `AppLogger` needs no async init (console only) |
| 3 | FFI / native bindings | **Lazy:** the zxing-cpp decoder isolate starts on the first decode |
| 4 | Secure storage / key bootstrap | **Lazy:** the history key is read when history first opens |
| 5 | Database open + migrate (schema v2) | **Lazy:** on first history use (§14) |
| 6 | Open-source licence registration; `SharedPreferences` loaded once | Preloaded prefs go to `LocaleProvider` and `OnboardingProvider`, so the saved language applies before the first frame (§8.4) |
| 7 | Lifecycle observers | Registered by the screens that need them (§6) |
| 8 | `runApp(...)` | Wrapped in `AppRestartScope` so "Delete all data" can rebuild everything |

Lazy steps keep cold start short (§10.6). Each step catches its own failure, logs it, and falls
back to defaults (if preferences fail to load, the providers load them themselves).

---

## 6. App Lifecycle Behavior

| Lifecycle state | App behavior |
|---|---|
| `resumed` | Camera screens (Scanner, AR CodeVision, AirQR receiver) start the camera again (the Scanner only if it was scanning); the Scan bubble settings screen refreshes its state (the bubble can change from the tile or notification) |
| `inactive` | Nothing (camera screens ignore it) |
| `hidden`, `paused` | Camera screens stop the camera and frame stream; there are no pending database writes (every write is awaited) |
| `detached` | Camera screens stop the camera; the database connection is kept for the app's life and closed by the OS |
| Memory pressure | No special handling |

App lock (when the user turned it on): `AppLockGate` reports `paused`/`hidden` and `resumed`
to `AppLockProvider`; the app locks when it comes back after 30 seconds or more away, and at
start ([security.md](security.md) §7). Sensitive screens set `FLAG_SECURE` (unless the user turned
the Screenshot guard off), so the recent-apps preview of those screens is blank.

---

## 7. Offline Behavior

- Connectivity: **offline-first**.
- Network permission: `INTERNET` is present but optional — used only for online link checks
  (Google Safe Browsing, VirusTotal, URLhaus, PhishTank, OpenPhish), redirect "active probing",
  and the sandboxed page preview. All are turned on by the user.
- Offline data sources: SQLite (history), `SharedPreferences` (settings), secure storage (keys).
- Works offline: every scan source, decoding, the 6 offline link checks, StegoQR, AirQR,
  AR CodeVision, CodeForge, history and exports.
- When offline, online checks report "unavailable" and the offline checks still give a verdict.

---

## 8. State Management

- Primary pattern: **Provider** (`ChangeNotifier`) — simple, no code generation, enough for one
  developer; Riverpod/Bloc are blocked (`CLAUDE.md`).
- Local widget state may use `setState` for purely visual state inside one widget.
- State boundaries:

| Provider | Owns |
|---|---|
| `ScanProvider` | Current scan result, payload parsing, link safety checks, StegoQR/encrypted payload state, whether to show the Quishing Guard sticker reminder, scan feedback settings |
| `HistoryProvider` | History list, filters, search, favorites, notes, exports, backup, load error flag, database delete |
| `BatchScanProvider` | Batch scanning queue and its export |
| `MultiCodeSelectionProvider` | Choosing one code when a frame holds several |
| `ArCodevisionProvider` | Tracked codes, modes and HUD data for AR CodeVision |
| `AirQrProvider` | AirQR transmitter and receiver state |
| `CameraSettingsProvider` | Zoom, brightness, contrast, invert, torch, lens |
| `CodeForgeProvider` | Generator presets, input and output |
| `ThemeProvider` | Theme mode (system/light/dark/OLED), dynamic color, accent, typography, scan overlay style |
| `LocaleProvider` | App language (`app_language`), `null` = system |
| `OnboardingProvider` | Onboarding seen flag |
| `ScanBubbleProvider` | Scan bubble on/off, overlay permission, start-after-restart |
| `AppLockProvider` | Optional app lock: on/off (`app_lock_enabled`), locked state, 30-second background grace |
| `ScreenSecurityProvider` | Screenshot guard on/off (`screen_security_enabled`, default on); pushes it to `ScreenSecurityService`. Created at start (`lazy: false`) |

- Widgets own: layout, animation and focus state. Services own: logic, storage, network,
  crypto, channels.

---

## 9. Data Flow

```text
Widget -> Provider -> Service -> (SQLite / secure storage / prefs / HTTP / platform channel / FFI)
```

There is no separate repository layer: in this Tier 1 app the storage services
(`HistoryDatabaseService`, `HistoryExportService`) play that role.

### Camera scan flow

```text
[Camera preview]  (camera plugin, CameraX, YUV frames)
       │
       ▼
[ScanCameraController] ── Y plane ──> [BarcodeDecoderService isolate]
       │                                   │ dart:ffi
       │                                   ▼
       │                        [libsreeraj_barcode.so → zxing-cpp]
       ▼
ScanFrameResult (ScannedCode list + upright frame size)
       │
       ▼
[ScanProvider] ──> [UrlSafetyService] (checks)  ──> [PayloadParserService] (actions)
       │         ──> [EncryptedPayloadService] / [StegoQrService]
       │         ──> [HistoryProvider] ──> [HistoryDatabaseService] (encrypted SQLite)
       ▼
[ResultScreen] ──> user actions (open, copy, share, connect, reveal secret)
```

### Screen scan flow (GhostScan and Scan bubble)

```text
[GhostScan tile] or [Scanner menu] or [Scan bubble tap]   (ScanBubbleService draws the bubble)
       │
       ▼
GhostScanActivity ── Android screen capture consent ──> GhostScanCaptureService (one frame)
       │                                                     │ JPEG in app cache (+ fromBubble, blocked flags)
       ▼                                                     ▼
(cancel → bubble shown again)               MainActivity ── ghost_scan channel ──> GhostScanService
                                                                     │ GhostScanCapture
                                                                     ▼
                                     ScannerScreen → MediaScanService → ScanProvider → HistoryProvider
                                     (metadata source = screen / screen_bubble; cache file deleted)
```

### Rules
- Widgets must not know SQL, crypto, HTTP, secure-storage keys or file paths.
- Services must not know `BuildContext`, routes or UI text; they return `AppMessage` keys or
  typed results, and screens turn them into text.

---

## 10. Error Handling Architecture

- **Global handlers** (`lib/core/errors/global_error_handlers.dart`): `FlutterError.onError` and
  `PlatformDispatcher.instance.onError` log through `AppLogger`; release builds show
  `SafeErrorFallback` (`lib/widgets/safe_error_fallback.dart`) instead of a raw error box.
- **Typed exceptions** (`lib/models/`):

| Exception | Thrown by | Meaning |
|---|---|---|
| `StorageException` (sealed `AppException`) | `HistoryDatabaseService` | History key unavailable or not saved; field encryption failed |
| `BackupException` | `HistoryExportService` | A backup file cannot be read (bad format, bad header, wrong passphrase); carries an `AppMessage` key |

- **Recoverable errors** become screen state: History shows a "could not be loaded" message with
  **Try again**; camera errors show a message with a retry button; link checks that fail become
  "unavailable" results.
- **Never crash on bad input** (hard rule 4): parsers and the native decoder return empty or
  error results instead of throwing to the UI.
- There is no fatal error screen; the release fallback widget covers build failures.

---

## 11. Domain Model

### Current schema version
SQLite schema version: **2** (details in §14).

| Version | Change summary |
|---|---|
| 1 | Initial schema: `scan_records` |
| 2 | Table rebuilt with `CHECK (safetyScore BETWEEN 0 AND 100)` and `CHECK (isFavorite IN (0, 1))`; three indexes |

### Core models

All models are immutable (`const` constructors, `copyWith`).

| Type | Purpose |
|---|---|
| `ScanRecord` | One history entry (content, format, category, safety score, notes, location, favorite, metadata) |
| `ScannedCode`, `ScanFrameResult`, `CodeFormat`, `CodeContentType`, `DecodeProfile`, `VisibleBarcode` | Decoder output and options (replaced `mobile_scanner` types) |
| `SafetyCheckResult` | Result of one link safety check |
| `ParsedPayload` | Parsed smart payload (Wi-Fi, contact, UPI, …) |
| `StegoQrData`, `EncryptedPayloadData` | StegoQR / encrypted payload content |
| `DomSandboxResult` | Sandboxed page preview result |
| `AirQrFrame`, `AirQrProgress` | AirQR frames (data or XOR parity, CRC32) and receiver progress |
| `ArCodeTarget` | One tracked code in AR CodeVision |
| `BatchScanItem`, `ClipboardScanData`, `GhostScanCapture` | Batch, clipboard and screen-capture inputs |
| `CodeForgeConfig`, `CameraSettings`, `DistanceEnhancedScanResult`, `LocationResult`, `DeviceSyncData`, `OnboardingSlide`, `HistoryReportLabels` | Feature settings and results |
| `AppMessage` | A UI text key plus arguments returned by services |
| `AppException`, `BackupException` | Typed errors (§10) |

### Serialization strategy
- JSON: `ScanRecord.toJson/fromJson` (exports and backups), `AppConfig.fromJson`.
- Database: `HistoryDatabaseService` maps `ScanRecord` to rows and encrypts content fields.
- No separate transport models (Tier 1, shapes are the same).

### Database indexes

| Table | Indexed columns | Reason |
|---|---|---|
| `scan_records` | `timestamp` | Newest-first history list |
| `scan_records` | `LOWER(category)` | Category filter |
| `scan_records` | `isFavorite, timestamp` | Favorites filter |

---

## 12. Dependency Management And Injection

- Approach: the Provider tree in `main.dart` plus constructor injection. Services are created by
  providers (`HistoryProvider(dbService: ...)`) or screens, with optional constructor parameters.
- App-root dependencies: the 13 providers (§8), created inside `AppRestartScope`; `AppLockGate` wraps every route through `MaterialApp.builder`.
- Test replacement: every service that tests need to replace takes an optional constructor
  argument (database, secure storage, method channel, HTTP client, loaders); tests pass fakes
  (`Fake implements …`), `MockClient`, in-memory SQLite (`sqflite_common_ffi`) and mocked
  platform channels. `PrivacySettingsScreen` takes a `dataWipeServiceBuilder`.

---

## 13. Navigation

- Approach: Navigator 1.0 with named routes, defined in `lib/main.dart`.
- Home: `MainShellScreen` (bottom navigation: Scan, CodeForge, History), or `OnboardingScreen`
  on first run.
- Named routes: `/scanner`, `/result`, `/about`, `/settings`, `/history`, `/code_forge`,
  `/air_qr`, `/air_qr_transmitter`, `/ar_codevision`, `/onboarding`, and
  `ScanBubbleSettingsScreen.routeName`. Settings sub-pages, help screens and appearance pages
  are pushed with `MaterialPageRoute`.
- `routeObserver` (in `main.dart`) lets the scanner stop and restart the camera when another
  screen covers it.
- Protected routes: none (no app lock). Deep links: app shortcuts and Quick Settings tiles open
  the scanner or the screen-scan flow; no URL deep links.

---

## 14. Persistence And External Systems

### Local storage
- **Database:** SQLite (`sqflite`), file `sreeraj_scan_history.db` in app-private storage.
  Schema and migrations live in `lib/services/history_database_schema.dart`:
  - **Current schema version: 2.** Table `scan_records` (`id` TEXT PK, `timestamp`,
    `rawContent`, `barcodeFormat`, `category`, `imageThumbnail`, `locationTag`, `safetyScore`,
    `notes`, `isFavorite`, `metadata`). Content fields are encrypted with AES-256-GCM (format
    `h2:`) by `HistoryFieldCipher`; see [security.md](security.md) §6.2.
  - Constraints: `NOT NULL` on required columns; `CHECK (safetyScore BETWEEN 0 AND 100)`;
    `CHECK (isFavorite IN (0, 1))`. `category` has no CHECK on purpose: its values come from
    the payload classifier and from history import, so it is an open set.
  - Indexes: see §11.
  - `onConfigure` sets `PRAGMA foreign_keys = ON` and `PRAGMA journal_mode = WAL` on every
    connection (engineering standard §13.2, §13.4). No foreign keys exist yet (one table).
  - Migrations are append-only and each runs in a transaction: v1 = original table; v2 = table
    rebuild with the CHECKs (old values clamped) plus the indexes. Never edit a shipped
    migration; a schema change adds a version and an upgrade test
    (`test/services/history_database_schema_test.dart`).
  - The connection stays open for the app's lifetime; "Delete all data" closes and deletes it.
- **WAL mode:** enabled.
- **Key-value storage:** `SharedPreferences` for non-sensitive settings — for example
  `app_language` (`system`, `en`, `ml`, `sa`), theme mode, scan feedback, privacy (active
  probing), onboarding flag, daily request counters.
- **Secure storage:** `flutter_secure_storage` (Android KeyStore) — the history key
  (`db_encryption_key_v1`) and user API keys.

### Network
- Client: `http`, only inside `UrlSafetyService` and `DomSandboxService`; HTTPS only; every call
  is optional (§7). Tests use `MockClient`.

### Platform channels and native integrations

| Integration | Purpose |
|---|---|
| `in.sreerajp.qr_studio/ghost_scan` | GhostScan screen capture (tile, menu, bubble) |
| `in.sreerajp.qr_studio/scan_bubble` | Scan bubble overlay, tile, start-on-boot, `clearData` |
| `in.sreerajp.qr_studio/clipboard` | Read a clipboard image |
| `in.sreerajp.qr_studio/ambient_light` | Light sensor for low-light hints |
| `in.sreerajp.qr_studio/wifi` | Add a scanned Wi-Fi network |
| `in.sreerajp.qr_studio/window` | `setSecure` — `FLAG_SECURE` for sensitive screens |
| dart:ffi `libsreeraj_barcode.so` | Own barcode decoder (§14a) |
| Plugins | `camera`, `local_auth`, `geolocator`, `image_picker`, `file_picker`, `pdfx`, `receive_sharing_intent`, `share_plus`, `url_launcher`, `permission_handler`, `dynamic_color`, `package_info_plus` |

Native Android pieces (`android/app/src/main/kotlin/`): `ScanBubbleService` (overlay +
special-use foreground service), `ScanBubbleTileService` (Quick Settings toggle),
`ScanBubbleShortcutActivity` (app shortcut and tile starter), `ScanBubbleBootReceiver`
(optional restart), `ScanBubblePrefs` (native on/off flags and position), `GhostScanActivity`,
`GhostScanCaptureService`, `GhostScanTileService`.

## 14a. Barcode Decoding Engine

The app decodes codes with its **own** engine. No Google ML Kit or other closed SDK is used.

| Layer | File | Role |
|---|---|---|
| Native | `native/zxing-cpp/` | Vendored zxing-cpp v3.1.1 reader (Apache-2.0), built with writers turned off |
| Native | `native/sreeraj_barcode/` | Our small C bridge: `srb_read`, `srb_free`, `srb_version`. Checks every size, catches every C++ exception, rotates frames without copying, and maps UPC-A/UPC-E back to their short forms |
| Build | `native/CMakeLists.txt` | Builds `libsreeraj_barcode.so` (`-O3`, 16 KB pages, static C++ runtime) from `android/app/build.gradle` |
| Service | `lib/services/barcode_decoder/` | `BarcodeFfiBindings` (hand-written FFI), `NativeBarcodeReader`, and `BarcodeDecoderService`, which runs decoding on one long-lived background isolate |
| Service | `lib/services/barcode_content_classifier.dart` | Offline URL / Wi-Fi / contact / product / ISBN / … classification of decoded text |
| Service | `lib/services/scan_camera/scan_camera_controller.dart` | Owns the `camera` plugin, sends the luminance plane of each frame to the decoder, drops frames while one is being decoded, handles torch, zoom, focus and lens switching |
| Widget | `lib/screens/widgets/scan_camera_view.dart` | Cover-fit camera preview that reports `ScanFrameResult`s |
| Models | `code_format.dart`, `code_content_type.dart`, `scanned_code.dart`, `scan_frame_result.dart`, `decode_profile.dart` | Immutable types that replaced `mobile_scanner`'s `Barcode`, `BarcodeFormat`, `BarcodeType` and `BarcodeCapture` |

Decode profiles: `fast` (AirQR, QR only), `live` (camera, rotated 1D barcodes allowed),
`thorough` (gallery, PDF, share sheet: all passes and all formats). Corner points are always
reported in the upright frame's coordinate space, mirrored for the front camera, so
`MultiCodeService` can project them with `BoxFit.cover`.

Gallery images, PDF pages and distance-enhanced crops are decoded **in memory**; no temporary
image files are written.

---

## 15. Environment And Build Model

- Flavors: `dev` (`in.sreerajp.qr_studio.dev`, "SreerajP QR Studio Dev", debug key, "DEV" icon badge)
  and `prod` (`in.sreerajp.qr_studio`, "SreerajP QR Studio", release key).
- Runtime config: `--flavor <name>`; Flutter sets `FLUTTER_APP_FLAVOR`, read by
  `AppFlavorConfig` (`APP_FLAVOR` first, for desktop compatibility; default `prod`). Verbose
  logging follows the flavor. `BUILD_DATE` is passed by `tool/build_release.sh`; version files
  are generated from `pubspec.yaml` during the Android build.
- Obfuscation: on for every prod release build; symbols in
  `build/symbols/android-prod-<version>/`, archived outside the repository
  ([release_process.md](release_process.md) §6.1).
- Toolchain: Flutter 3.47.6 / Dart 3.13.5; AGP 9 with built-in Kotlin
  (`android.builtInKotlin=true`, `android.newDsl=false`); `kotlin { compilerOptions }`; Gradle
  tasks use `ExecOperations`.
- Language splitting is off in the App Bundle (`bundle.language.enableSplit = false`), so the
  in-app picker works for Play installs.

### Target platforms and distribution

| Platform | Minimum OS | Release artifact | Channels | Signing | Notes |
|---|---|---|---|---|---|
| Android | `minSdk 24` (wide device reach; camera and the FFI decoder work there) | `.aab`, split `.apk` | Google Play, direct download | Release keystore (upload key) + Play App Signing | 16 KB pages; permissions in [security.md](security.md) §11 |

### Platform differences
Android only; features that need newer Android versions degrade on older ones — for example the
"Add tile" request (Android 13+), themed icons (Android 13+), the Wi-Fi add flow (Android 11+
system prompt, Android 10 suggestion, older direct add).

---

## 16. UI System

- Theme source of truth: `ThemeProvider` (`lib/providers/theme_provider.dart`) builds the light,
  dark and OLED `ThemeData` (Material 3, `material_ui`), with dynamic color (`dynamic_color`,
  Android 12+) or a blue seed color, user accent and typography choices, and a font fallback chain
  (Noto Sans Malayalam, Noto Sans Devanagari) for the two non-Latin scripts.
- Design tokens: there is no separate tokens file yet; colors come from the `ColorScheme`, but
  about 31 `Color(0x…)` literals remain in 16 screen and widget files (§21).
- Shared widgets: `lib/widgets/` (shared across screens) and `lib/screens/widgets/` (parts of
  one screen family).
- Accessibility: 48 × 48 dp touch targets; WCAG AA contrast; every icon-only control has a
  localized tooltip (checked by tests in en, ml and sa); TalkBack checked before each release;
  layouts checked at 1.0×, 1.5× and 2.0× text scale.
- About screen: data-driven from `assets/config/app_config.json`, localized, ends with the
  "Made with ❤️ from India" badge.

---

## 17. Logging

- Logger: `AppLogger` (`lib/core/logging/app_logger.dart`) on `dart:developer`; `print` and
  `debugPrint` are not used in `lib/`.
- Log file: none — console only, so no rotation (§14.4) and no log file to purge (§15.4).
- Verbose gate: `trace` and `debug` only when `AppFlavorConfig.enableVerboseLogging` (dev).
- Sensitive data: outside dev, an error is logged by its type name only, with no stack trace,
  because exception text can contain scanned content. Never logged: keys, passphrases, scanned
  content ([security.md](security.md) §9).

---

## 18. Testing Strategy

| Test type | Scope | Notes |
|---|---|---|
| Unit | Models, services (link checks, homographs, crypto, payload parsing, AirQR, database schema and encryption, data wipe, logger, flavor, startup), providers | `sqflite_common_ffi`, `MockClient`, fakes |
| Widget | Every screen in en, ml and sa (no overflow, every icon-only control has a tooltip); flows such as Delete all data, history error, Sanskrit date picker | `test/helpers/test_app.dart`, `test/helpers/accessibility_checks.dart` |
| Localization | ARB parity, no copies of English, standard key prefixes, `{heart}` marker, `app_config.json` languages, label length (each plural branch), Hindi markers | `test/l10n/`, plus `tool/check_sanskrit_hindi_markers.sh` in CI |
| Integration | Native decoder on a real device | `integration_test/barcode_decoder_test.dart` |
| Performance | Not automated yet | Profile-mode check in the release checklist |

### Test layout

```text
test/
|-- core/        # config, errors, logging
|-- helpers/     # test_app.dart, accessibility_checks.dart
|-- l10n/
|-- models/
|-- providers/
|-- screens/     # widgets/, help/
|-- services/
`-- widgets/
integration_test/
```

### Critical test areas
- Link checks, homograph detection, rate limiting, `ScanProvider` state transitions.
- History encryption (tamper, wrong key, legacy upgrade, key errors) and the v1 → v2 database
  upgrade.
- "Delete all data" (every store, partial failure, restart).
- Global error handlers and the release fallback.
- Every screen in every language.

---

## 19. Operational Constraints

- Minimum OS: Android 7.0 (API 24); target API 36.
- Performance: cold start under 2 seconds on a mid-range phone; 16 ms frame budget at 60 Hz;
  decoding off the UI isolate; size budgets in [release_process.md](release_process.md) §6.3.
- Store: Google Play policies (foreground-service declarations for the Scan bubble and
  GhostScan, Data safety, privacy policy, 16 KB pages).
- Team: a single developer; releases tagged `v<X.Y.Z>` (older ones `Release_YYYYMMDD`).
- Orientation: portrait only.
- Offline: no network package may run without the user turning it on.

---

## 20. Decisions And Tradeoffs

| Decision | Chosen option | Why | Tradeoff |
|---|---|---|---|
| State management | Provider | Simple, enough for one developer | Less structure than Bloc for very large screens |
| Barcode engine | Own zxing-cpp via dart:ffi | Open source, no telemetry, offline | We maintain the C bridge and the native build |
| History encryption | AES-256-GCM per field, key in KeyStore | Meets §15.2 without a native SQLCipher dependency | Metadata columns (time, category, score) stay readable |
| Backup / sync crypto | PBKDF2-HMAC-SHA256 600,000 + AES-256-GCM (`PassphraseCipher`) | OWASP-strength key from a passphrase, pure Dart | A few seconds per backup on a phone (background isolate) |
| App lock grace | Lock after 30 s in the background | Pickers and the share sheet keep working | A short window after leaving the app; sensitive screens are hidden by `FLAG_SECURE` |
| Screenshot protection | `FLAG_SECURE` on sensitive screens only; on by default, user can turn it off in Settings → Privacy | Users can still screenshot codes they make and help pages, and can choose to allow all screenshots | Each new sensitive screen must be wrapped in `SecureScreen` |
| Logging | Console only, errors by type in prod | No user data on disk; nothing to purge | No logs to export for support |
| Navigation | Navigator 1.0 named routes | Few screens, no URL deep links | No typed routes |
| Rendering | Impeller default, no opt-out | Flutter default on Android 10+ | — |
| Material | `material_ui` / `cupertino_ui` packages | Flutter 3.47 rule (§6.1) | `dynamic_color` had to move to 2.x |

---

## 21. Known Risks And Follow-Ups

- Risk: the Phase 9b controls (`FLAG_SECURE`, app lock, backup/sync v2, prod signing check,
  R8 rules) are tested in unit and widget tests but not yet on a real phone. Mitigation:
  release checklist ([release_process.md](release_process.md) §8).
- Risk: the `pdfx` plugin applies the Kotlin Gradle Plugin, which future Flutter versions will
  reject. Mitigation: update or replace `pdfx` when needed.
- Risk: about 31 hard-coded `Color(0x…)` literals in screens and widgets (§6.1 asks for tokens).
  Mitigation: move them to the theme or a tokens file in a later change.
- Risk: 16 KB page size and themed icons are verified only on a device before release.
  Mitigation: [release_process.md](release_process.md) §6.9, §8.

---

## 22. Related Documents

- [README.md](../README.md)
- [CHANGELOG.md](../CHANGELOG.md)
- [PROJECT_PROFILE.md](PROJECT_PROFILE.md)
- [security.md](security.md)
- [release_process.md](release_process.md)
- [dependencies.md](dependencies.md)
- [project_structure.md](project_structure.md)
- [implementation_plan.md](implementation_plan.md)
- [guidelines/flutter_project_engineering_standard.md](guidelines/flutter_project_engineering_standard.md)
- [guidelines/flutter_build_flavors_guide.md](guidelines/flutter_build_flavors_guide.md)
- [guidelines/platform_store_readiness.md](guidelines/platform_store_readiness.md)
