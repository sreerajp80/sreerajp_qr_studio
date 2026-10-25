# Changelog — SreerajP QR Studio

User-facing release history. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/);
versions come from `pubspec.yaml` and release tags use the `Release_YYYYMMDD` format
([docs/release_process.md](docs/release_process.md) §3). Developer-level detail for every
change is in [`change_log/`](change_log/).

---

## [Unreleased]

### Added
- **Delete all data** in Settings → Privacy: removes scan history, saved API keys, all
  settings, Scan bubble settings and temporary files, then restarts the app like a fresh install.
- A clear message with **Try again** when the history cannot be loaded, instead of an empty list.
- A **Privacy policy** link on the About screen.
- An adaptive launcher icon that fits every launcher shape, a themed (monochrome) icon on
  Android 13+, and a "DEV" badge on the development build's icon.
- **App lock** (optional, Settings → Privacy): asks for fingerprint, face or the screen lock when
  the app opens and after 30 seconds away.
- Screens that show scans, history, secrets or API keys now block screenshots and screen
  recording. This **Screenshot guard** is on by default; you can turn it off in
  Settings → Privacy.
- A warning before exporting history or batch scans as an unencrypted file.
- **Settings → Permissions** now lists every permission the app can use, in plain words, and
  says why each one is needed.
- A **Settings** button on the CodeForge and History tabs.
- Driving licence / ID card barcodes (US and Canada) now show the name, dates, issuer and
  address in a clear card. The document number stays hidden until you tap **Show number**.
  ID card scans are never saved to history.

### Changed
- Scan history is now encrypted with AES-256-GCM and a fresh random nonce for every field.
  Existing history is upgraded automatically the first time the new version opens it.
- The app now never saves history unencrypted, and never replaces a history key it could not
  read.
- Encrypted backups (`.sreerajqr`) and AirQR sync packages use a much stronger format
  (PBKDF2 with 600,000 rounds and AES-256-GCM). Old backups and sync packages still open.
- The Features and Help texts now describe the security features exactly as they work.
- The saved app language is applied before the first screen appears, so the app no longer
  flashes in another language at start-up.
- Translation fixes: the copyright line is translated into Malayalam and Sanskrit, and a long
  tooltip was shortened.
- Shorter, clearer button, title and tab texts in all three languages, so they fit on small
  screens.
- Malayalam and Sanskrit now use one word for "History" everywhere (നാൾവഴി, इतिवृत्तम्).
- The privacy policy now says correctly that the page preview runs by itself after a link scan,
  only when "Active online checks" is on. The "Private mode" note on a scanned link no longer
  names only Google Safe Browsing; it says the safety services you turned on were used.
- Every Help guide is rewritten in plain words and covers every feature.
- The fake sticker check no longer shows a made-up "authentic" score. It now gives an honest
  reminder to check for a sticker placed over the real code.
- Lower battery use: the light sensor runs only while the camera is open and the flash is
  set to Auto.

### Fixed
- Unexpected errors no longer show a raw error box in release builds; they are logged without
  any scanned content.
- Screen scan (Scan bubble and Quick Settings tile) now waits a moment for the
  "Start recording?" dialog to fade before taking the picture, so smaller QR codes on screen
  are found.
- Screen scan no longer stays silent right after first-run onboarding (until the app was
  restarted, captures were not decoded).
- AirQR Receiver and AR CodeVision no longer show a black camera when opened from the Scan
  screen menu.
- Live scanning can no longer stop silently if the background barcode reader stops
  responding; it now starts a fresh reader.
- The "Online checks" card in Settings is readable in dark mode, and menu icons are clear in
  light mode.
- CodeForge previews of Code 128, EAN, UPC and Code 39 barcodes now show the numbers under the
  bars (before, the preview could be blank or the numbers could not be seen).
- Text no longer runs off the screen in the camera adjustments panel or on the label under a
  detected code, in any language or with large text.

## [4.1.0+34] — 2026-10-12 (`Release_20261012`)

### Added
- Own barcode engine (vendored zxing-cpp through dart:ffi) — Google ML Kit removed; no scanner
  telemetry.
- Scan bubble: a floating button over other apps for one-tap screen scanning, with a Quick
  Settings tile, app shortcut and optional start after restart.
- Localized help screens and Features screen in all three languages.
- UPI amount prompt before opening a payment link.
- Distance assist for small or far-away codes during live scanning.
- Privacy policy and Play Data safety information.

### Changed
- App renamed to **SreerajP QR Studio** (`in.sreerajp.qr_studio`).
- Faster AirQR transfers (fountain-code fixes, better block size).
- Compact result screen layout; better button contrast in the dark theme; correct insets in
  edge-to-edge mode.
- Toolchain: latest Flutter with AGP 9, Gradle 9, built-in Kotlin; target API 36.

## [3.2.0+28] — 2026-09-20 (`Release_20260921`)

### Added
- Multi-provider link safety: optional VirusTotal, URLhaus, PhishTank and OpenPhish checks
  alongside Google Safe Browsing.

### Changed
- README updated with the latest features.

## [3.1.2+27] — 2026-09-19 (`Release_20260919`)

### Added
- GhostScan: scan a QR code shown on the screen through a Quick Settings tile.
- Scan from the clipboard; read a code from a file; choose one code when several are visible.
- CodeForge generator tab with a QR customizer; interactive onboarding; scan feedback
  (sound, vibration, animation); continuous batch scan mode; distance-enhanced scanning.
- Smart action cards, Wi-Fi direct connect, camera controls, encrypted history with AirQR sync.
- English, Malayalam and Sanskrit with an in-app language picker.

### Fixed
- System-default language choice in the picker; camera feed and scan area; GPS and UPI cards;
  CodeForge text length limit.
