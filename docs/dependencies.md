# Dependencies — SreerajP QR Reader

This document records approved packages, dependency categories, and prohibited packages for SreerajP QR Reader. Read this before adding or updating any dependency in `pubspec.yaml`.

**Read first:**
- [CLAUDE.md](../CLAUDE.md)
- [AGENTS.md](../AGENTS.md)
- [architecture.md](architecture.md)
- [security.md](security.md)
- [guidelines/flutter_project_engineering_standard.md](guidelines/flutter_project_engineering_standard.md)

---

## 1. Dependency Principles

- **Open Source Only:** Every added package MUST have a verified permissive open-source license (MIT, BSD, Apache 2.0).
- **Minimal Surface Area:** Prefer Flutter framework utilities over third-party packages when available (e.g. Flutter built-in `Clipboard` service).
- **Security & Privacy Gating:** Offline-first design is mandatory. Packages must not communicate over external networks unless explicitly opted-in by the user (such as Google Safe Browsing API checks).
- **No Unnecessary Abstractions:** Keep dependencies scoped to core requirements; do not add overlapping state management or framework wrappers.

---

## 2. Approved Production Dependencies

| Package | Version | Purpose | Security / Privacy Note |
|---|---|---|---|
| `mobile_scanner` | `^7.2.0` | Live camera QR and barcode scanning | Requires camera permission at point of use |
| `qr_flutter` | `^4.1.0` | Offline optical QR code matrix rendering for AirQR | Pure Dart; zero network; offline rendering |
| `qr` | `^3.0.2` | Core QR matrix and error correction computation | Pure Dart; zero network; offline generation |
| `barcode` | `^2.2.9` | 1D and 2D barcode generation for CodeForge | Pure Dart; zero network; offline generation |
| `flutter_localizations` | `sdk: flutter` | Core localization delegates | Framework package |
| `intl` | `any` | Date, number, and locale formatting | Formats dates and numbers; Sanskrit falls back to English patterns |
| `http` | `^1.6.0` | HTTP client for URL safety & redirect checks | Gated within `UrlSafetyService`; offline-safe fallback |
| `url_launcher` | `^6.3.2` | Open URLs in system browser or intent apps | System intent launcher; user-confirmed |
| `share_plus` | `^12.0.1` | Share scanned text/URLs via system share sheet | System share sheet; zero external network |
| `permission_handler` | `^12.0.1` | Runtime Android permissions | Camera and biometrics requested on demand |
| `provider` | `^6.1.5` | App state management (`ChangeNotifier`) | Zero network; sole approved state framework |
| `dynamic_color` | `^1.7.0` | Material You Android 12+ dynamic color extraction | Reads device wallpaper palette locally |
| `package_info_plus` | `^9.0.0` | Retrieve app version and build number | Local platform channel read |
| `flutter_secure_storage` | `^10.0.0` | Encrypted storage for API keys | Uses Android KeyStore |
| `shared_preferences` | `^2.5.5` | Non-sensitive preferences (theme, language, counters) | Plaintext local key-value store |
| `local_auth` | `^2.3.0` | Biometric authentication for StegoQR secret reveal | Local Android BiometricPrompt; biometric data never leaves OS |
| `flutter_plugin_android_lifecycle` | `^2.0.24` | Android lifecycle glue for local auth plugin | Flutter team maintained |
| `encrypt` | `^5.0.3` | Symmetric AES encryption for StegoQR payloads | Pure Dart; zero network |
| `pointycastle` | `^3.9.1` | Cryptographic primitives (PBKDF2, key derivation) | Pure Dart; cryptographic engine |
| `sqflite` | `^2.4.1` | Local SQLite database for scan history | Local database file; zero cloud sync |
| `path_provider` | `^2.1.5` | Resolves app-internal storage directories | Scoped storage paths |
| `path` | `^1.9.0` | Filesystem path manipulation utilities | Pure Dart path operations |
| `crypto` | `^3.0.6` | Hashing functions (SHA-256 for code fingerprinting) | Pure Dart hashing |
| `pdf` | `^3.11.1` | PDF export report generation | Generates PDF documents locally |
| `image_picker` | `^1.1.2` | Select images from gallery for barcode scanning | Uses modern Android Photo Picker |
| `file_picker` | `^8.1.7` | Select PDF documents for document barcode scanning | Android Storage Access Framework |
| `pdfx` | `^2.7.0` | Local PDF document rendering for barcode scanning | Renders PDF pages into images locally for scanning |
| `receive_sharing_intent` | `^1.8.1` | Receive shared text/images/PDFs from Android share sheet | Inbound Android intent receiver |

---

## 3. Approved Development Dependencies

| Package | Version | Purpose |
|---|---|---|
| `flutter_test` | `sdk: flutter` | Framework unit & widget test library |
| `flutter_lints` | `^6.0.0` | Static analysis lint rule baseline |
| `sqflite_common_ffi` | `^2.3.4` | In-memory SQLite FFI driver for fast headless unit testing |

---

## 4. Prohibited Dependencies

> **WARNING:** Do not add any of the following package types to `pubspec.yaml` under any circumstances:

- **Analytics / Tracking SDKs:** Firebase Analytics, Mixpanel, Amplitude, Segment, Flurry.
- **Crash Reporting SDKs:** Sentry, Crashlytics, Bugsnag (privacy violation; crashes must be diagnosed locally).
- **Ad Frameworks:** AdMob, Unity Ads, AppLovin, ironSource (zero ads policy).
- **Heavy State Frameworks:** Riverpod, Bloc, Redux, MobX (`provider` is the sole state standard).
- **Unvetted Cryptography / Network Proxies:** Any closed-source or unverified binary blobs.
