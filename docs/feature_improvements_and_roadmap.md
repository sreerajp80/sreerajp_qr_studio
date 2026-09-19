# Feature Improvements & New Feature Roadmap — SreerajP QR Reader

> **Purpose:** This document lists improvements to existing features and new unique features that make SreerajP QR Reader stand out in the Android app market. Each item includes a brief rationale, expected user impact, architectural fit, and priority rating.
>
> **Audience:** Developer planning, product roadmap, AI agent reference.
>
> **Last updated:** 2026-09-14

**Read first:**
- [CLAUDE.md](../CLAUDE.md)
- [AGENTS.md](../AGENTS.md)
- [features.md](features.md)
- [architecture.md](architecture.md)
- [dependencies.md](dependencies.md)

---

## Table of Contents

1. [Current Feature Inventory](#1-current-feature-inventory)
2. [Improvements to Existing Features](#2-improvements-to-existing-features)
3. [New Unique Features](#3-new-unique-features)
4. [Priority Summary Matrix](#4-priority-summary-matrix)
5. [Competitive Edge Summary](#5-competitive-edge-summary)

---

## 1. Current Feature Inventory

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

## 2. Improvements to Existing Features

### 2.1 Scanner Screen

| #     | Improvement                                       | Current State                                                                                                          | Proposed Change                                                                                                                                                                                             | Impact                                                                                     | Priority       |
| ----- | ------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------ | -------------- |
| 2.1.1 | **Continuous Batch Scan Mode**                    | Implemented (`BatchScanProvider` + floating counter badge + `BatchReviewSheet` with 6-layer URL safety & batch export) | Toggle for continuous scanning queues multiple codes into a list without leaving the camera viewport, shows floating counter badge, batch list review, and CSV/JSON/TXT/PDF export with 6-layer URL safety. | High — warehouse workers and professionals scanning inventory need this.                   | ✅  Implemented |
| 2.1.2 | **Distance-Enhanced Scanning Pipeline**           | Implemented (`DistanceEnhancementService` + ROI cropping, bilinear digital zoom, contrast boost, unsharp masking, camera autoZoom & Viewport controls) | Pure-Dart digital zoom-crop-enhance pipeline that extracts candidate regions of interest, applies bilinear upscaling and high-pass unsharp masking, leverages MLKit autoZoom, and provides a multi-scale fallback for distant photos. | Medium — accessibility improvement for physically distant codes (posters, overhead signs). | ✅  Implemented |
| 2.1.3 | **Scan From Clipboard**                           | Implemented (`ClipboardScanService` + native Android clipboard bridge + quick-action detection pill & AppBar button)   | Detect if system clipboard contains an image, URL, or raw barcode payload and offer a quick "Scan from Clipboard" button on the scanner screen.                                                             | Medium — fast workflow for links or images copied in messaging apps.                       | ✅  Implemented |
| 2.1.4 | **Multi-Code Tappable Selection on Main Scanner** | Implemented (`MultiCodeSelectionProvider` + `MultiCodeService` + bounding box overlay & hint banner + CameraAdjustments toggle) | Outline all visible barcodes in the main camera view with subtle bounding boxes and let the user tap which specific code to inspect. | Medium — eliminates scan errors when multiple QR codes are printed close together. | ✅  Implemented |

### 2.2 URL Safety Engine

| #     | Improvement                             | Current State                              | Proposed Change                                                                                                                                                                 | Impact                                                                          | Priority |
| ----- | --------------------------------------- | ------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- | -------- |
| 2.2.1 | **Safety Score Summary Badge**          | Individual check results shown as a list   | Add an aggregated overall safety score (0–100) with a colour-coded badge (green/amber/red) at the top of the result screen combining all 6 layers into one intuitive indicator. | High — instant visual clarity for non-technical users.                          | 🔴 High   |
| 2.2.2 | **Redirect Chain Flowchart**            | Text-based redirect hops from HEAD probing | Render redirect chains as an interactive visual flowchart (Origin → Intermediate Hop → Final Destination) with safety badges at each node.                                      | Medium — makes hidden redirect and open-redirect attacks clear and educational. | 🟡 Medium |
| 2.2.3 | **Local Threat Hash Prefix Cache**      | Online-only Google Safe Browsing API check | Cache Safe Browsing threat hash prefixes locally (with periodic opt-in sync) so lookups work even when offline.                                                                 | High — strengthens the offline-first security promise.                          | 🔴 High   |
| 2.2.4 | **Custom Domain Allowlist / Blocklist** | No user-defined domain rules               | Let users add domains to a personal blocklist or allowlist. Blocked domains show an immediate alert. Allowed domains bypass active probing.                                     | Low — useful for power users and enterprise testing.                            | 🟢 Low    |

### 2.3 QuishingGuard

| #     | Improvement                      | Current State                             | Proposed Change                                                                                                                                  | Impact                                                                                      | Priority |
| ----- | -------------------------------- | ----------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------- | -------- |
| 2.3.1 | **Quishing Risk Trend Analysis** | Point-in-time score per scan              | Track quishing risk scores over time in history. Warn users if a specific merchant or location frequently presents suspicious physical overlays. | Low — informational awareness.                                                              | 🟢 Low    |
| 2.3.2 | **Forensic Evidence Capture**    | In-memory frame analysis; no image stored | Offer an optional button to save the captured camera frame alongside the tamper forensic breakdown for scam reporting.                           | Medium — helpful for reporting fraudulent stickers on parking meters and payment terminals. | 🟡 Medium |

### 2.4 Smart Payloads & Actions

| #     | Improvement                              | Current State                                                      | Proposed Change                                                                                                                                         | Impact                                                                            | Priority      |
| ----- | ---------------------------------------- | ------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------- | ------------- |
| 2.4.1 | **Direct Wi-Fi Suggestion API**          | Implemented via native MethodChannel (`in.sreeraj.qr_reader/wifi`) | Uses Android's `WifiNetworkSuggestion` / `ACTION_WIFI_ADD_NETWORKS` to connect to the scanned Wi-Fi network with 1 tap.                                 | High — instant network connection without leaving the app.                        | ✅ Implemented |
| 2.4.2 | **TOTP Cloud-Free Vault**                | Scans TOTP and displays live countdown card                        | Provide an encrypted local vault screen where users can store and manage multiple 2FA accounts, transforming the app into an offline authenticator.     | High — dual utility: secure scanner + privacy-first 2FA authenticator.            | 🔴 High        |
| 2.4.3 | **Rich Calendar Card & Timezone Picker** | Text preview with Google Calendar link                             | Display an interactive mini-calendar widget showing event start/end, recurrence rules, and a timezone selector.                                         | Medium — refined UX for business schedules.                                       | 🟡 Medium      |
| 2.4.4 | **Inline Product Nutrition & Details**   | `ProductBarcodeActionCard` with Open Food Facts and Google buttons | Fetch Open Food Facts data directly inside the card (product name, brand, image, Nutri-Score, allergens) with local caching, avoiding a browser detour. | Medium — high value for grocery and retail shoppers.                              | 🟡 Medium      |
| 2.4.5 | **App Links Expansion & Rich Metadata**  | Supports Play Store, YouTube, WhatsApp, Telegram                   | Expand parser to Instagram, Spotify, Amazon, and Twitter/X; show rich previews (video titles, playlist previews) before launching apps.                 | Medium — extends the existing deep linking capability to more everyday platforms. | 🟡 Medium      |

### 2.5 History & Backup

| #     | Improvement                                 | Current State                                                                | Proposed Change                                                                                                                            | Impact                                                      | Priority    |
| ----- | ------------------------------------------- | ---------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------- | ----------- |
| 2.5.1 | **History Analytics Dashboard**             | List view with category chips and search                                     | Add a visual analytics dashboard: total scans, scan category distribution pie chart, safety score spread, and scan frequency timeline.     | Medium — visual insights into user scanning habits.         | 🟡 Medium    |
| 2.5.2 | **Scheduled Automated Backups**             | Manual export to JSON/CSV/PDF                                                | Allow users to schedule periodic automated encrypted backups (`.sreerajqr`) to a user-chosen folder via Android Storage Access Framework.  | Medium — seamless data protection with zero cloud reliance. | 🟡 Medium    |
| 2.5.3 | **AirQR Encrypted History & Settings Sync** | Implemented (`DeviceSyncService` + `AirQrTransmitterScreen` + `AirQrScreen`) | Beams encrypted scan history and application settings between phones air-gapped via animated QR fountain codes without networks or cables. | Low — niche but completely private air-gapped sync.         | ✅ Completed |

### 2.6 Appearance & UX

| #     | Improvement                          | Current State                                                                                            | Proposed Change                                                                                                                                                | Impact                                                | Priority      |
| ----- | ------------------------------------ | -------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------- | ------------- |
| 2.6.1 | **Interactive Onboarding Carousel**  | Implemented (`OnboardingProvider` + `OnboardingScreen` with replay via Settings/Help)                    | Lightweight 3-slide introductory carousel on first launch explaining the 6-layer URL safety engine, QuishingGuard tamper detection, and offline privacy model. | High — boosts first impression and feature discovery. | ✅ Implemented |
| 2.6.2 | **Home Screen Quick-Scan Widget**    | App icon launch only                                                                                     | Provide Android home screen app widgets (1x1 quick scan trigger, 2x1 showing recent scan status) launching directly into the camera.                           | High — saves user time, promotes daily adoption.      | 🔴 High        |
| 2.6.3 | **Micro-Interaction Scan Feedback**  | Implemented (`ScanOverlayWidget` reticle pulse, checkmark morph & ripple, haptic/chime, settings toggle) | Add a polished micro-animation (subtle reticle pulse and checkmark morph) before transitioning to the result screen.                                           | Low — visual polish and tactile satisfaction.         | ✅ Implemented |
| 2.6.4 | **Dynamic Accessibility Adaptation** | Static typography settings                                                                               | Listen to system accessibility changes (font scale, high contrast, screen reader state) and adjust layout density automatically.                               | Medium — inclusive design adherence.                  | 🟡 Medium      |

---

## 3. New Unique Features

These features do not exist in the current app and represent greenfield capabilities designed to set SreerajP QR Reader apart.

### 3.1 🏆 QR ThreatMap — Community Threat Intelligence Feed

**What:** An opt-in, privacy-preserving threat intelligence feed. When users encounter a verified phishing or malicious URL, they can submit an anonymous domain hash report. Other users scanning the same domain see a "Community Threat Alert" badge with report metrics.

**Why it stands out:** Transforms individual scans into collective security defense while preserving complete privacy (only truncated domain hashes are shared, never raw URLs or user identifiers).

**Architectural fit & constraints:**
- Requires an external API service or public blocklist source (e.g. periodically synchronizing an open-source threat feed like URLhaus/PhishTank).
- *Note on architecture:* Because the app is strictly serverless and client-only, this feature should be implemented as an **opt-in public threat feed subscription** (fetching verified open-source threat databases) rather than maintaining a custom centralized reporting server.

**Priority:** 🔴 High — category-defining security differentiator.

---

### 3.2 🏆 VoiceGuard — Guided Audio-First Accessibility Mode

**What:** A comprehensive accessibility mode that announces scan results, threat levels, and action cards via text-to-speech. Includes audio-guided camera aiming ("move camera slightly higher... code detected") and distinct haptic vibration signatures for risk categories (single pulse = safe, rapid triple pulse = dangerous).

**Why it stands out:** No existing scanner combines directional audio aiming with threat-level haptic pulses, making the scanner independently usable by blind and low-vision users without relying entirely on TalkBack.

**Architectural fit:** New `VoiceGuardService` in `services/`, localized voice strings across English, Malayalam, and Sanskrit, uses `flutter_tts` or native Android TTS platform channel.

**Priority:** 🔴 High — accessibility is an engineering standard requirement.

---

### 3.3 🏆 ScanLens AI — Heuristic & On-Device Intent Engine

**What:** Classifies the intent of scanned barcodes and presents plain-English contextual explanations: *"This QR code directs to a payment gateway requesting money — verify recipient"* or *"This link contains tracking parameters from an advertising campaign"*.

**Why it stands out:** Bridges raw decoded data and human understanding, explaining *what the code wants to do* before the user takes action.

**Architectural fit & constraints:**
- *Phase 1:* Implement as an offline, rule-based heuristic classifier inside `PayloadParserService` (pure Dart, zero binary bloat).
- *Phase 2 (Optional):* Lightweight on-device TensorFlow Lite model. *Note:* Must evaluate APK binary size impact (~30MB) and ensure compliance with split-APK builds.

**Priority:** 🟡 Medium — valuable user context; Phase 1 heuristic engine can be built with zero external dependencies.

---

### 3.4 🏆 CodeForge — Standalone QR & Barcode Generator

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

### 3.5 🏆 GhostScan — Screen Content QR Detector

**What:** Detects and decodes QR codes visible on the phone screen (inside messaging apps, social media feeds, web pages, documents) without requiring the user to take a manual screenshot, open the gallery, and crop.

**Why it stands out:** Eliminates multi-step friction for scanning codes received on mobile screens.

**Architectural fit & constraints:**
- *Play Store Policy Consideration:* Using `SYSTEM_ALERT_WINDOW` or continuous MediaProjection triggers heavy Google Play security scrutiny.
- *Recommended compliant approach:* Integrate an Android Quick Settings tile / Quick Screenshot action that captures the current display on demand and feeds it into the existing `image_picker` / `MobileScannerController.analyzeImage()` pipeline.

**Priority:** 🟡 Medium — high utility, but implementation must strictly follow Google Play policy guidelines.

**Current State:** ✅ Implemented. Native Android `GhostScanTileService` (`TileService`) for Quick Settings, short-lived single-frame `GhostScanCaptureService` (`FOREGROUND_SERVICE_MEDIA_PROJECTION`), transparent `GhostScanActivity`, Dart `GhostScanService` platform channel, `GhostScanSheet` modal bottom sheet, and seamless `MobileScannerController.analyzeImage()` integration with 100% tri-lingual localization.

---

### 3.6 🏆 TimeVault — Self-Destructing / Time-Locked QR Payloads

**What:** In conjunction with CodeForge, generate QR codes that self-expire after a set timestamp. Scanned by SreerajP QR Reader, the content is decrypted only if the device clock is prior to the expiration timestamp; otherwise, the app displays a friendly expiration notice.

**Why it stands out:** Privacy-centric temporary payload sharing for temporary Wi-Fi guest access, one-time coupons, or temporary event coordinates without requiring any cloud server.

**Architectural fit:** Extends `StegoQrService` and cryptographic models. Evaluated entirely offline via timestamp header verification.

**Priority:** 🟡 Medium — pairs naturally with CodeForge.

---

### 3.7 🏆 ScanChain — Sequential Multi-Code Document Assembly

**What:** Reads a physical sequence of printed QR codes that together represent a large document or dataset exceeding the single-QR capacity limit. Shows a real-time progress HUD ("Part 3 of 8 captured") and reassembles the complete file when all segments are scanned.

**Why it stands out:** Brings AirQR's optical packet assembly to physical printed paper, enabling physical distribution of large text files or documents offline.

**Architectural fit:** New `ScanChainService` extending the block encoding algorithms of `AirQrService`.

**Priority:** 🟢 Low — specialized offline use case.

---

### 3.8 🏆 TrustBadge — Cryptographic QR Authenticity Verification

**What:** Allows merchants and organizations to digitally sign their QR codes with an asymmetric private key. When scanned, SreerajP QR Reader verifies the digital signature using an embedded public key or local certificate, displaying a verified green "TrustBadge: Verified Authentic Merchant" certificate.

**Why it stands out:** Directly solves physical quishing and counterfeit payment QR stickers by providing cryptographic proof of code authenticity.

**Architectural fit:** Pure Dart digital signature verification using `pointycastle` (already an approved production dependency). Fully offline.

**Priority:** 🟡 Medium — powerful enterprise and anti-quishing story.

---

### 3.9 📱 Android Quick Settings Tile & App Shortcuts

**What:** An Android Quick Settings tile in the system notification shade that launches directly into the camera scanner from any app or lock screen. Includes dynamic Android App Shortcuts (long-press icon) for "Scan", "History", and "AirQR".

**Why it stands out:** Reduces time-to-scan to under 1.5 seconds from anywhere on the device.

**Architectural fit:** Native Android `TileService` configured in `android/app/src/main/AndroidManifest.xml` via platform channel; static shortcuts declared in Android XML resources.

**Priority:** 🔴 High — minimal code overhead, dramatic improvement in daily accessibility.

---

### 3.10 🌍 Multi-Language Content Translation

**What:** After scanning text or foreign-language payloads, auto-detect the source language and offer one-tap inline translation alongside the original text.

**Why it stands out:** Enables travelers and multilingual users to understand foreign QR notices and menus instantly without switching to an external translator app.

**Architectural fit & constraints:**
- *Offline Consideration:* Native ML Kit translation models require dynamic downloads (30MB per language).
- *Recommended compliant approach:* Provide a clean system intent / Google Translate launcher action card first, and evaluate bundled offline translation delegates for Sanskrit, Malayalam, and English.

**Priority:** 🟡 Medium — high utility for travelers.

---

### 3.11 📊 Enterprise Security PDF Audit Reports

**What:** Generate branded, professional PDF security audit reports from scan sessions. Includes timestamped evidence, quishing risk breakdown, 6-layer URL safety scores, and cryptographic hashes of scanned items.

**Why it stands out:** Tailored for IT security professionals auditing QR codes on corporate campuses, events, and retail branches.

**Architectural fit:** Extends the existing `pdf` package dependency. New `AuditReportService` in `services/`.

**Priority:** 🟡 Medium — builds upon existing PDF generation capabilities.

---

### 3.12 🎮 Privacy-First Security Streaks & Achievements

**What:** Local, offline gamification rewarding safe scanning habits: "Safe Scanner Streak" (consecutive days without clicking unverified links), "Tamper Hunter" (quishing checks performed), and "AirQR Pioneer" badges.

**Why it stands out:** Encourages continuous safe scanning habits in a fun, non-intrusive way.

**Architectural fit:** Uses existing `shared_preferences` key-value storage. 100% offline; zero telemetry or external analytics.

**Priority:** 🟢 Low — engaging polish feature.

---

### 3.13 🛡️ Family Safety Child-Shield Mode

**What:** A parent-configured mode where scanned URLs are checked against an on-device content filter (blocking adult, gambling, and dangerous categories). Blocked links display a kid-safe notification screen and require a PIN or biometric unlock to bypass.

**Why it stands out:** Turns the device into a child-safe QR gateway.

**Architectural fit:** New `ContentFilterService`, PIN authentication stored securely in `flutter_secure_storage`. Fully offline.

**Priority:** 🟡 Medium — valuable for family devices and education environments.

---

### 3.14 ⌚ Wear OS Companion Remote Trigger

**What:** A companion Wear OS application that acts as a remote viewfinder trigger and displays the latest scan result and safety badge directly on the user's wrist.

**Why it stands out:** Hands-free verification for warehouse inventory and rapid glance checks.

**Architectural fit:** Separate Wear OS companion module communicating via Google Play Services `MessageClient`.

**Priority:** 🟢 Low — niche hardware requirement.

---

## 4. Priority Summary Matrix

### 🔴 High Priority (Do First)

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

### 🟡 Medium Priority (Do Next)

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

### 🟢 Low Priority (Future Polish)

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

## 5. Competitive Edge Summary

What makes SreerajP QR Reader already unique:

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
