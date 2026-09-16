# Project Structure — SreerajP QR Reader

This document describes the directory tree layout and responsibility mapping of the SreerajP QR Reader repository. Read this for quick orientation on file locations.

**Read first:**
- [CLAUDE.md](../CLAUDE.md)
- [AGENTS.md](../AGENTS.md)
- [architecture.md](architecture.md)

---

## 1. Directory Tree Layout

```text
sreeraj_qr_reader/
|-- .github/
|   `-- workflows/
|       `-- ci.yml                   # GitHub Actions CI workflow
|-- android/                         # Android native project files
|   |-- app/
|   |   |-- build.gradle             # App-level build config (flavors: dev, prod)
|   |   `-- src/
|   |       |-- dev/                 # Dev flavor manifest and resources
|   |       |-- main/                # Main Android manifest and resources
|   |       `-- prod/                # Prod flavor manifest and resources
|   |-- build.gradle                 # Project-level build config
|   `-- key.properties               # Release signing keys (gitignored)
|-- assets/                          # App branding and static assets
|   |-- config/
|   |   `-- app_config.json          # About screen data (single source of truth)
|   `-- app_icon.png
|-- change_log/                      # Completed change log records
|-- docs/                            # Project baseline & living documentation
|   |-- guidelines/                  # Shared Flutter Guidelines (Git Submodule)
|   |-- architecture.md              # Technical design and architecture
|   |-- dependencies.md              # Approved baseline packages and constraints
|   |-- GUIDELINES_MANIFEST.md       # Shared guidelines manifest
|   |-- project_structure.md         # File tree layout and responsibilities
|   |-- release_process.md           # Keystore signing and release runbook
|   |-- security.md                  # Threat model, permissions, and security
|   |-- features.md                  # Implemented features catalog
|   `-- workflow_rules.md            # Plan, approval, and log workflow rules
|-- lib/                             # Application Dart source (Tier 1 layer-first)
|   |-- core/
|   |   |-- config/
|   |   |   |-- app_config.dart      # AppConfig model & fallback
|   |   |   `-- config_service.dart  # Config asset loader & version verification
|   |   `-- constants/
|   |       |-- app_constants.dart   # Technical constants
|   |       `-- build_date.g.dart    # Build timestamp metadata
|   |-- l10n/
|   |   |-- app_en.arb               # English ARB template
|   |   |-- app_ml.arb               # Malayalam ARB translation
|   |   |-- app_sa.arb               # Sanskrit ARB translation
|   |   |-- sa_material_localizations.dart # Sanskrit framework fallback delegates
|   |   `-- gen/                     # Generated localization accessors
|   |-- models/
|   |   |-- safety_check_result.dart # URL safety check results
|   |   |-- scan_history_item.dart   # SQLite history record model
|   |   |-- air_qr_packet.dart       # Optical streaming packet
|   |   `-- smart_action.dart        # Action triggers (Wi-Fi, UPI, contacts)
|   |-- providers/
|   |   |-- scan_provider.dart       # Scan state & URL analysis coordination
|   |   |-- history_provider.dart    # SQLite scan history state
|   |   |-- theme_provider.dart      # Material 3 theme mode & dynamic color
|   |   |-- air_qr_provider.dart     # Optical transmitter/receiver state
|   |   |-- ar_codevision_provider.dart # Multi-barcode HUD tracking state
|   |   `-- camera_settings_provider.dart # Camera viewport controls
|   |-- screens/
|   |   |-- scanner_screen.dart      # Main camera scanner interface
|   |   |-- result_screen.dart       # Scan outcome, actions, and Stego reveal
|   |   |-- history_screen.dart      # Searchable scan history & export
|   |   |-- air_qr_screen.dart       # Optical receiver screen
|   |   |-- air_qr_transmitter_screen.dart # Optical transmission screen
|   |   |-- ar_codevision_screen.dart # Multi-code AR HUD viewfinder
|   |   |-- settings_screen.dart     # App preferences, language, API keys
|   |   `-- about_screen.dart        # Dynamic About screen with MadeWithLove
|   |-- services/
|   |   |-- url_safety_service.dart  # 6-check URL safety algorithms
|   |   |-- encrypted_payload_service.dart # AES-GCM decryption & biometrics
|   |   |-- database_helper.dart     # SQLite database helper & migrations
|   |   `-- air_qr_service.dart      # Packet framing and Reed-Solomon assembly
|   |-- widgets/
|   |   |-- made_with_love.dart      # Fixed signature footer badge
|   |   |-- focus_ring_widget.dart   # Tap-to-focus camera ring animation
|   |   `-- camera_adjustments_sheet.dart # Viewport controls bottom sheet
|   `-- main.dart                    # Entry point (Provider tree, theme, routes)
|-- plans/                           # Change plans (plan-before-changing)
|-- test/                            # Unit & widget tests mirroring lib/ structure
|   |-- core/
|   |-- providers/
|   |-- services/
|   `-- widgets/
|-- tool/                            # Build helper scripts
|   `-- build_release.sh
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
| `docs/` | Comprehensive baseline and living documentation |
| `docs/guidelines/` | Authoritative shared Flutter guidelines Git submodule |
