# AGENTS.md — SreerajP QR Studio

This file is read by AI agents and LLM coding assistants (Gemini, Antigravity, Cursor, Windsurf, Codex, and others) at the start of every session in this repository.
Read it before making any change. See the docs table below for full detail.

> `CLAUDE.md` holds the same rules for Claude Code. Keep the two files in step — if you change a rule, a command, or the identity table here, make the same change there.

---

## Project identity

| Field            | Value                                                                                                                                                                 |
| ---------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| App name         | SreerajP QR Studio                                                                                                                                                    |
| Type             | Flutter Android application for scanning QR codes & barcodes with 6-layer URL safety, StegoQR encryption, AirQR optical transfer, AR CodeVision, and encrypted history |
| Platforms        | Android only (minSdk 24, targetSdk 36, compileSdk 37) — declared in `docs/PROJECT_PROFILE.md`                                                                         |
| Stores / channels | Google Play (`.aab`); direct download (split APKs)                                                                                                                   |
| Languages        | English (`en`, template), Malayalam (`ml`), Sanskrit (`sa`) — declared in `docs/PROJECT_PROFILE.md`                                                                   |
| Package / org id | `in.sreerajp.qr_studio`                                                                                                                                                |
| Flutter SDK      | 3.47.6 (stable) — from `flutter --version`                                                                                                                            |
| Dart SDK         | 3.13.5 — from `flutter --version`                                                                                                                                     |
| State management | Provider (`ChangeNotifier`)                                                                                                                                           |
| Navigation       | Named routes (`Navigator 1.0`)                                                                                                                                        |
| Database         | SQLite (`sqflite` for encrypted scan history), `shared_preferences` (settings/counters), `flutter_secure_storage` (API keys)                                          |
| Orientation      | Portrait only                                                                                                                                                         |
| Connectivity     | Offline-first / online optional (URL safety checks work offline; Google Safe Browsing optional)                                                                       |

---

## Read these docs before working

| Document                                                                                                           | Read when                                                  |
| ------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------- |
| [docs/PROJECT_PROFILE.md](docs/PROJECT_PROFILE.md)                                                                 | Always — platforms, stores, languages, identity, About options |
| [docs/architecture.md](docs/architecture.md)                                                                       | Changing structure, screens, state, services, models       |
| [docs/security.md](docs/security.md)                                                                               | Touching permissions, logging, storage, API keys, manifest |
| [docs/release_process.md](docs/release_process.md)                                                                 | Building a release, versioning, signing, release checklist |
| [docs/workflow_rules.md](docs/workflow_rules.md)                                                                   | Planning changes, approval gate, writing change logs       |
| [docs/dependencies.md](docs/dependencies.md)                                                                       | Package constraints, adding dependencies                   |
| [docs/project_structure.md](docs/project_structure.md)                                                             | Orienting on directory layout and file responsibilities    |
| [docs/guidelines/AI_AGENT_START_HERE.md](docs/guidelines/AI_AGENT_START_HERE.md)                                   | Read order and "ready for the stores" checklist            |
| [docs/guidelines/flutter_project_engineering_standard.md](docs/guidelines/flutter_project_engineering_standard.md) | Any code change — layers, naming, testing rules            |
| [docs/guidelines/guideline.md](docs/guidelines/guideline.md)                                                       | About screen, Android keystore, `lib/` layout              |
| [docs/guidelines/language_packs/sanskrit_malayalam.md](docs/guidelines/language_packs/sanskrit_malayalam.md)       | Any Malayalam or Sanskrit text                             |
| [docs/guidelines/flutter_build_flavors_guide.md](docs/guidelines/flutter_build_flavors_guide.md)                   | Build flavors, Gradle, signing configuration               |
| [docs/guidelines/platform_store_readiness.md](docs/guidelines/platform_store_readiness.md)                         | Before any release; when touching permissions or store-listed behavior |
| [docs/guidelines/CLAUDE_MD_GUIDELINE.md](docs/guidelines/CLAUDE_MD_GUIDELINE.md)                                   | Editing `CLAUDE.md`                                        |
| [docs/guidelines/AGENTS_MD_GUIDELINE.md](docs/guidelines/AGENTS_MD_GUIDELINE.md)                                   | Editing this file                                          |
| [docs/guidelines/DOCS_FOLDER_GUIDELINE.md](docs/guidelines/DOCS_FOLDER_GUIDELINE.md)                               | Adding or renaming a file in `docs/`                       |
| [docs/GUIDELINES_MANIFEST.md](docs/GUIDELINES_MANIFEST.md)                                                         | The shared Flutter guidelines index                        |

