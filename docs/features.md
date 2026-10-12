# SreerajP QR Studio — Features

This file lists everything this app does today. It is meant to be shared with
another AI assistant (or a human) working on a different app, so they can
check what this app already has before building something similar or
overlapping.

Source of truth used to write this file: the app source code in `lib/`,
`pubspec.yaml`, and the dated files in `change_log/`. The older docs
(`docs/architecture.md`, `docs/security.md`, `docs/project_structure.md`)
describe an earlier, simpler version of the app and are **not** used as the
source here — they have not been updated to match the current code.

---

## What this app is

SreerajP QR Studio is an Android-only, offline-first Flutter app for
scanning QR codes and barcodes. It is primarily a privacy-first **reader** and
barcode security analyzer. It can also make codes: the CodeForge tab builds
QR codes and barcodes (text, links, Wi-Fi, contacts, UPI, SMS, email,
location) with a style editor, and the AirQR transmitter turns text into
animated QR code sequences (5–25 FPS) for optical transmission. Beyond plain decoding, every scanned link is checked for safety against
phishing and fake sites using a 6-layer check, and the user can preview the
destination page itself in a safe, script-disabled sandbox before ever
opening it. Every scanned code can also be checked for physical tampering
(like a sticker glued over a real code). It also understands "smart" QR
content (Wi-Fi logins, contact cards, locations, calendar invites, payment
links, 2FA codes) and turns them into one-tap actions, supports a
hidden/encrypted QR format unlocked by a passphrase (with an optional
fingerprint check), keeps a searchable local scan history with export and
encrypted backup/restore, and
includes two extra tools: an optical "air-gapped" data transfer mode (transmitter &
receiver; no network or Bluetooth needed) and a live camera view that can track and label
many codes at once. Scanning also works beyond the live camera — codes can
be read from a gallery photo, a multi-page PDF, or a file/image shared in
from another app. There is no cloud sync and no user account — everything
runs and stays on the device, and network calls are off by default unless
the user turns them on.

---

## Core scanning

- Live camera scanning of QR codes and barcodes using the phone camera.
- Barcode formats read by the live camera: QR Code, Code128, Code39, Code93,
  EAN-8, EAN-13, UPC-A, UPC-E, PDF417, Data Matrix. Gallery and PDF scans also
  read Aztec, Micro QR, rMQR, MaxiCode, Codabar, ITF and DataBar.
- Decoding uses the app's own engine (vendored zxing-cpp, called through
  dart:ffi). No Google ML Kit or other closed scanning SDK.
- Torch (flashlight) on/off toggle.
- Front/rear camera switch.
- Pinch-to-zoom and an on-screen zoom slider (1.0x–8.0x).
- Sound (the system click tone) and vibration feedback on a successful
  scan, each can be turned on/off separately in Settings.
- Animated scan overlay with 4 styles to choose from: Laser Line, Pulsing
  Corners, Cybernetic Grid, Subtle Dot Matrix — the overlay box also tracks
  and glows around the real detected code.
- Scan a QR/barcode from a photo in the gallery.
- Scan a multi-page PDF file and see every code found on every page, with a
  "Save All to History" option.
- Appears as a target in the Android Share Sheet, so images or PDFs shared
  from other apps can be scanned directly.
- Continuous Batch Scan Mode: toggleable mode that queues multiple codes rapidly without leaving the camera viewport, showing a floating counter badge, batch list review, duplicate prevention, background 6-layer URL safety verification, and multi-format batch export (CSV, JSON, TXT, PDF).
- Distance-Enhanced Scanning Pipeline: digital zoom-crop-enhance pipeline for physically distant codes (posters, overhead signs, billboards). Extracts candidate regions of interest (ROI), applies pure-Dart bilinear upscaling, contrast boost, and high-pass unsharp masking before passing to the barcode engine, fully in memory. Includes Viewport Distance Assist toggle, HUD reticle badge, and automated multi-scale fallback scanning for photo files.
- GhostScan: scan a QR code or barcode that is shown on the phone screen
  inside another app. Start it from the GhostScan Quick Settings tile or the
  scanner menu. Android asks for screen capture permission, one picture is
  taken, read on the phone, and deleted.
- Scan bubble: a small floating button over other apps (off by default).
  Tap it to run a GhostScan of the current screen. Turn it on or off from
  Settings > Scan bubble, the "Scan bubble" Quick Settings tile, the app
  icon long-press shortcut, or the scanner menu. Drag it to move it; drag it
  onto the X at the bottom to turn it off. An optional "Start after restart"
  switch (off by default) brings it back after the phone restarts. Scans are
  saved to history with a "From screen" label. If the app on screen blocks
  screen capture (for example a banking app), a clear message says so.
