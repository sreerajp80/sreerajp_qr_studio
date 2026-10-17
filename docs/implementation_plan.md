# Implementation Plan — SreerajP QR Studio

This document outlines the phase-by-phase build roadmap and implementation targets for SreerajP QR Studio. Read this to understand current development objectives.

**Date:** 2026-07-31 (status updated 2026-10-10; roadmap records added 2026-10-12)

> This is the early build roadmap, kept as history. For what the app does
> today see the "Detailed Feature Reference" in [README.md](../README.md); for later
> work see the dated files in `plans/` and `change_log/`. Sections 4 and 5 are dated
> roadmap records merged in from two former docs; they are not kept current.

**Read first:**
- [CLAUDE.md](../CLAUDE.md)
- [architecture.md](architecture.md)
- [workflow_rules.md](workflow_rules.md)

---

## 1. Phase 1: Core Scanning and URL Safety Engine (Completed)

- **Objective:** Build robust QR/barcode scanner with multi-heuristic URL safety verification.
- **Action Steps:**
  - Implement camera scanning in `ScannerScreen` (first with `mobile_scanner`; replaced on 2026-09-28 by the app's own zxing-cpp decoder — see `change_log/20260928_120846_replace_mlkit_with_own_zxing_decoder.md`).
  - Implement 6-layer URL safety engine in `UrlSafetyService` (SSL, Redirects, Phishing, Shorteners, Homographs, Google Safe Browsing).
  - Implement `ScanProvider` state management using Provider.
  - Implement secure storage for Google Safe Browsing API key via `flutter_secure_storage`.

---

## 2. Phase 2: Standards & Guidelines Compliance (Completed)

- **Objective:** Align application documentation, structure, and configuration strictly with shared Flutter Guidelines.
- **Action Steps:**
  - Add `docs/guidelines` submodule (`https://github.com/sreerajp80/Flutter_Guidelines`).
  - Create complete baseline doc suite (`workflow_rules.md`, `dependencies.md`, `project_structure.md`, `architecture.md`, `security.md`, `release_process.md`, `implementation_plan.md`, `implementation_progress.md`).
  - Update root `CLAUDE.md` to follow Thin profile canonical section order.
  - Standardize build flavor configurations (`dev` and `prod`).

---

## 3. Phase 3: Testing & UI Refinement (Completed)

- **Objective:** Expand test coverage and refine Material Design 3 user experience.
- **Action Steps:**
  - Add widget tests for `ScannerScreen`, `ResultScreen`, and `SettingsScreen` (done; every top-level screen has a widget test since 2026-10-10).
  - Implement scan history screen (done: encrypted history with search, filters, export and backup).
  - Enhance visual feedback and accessibility semantics.

---

## 4. Roadmap Record: Feature Analysis And Innovation Roadmap

**Date:** written at app version 1.4.3+1 (before 2026-09); merged here on 2026-10-12 from `docs/feature_analysis_and_roadmap.md`.
**Scope:** feature assessment, improvement ideas and the five headline features, with their status at that time. Point-in-time record — not updated.

### Executive Summary

**SreerajP QR Studio** is a high-performance Android QR and Barcode scanner application built with Flutter, focused on real-time scanning, URL safety inspection, clipboard integration, and clean Material 3 UI design.

When this analysis was written (app version v1.4.3+1), the app provided solid foundation scanning with **10 supported barcode formats** and a multi-heuristic **UrlSafetyService**, the modern mobile utilities landscape demands richer utility, enhanced safety against physical/digital attacks, offline data sovereignty, and advanced productivity features.

This document presents a comprehensive, multi-phase engineering analysis of the project. It outlines:
1. A thorough code & feature assessment of the existing codebase.
2. Concrete **improvements and enhancements to existing features**.
3. Five **groundbreaking, world's-first innovative features** non-existent in any Android scanner app today.
4. A structured **implementation roadmap** and architectural recommendations.

---

### 1. Existing Codebase & Architecture Assessment

#### 1.1 Current Capabilities
* **Scanning Engine**: The app's own decoder: vendored zxing-cpp v3.1.1 (Apache-2.0) called through dart:ffi, with the `camera` plugin for frames. No Google ML Kit. The live scanner reads 10 formats (`qrCode`, `code128`, `code39`, `code93`, `ean8`, `ean13`, `upcA`, `upcE`, `pdf417`, `dataMatrix`); gallery/PDF scans also read Aztec, Micro QR, rMQR, MaxiCode, Codabar, ITF and DataBar.
* **URL Safety Engine**: `UrlSafetyService` executes local heuristic checks (SSL requirement, IP format detection, domain risk patterns, top URL shorteners, homograph attack detection) and supports online active probing via Google Safe Browsing API key stored securely in `flutter_secure_storage`.
* **State Management**: `ScanProvider` manages current scan string, barcode type, URL detection state, and safety evaluation results using Provider pattern.
* **Basic Actions**: Copy raw string to clipboard, open detected URLs via `url_launcher`, share raw text via `share_plus`.

#### 1.2 Identified Technical & Feature Gaps
| Category | Current State | Missing Capability / Limitation |
| :--- | :--- | :--- |
| **Scan Persistence** | Memory-only in `ScanProvider` | Scanned data is lost when navigating back or closing app; no search, history, or export. |
| **Camera Controls** | Static scanning view | No torch/flashlight toggle, no pinch-to-zoom, no front/rear camera flip, no touch-to-focus. |
| **Input Sources** | Camera live stream only | Cannot select image from gallery, scan PDF pages, or scan images shared from other apps. |
| **Payload Actionability**| Generic URL / Raw Text | Lacks smart parsers for WiFi, vCard/MeCard contacts, iCal events, Geo maps, OTP secrets, or UPI payments. |
| **Theme & UX** | Static light blue theme | No Dark Mode, OLED Black, dynamic Android Material You (Monet) theme support, or haptic/sound feedback. |
| **Batch Processing** | Single item scan | Immediately navigates away after 1 code; cannot batch scan inventory or multiple codes continuously. |

---

### 2. Improvements & Enhancements to Existing Features

```
                                  +---------------------------------------+
                                  |    SREERAJP QR STUDIO ENHANCEMENTS    |
                                  +---------------------------------------+
                                                      |
         +--------------------+-----------------------+-----------------------+--------------------+
         |                    |                       |                       |                    |
  +--------------+    +---------------+       +---------------+       +---------------+    +---------------+
  | Camera & UX  |    | Smart Payload |       |  Persistent   |       | Gallery & File|    | URL Safety    |
  | Control Suite|    |  Actioning    |       | Scan History  |       | Scanning      |    | Sandbox       |
  +--------------+    +---------------+       +---------------+       +---------------+    +---------------+
```

#### 2.1 Camera & Viewport Controls Suite ✅ [COMPLETED]
* **Flashlight / Torch Toggle**: Add floating button on `ScannerScreen` with native camera flash state binding (`controller.toggleTorch()`).
* **Camera Flip**: Toggle between back and front camera for scanning codes displayed on external displays or badges (`controller.switchCamera()`).
* **Pinch-to-Zoom & Zoom Slider**: Implement visual zoom bar (1.0x to 8.0x) allowing distance scanning of small QR codes on billboards or tall shelves.
* **Haptic & Audible Feedback**: Provide user configurable vibration pulses and customizable scan beep sounds upon successful code recognition.
* **Animated Frame & Focus Box**: Enhance fixed 250x250 scanning overlay with dynamic auto-resizing bounding boxes around detected barcodes in real time.

#### 2.2 Smart Payload Action Engine ✅ [COMPLETED]
Instead of displaying raw string text, automatically detect and parse standard payload schemas with dedicated action cards:
* **Wi-Fi QR (`WIFI:S:SSID;T:WPA;P:password;;`)**: Display network name, security type, hide/show password, and a **"Connect to Wi-Fi"** 1-tap button using Android `wifi_iot` / native network request API.
* **Contact Card (`vCard` / `MeCard`)**: Render structured contact avatar, name, phones, emails, address, with a **"Save to Contacts"** button (`flutter_contacts` / native intent).
* **Geographic Location (`geo:latitude,longitude`)**: Render interactive map snippet preview with a **"Navigate in Google Maps"** action button.
* **Calendar Event (`BEGIN:VEVENT ...`)**: Show event title, start/end time, location, and a **"Add to Device Calendar"** button (`add_2_calendar`).
* **Payment Code (`upi://pay`, `SEPA`, `Crypto`)**: Show merchant name, amount, transaction ID, and a **"Pay via App"** button (GPay, PhonePe, Paytm, Banking app).
* **Two-Factor Authentication (`otpauth://totp/`)**: Extract secret key, issuer, account name, and provide **"Import into Authenticator"** or live 30-second TOTP token generator card.

#### 2.3 Comprehensive Persistent History & Database ✅ [COMPLETED]
* **Local Database Integration**: Store all scan records locally using encrypted SQLite / `isar` / `hive`.
* **Rich Metadata**: Save timestamp, barcode format, scanned image thumbnail, location tag (optional), safety check score, and custom user notes.
* **Categorization & Search**: Filter history by type (URLs, Wi-Fi, Contacts, Text, Barcodes), star favorite scans, and perform full-text search.
* **Export & Import**: Export history to **CSV, JSON, formatted TXT, or PDF report**, and support cloud backup/restore via encrypted local backup file.

#### 2.4 Gallery & File Media Scanning ✅ [COMPLETED]
* **Gallery Image Picker**: Add a "Scan Image" button allowing users to pick photos from Android Gallery / Photos app (`image_picker`).
* **Multi-Page PDF Scanning**: Allow users to select a PDF document, extract pages, and scan for embedded QR/barcodes automatically.
* **Android System Share Sheet Target**: Register app as a native Android "Share to..." receiver so users can share images directly from web browsers or messaging apps to SreerajP QR Studio.

#### 2.5 Modern Material You (M3) & Dark Theme Engine ✅ [COMPLETED]
* **Material You Dynamic Colors**: Dynamically sample system wallpaper colors on Android 12+ (Monet engine) for a personalized UI.
* **True OLED Dark Mode**: Pure black theme option optimized for AMOLED screens to conserve battery during continuous camera usage.
* **Customizable Scan Overlay**: Allow users to choose scanner frame styles (laser line, pulsing corners, cybernetic grid, subtle dot matrix).

---

### 3. World-First Innovative Features (Unmatched in Android QR Apps)

The following 5 features **do not exist in any mainstream Android QR reader application** on the Google Play Store today. Incorporating them will elevate SreerajP QR Studio to an industry-defining benchmark.

```
+---------------------------------------------------------------------------------------------------------+
|                                    WORLD-FIRST NOVEL FEATURES MATRIX                                    |
+-------------------+--------------------------------------------------+----------------------------------+
| Feature Name      | Technical Concept                                | Competitive Edge                 |
+-------------------+--------------------------------------------------+----------------------------------+
| 1. StegoQR        | Biometric-Locked Steganographic Encrypted QR     | Invisible hidden payload inside  |
|                   | reader engine with decoy text layer              | ordinary decoy QR codes.         |
+-------------------+--------------------------------------------------+----------------------------------+
| 2. QuishingGuard  | Physical Print & Sticker Tamper Analyzer         | Detects physical QR sticker      |
|                   | using edge blur, texture noise & reflection ML   | overwrites on public posters.    |
+-------------------+--------------------------------------------------+----------------------------------+
| 3. AirQR          | High-Speed Optical Air-Gap Stream Reader         | Receives files via camera from   |
|                   | using fountain-coded animated QR stream receiver | animated QR code streams offline.|
+-------------------+--------------------------------------------------+----------------------------------+
| 4. AR CodeVision  | 3D Spatial Multi-Target Camera HUD               | Real-time floating M3 chip       |
|                   | anchoring over ALL visible codes simultaneously  | tags over warehouse/store codes. |
+-------------------+--------------------------------------------------+----------------------------------+
| 5. Zero-Trust DOM | Sandboxed Headless HTML Pre-Render Previewer     | Renders safe visual preview      |
| Sandbox           | with JS disabling and tracking pixel isolation  | before user clicks open link.    |
+-------------------+--------------------------------------------------+----------------------------------+
```

#### 3.1 Feature 1: StegoQR — Biometric-Locked Encrypted Steganographic QR System ✅ [COMPLETED - Reader Engine]

##### What It Is:
A dual-layer QR reading and decryption engine that detects and extracts secret AES-256 encrypted payloads embedded inside standard, readable QR codes.

##### How It Works:
* **The Decoy Layer**: When scanned by any standard QR reader (Google Lens, Samsung Camera, basic scanner), the QR code displays an innocent public text (e.g., `"Scan to view lunch menu"` or `"Visit website for info"`).
* **The Steganographic Encrypted Layer**: Hidden within lower-order matrix bits or payload padding of the QR code is an AES-256-GCM encrypted secret payload (e.g., confidential passcodes, private keys, secret contact info).
* **The SreerajP QR Studio Advantage**: When scanned by SreerajP QR Studio, the app detects the StegoQR signature header. It prompts for biometric authentication (Fingerprint / Face Unlock via `local_auth`) or passphrase, decrypts the payload, and displays the secret content seamlessly.

##### Why It's Unique:
No mobile QR app combines dual-layer steganography with biometric authorization. It provides physical security against shoulder surfing and unauthorized scanning.

---

#### 3.2 Feature 2: QuishingGuard — Physical Print & Sticker Tamper Detector ✅ [COMPLETED]

##### What It Is:
An on-device computer vision engine designed specifically to detect **"Quishing"** (QR Phishing via physical malicious sticker overlays placed over legitimate public posters, parking meters, or restaurant tables).

##### How It Works:
1. **Edge & Boundary Discontinuity Analysis**: When framing a QR code, the camera analyzes edge reflection profiles and boundary depth discontinuities. Physical stickers stuck on top of glossy posters exhibit double edges and micro-shadow lines around the matrix perimeter.
2. **Texture & Print Grain Analysis**: Analyzes print DPI micro-patterns. Real printed posters have consistent halftone dot density; overlay stickers printed on desktop inkjet/thermal printers exhibit mismatching grain noise and color chromatic aberration.
3. **Quishing Alert Index**: Displays a real-time risk bar:
   * 🟢 *Authentic Printed Code*
   * 🟡 *Wear & Tear Detected*
   * 🔴 *High Warning: Physical Overlay Sticker Detected! Verify Before Tapping Links.*

##### Why It's Unique:
Existing scanners only check the URL string *after* decoding. QuishingGuard is the **world's first camera-level physical tampering detection tool** for QR codes.

---

#### 3.3 Feature 3: AirQR — High-Speed Optical Air-Gap Stream Reader ✅ [COMPLETED]

##### What It Is:
An offline optical data receiving engine that captures and reassembles large text blocks, contact lists, encrypted notes, or small file backups from continuous animated QR code streams (Fountain Codes / Raptor Codes) without Bluetooth, Wi-Fi, NFC, or cellular data.

##### How It Works:
* **Optical Stream Receiver Mode**: The SreerajP QR Studio camera points at an animated QR stream playing on an external screen or device.
* **Frame Decoding & Reassembly**: The custom frame decoder captures 256-byte chunks in any sequence order, applies forward error correction (RS-EC / Fountain code decoding) to recover missing frames, and automatically reassembles the complete payload offline.

##### Why It's Unique:
Completely immune to network sniffing, RF interference, cellular blackouts, or air-gapped security restrictions. Enables secure optical phone-to-phone data ingestion without wireless pairing.

---

#### 3.4 Feature 4: AR CodeVision — Spatial Multi-Target Real-Time Camera HUD ✅ [COMPLETED]

##### What It Is:
An Augmented Reality (AR) live viewport that scans and anchors interactive 3D Material M3 floating chips over **every visible barcode and QR code simultaneously** in camera frame.

##### How It Works:
* Instead of capturing 1 code and pausing the scanner screen, AR CodeVision continuously tracks multiple bounding boxes across the video frame.
* Anchors interactive floating tags over each item:
  * **Warehouse / Store Mode**: Shows price tags, barcode format, and instant batch select checkboxes.
  * **Safety HUD Mode**: Displays green shield or red warning badge above each URL link floating in physical space.
* Tapping any floating tag in 3D camera space expands its action sheet without stopping live preview.

##### Why It's Unique:
Traditional apps freeze camera and navigate away on the first code encountered. AR CodeVision brings spatial computing UX to everyday barcode scanning.

---

#### 3.5 Feature 5: Zero-Trust Sandboxed HTML Pre-Render Previewer ✅ [COMPLETED]

##### What It Is:
An isolated off-screen sandbox renderer that generates a static visual preview screenshot of web URLs scanned from QR codes **before** opening them in the device browser.

##### How It Works:
1. When a URL QR code is scanned, SreerajP QR Studio fetches the destination HTML header and DOM hierarchy using a headless, script-disabled sandbox socket.
2. It blocks execution of tracking scripts, automatic downloads, popups, and malicious redirects.
3. Renders an instant **Sanitized Visual Thumbnail Preview** on `ResultScreen`, allowing the user to view the actual target site visual layout before tapping "Open in Browser".
4. Checks domain age, SSL certificate validity, open redirect traps, and WHOIS domain creation date.

##### Why It's Unique:
Prevents drive-by downloads, IP logger grabs, and zero-click mobile web exploits triggered by opening suspicious QR links blind.

---

### 4. Comprehensive Feature Comparison Table

| Feature Dimension | Standard Android QR Apps | SreerajP QR Studio (Planned V2) |
| :--- | :--- | :--- |
| **Basic QR & Barcode Scanning** | ✅ Yes | ✅ Enhanced with 10 Formats |
| **Camera Controls (Torch/Zoom)** | ⚠️ Basic or None | ✅ Full Control Bar & Multi-Touch Zoom |
| **Persistent Scan History** | ⚠️ Unencrypted Plain Text | ✅ Encrypted SQLite Database with Tagging & Export |
| **Smart Action Parsers** | ⚠️ URLs only | ✅ Wi-Fi, vCard, Geo, Event, OTP 2FA, UPI Payments |
| **Gallery & PDF Scanning** | ⚠️ Basic Gallery Pick | ✅ **Multi-Page PDF & Image Stream Scanning** (Completed) |
| **Steganographic Encrypted QR** | ❌ None | ✅ **StegoQR Reader** (Dual-Layer Biometric Encryption - Completed) |
| **Physical Sticker Tamper Detection**| ❌ None | ✅ **QuishingGuard** (CV Physical Overlay Analyzer - Completed) |
| **Optical Air-Gap Stream Reader**| ❌ None | ✅ **AirQR** (Fountain-Coded Optical Stream Receiver - Completed) |
| **Spatial AR Continuous Multi-HUD**| ❌ Single-code lock only | ✅ **AR CodeVision** (Real-Time 3D Tag Anchoring - Completed) |
| **Zero-Trust Pre-Render Preview** | ❌ None (Direct Browser Launch)| ✅ **DOM Sandbox** (Script-Free Visual Preview - Completed) |

---

### 5. Implementation Architecture & Phased Roadmap

```
+-----------------------------------------------------------------------------------+
|                            DEVELOPMENT ROADMAP PHASES                             |
+-----------------------------------------------------------------------------------+
|                                                                                   |
|  [PHASE 1: Core UX & Utilities] -----------------------------------> [Target: Q1] |
|  * Camera Torch, Zoom, Flip controls in scanner_screen.dart [COMPLETED]                       |
|  * Scan History with local Isar/SQLite storage & CSV/JSON export                  |
|  * Gallery Image Picker & System Share Target integration [COMPLETED]                         |
|  * Material You Dynamic Theme & OLED Dark Mode support                            |
|                                                                                   |
|  [PHASE 2: Smart Payload Actions & Safety Sandbox] --------------> [Target: Q2] |
|  * Wi-Fi 1-tap connect, vCard contact parser, iCal event handler [COMPLETED]      |
|  * OTP 2FA secret parser & live token preview card [COMPLETED]                    |
|  * Sandboxed HTML Pre-Render Previewer in result_screen.dart [COMPLETED]          |
|  * Domain age, SSL certificate details & WHOIS safety checker [COMPLETED]         |
|                                                                                   |
|  [PHASE 3: StegoQR Reader & AR CodeVision] -----------------------> [Target: Q3] |
|  * StegoQR Dual-Layer AES-256 Reader Engine with local_auth [COMPLETED]           |
|  * AR CodeVision 3D Bounding Box Tracking & Floating M3 Chips [COMPLETED]           |
|                                                                                   |
|  [PHASE 4: QuishingGuard & AirQR Stream Receiver] ----------------> [Target: Q4] |
|  * QuishingGuard Computer Vision Edge & Sticker Tamper Analyzer [COMPLETED]        |
|  * AirQR Optical Fountain-Code Animated Stream Receiver Engine [COMPLETED]          |
|                                                                                   |
+-----------------------------------------------------------------------------------+
```

---

### 6. Conclusion & Strategic Value

By combining essential core scanner improvements (persistent storage, camera suite, smart action parsers, gallery scanning) with **groundbreaking innovations like StegoQR, QuishingGuard, AirQR, AR CodeVision, and Sandboxed HTML Pre-rendering**, SreerajP QR Studio will transcend standard scanning tools.

It positions the application as a **next-generation security, privacy, and spatial productivity platform** for Android, setting a new benchmark for mobile QR scanning applications worldwide.

---

## 5. Roadmap Record: Feature Improvements And New Features

**Date:** 2026-09-14; merged here on 2026-10-12 from `docs/feature_improvements_and_roadmap.md`.
**Scope:** improvement ideas per area, new feature ideas, priority matrix. Point-in-time record — not updated.

### 1. Current Feature Inventory

Before listing improvements, here is what the app already includes:

| Category           | Features                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| ------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Core Scanning      | Multi-format barcode engine (QR, EAN-13, EAN-8, UPC-A, UPC-E, Code 128, Code 39, Code 93, Data Matrix, Aztec, PDF417), gallery image & multi-page PDF ingestion, Android Share Sheet target, camera controls (pinch-to-zoom 1.0x–8.0x, front/rear flip, Full HD / Max 4K / HD resolution presets, 3-state flash with ambient light lux sensor, live Skia brightness & contrast adjustment sliders, negative/inverted barcode scanning mode, tap-to-focus with exposure reticle), 4 animated scan overlay styles, haptic and audio feedback                                                                        |
| URL Safety         | 6-layer offline/online analysis (Protocol Guard, Homograph Shield, TLD Entropy, IP/Port Flagging, HEAD Probing, Google Safe Browsing API), private mode by default with active online probing toggle, anti-fingerprinting request headers                                                                                                                                                                                                                                                                                                                                                                         |
| Zero-Trust Preview | DOM Sandbox page preview stripping scripts, frames, and tracking pixels; open redirect detection; WHOIS/RDAP domain age check                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| Advanced Vision    | QuishingGuard physical tamper detection (tell-tale edge/shadow/grain analysis), AR CodeVision multi-code HUD with Warehouse and Safety tracking modes, AirQR optical air-gap data transfer (transmitter with animated QR streams & receiver with frame reassembly), StegoQR steganographic scanner with AES-256 GCM encryption and biometric gating                                                                                                                                                                                                                                                               |
| Smart Payloads     | 12 recognized payload types with dedicated action cards: Wi-Fi (1-tap native network suggestion / direct connect via Android platform channel with settings fallback), Contact cards (vCard & MeCard), Geo locations (Google Maps intent), Calendar events (Google Calendar & system intent), Payments (UPI, SEPA, Crypto), TOTP 2FA (live countdown token generator), Email (`mailto:`, `MATMSG:`), Phone (`tel:`), SMS (`sms:`, `smsto:`), App Links (Play Store, WhatsApp, Telegram, YouTube with branded cards), Product Barcodes (Open Food Facts & Google Search), ISBN books (Google Books & Open Library) |
| History & Privacy  | Encrypted SQLite database (`sqflite`), search, category filters, favorite star flag, CSV/JSON/TXT export, branded PDF report generation, encrypted `.sreerajqr` backup and restore, 100% offline-first, zero analytics, zero crash SDKs, zero cloud sync                                                                                                                                                                                                                                                                                                                                                          |
| Appearance         | Material 3 themes (System, Light, Dark, true OLED pure-black), dynamic color (Material You wallpaper extraction), 4 scan overlays, typography settings                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| Help & Settings    | Dedicated guide screens for all major security and vision features, plain-English permissions breakdown screen, about metadata with "Made with ❤️ from India" footer                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| Localization       | Full tri-lingual localization across English (`en`), Malayalam (`ml`), and Sanskrit (`sa`) with 100% ARB key parity (632 keys each), custom Sanskrit framework fallback delegates, in-app interactive language switcher in Settings, and Malayalam/Devanagari font fallbacks                                                                                                                                                                                                                                                                                                                                      |

---

### 2. Improvements to Existing Features

#### 2.1 Scanner Screen

| #     | Improvement                                       | Current State                                                                                                          | Proposed Change                                                                                                                                                                                             | Impact                                                                                     | Priority       |
| ----- | ------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------ | -------------- |
| 2.1.1 | **Continuous Batch Scan Mode**                    | Implemented (`BatchScanProvider` + floating counter badge + `BatchReviewSheet` with 6-layer URL safety & batch export) | Toggle for continuous scanning queues multiple codes into a list without leaving the camera viewport, shows floating counter badge, batch list review, and CSV/JSON/TXT/PDF export with 6-layer URL safety. | High — warehouse workers and professionals scanning inventory need this.                   | ✅  Implemented |
| 2.1.2 | **Distance-Enhanced Scanning Pipeline**           | Implemented (`DistanceEnhancementService` + ROI cropping, bilinear digital zoom, contrast boost, unsharp masking, camera zoom & Viewport controls) | Pure-Dart digital zoom-crop-enhance pipeline that extracts candidate regions of interest, applies bilinear upscaling and high-pass unsharp masking, uses the app's own camera zoom control (`camera` plugin), and provides a multi-scale fallback for distant photos. | Medium — accessibility improvement for physically distant codes (posters, overhead signs). | ✅  Implemented |
| 2.1.3 | **Scan From Clipboard**                           | Implemented (`ClipboardScanService` + native Android clipboard bridge + quick-action detection pill & AppBar button)   | Detect if system clipboard contains an image, URL, or raw barcode payload and offer a quick "Scan from Clipboard" button on the scanner screen.                                                             | Medium — fast workflow for links or images copied in messaging apps.                       | ✅  Implemented |
| 2.1.4 | **Multi-Code Tappable Selection on Main Scanner** | Implemented (`MultiCodeSelectionProvider` + `MultiCodeService` + bounding box overlay & hint banner + CameraAdjustments toggle) | Outline all visible barcodes in the main camera view with subtle bounding boxes and let the user tap which specific code to inspect. | Medium — eliminates scan errors when multiple QR codes are printed close together. | ✅  Implemented |

#### 2.2 URL Safety Engine

| #     | Improvement                             | Current State                              | Proposed Change                                                                                                                                                                 | Impact                                                                          | Priority |
| ----- | --------------------------------------- | ------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- | -------- |
| 2.2.1 | **Safety Score Summary Badge**          | Individual check results shown as a list   | Add an aggregated overall safety score (0–100) with a colour-coded badge (green/amber/red) at the top of the result screen combining all 6 layers into one intuitive indicator. | High — instant visual clarity for non-technical users.                          | 🔴 High   |
| 2.2.2 | **Redirect Chain Flowchart**            | Text-based redirect hops from HEAD probing | Render redirect chains as an interactive visual flowchart (Origin → Intermediate Hop → Final Destination) with safety badges at each node.                                      | Medium — makes hidden redirect and open-redirect attacks clear and educational. | 🟡 Medium |
| 2.2.3 | **Local Threat Hash Prefix Cache**      | Online-only Google Safe Browsing API check | Cache Safe Browsing threat hash prefixes locally (with periodic opt-in sync) so lookups work even when offline.                                                                 | High — strengthens the offline-first security promise.                          | 🔴 High   |
| 2.2.4 | **Custom Domain Allowlist / Blocklist** | No user-defined domain rules               | Let users add domains to a personal blocklist or allowlist. Blocked domains show an immediate alert. Allowed domains bypass active probing.                                     | Low — useful for power users and enterprise testing.                            | 🟢 Low    |

#### 2.3 QuishingGuard

| #     | Improvement                      | Current State                             | Proposed Change                                                                                                                                  | Impact                                                                                      | Priority |
| ----- | -------------------------------- | ----------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------- | -------- |
| 2.3.1 | **Quishing Risk Trend Analysis** | Point-in-time score per scan              | Track quishing risk scores over time in history. Warn users if a specific merchant or location frequently presents suspicious physical overlays. | Low — informational awareness.                                                              | 🟢 Low    |
| 2.3.2 | **Forensic Evidence Capture**    | In-memory frame analysis; no image stored | Offer an optional button to save the captured camera frame alongside the tamper forensic breakdown for scam reporting.                           | Medium — helpful for reporting fraudulent stickers on parking meters and payment terminals. | 🟡 Medium |

#### 2.4 Smart Payloads & Actions

| #     | Improvement                              | Current State                                                      | Proposed Change                                                                                                                                         | Impact                                                                            | Priority      |
| ----- | ---------------------------------------- | ------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------- | ------------- |
| 2.4.1 | **Direct Wi-Fi Suggestion API**          | Implemented via native MethodChannel (`in.sreerajp.qr_studio/wifi`) | Uses Android's `WifiNetworkSuggestion` / `ACTION_WIFI_ADD_NETWORKS` to connect to the scanned Wi-Fi network with 1 tap.                                 | High — instant network connection without leaving the app.                        | ✅ Implemented |
| 2.4.2 | **TOTP Cloud-Free Vault**                | Scans TOTP and displays live countdown card                        | Provide an encrypted local vault screen where users can store and manage multiple 2FA accounts, transforming the app into an offline authenticator.     | High — dual utility: secure scanner + privacy-first 2FA authenticator.            | 🔴 High        |
| 2.4.3 | **Rich Calendar Card & Timezone Picker** | Text preview with Google Calendar link                             | Display an interactive mini-calendar widget showing event start/end, recurrence rules, and a timezone selector.                                         | Medium — refined UX for business schedules.                                       | 🟡 Medium      |
| 2.4.4 | **Inline Product Nutrition & Details**   | `ProductBarcodeActionCard` with Open Food Facts and Google buttons | Fetch Open Food Facts data directly inside the card (product name, brand, image, Nutri-Score, allergens) with local caching, avoiding a browser detour. | Medium — high value for grocery and retail shoppers.                              | 🟡 Medium      |
| 2.4.5 | **App Links Expansion & Rich Metadata**  | Supports Play Store, YouTube, WhatsApp, Telegram                   | Expand parser to Instagram, Spotify, Amazon, and Twitter/X; show rich previews (video titles, playlist previews) before launching apps.                 | Medium — extends the existing deep linking capability to more everyday platforms. | 🟡 Medium      |

#### 2.5 History & Backup

| #     | Improvement                                 | Current State                                                                | Proposed Change                                                                                                                            | Impact                                                      | Priority    |
| ----- | ------------------------------------------- | ---------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------- | ----------- |
| 2.5.1 | **History Analytics Dashboard**             | List view with category chips and search                                     | Add a visual analytics dashboard: total scans, scan category distribution pie chart, safety score spread, and scan frequency timeline.     | Medium — visual insights into user scanning habits.         | 🟡 Medium    |
| 2.5.2 | **Scheduled Automated Backups**             | Manual export to JSON/CSV/PDF                                                | Allow users to schedule periodic automated encrypted backups (`.sreerajqr`) to a user-chosen folder via Android Storage Access Framework.  | Medium — seamless data protection with zero cloud reliance. | 🟡 Medium    |
| 2.5.3 | **AirQR Encrypted History & Settings Sync** | Implemented (`DeviceSyncService` + `AirQrTransmitterScreen` + `AirQrScreen`) | Beams encrypted scan history and application settings between phones air-gapped via animated QR fountain codes without networks or cables. | Low — niche but completely private air-gapped sync.         | ✅ Completed |

#### 2.6 Appearance & UX

| #     | Improvement                          | Current State                                                                                            | Proposed Change                                                                                                                                                | Impact                                                | Priority      |
| ----- | ------------------------------------ | -------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------- | ------------- |
| 2.6.1 | **Interactive Onboarding Carousel**  | Implemented (`OnboardingProvider` + `OnboardingScreen` with replay via Settings/Help)                    | Lightweight 3-slide introductory carousel on first launch explaining the 6-layer URL safety engine, QuishingGuard tamper detection, and offline privacy model. | High — boosts first impression and feature discovery. | ✅ Implemented |
| 2.6.2 | **Home Screen Quick-Scan Widget**    | App icon launch only                                                                                     | Provide Android home screen app widgets (1x1 quick scan trigger, 2x1 showing recent scan status) launching directly into the camera.                           | High — saves user time, promotes daily adoption.      | 🔴 High        |
| 2.6.3 | **Micro-Interaction Scan Feedback**  | Implemented (`ScanOverlayWidget` reticle pulse, checkmark morph & ripple, haptic/chime, settings toggle) | Add a polished micro-animation (subtle reticle pulse and checkmark morph) before transitioning to the result screen.                                           | Low — visual polish and tactile satisfaction.         | ✅ Implemented |
| 2.6.4 | **Dynamic Accessibility Adaptation** | Static typography settings                                                                               | Listen to system accessibility changes (font scale, high contrast, screen reader state) and adjust layout density automatically.                               | Medium — inclusive design adherence.                  | 🟡 Medium      |

---

### 3. New Unique Features

These features do not exist in the current app and represent greenfield capabilities designed to set SreerajP QR Studio apart.

#### 3.1 🏆 QR ThreatMap — Community Threat Intelligence Feed

**What:** An opt-in, privacy-preserving threat intelligence feed. When users encounter a verified phishing or malicious URL, they can submit an anonymous domain hash report. Other users scanning the same domain see a "Community Threat Alert" badge with report metrics.

**Why it stands out:** Transforms individual scans into collective security defense while preserving complete privacy (only truncated domain hashes are shared, never raw URLs or user identifiers).

**Architectural fit & constraints:**
- Requires an external API service or public blocklist source (e.g. periodically synchronizing an open-source threat feed like URLhaus/PhishTank).
- *Note on architecture:* Because the app is strictly serverless and client-only, this feature should be implemented as an **opt-in public threat feed subscription** (fetching verified open-source threat databases) rather than maintaining a custom centralized reporting server.

**Priority:** 🔴 High — category-defining security differentiator.

---

#### 3.2 🏆 VoiceGuard — Guided Audio-First Accessibility Mode

**What:** A comprehensive accessibility mode that announces scan results, threat levels, and action cards via text-to-speech. Includes audio-guided camera aiming ("move camera slightly higher... code detected") and distinct haptic vibration signatures for risk categories (single pulse = safe, rapid triple pulse = dangerous).

**Why it stands out:** No existing scanner combines directional audio aiming with threat-level haptic pulses, making the scanner independently usable by blind and low-vision users without relying entirely on TalkBack.

**Architectural fit:** New `VoiceGuardService` in `services/`, localized voice strings across English, Malayalam, and Sanskrit, uses `flutter_tts` or native Android TTS platform channel.

**Priority:** 🔴 High — accessibility is an engineering standard requirement.

---

#### 3.3 🏆 ScanLens AI — Heuristic & On-Device Intent Engine

**What:** Classifies the intent of scanned barcodes and presents plain-English contextual explanations: *"This QR code directs to a payment gateway requesting money — verify recipient"* or *"This link contains tracking parameters from an advertising campaign"*.

**Why it stands out:** Bridges raw decoded data and human understanding, explaining *what the code wants to do* before the user takes action.

**Architectural fit & constraints:**
- *Phase 1:* Implement as an offline, rule-based heuristic classifier inside `PayloadParserService` (pure Dart, zero binary bloat).
- *Phase 2 (Optional):* Lightweight on-device TensorFlow Lite model. *Note:* Must evaluate APK binary size impact (~30MB) and ensure compliance with split-APK builds.

**Priority:** 🟡 Medium — valuable user context; Phase 1 heuristic engine can be built with zero external dependencies.

---

#### 3.4 🏆 CodeForge — Standalone QR & Barcode Generator

**Status:** ✅ Implemented (v2.9.0)

**What:** A full-featured barcode generation suite. Users can generate QR codes, Barcodes (EAN-13, EAN-8, UPC-A, Code 128, Code 39, PDF417, Data Matrix), Wi-Fi logins, Contact vCards, UPI payment codes, plain text, SMS, Email, and Geo locations. Includes deep visual customization: eye corner shape (square, rounded, circle, leaf), inner eye pupil shape (square, rounded, circle, diamond), pattern dot shapes (square, dots, rounded, classy, diamond), solid/gradient color studio, custom error correction levels (L, M, Q, H), center badges, and export to PNG/SVG. Embedded as a dedicated primary root navigation tab.

**Why it stands out:** Turns the app from a pure scanner into a complete two-way utility. Generated codes can be pre-flight verified against the 6-layer URL safety engine and embedded with authenticity badges.

**Architectural fit:**
- Root `MainShellScreen` hosting persistent Material 3 `NavigationBar` with Scan, CodeForge, and History tabs.
- Domain models in `lib/models/code_forge_config.dart`, state management in `lib/providers/code_forge_provider.dart`, service in `lib/services/code_forge_service.dart`.
- Custom high-performance canvas painter in `lib/widgets/code_forge_qr_painter.dart` and `lib/widgets/code_forge_barcode_widget.dart`.
- Full tri-lingual key parity across English, Malayalam, and Sanskrit.

**Priority:** 🔴 High — highly requested utility that completes the product loop.

---

#### 3.5 🏆 GhostScan — Screen Content QR Detector

**What:** Detects and decodes QR codes visible on the phone screen (inside messaging apps, social media feeds, web pages, documents) without requiring the user to take a manual screenshot, open the gallery, and crop.

**Why it stands out:** Eliminates multi-step friction for scanning codes received on mobile screens.

**Architectural fit & constraints:**
- *Play Store Policy Consideration:* Using `SYSTEM_ALERT_WINDOW` or continuous MediaProjection triggers heavy Google Play security scrutiny.
- *Recommended compliant approach:* Integrate an Android Quick Settings tile / Quick Screenshot action that captures the current display on demand and feeds it into the existing `image_picker` / `MobileScannerController.analyzeImage()` pipeline.

**Priority:** 🟡 Medium — high utility, but implementation must strictly follow Google Play policy guidelines.

**Current State:** ✅ Implemented. Native Android `GhostScanTileService` (`TileService`) for Quick Settings, short-lived single-frame `GhostScanCaptureService` (`FOREGROUND_SERVICE_MEDIA_PROJECTION`), transparent `GhostScanActivity`, Dart `GhostScanService` platform channel, `GhostScanSheet` modal bottom sheet, and seamless `MobileScannerController.analyzeImage()` integration with 100% tri-lingual localization.

---

#### 3.6 🏆 TimeVault — Self-Destructing / Time-Locked QR Payloads

**What:** In conjunction with CodeForge, generate QR codes that self-expire after a set timestamp. Scanned by SreerajP QR Studio, the content is decrypted only if the device clock is prior to the expiration timestamp; otherwise, the app displays a friendly expiration notice.

**Why it stands out:** Privacy-centric temporary payload sharing for temporary Wi-Fi guest access, one-time coupons, or temporary event coordinates without requiring any cloud server.

**Architectural fit:** Extends `StegoQrService` and cryptographic models. Evaluated entirely offline via timestamp header verification.

**Priority:** 🟡 Medium — pairs naturally with CodeForge.

---

#### 3.7 🏆 ScanChain — Sequential Multi-Code Document Assembly

**What:** Reads a physical sequence of printed QR codes that together represent a large document or dataset exceeding the single-QR capacity limit. Shows a real-time progress HUD ("Part 3 of 8 captured") and reassembles the complete file when all segments are scanned.

**Why it stands out:** Brings AirQR's optical packet assembly to physical printed paper, enabling physical distribution of large text files or documents offline.

**Architectural fit:** New `ScanChainService` extending the block encoding algorithms of `AirQrService`.

**Priority:** 🟢 Low — specialized offline use case.

---

#### 3.8 🏆 TrustBadge — Cryptographic QR Authenticity Verification

**What:** Allows merchants and organizations to digitally sign their QR codes with an asymmetric private key. When scanned, SreerajP QR Studio verifies the digital signature using an embedded public key or local certificate, displaying a verified green "TrustBadge: Verified Authentic Merchant" certificate.

**Why it stands out:** Directly solves physical quishing and counterfeit payment QR stickers by providing cryptographic proof of code authenticity.

**Architectural fit:** Pure Dart digital signature verification using `pointycastle` (already an approved production dependency). Fully offline.

**Priority:** 🟡 Medium — powerful enterprise and anti-quishing story.

---

#### 3.9 📱 Android Quick Settings Tile & App Shortcuts

**What:** An Android Quick Settings tile in the system notification shade that launches directly into the camera scanner from any app or lock screen. Includes dynamic Android App Shortcuts (long-press icon) for "Scan", "History", and "AirQR".

**Why it stands out:** Reduces time-to-scan to under 1.5 seconds from anywhere on the device.

**Architectural fit:** Native Android `TileService` configured in `android/app/src/main/AndroidManifest.xml` via platform channel; static shortcuts declared in Android XML resources.

**Priority:** 🔴 High — minimal code overhead, dramatic improvement in daily accessibility.

---

#### 3.10 🌍 Multi-Language Content Translation

**What:** After scanning text or foreign-language payloads, auto-detect the source language and offer one-tap inline translation alongside the original text.

**Why it stands out:** Enables travelers and multilingual users to understand foreign QR notices and menus instantly without switching to an external translator app.

**Architectural fit & constraints:**
- *Offline Consideration:* Native ML Kit translation models require dynamic downloads (30MB per language).
- *Recommended compliant approach:* Provide a clean system intent / Google Translate launcher action card first, and evaluate bundled offline translation delegates for Sanskrit, Malayalam, and English.

**Priority:** 🟡 Medium — high utility for travelers.

---

#### 3.11 📊 Enterprise Security PDF Audit Reports

**What:** Generate branded, professional PDF security audit reports from scan sessions. Includes timestamped evidence, quishing risk breakdown, 6-layer URL safety scores, and cryptographic hashes of scanned items.

**Why it stands out:** Tailored for IT security professionals auditing QR codes on corporate campuses, events, and retail branches.

**Architectural fit:** Extends the existing `pdf` package dependency. New `AuditReportService` in `services/`.

**Priority:** 🟡 Medium — builds upon existing PDF generation capabilities.

---

#### 3.12 🎮 Privacy-First Security Streaks & Achievements

**What:** Local, offline gamification rewarding safe scanning habits: "Safe Scanner Streak" (consecutive days without clicking unverified links), "Tamper Hunter" (quishing checks performed), and "AirQR Pioneer" badges.

**Why it stands out:** Encourages continuous safe scanning habits in a fun, non-intrusive way.

**Architectural fit:** Uses existing `shared_preferences` key-value storage. 100% offline; zero telemetry or external analytics.

**Priority:** 🟢 Low — engaging polish feature.

---

#### 3.13 🛡️ Family Safety Child-Shield Mode

**What:** A parent-configured mode where scanned URLs are checked against an on-device content filter (blocking adult, gambling, and dangerous categories). Blocked links display a kid-safe notification screen and require a PIN or biometric unlock to bypass.

**Why it stands out:** Turns the device into a child-safe QR gateway.

**Architectural fit:** New `ContentFilterService`, PIN authentication stored securely in `flutter_secure_storage`. Fully offline.

**Priority:** 🟡 Medium — valuable for family devices and education environments.

---

#### 3.14 ⌚ Wear OS Companion Remote Trigger

**What:** A companion Wear OS application that acts as a remote viewfinder trigger and displays the latest scan result and safety badge directly on the user's wrist.

**Why it stands out:** Hands-free verification for warehouse inventory and rapid glance checks.

**Architectural fit:** Separate Wear OS companion module communicating via Google Play Services `MessageClient`.

**Priority:** 🟢 Low — niche hardware requirement.

---

### 4. Priority Summary Matrix

#### 🔴 High Priority (Do First)

| #     | Feature                                | Category    | Rationale                                                                                             |
| ----- | -------------------------------------- | ----------- | ----------------------------------------------------------------------------------------------------- |
| 2.1.1 | Continuous Batch Scan Mode             | Improvement | Core requirement for inventory and professional workflows; unique when combined with safety analysis. |
| 2.2.1 | Safety Score Summary Badge             | Improvement | Instant, intuitive safety verdict for all users at a glance.                                          |
| 2.2.3 | Local Threat Hash Prefix Cache         | Improvement | Deepens the offline-first security model.                                                             |
| 2.4.1 | Direct Wi-Fi Suggestion API            | Improvement | Eliminates Android settings detour on Android 10+.                                                    |
| 2.4.2 | TOTP Cloud-Free Vault                  | Improvement | Transforms the app into an all-in-one privacy authenticator.                                          |
| 2.6.1 | Interactive Onboarding Carousel        | Improvement | Highlights differentiators (6 layers, QuishingGuard, AirQR) on first run.                             |
| 2.6.2 | Home Screen Quick-Scan Widget          | Improvement | Reduces scan launch latency to under 1.5 seconds.                                                     |
| 3.1   | QR ThreatMap (Open Feed Subscription)  | New         | Category-defining safety intelligence.                                                                |
| 3.2   | VoiceGuard (Audio-First Accessibility) | New         | Closes a major industry accessibility gap; aligns with engineering standards.                         |
| 3.4   | CodeForge (QR & Barcode Generator)     | New         | Completes the two-way utility loop; most requested scanner capability.                                |
| 3.9   | Quick Settings Tile & Shortcuts        | New         | Instant scanning trigger from Android notification shade.                                             |

#### 🟡 Medium Priority (Do Next)

| #     | Feature                                 | Category    | Rationale                                                               |
| ----- | --------------------------------------- | ----------- | ----------------------------------------------------------------------- |
| 2.1.2 | Distance-Enhanced Scanning Pipeline     | Improvement | ✅ Implemented. Pure-Dart zoom-crop-enhance pipeline with unsharp masking. |
| 2.1.3 | Scan From Clipboard                     | Improvement | ✅ Implemented. Rapid workflow for links/images in chat apps.                           |
| 2.1.4 | Multi-Code Tappable Selection           | Improvement | Simplifies scanning in multi-barcode environments.                      |
| 2.2.2 | Redirect Chain Flowchart                | Improvement | Educational visualization of redirect-based phishing.                   |
| 2.3.2 | Forensic Evidence Capture               | Improvement | Allows saving tamper evidence for reporting scam stickers.              |
| 2.4.3 | Rich Calendar Card & Timezone Picker    | Improvement | Polished calendar scheduling experience.                                |
| 2.4.4 | Inline Product Nutrition & Details      | Improvement | Displays Open Food Facts details inline without opening a browser.      |
| 2.4.5 | App Links Expansion & Rich Metadata     | Improvement | Expands deep linking to Spotify, Instagram, Amazon, with rich previews. |
| 2.5.1 | History Analytics Dashboard             | Improvement | Meaningful usage insights into scanning patterns.                       |
| 2.5.2 | Scheduled Automated Backups             | Improvement | Frictionless data protection with Storage Access Framework.             |
| 2.6.4 | Dynamic Accessibility Adaptation        | Improvement | Responsive layout adaptation to system accessibility flags.             |
| 3.3   | ScanLens AI (Heuristic Intent Engine)   | New         | Explains what the QR payload intends to do in plain English.            |
| 3.5   | GhostScan (Compliant Screen Capture)    | New         | ✅ Implemented. Native Quick Settings tile & on-demand screen capture.  |
| 3.6   | TimeVault (Self-Expiring Payloads)      | New         | Privacy-first temporary credentials and tickets.                        |
| 3.8   | TrustBadge (Cryptographic Authenticity) | New         | Cryptographic protection against counterfeit payment stickers.          |
| 3.10  | Multi-Language Content Translation      | New         | High utility for international travelers.                               |
| 3.11  | Enterprise Security PDF Audit Reports   | New         | Professional compliance reporting for corporate security audits.        |
| 3.13  | Family Safety Child-Shield Mode         | New         | Parental controls for safe browsing via QR codes.                       |

#### 🟢 Low Priority (Future Polish)

| #     | Feature                             | Category    | Rationale                                                 |
| ----- | ----------------------------------- | ----------- | --------------------------------------------------------- |
| 2.2.4 | Custom Domain Allowlist / Blocklist | Improvement | Power-user feature for custom network rules.              |
| 2.3.1 | Quishing Risk Trend Analysis        | Improvement | Long-term observational trend data.                       |
| 2.5.3 | AirQR Encrypted History Sync        | Improvement | Highly secure air-gapped sync between devices.            |
| 2.6.3 | Micro-Interaction Scan Feedback     | Improvement | Delightful tactile and visual polish.                     |
| 3.7   | ScanChain (Multi-Code Sequence)     | New         | Document assembly across multiple printed physical codes. |
| 3.12  | Privacy-First Security Streaks      | New         | Engagement booster for everyday safety habits.            |
| 3.14  | Wear OS Companion Remote Trigger    | New         | Niche smart-watch trigger.                                |

---

### 5. Competitive Edge Summary

What makes SreerajP QR Studio already unique:

- **6-layer URL safety** — no competitor goes beyond single-layer checks.
- **QuishingGuard** physical tamper detection — zero competitors detect printed sticker overlays.
- **AirQR** optical air-gap data transfer — zero competitors provide screen-to-camera optical data transmission.
- **StegoQR** steganographic scanner — hidden encrypted payloads protected by biometrics and passphrases.
- **DOM Sandbox** page preview — inspects web pages with scripts and trackers completely disabled.
- **Full Tri-Lingual Support** — 100% parity across English, Malayalam, and Sanskrit with Sanskrit framework delegates.
- **Advanced Camera Controls** — 3-state ambient light sensor flash, Full HD/Max resolution presets, live Skia brightness/contrast adjustment, negative barcode scanning, and tap-to-focus.
- **Smart Quick-Action Cards** — 12 payload types with direct native actions (Wi-Fi, UPI, crypto, TOTP, Play Store/YouTube/WhatsApp app links, Open Food Facts, ISBN).
- **100% offline-first architecture** with zero telemetry, zero crash SDKs, and zero cloud tracking.

What will make it unbeatable with the roadmap additions:

- **CodeForge** = completes the two-way loop (scan + generate).
- **VoiceGuard** = industry-first guided audio accessibility with threat haptics.
- **Continuous Batch Scanning + Safety** = the only batch scanner in the industry with full multi-layer URL security.
- **Quick Settings Tile** = fastest scan-to-result trigger on Android.
- **Local Threat Hash Prefix Cache** = Safe Browsing threat detection that operates completely offline.

---

> **Note:** All proposed roadmap features strictly adhere to project engineering rules: open-source permissive packages only, offline-first scanning, scoped storage, zero sensitive data leaks, zero crashes on malformed inputs, and tri-lingual localization parity. Features requiring external network access remain strictly opt-in.