> `docs/<file>` = this app's filled-in copy (templates). `docs/guidelines/<file>` = the shared
> reference in the submodule; never copy it into `docs/`.

---

## Hard rules (must follow — these override convenience)

1. Open source packages only. Check package licenses before adding dependencies.
2. Offline-first scanning. Scanned barcode analysis must work offline; online Safe Browsing API check is optional and opt-in.
3. Scoped storage and camera permission on-demand. Request camera permission only when scanning.
4. Never crash on malformed inputs or unparseable barcodes. Return a safe, friendly error state.
5. Never expose or log sensitive data (such as the Google Safe Browsing API key).

---

## Architecture rules

- Tier 1 layer-first structure under `lib/`: `core/config/` (`app_config.dart`, `config_service.dart`), `core/constants/` (`app_constants.dart`), `core/logging/` (`app_logger.dart`), `l10n/`, `models/`, `providers/`, `screens/`, `services/`, `widgets/`, `main.dart`. `assets/config/app_config.json` is the single source of truth for About metadata (`guideline.md` §1). The About screen ends with the signature badge, which `docs/PROJECT_PROFILE.md` turns on (`guideline.md` §1.7). Do not restructure without instruction.
- Layer boundaries: Widgets must not make HTTP calls, access secure storage, or perform URL analysis directly. Services must not depend on `BuildContext`, UI strings, or navigation routes.
- Dependency direction: `screens → providers → services → models`.
- Models are immutable (`const` constructors). Never mutate domain objects in place.

---

## Build & run commands

```bash
flutter pub get                        # install dependencies
flutter run --flavor dev               # daily development (dev flavor)
flutter run --flavor prod              # production build with debug tooling
flutter analyze                        # static analysis (must be clean)
flutter test                           # run all unit tests
flutter test integration_test --flavor dev -d <device>  # on-device native decoder tests
dart format .                          # format code before committing

# Production release APK (split per ABI) — direct download
flutter build apk --flavor prod --release \
  --obfuscate --split-debug-info=build/symbols/android-prod-<version>/ --split-per-abi

# Production Play Store bundle
flutter build appbundle --flavor prod --release \
  --obfuscate --split-debug-info=build/symbols/android-prod-<version>/
./tool/build_release.sh appbundle      # same build, with BUILD_DATE injected
```

> The app defines flavors, so a bare `flutter run` fails — always pass `--flavor`.
> `<version>` is the full `pubspec.yaml` version (e.g. `4.1.0+34`), so symbols from different
> releases never collide.
> Before any release, pass `docs/guidelines/platform_store_readiness.md` §1 and §2 (Google Play).
> Release builds are done locally, never in CI.

---

## Build flavors

| Flavor | App ID                     | Display name        | Signing                                     |
| ------ | -------------------------- | ------------------- | ------------------------------------------- |
| `dev`  | `in.sreerajp.qr_studio.dev` | SreerajP QR Studio Dev | Debug keystore (automatic)                  |
| `prod` | `in.sreerajp.qr_studio`     | SreerajP QR Studio | Release keystore (`android/key.properties`) |

> Android: `--flavor <name>` only. Flutter sets `FLUTTER_APP_FLAVOR` itself; never pass it with
> `--dart-define`. Read it with `String.fromEnvironment('FLUTTER_APP_FLAVOR')` (engineering
> standard §5.2).

---

## Signing / keystore

- Release signing uses `android/key.properties` pointing to `android/keystore.jks`. Back it up as `docs/guidelines/guideline.md` §2.3 says: at least two separate secure backups, at least one of them offline.
- `android/key.properties` and `*.jks` are gitignored — never commit them.
- `.gitignore` must include `android/key.properties`, `*.jks`, `*.keystore`, and `build/` (which also holds the debug symbols).
- Full keystore rules: `docs/guidelines/guideline.md` §2.

---

## Security rules