- Scan from clipboard: when the clipboard holds a link or a code payload, the
  scanner offers to check it like a scanned code.
- Multi-code selection: when the camera sees several codes at once, each gets
  a tappable box so the user picks which one to open (can be turned off in
  the camera settings sheet).
- Camera settings sheet: flash (off / on / auto by light sensor), capture
  resolution, preview brightness, contrast and invert colors (all saved
  between app starts), distance zoom and sharpening for far-away codes.
- First-run welcome tour (onboarding carousel) that can be shown again from
  Settings.
- Camera is robust to app lifecycle changes: it recovers from being paused,
  coming back from another screen, or camera errors, without freezing or
  showing a wrong "permission denied" message.

---

## URL safety and anti-phishing (6-layer check)

When a scanned code contains a link, the app runs it through 6 checks before
showing it as safe or unsafe:

1. **HTTPS/SSL check** — confirms the link uses a secure connection; can
   check the live certificate if the user has turned on active checking.
2. **Redirect check** — follows redirect chains and flags loops or
   unusually long chains.
3. **Suspicious pattern check** — flags raw IP addresses used as a
   hostname, long strings of digits, too many dashes/underscores, known
   phishing keywords, data URIs, and excessive subdomains.
4. **Link-shortener check** — detects known link-shortener services and can
   check where a shortened link actually leads.
5. **Look-alike character check** — detects lookalike letters (e.g.
   Cyrillic/Greek characters that look like Latin letters) used to fake a
   trusted domain name.
6. **Google Safe Browsing check** — optional; uses the user's own API key to
   ask Google if the link is a known bad site.

Extra optional providers (Settings > URL Safety Providers), each off until
the user sets it up:
- **VirusTotal** and **URLhaus** — with the user's own API key (stored in
  secure storage) and an editable endpoint; VirusTotal has a daily request
  limit counter.
- **PhishTank** and **OpenPhish** — on/off switches; OpenPhish uses a
  downloaded feed list that is checked on the device.

Privacy controls:
- **Private mode by default** — the app does not contact the destination
  server at all unless the user explicitly turns on "Active Online
  Probing." Only local, on-device checks (and Safe Browsing, if configured)
  run.
- When active probing is turned on, outbound requests strip identifying
  browser information to reduce fingerprinting.
- A banner on screen always tells the user whether a check was done
  privately or actively.
- All checks are combined into one overall safe/unsafe verdict.

Result screen layout:
- The main actions (Open in Browser, Copy, Share, and a More menu with
  Decrypt, Recheck and Scan another) sit in a bar fixed to the bottom of the
  screen, so the user never has to scroll to act.
- A short verdict card sits right under the link: "N issues found" (with the
  first problem named) or "No issues found", plus "X of Y checks passed" and
  the privacy mode. "See details" scrolls to the full list.
- In the full list, failed checks are always shown. Passed checks and
  skipped checks (no API key, or service turned off) are folded into one
  line each. The sandbox preview and a genuine-print Quishing Guard result
  also start folded.
- The Open button follows the risk: normal when safe, amber with a warning
  sign for a warning, and outlined red for danger. A confirm step always
  comes before a link is opened.

---

## Zero-trust link preview (sandboxed page preview)

- Before the user opens a scanned link, the app can fetch the destination
  page in a safe, script-disabled way and show a cleaned-up preview.
- Strips scripts, click handlers, iframes, embeds, and hidden
  redirect/tracking tricks (meta-refresh redirects, tracking pixels) before
  showing anything.
- Detects "open redirect" traps hidden in the link or the page.
- Shows the page's title, description, icon, and main heading/text so the
  user can judge the destination without visiting it directly.
- Shows whether the site's SSL certificate is valid and how old the domain
  is (via a WHOIS/RDAP lookup), flagging very new domains (under 30 days
  old) as riskier.
- A details view lets the user inspect exactly what was removed from the
  page.

---

## Quishing Guard — physical tamper detector

Checks whether a printed QR code has been physically tampered with (for
example, a fake sticker glued over a real one — a real-world "quishing"
attack).

- Runs fully on the device, using the camera image around the scanned code,
  no network needed.
- Looks for tell-tale signs of an overlay: double edges, small shadow steps,
  print texture/grain mismatches, and other forensic signals.
- Gives a 3-level risk result: **Authentic** (green), **Wear & Tear**
  (yellow), **High Warning** (red), with the details behind the score shown
  to the user.

---

## StegoQR — hidden, locked QR content

Supports a special QR format that hides a second, private message inside a
normal-looking QR code.

- The visible ("decoy") content shows right away, and is itself checked for
  link safety like any other scan.
