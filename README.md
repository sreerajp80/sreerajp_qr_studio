# SreerajP QR Studio

<div align="center">

![SreerajP QR Studio](assets/app_icon.png)

**Privacy-First, Offline-First Android QR & Barcode Scanner with 6-Layer Link Safety, Multi-Provider Threat Intelligence, Quishing Guard, StegoQR Encryption, AirQR Optical Sync, and Tri-Lingual Support.**

[![Flutter](https://img.shields.io/badge/Flutter-%3E%3D3.47.6-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-%3E%3D3.13.5-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Platform](https://img.shields.io/badge/Platform-Android%20(SDK%2024%2B)-3DDC84?logo=android&logoColor=white)](https://android.com)
[![Languages](https://img.shields.io/badge/Languages-EN%20%7C%20ML%20%7C%20SA-blue)](#-tri-lingual-localization)
[![Security](https://img.shields.io/badge/Privacy-Offline--First-success)](#-security--privacy-architecture)
[![License](https://img.shields.io/badge/License-Open%20Source-orange)](#-license)

</div>

---

## 📖 Overview

**SreerajP QR Studio** is a high-performance, privacy-focused Flutter Android application for scanning, analyzing, and creating QR codes and barcodes. Built with an offline-first architecture, it ensures that your data never leaves your device unless explicitly requested.

Beyond standard barcode decoding, SreerajP QR Studio serves as a comprehensive **security and privacy toolkit** for the physical-to-digital world:
- **6-Layer URL Safety & Threat Intelligence** protects against phishing, malicious redirects, and lookalike domains using local heuristics plus Google Safe Browsing, VirusTotal, URLhaus, PhishTank, and OpenPhish.
- **QuishingGuard™** reminds you to check printed QR codes for fake stickers before you open a link or pay, with simple checks you do by hand.
- **Zero-Trust Sandboxed Preview** renders web destinations in an isolated, script-disabled environment with domain age (WHOIS) insights before opening.
- **StegoQR** allows secret payloads hidden within standard QR codes, encrypted with AES-256 and protected by passphrases and biometric authentication.
- **AirQR Optical Streaming & Device Sync** provides an air-gapped optical transfer mechanism (5–25 FPS animated QR sequences) to send files, encrypted scan history, and app settings between phones without Wi-Fi, Bluetooth, or cables.
- **CodeForge Studio** provides a full-featured QR and barcode generator suite with custom styling, color palettes, and embedded logos.
- **Multi-Code Viewport Selection & AR CodeVision** tracks, labels, and provides interactive touch targets for multiple barcodes simultaneously in real time.
- **Distance-Enhanced Pipeline & GhostScan™** scans distant codes using digital zoom-crop-enhancement and screen barcodes via an Android Quick Settings tile.
- **Tri-Lingual Standard**: Fully translated across **English**, **Malayalam (മലയാളം)**, and **Sanskrit (संस्कृतम्)** with live in-app switching.

---

## 📱 Visual Showcase

<div align="center">

| Live Camera Scanner | CodeForge Studio | Encrypted History |
| :---: | :---: | :---: |
| <img src="docs/screenshots/01_live_scanner.png" width="260" alt="Live Scanner" /> | <img src="docs/screenshots/02_code_forge_generator.png" width="260" alt="CodeForge Studio" /> | <img src="docs/screenshots/03_encrypted_history.png" width="260" alt="Encrypted History" /> |
| *Viewfinder with zoom, reticle & toolbar* | *QR & Barcode generator with live preview* | *Searchable, categorized scan logs* |

| Scan Result & URL Safety | AirQR Optical Receiver | AirQR Optical Transmitter |
| :---: | :---: | :---: |
| <img src="docs/screenshots/08_scan_result_and_safety.png" width="260" alt="Scan Result & URL Safety" /> | <img src="docs/screenshots/07_air_qr_optical_transfer.png" width="260" alt="AirQR Receiver" /> | <img src="docs/screenshots/07_air_qr_transmitter.png" width="260" alt="AirQR Transmitter" /> |
| *QuishingGuard™ & Zero-Trust Sandbox* | *Optical stream capture with error recovery* | *Air-gapped animated stream broadcast* |

| Settings & Security | Appearance & Themes | About & Verification |
| :---: | :---: | :---: |
| <img src="docs/screenshots/04_settings_and_privacy.png" width="260" alt="Settings & Security" /> | <img src="docs/screenshots/05_appearance_and_themes.png" width="260" alt="Appearance & Themes" /> | <img src="docs/screenshots/06_about_and_credits.png" width="260" alt="About Screen" /> |
| *Privacy controls & Safe Browsing API* | *Material You, OLED black & reticle styles* | *Version, build metadata & India badge* |

</div>

---

## ✨ Key Features

### 🛡️ 6-Layer URL Safety & Multi-Provider Threat Intelligence
Every scanned link is evaluated across six rigorous security layers before the user can open it:
1. **HTTPS / SSL Protocol Validation**: Verifies secure communication channels.
2. **Redirect Chain Inspection**: Traverses HTTP redirect chains to detect evasive redirect loops and open redirect traps.
3. **Heuristic Suspicious Pattern Analysis**: Identifies raw IP hostnames, excessive subdomains, long digit strings, and phishing keywords.
4. **Known Link-Shortener Detection**: Automatically recognizes and expands shortened links (e.g., bit.ly, tinyurl) to verify true targets.
5. **Homoglyph & Lookalike Attack Detection**: Identifies internationalized domain names (IDN) using Cyrillic or Greek characters to spoof trusted domains.
6. **Multi-Provider Threat Intelligence**: Comprehensive verification against leading security engines managed from a dedicated settings screen:
   - **Google Safe Browsing**: Free personal API key integration for known deceptive and malware sites.
   - **VirusTotal v3**: Free personal API key integration querying 70+ antivirus engines with daily 500-request quota tracking and customizable endpoints.
   - **URLhaus (abuse.ch)**: Free Auth-Key integration flagging active malware distribution sites and campaigns with tags and customizable endpoints.
   - **PhishTank**: Built-in, commercial-friendly phishing verification database with a 1-tap on/off toggle (no API key needed).
   - **OpenPhish**: Built-in community feed with automatic 12-hour local caching that operates 100% offline once cached.

> **Private by Default**: Outbound threat queries run only when enabled by the user or when **Active Online Probing** is explicitly enabled. In private mode, heuristic checks run entirely on-device.

### 🔍 QuishingGuard™ Fake Sticker Check
Helps users avoid real-world "quishing" (QR phishing), where attackers paste fake stickers over real QR codes on parking meters, restaurants, or payment stands.
- **Shown when it matters**: When a link or payment code is scanned with the camera, the result screen shows a small "Fake sticker check" card.
- **Hand checks**: Feel for raised sticker edges, check the payee name before paying, and ask staff or type the address yourself when in doubt.
- **Honest by design**: The app does not analyse the camera picture for stickers and gives no score, so it never claims a code is genuine.

### 🌐 Zero-Trust Sandboxed Web Preview
- Fetches destination pages in an isolated, script-disabled sandbox.
- Blocks JavaScript execution, iframes, trackers, and hidden meta-refresh redirects.
- Extracts page title, meta description, favicon, and primary heading.
- Queries WHOIS/RDAP to display domain registration age, flagging newly registered domains (<30 days old).

### 🔐 StegoQR Encrypted Payloads & Biometric Protection
- Encodes hidden, encrypted payloads inside standard-looking QR codes.
- The visible "decoy" payload scans normally for casual viewers.
- Secret payload is encrypted with **AES-256-GCM** using keys derived via **PBKDF2-HMAC-SHA256**.
- Unlocking requires the passphrase, with optional biometric verification (fingerprint or face unlock) as a secondary check.

### ⚡ Smart Payload Action Engine
Scanned content is automatically parsed into interactive action cards:
- **Wi-Fi**: Displays SSID and password (hidden by default). One-tap direct native connection using Android's network suggestions API (`Settings.ACTION_WIFI_ADD_NETWORKS` / `WifiManager`), one-tap copy, and quick navigation to Android Wi-Fi settings.
- **Payments & Banking**:
  - **UPI Payments**: Detects `upi://pay` strings; displays payee name, VPA, amount, and reference notes with a high-contrast UI and direct launch into installed UPI payment apps.
  - **SEPA Bank Transfers**: Parses European EPC QR / SEPA credit transfer payloads (`BCD\n`, `sepa:`) with IBAN, BIC, payee name, amount, and payment reference.
  - **Cryptocurrency**: Parses Bitcoin (`bitcoin:`), Ethereum (`ethereum:`), and Solana (`solana:`) payment links with address, amount, and label extraction.
- **Contacts (vCard / MeCard)**: Parses name, organization, title, phone numbers, emails, addresses, and websites with a "Save to Contacts" action.
- **Calendar Events (iCalendar)**: Parses `BEGIN:VEVENT` with summary, timestamps, location, and an "Add to Calendar" button.
- **2FA / Authenticator (TOTP)**: Parses `otpauth://totp/` URIs and computes live 6-digit TOTP codes with a 30-second countdown timer using HMAC-SHA1.
- **Geo GPS Coordinates**: Parses `geo:lat,lng` and renders device-drawn coordinate banners with "Open in Google Maps".

### 📡 AirQR Optical Air-Gapped Data Transfer & Device Sync
Transfer data and synchronize devices without Wi-Fi, Bluetooth, cellular data, or cables:
- **Transmitter Mode**: Splits data into small chunks (150 bytes by default) with Fountain FEC error-correction codes and broadcasts them as an animated sequence of QR codes at configurable frame rates (5–25 FPS).
- **Receiver Mode**: Captures the optical QR stream via camera, tracks received blocks, recovers missing packets via error correction, and reassembles the complete payload.
- **Air-Gapped Device Sync**: Beams encrypted SQLite scan history and application settings (`.sreerajqr` / `SREERAJ_AIRQR_SYNC_V1` container) from one phone to another. The receiving phone detects the sync container, prompts for the decryption passphrase, and immediately restores history and applies app preferences without restart.

### 👓 AR CodeVision & Viewfinder Intelligence
- **Multi-Code Tappable Selection**: When multiple barcodes appear in the camera viewport simultaneously, the scanner draws glowing bounding boxes and corner brackets around all detected codes with format badges. Users can tap the exact barcode they wish to inspect or queue.
- **Simultaneous AR Tracking**: Tracks and labels multiple barcodes in real time with anchored floating visual chips as the camera moves.
- **Warehouse Mode**: Highlights product details and enables multi-selection with single-tap batch clipboard copying.
- **Safety Mode**: Displays instant green/red security ratings over all detected URLs in the viewfinder.

### 🎨 CodeForge: QR & Barcode Creator Studio
- Built-in generator supporting QR codes and 10+ standard 1D and 2D barcode formats.
- Supports text, URLs, Wi-Fi networks, contacts, UPI payment strings, SMS, email, and GPS coordinates.
- Custom styling: adjustable error correction (L, M, Q, H), foreground/background colors, and embedded logo badges.
- One-tap copy, share, and image export.

### 📸 Advanced Media & Pipeline Scanning
- **Distance-Enhanced Scanning**: Pure-Dart digital zoom-crop-enhance pipeline for scanning distant codes on billboards and signs. Applies candidate region-of-interest (ROI) extraction, bilinear upscaling, contrast enhancement, and unsharp masking. Includes viewport distance assist toggle and automated multi-scale fallback scanning for photo files.
- **Gallery & Multi-Page PDF Scanning**: Scan codes from existing photos or multi-page PDF documents with batch extraction and "Save All to History".
- **Android Share Sheet Target**: Receives shared images and PDF files directly from other applications.
- **GhostScan™ Screen Content Detector**: Scans QR codes visible on your screen via an Android Quick Settings tile without manual screenshot cropping.
- **Scan Bubble**: An optional floating button over other apps. Tap it to scan a code shown on screen. Turn it on from Settings, a Quick Settings tile, or the app icon shortcut.
- **Clipboard Scanner**: Automatically identifies and previews scannable barcode data present on the Android clipboard with 1-tap scanning.
- **Continuous Batch Scan Mode**: Rapidly queues multiple scans without leaving the viewfinder, complete with duplicate prevention and multi-format export.

### 🚀 Interactive Onboarding & Feature Guides
- **Welcome Tour**: 3-slide interactive onboarding carousel on first launch introducing the 6-Layer URL Safety Engine, the QuishingGuard™ fake sticker check, and 100% offline privacy architecture.
- **Tour Replay**: Replay the onboarding tour at any time from the Settings screen or the Help Center.
- **Feature Help Guides**: Dedicated in-app guide cards explaining AR CodeVision, AirQR, QuishingGuard™, URL threat checks, and permission requirements.

### 🗄️ Encrypted SQLite History & Export
- All scans are securely persisted on-device in an **AES-256 encrypted SQLite database**.
- Searchable by content, format, and custom user notes.
- Categorized filters: All, Starred, URLs, Wi-Fi, Contacts, Text, Barcodes.
- Multi-format export: **CSV**, **JSON**, **TXT**, and formatted **PDF Reports**.
- Encrypted backup and restore using password-protected `.sreerajqr` containers.

### 🌐 Tri-Lingual Localization
- Developed under a strict tri-lingual standard with 100% key parity across:
  - **English (`en`)**
  - **Malayalam (`ml`)** — മലയാളം
  - **Sanskrit (`sa`)** — संस्कृतम्
- Includes dedicated fallback delegates (`FallbackMaterialLocalizationsDelegate`, `FallbackCupertinoLocalizationsDelegate`, `FallbackWidgetsLocalizationsDelegate`) for full Material/Cupertino framework support under Sanskrit.
- Live in-app language picker switches instantly without requiring an application restart.

### 🎨 Material 3 & OLED Themes
- Full **Material Design 3** compliance with **Material You dynamic color** support (Monet engine on Android 12+).
- Four theme modes: **System Default**, **Light**, **Dark**, and **True OLED Pure Black** (`#000000`).
- Four animated scan overlay styles: **Laser Line**, **Pulsing Corners**, **Cybernetic Grid**, and **Subtle Dot Matrix**.

---

## 📊 Supported Barcode Formats

| Format | Type | Standard Use Case |
| :--- | :--- | :--- |
| **QR Code** | 2D Matrix | URLs, Wi-Fi, Contacts, Payments, StegoQR, AirQR |
| **Data Matrix** | 2D Matrix | Electronics, logistics, small-item marking |
| **PDF417** | 2D Stacked | Boarding passes, government IDs, shipping labels |
| **Code 128** | 1D Linear | Packaging, shipping, inventory tracking |
| **Code 39** | 1D Linear | Automotive, defense, industrial inventory |
| **Code 93** | 1D Linear | Postal services, high-density inventory |
| **EAN-13** | 1D Linear | Global retail product numbering |
| **EAN-8** | 1D Linear | Compact retail packaging |
| **UPC-A** | 1D Linear | North American retail products |
| **UPC-E** | 1D Linear | Small North American retail packages |

---

## 📚 Detailed Feature Reference

Everything the app does today, in plain words. (This section was `docs/features.md`, merged here on 2026-10-12.)

### What this app is

SreerajP QR Studio is an Android-only, offline-first Flutter app for
scanning QR codes and barcodes. It is primarily a privacy-first **reader** and
barcode security analyzer. It can also make codes: the CodeForge tab builds
QR codes and barcodes (text, links, Wi-Fi, contacts, UPI, SMS, email,
location) with a style editor, and the AirQR transmitter turns text into
animated QR code sequences (5–25 FPS) for optical transmission. Beyond plain decoding, every scanned link is checked for safety against
phishing and fake sites using a 6-layer check, and the user can preview the
destination page itself in a safe, script-disabled sandbox before ever
opening it. For links and payment codes scanned with the camera, it also reminds the
user to check for a fake sticker glued over the real code. It also understands "smart" QR
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

### Core scanning

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

### URL safety and anti-phishing (6-layer check)

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
  line each. The sandbox preview and the Quishing Guard sticker check card
  also start folded.
- The Open button follows the risk: normal when safe, amber with a warning
  sign for a warning, and outlined red for danger. A confirm step always
  comes before a link is opened.

---

### Zero-trust link preview (sandboxed page preview)

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

### Quishing Guard — fake sticker check

Reminds the user to check a printed QR code for a fake sticker glued over
the real one (a real-world "quishing" attack).

- Shown on the result screen for links and payment codes scanned with the
  camera. Not shown for photos, the clipboard, screen scans or plain text.
- Lists simple hand checks: feel for raised sticker edges, check the payee
  name before paying, ask staff or type the address yourself.
- The app does not analyse the camera image for stickers and gives no score.
  Spotting a well-made sticker reliably from a phone camera is not possible
  today, so the app does not pretend to.

---

### StegoQR — hidden, locked QR content

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

### Smart payload actions

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

### Scan history

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

### AirQR — optical data transfer (no network needed)

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

### CodeForge — code generator

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

### AR CodeVision — live multi-code camera view

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

### Appearance and settings

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

### Security and privacy

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

### Key technical facts

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

---

## 🏗️ Architecture & Engineering Standards

The codebase strictly follows a **Tier 1 Layer-First** directory layout:

```
lib/
├── core/
│   ├── config/             # Typed AppConfig & ConfigService loader, AppFlavorConfig
│   ├── errors/             # Global error handlers
│   ├── logging/            # AppLogger
│   └── constants/          # Technical constants & build metadata
├── l10n/
│   ├── app_en.arb          # English ARB template (source of truth)
│   ├── app_ml.arb          # Malayalam ARB translation
│   ├── app_sa.arb          # Sanskrit ARB translation
│   ├── fallback_localizations.dart # Framework fallback delegates (sa)
│   └── formatting_locale.dart # formattingLocale() for intl
├── models/                 # Immutable domain value objects (const constructors)
├── providers/              # ChangeNotifier state handlers (Provider architecture)
├── screens/                # Presentational UI screens & dialogs
├── services/               # Stateless business logic, cryptography, SQLite
├── widgets/                # Reusable UI components & MadeWithLove footer
└── main.dart               # Entry point, Provider tree, dynamic color & routes
```

### Architectural Principles:
- **Dependency Flow**: `screens → providers → services → models`.
- **Stateless Services**: Services never depend on `BuildContext`, UI strings, or navigation routes.
- **Immutable Models**: Domain models use `const` constructors and never mutate in place.
- **Provider Only**: State management is handled exclusively via `package:provider` (`ChangeNotifier`).

---

## 🔒 Security & Privacy Architecture

- **Offline-First**: Scanning, decoding, QuishingGuard™, StegoQR, AirQR, and database storage operate 100% offline.
- **Hardware-Backed Key Storage**: The optional Google Safe Browsing API key is stored strictly within `flutter_secure_storage` (Android Keystore / EncryptedSharedPreferences).
- **Anti-Fingerprinting**: When Active Online Probing is enabled, outbound requests strip identifying browser user agents.
- **No Cloud, No Analytics**: Zero tracking SDKs, zero crash reporting telemetry, zero advertising libraries.
- **Backup Protection**: `android:allowBackup="false"` prevents database or secret leakage via Android system backups.
- **Permission on Demand**: Camera, biometric, and storage permissions are requested strictly at point of use.

---

## 🚀 Getting Started

### Prerequisites
- **Flutter SDK**: `>=3.47.6`
- **Dart SDK**: `>=3.13.5 <4.0.0`
- **Android SDK**: `minSdk 24`, `compileSdk 37`, `targetSdk 36`
- Android Studio / VS Code with Flutter extension

### Installation & Setup

1. **Clone the repository**:
   ```bash
   git clone https://github.com/sreerajp80/sreerajp_qr_studio.git
   cd sreerajp_qr_studio
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Verify environment**:
   ```bash
   flutter doctor
   ```

4. **Run development build**:
   ```bash
   flutter run --flavor dev
   ```

---

## 🛠️ Build & Release Commands

### Development & Validation
```bash
# Static analysis (must be 0 warnings)
flutter analyze

# Run complete unit and widget test suite
flutter test

# Format code to standard
dart format .

# Regenerate localizations after editing ARB files
flutter gen-l10n
```

### Production Builds
```bash
# Build release APK (split per ABI for optimal size)
flutter build apk --flavor prod --release \
  --obfuscate --split-debug-info=build/symbols/android-prod-<version>/ --split-per-abi

# Build Play Store App Bundle (AAB)
flutter build appbundle --flavor prod --release \
  --obfuscate --split-debug-info=build/symbols/android-prod-<version>/
```

`<version>` is the full `pubspec.yaml` version (e.g. `4.1.0+34`), so symbols from different
releases never collide.

### Build Flavors

| Flavor | Application ID | Display Name | Signing |
| :--- | :--- | :--- | :--- |
| **`dev`** | `in.sreerajp.qr_studio.dev` | `SreerajP QR Studio Dev` | Automatic Debug Keystore |
| **`prod`** | `in.sreerajp.qr_studio` | `SreerajP QR Studio` | Release Keystore (`android/key.properties`) |

---

## 👥 Credits & Acknowledgments

- **Author**: Sreeraj P ([sreerajp@zohomail.in](mailto:sreerajp@zohomail.in))
- **AI Coding Assistance**: Anthropic Claude, Gemini 3.6, ChatGPT 5.4
- **IDEs**: VS Code / Gemini Antigravity IDE
- **Barcode Engine**: the app's own decoder built on [zxing-cpp](https://github.com/zxing-cpp/zxing-cpp) v3.1.1 (Apache-2.0), vendored in `native/` and called through dart:ffi. No Google ML Kit and no scanner telemetry.
- **Core Open-Source Libraries**: `camera`, `ffi`, `provider`, `dynamic_color`, `qr_flutter`, `encrypt`, `pointycastle`, `sqflite`, `local_auth`, `url_launcher`, `share_plus`, `pdfx`, `pdf`, `receive_sharing_intent`, `permission_handler`.

---

## 📝 Changelog

Release history: [CHANGELOG.md](CHANGELOG.md).

---

## 📄 License

This project is open source. All third-party libraries and dependencies used in this project are distributed under permissive open-source licenses (MIT, Apache 2.0, BSD-3-Clause).

---

<div align="center">

**Made with ❤️ from India**

</div>