- Follow the Security Baseline (`docs/guidelines/flutter_project_engineering_standard.md` §15.1, checklist in `docs/security.md` §1.1). Never weaken a security control to make something work; ask first.
- HTTPS only; never disable certificate checks.
- No secrets in code, assets, or `--dart-define` — anything shipped in the app is public.
- Never log secrets, API keys, or decrypted data in debug or production builds.
- Store sensitive keys in `flutter_secure_storage`; never in `SharedPreferences`.
- Maintain `android:allowBackup="false"` and `android:usesCleartextTraffic="false"` in `AndroidManifest.xml`. Backup and device-transfer rules stay as recorded in `docs/security.md` §10.
- Request camera permission at point of use.

---

## Localization rules

- Declared languages (from `docs/PROJECT_PROFILE.md`): **English (`en`, template), Malayalam (`ml`), Sanskrit (`sa`)**. Every feature and every screen works in every declared language.
- All user-visible text comes from `lib/l10n/*.arb` through `AppLocalizations` — never a raw string literal in a widget.
- `l10n.yaml` (project root) and one ARB file per declared language (`app_en.arb`, `app_ml.arb`, `app_sa.arb`) must exist. Run `flutter gen-l10n` after editing any `.arb` file.
- Every new key goes into **every** declared language's file with a real translation. Never leave the English value sitting in `app_ml.arb` or `app_sa.arb`.
- Every ARB key needs an `@key` description entry in `app_en.arb`, so a translator has context.
- Language pack in force: `docs/guidelines/language_packs/sanskrit_malayalam.md` — follow its rules, gates and glossary. Sanskrit must be pure Sanskrit, never Hindi (`app_sa.arb` must pass the Hindi-marker gate). Malayalam uses natural vocabulary, proper verb forms on buttons, and correct negation. Flag any translation you are unsure of for native-reader review in the change log.
- `supportedLocales` equals the declared languages. The framework fallback delegates (`FallbackMaterialLocalizationsDelegate`, `FallbackCupertinoLocalizationsDelegate`, `FallbackWidgetsLocalizationsDelegate` in `lib/l10n/fallback_localizations.dart`, driven by `kFrameworkFallbackLanguages`) are installed for `sa` (engineering standard §8.3.1). Format dates and numbers with the `formattingLocale(...)` helper (§8.3.2).
- In-app language picker in Settings: System default, then each language by its endonym (`English`, `മലയാളം`, `संस्कृतम्`), persisted to `SharedPreferences` (`app_language`) and applied immediately without restart (§8.4).
- Menu, button, label, tab and tooltip strings stay short in every declared language — at most 20 characters in English and 22 in Malayalam and Sanskrit (§8.6, language pack §5). Only `desc…`/`help…`/`empty…`/`error…`/`body…`/`aboutDetail…` keys may be long.
- Every icon-only control has a localized `tooltip:` (§7.8).
- Material and Cupertino come from the `material_ui` / `cupertino_ui` packages (with a caret `^` constraint). New code imports `package:material_ui/material_ui.dart`, never `package:flutter/material.dart` (§6.1). Existing imports are being migrated (compliance roadmap Phase 4).
- The About screen is data-driven and localized; it ends with the signature badge "Made with {heart} from India" (on, per `docs/PROJECT_PROFILE.md`). Write the heart as `{heart}`, never as an emoji.
- Services must not hold user-visible text. They return an `AppMessage` (a key plus arguments); the screen turns it into text through `AppLocalizations`.
- Literals are allowed only for logs, non-UI exception messages, asset paths, route names, map/JSON keys, `Semantics` test tags, developer-only screens, barcode protocol tokens (`BEGIN:VCARD`, `WIFI:`), and the CSV/JSON export headers that the import path reads back.
- The one other source of user-visible text is the About-screen values in `assets/config/app_config.json` (locale maps, `docs/guidelines/guideline.md` §1). The app name comes from `appName` there (plus the dev suffix, `AppFlavorConfig.nameSuffix`) and matches the Android `app_name` in every `values-<code>/strings.xml` (§1.8). There is no app-name key in the ARB files.

---

## Code style / naming

- Files `snake_case.dart`; classes `PascalCase`; variables/methods `camelCase`; providers `camelCase` + `Provider` suffix.
- Use `package:` imports (`package:sreerajp_qr_studio/...`), not relative imports.
- Prefer `const` constructors, `final` locals, and single quotes.
- Run `dart format .` before every commit; `flutter analyze` adds no new warnings (zero is the goal, and the code is at zero today).

---

## Testing rules