- The hidden content is encrypted (AES-256) with a key derived from a
  passphrase (PBKDF2-HMAC-SHA256). The passphrase is always required to
  decrypt it.
- The user can add the phone's fingerprint/face unlock as an extra check
  before the passphrase is used. Biometrics never replace the passphrase.
- The unlocked hidden content has its own copy/share buttons, separate from
  the decoy content.

---

## Smart payload actions

The app recognizes common QR content types and turns them into ready-to-use
action cards instead of plain text:

- **Wi-Fi** — shows network name and password (hidden by default, tap to
  reveal/copy). The "Connect to Wi-Fi" button asks Android to add the
  network: on Android 11+ the system "add network" prompt opens, on
  Android 10 a network suggestion is made, and on older versions the network
  is added directly. If that fails, the Android Wi-Fi settings screen opens.
- **Contact card** — supports both vCard (`BEGIN:VCARD`) and MeCard (`MECARD:`) formats;
  shows name, organization, title, phone numbers (tap to call), emails (tap to email),
  addresses, and website URL, with a "Save to Contacts" button.
- **Location** — parses `geo:lat,lng` coordinates with optional labels/queries; shows
  the coordinates on a location banner and an "Open in Google Maps" button. The banner
  is drawn on the device — no map tiles are downloaded.
- **Calendar event** — parses iCalendar (`BEGIN:VEVENT`); shows event summary, description,
  location, start/end date and time, and an "Add to Calendar" button.
- **Payment links** — supports UPI (`upi://pay`), SEPA bank transfer (EPC QR / `BCD\n` / `sepa:`),
  and crypto (Bitcoin, Ethereum, Solana) payment links; shows the payee, amount, currency, note,
  and transaction reference ID, with a "Pay" button and copy buttons. If a UPI code has no
  amount, the app asks for one (₹1 or more) before opening the UPI app, because some UPI apps
  reject a link with no amount when another app opens it.
- **2FA / authenticator codes** — reads `otpauth://totp/` codes; computes live,
  auto-refreshing 6-digit TOTP codes with a 30-second countdown using HMAC-SHA1 algorithms and
  secret key parsing, plus options to copy or import into an authenticator app.

All action buttons fail gracefully with an on-screen message if the target
app isn't installed.

---

## Scan history

- Every scan can be saved to a local, on-device history list.
- Each entry stores: the content, when it was scanned, the barcode type, a
  category, a safety score, an optional note, an optional location tag, and
  a favorite/star flag.
- History screen supports search, filtering by category (All, Starred,
  URLs, Wi-Fi, Contacts, Text, Barcodes), and pull-to-refresh.
- Tap an entry to see full details, add notes, or tag a location.
- Export history to CSV, JSON, TXT, or a PDF report.
- Back up and restore history as a password-protected encrypted file (`.sreerajqr` container).
- History data is stored encrypted (AES-256) in a local SQLite database, not in
  plain text.

---

## AirQR — optical data transfer (no network needed)

A way to send and receive data between two phones using only the camera and screen — no
Wi-Fi, Bluetooth, or internet required.

- **Transmitter mode (`AirQrTransmitterScreen`)** — turns any text or data into an animated
  stream of QR code frames (configurable speed from 5 to 25 frames per second) to send data optically.
- **Receiver mode (`AirQrScreen`)** — reads the animated QR stream via camera, tracks frame chunks,
  uses error-correction to recover missing frames, displays live progress (captured frames, FPS,
  progress bar), and reassembles the complete original text payload.
- **Device sync** — the transmitter can send an encrypted package of scan
  history and app settings (protected by a passphrase or a random PIN); the
  receiving phone decrypts it and can restore the history and apply the
  settings.
- The receiver asks for camera permission when it opens. If permission is
  denied it says so and offers a button to ask again; if the camera cannot
  start it shows a clear message with a "Try again" button.

---

## CodeForge — code generator

- Builds QR codes from text, links, Wi-Fi logins, contact cards, UPI payment
  requests, SMS, email, and map locations ("use my location" fills the
  coordinates after asking for location permission).
- Also builds barcodes: Code 128, EAN-13, EAN-8, UPC-A, Code 39, PDF417 and
  Data Matrix, with a check that the content fits the chosen type.
- Style editor for QR codes: module and eye shapes, colors, error
  correction level, and an optional center badge. Choice chips wrap to a
  second line on narrow screens.
- Links can be checked with the same URL safety checks before sharing. A
  banner shows the result: not checked yet, safe, or how many problems were
  found (with a "Check again" button).
- Share as PNG or SVG; copy the payload text. Text is limited to 500
  characters and can be loaded from a file.

