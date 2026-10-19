# Project Structure — SreerajP QR Studio

This document describes the directory tree layout and responsibility mapping of the SreerajP QR Studio repository. Read this for quick orientation on file locations.

**Read first:**
- [CLAUDE.md](../CLAUDE.md)
- [AGENTS.md](../AGENTS.md)
- [architecture.md](architecture.md)

---

## 1. Directory Tree Layout

```text
sreerajp_qr_studio/
|-- .github/
|   `-- workflows/
|       `-- ci.yml                   # GitHub Actions CI workflow
|-- android/                         # Android native project files
|   |-- app/
|   |   |-- build.gradle             # App-level build config (flavors: dev, prod)
|   |   `-- src/
|   |       |-- dev/                 # Dev flavor manifest and resources
|   |       |-- main/                # Main Android manifest and resources
|   |       |   |-- kotlin/          # MainActivity, GhostScan capture, Scan bubble (service, tile, shortcut, boot receiver)
|   |       |   `-- res/             # Drawables and native strings (values, values-ml, values-sa)
|   |       `-- prod/                # Prod flavor manifest and resources
|   |-- build.gradle                 # Project-level build config
|   `-- key.properties               # Release signing keys (gitignored)
|-- assets/                          # App branding and static assets
|   |-- config/
|   |   `-- app_config.json          # About screen data (single source of truth)
|   |-- licenses/                    # Licence texts of vendored native code (zxing-cpp, libzueci)
|   `-- app_icon.png
|-- change_log/                      # Completed change log records
|-- docs/                            # Project baseline & living documentation
|   |-- guidelines/                  # Shared Flutter Guidelines (Git Submodule)
|   |-- architecture.md              # Technical design and architecture
|   |-- dependencies.md              # Approved baseline packages and constraints
|   |-- implementation_plan.md       # Build roadmap + dated roadmap records (point-in-time)
|   |-- implementation_progress.md   # Status checklist (point-in-time)
|   |-- GUIDELINES_MANIFEST.md       # Shared guidelines manifest
|   |-- PROJECT_PROFILE.md           # Platforms, stores, languages, identity, About options
|   |-- project_structure.md         # File tree layout and responsibilities
|   |-- release_process.md           # Keystore signing and release runbook
|   |-- security.md                  # Threat model, permissions, and security
|   `-- workflow_rules.md            # Plan, approval, and log workflow rules
|-- lib/                             # Application Dart source (Tier 1 layer-first)
|   |-- core/
|   |   |-- config/
|   |   |   |-- app_config.dart      # AppConfig model & fallback
|   |   |   |-- app_flavor_config.dart # Build flavor (APP_FLAVOR / FLUTTER_APP_FLAVOR)
|   |   |   `-- config_service.dart  # Config asset loader & version verification
|   |   |-- errors/
|   |   |   `-- global_error_handlers.dart # App-wide error handlers
|   |   |-- logging/
|   |   |   `-- app_logger.dart      # AppLogger (console only, flavor-gated)
|   |   `-- constants/
|   |       |-- app_constants.dart   # Technical constants
|   |       `-- build_date.g.dart    # Build timestamp metadata
|   |-- l10n/
|   |   |-- app_en.arb               # English ARB template
|   |   |-- app_ml.arb               # Malayalam ARB translation
|   |   |-- app_sa.arb               # Sanskrit ARB translation
|   |   |-- fallback_localizations.dart # Framework fallback delegates (sa)
|   |   |-- formatting_locale.dart   # formattingLocale() for intl
|   |   `-- gen/                     # Generated localization accessors
|   |-- models/
|   |   |-- app_exception.dart       # Sealed AppException / StorageException (§11.3)
|   |   |-- scanned_code.dart        # One decoded code (text, format, type, corners)
|   |   |-- scan_frame_result.dart   # All codes in one camera frame + frame size
|   |   |-- code_format.dart         # Barcode symbologies (native bit mapping)
|   |   |-- code_content_type.dart   # URL / Wi-Fi / contact / product … categories
|   |   |-- decode_profile.dart      # fast / live / thorough decode effort
|   |   |-- safety_check_result.dart # URL safety check results
|   |   |-- ghost_scan_capture.dart  # One screen capture (path, fromBubble, blocked)
|   |   |-- scan_history_item.dart   # SQLite history record model
|   |   |-- air_qr_frame.dart        # Optical stream frame (data or parity)
|   |   |-- air_qr_progress.dart     # Receiver progress state
|   |   `-- smart_action.dart        # Action triggers (Wi-Fi, UPI, contacts)
|   |-- providers/
|   |   |-- app_lock_provider.dart   # Optional app lock state (security §7)
|   |   |-- screen_security_provider.dart # Screenshot guard on/off (security §10.1)
|   |   |-- scan_provider.dart       # Scan state & URL analysis coordination
|   |   |-- history_provider.dart    # SQLite scan history state
|   |   |-- theme_provider.dart      # Material 3 theme mode & dynamic color
|   |   |-- air_qr_provider.dart     # Optical transmitter/receiver state
|   |   |-- ar_codevision_provider.dart # Multi-barcode HUD tracking state
|   |   |-- camera_settings_provider.dart # Camera viewport controls
|   |   `-- scan_bubble_provider.dart # Floating Scan bubble state
|   |-- screens/
|   |   |-- scanner_screen.dart      # Main camera scanner interface
|   |   |-- result_screen.dart       # Scan outcome, actions, and Stego reveal
|   |   |-- history_screen.dart      # Searchable scan history & export
|   |   |-- air_qr_screen.dart       # Optical receiver screen
|   |   |-- air_qr_transmitter_screen.dart # Optical transmission screen
|   |   |-- ar_codevision_screen.dart # Multi-code AR HUD viewfinder
|   |   |-- settings_screen.dart     # App preferences, language, API keys
|   |   |-- scan_bubble_settings_screen.dart # Scan bubble switch, permission, restart option
|   |   |-- help/help_home_screen.dart # Help hub: every guide, in 5 groups
|   |   |-- help/*_help_screen.dart  # One guide page per topic (13 guides)
|   |   |-- help/widgets/help_page_widgets.dart # Shared guide layout: intro, sections, tip
|   |   `-- about_screen.dart        # Dynamic About screen with MadeWithLove
|   |-- services/
|   |   |-- barcode_decoder/         # FFI bindings, native reader, decoder isolate service
|   |   |-- scan_camera/             # ScanCameraController (camera plugin + frame decoding)
|   |   |-- app_startup_service.dart # Startup steps in order (architecture §4a)
|   |   |-- data_wipe_service.dart   # "Delete all data": every local store (security §13)
|   |   |-- passphrase_cipher.dart   # PBKDF2 + AES-GCM for backups and AirQR sync (security §6.3)
|   |   |-- screen_security_service.dart # FLAG_SECURE counter over the window channel
|   |   |-- barcode_content_classifier.dart # Offline content-type classification
|   |   |-- open_source_licenses.dart # Registers native code licences on the licence page
|   |   |-- url_safety_service.dart  # 6-check URL safety algorithms
|   |   |-- encrypted_payload_service.dart # AES-GCM decryption & biometrics
|   |   |-- history_database_service.dart # Field-encrypted scan history queries
|   |   |-- history_database_schema.dart # Schema version, pragmas, append-only migrations
|   |   |-- history_field_cipher.dart # AES-256-GCM field encryption (format h2:)
|   |   |-- ghost_scan_service.dart  # GhostScan screen capture channel
|   |   |-- scan_bubble_service.dart # Scan bubble overlay channel
|   |   `-- air_qr_service.dart      # Frame packetizing and LT fountain code (XOR parity) assembly
|   |-- widgets/
|   |   |-- app_lock_gate.dart       # Lock screen above every route (optional app lock)
|   |   |-- app_restart_scope.dart   # Rebuilds the app tree after "Delete all data"
|   |   |-- plain_text_export_confirm.dart # Warning before an unencrypted export
|   |   |-- secure_screen.dart       # FLAG_SECURE while a sensitive screen is open
|   |   |-- safe_error_fallback.dart # Release fallback for a widget that failed to build
|   |   |-- made_with_love.dart      # Signature footer badge (on, per the project profile)
|   |   |-- focus_ring_widget.dart   # Tap-to-focus camera ring animation
|   |   `-- camera_adjustments_sheet.dart # Viewport controls bottom sheet
|   `-- main.dart                    # Entry point (Provider tree, theme, routes)
|-- integration_test/               # On-device tests (native barcode decoder)
|-- native/                          # Own native barcode decoder (C/C++)
|   |-- CMakeLists.txt               # Builds libsreeraj_barcode.so
|   |-- sreeraj_barcode/             # Our C bridge over zxing-cpp (srb_read / srb_free)
|   `-- zxing-cpp/                   # Vendored zxing-cpp v3.1.1 reader (Apache-2.0), see UPSTREAM.md
|-- plans/                           # Change plans (plan-before-changing)
|-- test/                            # Unit & widget tests mirroring lib/ structure
|   |-- core/
|   |-- providers/
|   |-- services/
|   `-- widgets/
|-- tool/                            # Build helper scripts
|   |-- build_release.sh             # Hardened prod release build (obfuscate + symbols)
|   |-- check_sanskrit_hindi_markers.sh # Language-pack Hindi-marker gate (CI)
|   |-- generate_launcher_icons.py   # Adaptive icon layers + DEV badge from assets/app_icon.png
|   |-- generate_app_version.dart
|   `-- generate_build_date.dart
|-- CHANGELOG.md                     # User-facing release history
|-- CLAUDE.md                        # Primary Claude Code project instructions
|-- AGENTS.md                        # Primary Agentic LLM project instructions
|-- pubspec.yaml                     # Flutter package manifest
`-- README.md                        # Repository overview & user guide
```

---

## 2. Directory Responsibilities

| Path | Responsibility |
|---|---|
| `assets/config/` | JSON single source of truth for About screen metadata |
| `lib/core/config/` | `AppConfig` domain model and `ConfigService` asset loader |
| `lib/core/constants/` | Constant configurations and technical constants |
| `lib/l10n/` | ARB localization files (English, Malayalam, Sanskrit) and fallback delegates |
| `lib/models/` | Immutable domain value objects |
| `lib/providers/` | `ChangeNotifier` state handlers bridging UI and service logic |
| `lib/screens/` | Presentational UI screens |
| `lib/services/` | Stateless business logic, cryptography, database, and integrations |
| `lib/widgets/` | Shared reusable UI components |
| `test/` | Automated unit and widget test suites mirroring `lib/` |
| `integration_test/` | On-device tests that need the native decoder (`flutter test integration_test --flavor dev`) |
| `native/` | Own barcode decoder: C bridge + vendored zxing-cpp reader, built by CMake |
| `assets/licenses/` | Licence texts that must ship with the vendored native code |
| `docs/` | Comprehensive baseline and living documentation |
| `docs/guidelines/` | Authoritative shared Flutter guidelines Git submodule |