- Mirror `lib/` structure in `test/` (e.g. `test/providers/`, `test/services/`).
- Critical coverage areas: URL pattern checks, homograph attack detection, rate limiting, and `ScanProvider` state transitions.
- Key parity tests across ARB files and Sanskrit fallback delegate tests must pass.
- Mock network calls with `MockClient` from `package:http/testing.dart`.

---

## Dependency constraints

- Blocked dependencies: Analytics, crash reporting, ads, heavy state frameworks (Riverpod, Redux), and closed or telemetry-bearing scanning SDKs (Google ML Kit / `mobile_scanner`, Firebase ML).
- Barcode decoding uses the app's own engine: vendored zxing-cpp (`native/`, Apache-2.0) via dart:ffi. Never edit files under `native/zxing-cpp/`; follow `native/zxing-cpp/UPSTREAM.md` to update it.
- Provider (`provider`) is the sole state management solution.
- Before adding any package: verify license, check transitive dependencies, and confirm offline friendliness.

---

## Where things live

```
CLAUDE.md            # project rules
AGENTS.md            # project rules (this file)
docs/                # project documentation (PROJECT_PROFILE.md first) & guidelines submodule
plans/               # change plans (plan-before-changing)
change_log/          # change logs (log-after-changing)
lib/                 # app source code (Tier 1 layer-first)
test/                # unit & widget test suite
integration_test/    # on-device tests (native barcode decoder)
native/              # own barcode decoder: C bridge + vendored zxing-cpp
tool/                # release & build scripts
```

---

## Workflow rules (mandatory — from global rules)

Every change follows plan-before-changing and log-after-changing:

1. **Plan before changing.** Write a full plan to `plans/` named `yyyymmdd_hhMMss_<short-slug>.md` with a `**Status:**` line, the files to change, the issue, and the fix. A plan that touches network, storage, sign-in, permissions, deep links, WebViews, platform folders or dependencies has a short **"Security impact"** line (engineering standard §22.2). Then **STOP and get explicit approval** before editing/creating/deleting any project file (other than the plan). A question or ambiguous reply is not approval.
2. **Log after changing.** After implementing, write a change log to `change_log/` named `yyyymmdd_hhMMss_<short-slug>.md` describing what changed and referencing its plan.
3. **Relative paths & privacy only.** `plans/` and `change_log/` files are committed and may become public on the internet. They MUST use relative repository paths only (never absolute system paths with a drive letter, and never `file:///` links). They MUST NOT contain any **local system details** — OS user name, computer/host name, home or drive-letter paths, network share names, LAN/internal IP addresses, local server URLs with ports, device serial numbers, personal email addresses — or any secret (API keys, tokens, passwords, keystore passphrases, credentials, PII). Write them as if a stranger will read them; nothing should reveal the machine they came from.
4. **The guidelines submodule is read-only.** `docs/guidelines/` is read-only. Never edit, pull, check out or commit the submodule or its version. If a guideline needs a change, write a note for the user instead (`docs/guidelines/DOCS_FOLDER_GUIDELINE.md` §1.1). If the folder is empty or missing, stop and ask the user.
5. **CI is checks + Dependabot only.** GitHub CI runs only `flutter pub get`, the format check, `flutter analyze`, `flutter test`, and other pass/fail check scripts, plus Dependabot (`.github/dependabot.yml` for `pub` and `github-actions`). CI never builds release artifacts, signs, holds signing secrets, uploads, or publishes. Release builds are done locally (`docs/guidelines/flutter_project_engineering_standard.md` §19).

Create `plans/` and `change_log/` if they do not exist.

---

## Communication rules

- **Always use simple English.** Write all responses, plans, change logs, and explanations in plain, simple English. Short sentences, common words. Explain any jargon you must use.

---

## What AI agents must always / never do

**Always:**
- Read `AGENTS.md` first before starting work, then `docs/PROJECT_PROFILE.md`.
- State the target layer (`models`, `providers`, `services`, `screens`) before adding a class.
- Run `flutter analyze` and `flutter test` after changes.
- Keep `main.dart` thin (initialization, Provider setup, routes only).

**Never:**
- Hard-code user-visible text in a widget — it belongs in `lib/l10n/*.arb`.
- Put business logic or HTTP calls in widgets.
- Store sensitive keys in `SharedPreferences`.
- Add blocked dependencies or alternative state management packages.
- Log API keys or sensitive data.
- Change anything in `docs/guidelines/` (files or submodule version).
- Add release builds, signing, secrets, uploads or deploys to CI.