---

## AR CodeVision — live multi-code camera view

A camera view that can track and label several QR/barcodes at once on
screen at the same time, instead of scanning one at a time.

- Floating labels ("chips") stay attached to each code as the camera moves.
- Two modes, chosen with a Warehouse / Safety switch under the title:
  **Warehouse mode** (shows price/batch info, lets you check off items) and
  **Safety mode** (shows a green/red safety badge per code, using the same
  link-safety checks as normal scanning). It opens in Warehouse mode;
  switching mode clears the selection.
- In Warehouse mode, several codes can be selected at once and copied to the
  clipboard together with a single "Batch Copy" action. This is the only batch
  action; the AR view does not save to history.

---

## Appearance and settings

- Material 3 theme with 4 options: follow system, Light, Dark, and a true
  pure-black (OLED-friendly) dark mode (#000000).
- "Material You" dynamic color — the app can match the colors of the
  phone's wallpaper (Android 12+ Monet engine).
- Appearance screen with four parts: theme mode, scan overlay style, accent
  color (with Material You dynamic color), and text size.
- Language picker: System default, English, Malayalam, or Sanskrit; applies
  at once without a restart.
- Settings screen organized into cards: Appearance, Language, Features,
  Scan Feedback (sound/vibration), Privacy & Online Probing, URL Safety
  Providers, Scan bubble, Permissions overview, Help & Feature Guides, and
  About.
- About screen shows app name, description, version and build number (read
  from `assets/config/app_config.json`, kept in step with `pubspec.yaml`), author,
  contact email, license, AI tools used (Claude, Gemini, ChatGPT), IDE used, and a "Made with ❤️ from India" footer.
- A Permissions screen explains, in plain terms, every permission the app
  can use and why (camera, biometric unlock, internet, vibration, and
  optional features like active probing or the Safe Browsing key).
- A Help screen explains the less obvious features (AR CodeVision, AirQR,
  Quishing Guard, and the URL safety/link tamper checks) with their own
  guide cards.

---

## Security and privacy

- The Google Safe Browsing API key (if the user adds one) is stored only in
  the phone's secure, encrypted storage — never in plain settings files and
  never logged.
- Android backups are turned off for this app (`allowBackup="false"`), so
  no secrets can leak through a phone backup.
- No network contact with a scanned link's server unless the user turns on
  active probing; when active probing is used, identifying request
  information is stripped.
- Unlocking hidden StegoQR content always requires the passphrase, with the
  phone's fingerprint/face unlock available as an optional extra check.
- Scan history and StegoQR hidden content are both encrypted (AES-256) at
  rest.
- The app never logs API keys, passwords, or decrypted hidden content, even
  in debug builds.
- No malformed or broken QR/barcode content can crash the app — it always
  falls back to a safe error message.

---

## Key technical facts

| Fact | Value |
|------|-------|
| Platform | Android only (no iOS, web, or desktop) |
| Framework | Flutter (>=3.47.6), Dart (>=3.13.5 <4.0.0) |
| App package | `in.sreerajp.qr_studio` |
| Min SDK / Compile SDK / Target SDK | minSdk 24 / compileSdk 37 / targetSdk 36 |
| State management | `provider` package (`ChangeNotifier`) — no Riverpod/Redux/BLoC |
| Network behaviour | Offline-first; core scanning, payload parsing, Quishing Guard, StegoQR, AirQR transmitter/receiver, and history all work fully offline. Online checks (active URL probing, Safe Browsing, DOM sandbox preview, WHOIS) are opt-in or triggered only by a link scan |
| Cloud sync / accounts | None — no user accounts, no server, no cloud backup |
| Local storage | `sqflite` (encrypted scan history database), `flutter_secure_storage` (API key, secrets), `shared_preferences` (simple settings/counters) |
| Build flavors | `dev` (`in.sreerajp.qr_studio.dev`, debug keystore) and `prod` (`in.sreerajp.qr_studio`, release keystore) |
| Navigation | Named routes (Navigator 1.0), no deep links |
| Notable packages | `camera`, `ffi`, vendored zxing-cpp (native decoder), `qr`, `qr_flutter`, `barcode`, `geolocator`, `local_auth`, `encrypt`, `pointycastle`, `sqflite`, `image_picker`, `file_picker`, `pdfx`, `pdf`, `receive_sharing_intent`, `dynamic_color`, `url_launcher`, `share_plus`, `permission_handler`, `crypto`, `package_info_plus` |

---

*Last generated: 2026-08-18; updated 2026-10-10 (gap analysis). Keep this file in sync by updating it whenever
a new feature is added — the `change_log/` folder is the most reliable place
to check for anything added after this date.*
