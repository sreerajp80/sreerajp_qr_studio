# Plan: Update and Correct Feature Improvements and Roadmap Documentation

**Status:** Planned  
**Date:** 2026-09-14  
**Files to Change:**
- `docs/feature_improvements_and_roadmap.md`

---

## 1. Issue Description

A detailed analysis of `docs/feature_improvements_and_roadmap.md` against the active codebase (`lib/`, `pubspec.yaml`, `change_log/`) and project standards (`AGENTS.md`, `CLAUDE.md`, `docs/guidelines/`) reveals several factual inaccuracies, outdated descriptions, and architectural conflicts:

1. **Outdated Localization Status (Section 1):** The document claims only English is shipped with Malayalam and Sanskrit metadata. In reality, full tri-lingual localization is completely implemented and shipped with 632 keys across all three languages (`en`, `ml`, `sa`), custom Sanskrit Material/Cupertino/Widgets delegates, and an in-app language picker in Settings.
2. **Incomplete Camera Scanning Inventory (Section 1):** The document lists only basic camera controls (zoom, torch, flip). It fails to reflect recently implemented Full HD/Max/HD resolution presets, 3-state ambient light sensor flash (Off/On/Auto), live Skia brightness/contrast adjustment, negative/inverted barcode scanning mode, and interactive tap-to-focus with exposure reticle.
3. **Contradiction and Duplication with Deep Link Actions (Section 1, Section 3.14, Section 4):** Item 3.14 proposes "Deep Link & App Intent Actions" as a "New Unique Feature" that does not exist in the app. However, this feature is already fully implemented (`AppLinkPayload`, `PayloadParserService`, `PayloadActionService`, `AppLinkActionCard` supporting Play Store, YouTube, WhatsApp, Telegram). This creates an internal contradiction with Section 1 and misrepresents current app capabilities.
4. **Inaccurate Wi-Fi Connect Current State (Section 2.4.1):** Current state says it only opens Wi-Fi settings. In reality, `connectToWifi()` already attempts the Android 10+ `ACTION_WIFI_ADD_NETWORKS` intent before falling back to settings.
5. **Inaccurate Product Barcode Current State (Section 2.4.4):** Current state says product barcode shows lookup links. In reality, `ProductBarcodeActionCard` already has 1-tap Open Food Facts lookup, Google Web Search, and barcode format chips.
6. **Serverless Architecture Mismatch (Section 3.1):** Item 3.1 ("QR ThreatMap") proposes a crowdsourced threat reporting feed without noting that the project is an offline-first, client-only Android app with zero backend servers or user accounts.
7. **Native Binary and Policy Risks (Section 3.3, Section 3.5, Section 3.10):** Proposing on-device TensorFlow Lite, ML Kit, and screen media projection without noting binary size impacts or Google Play store policy constraints.
8. **Missing "Read First" Links per Documentation Standards:** The document lacks the standard "Read first" links specified in `docs/guidelines/DOCS_FOLDER_GUIDELINE.md`.

---

## 2. Proposed Fix

Update `docs/feature_improvements_and_roadmap.md` to:

1. **Add Standard Header & Links:** Include "Read first" links to `../CLAUDE.md`, `../AGENTS.md`, `features.md`, `architecture.md`, and `dependencies.md`.
2. **Update Section 1 (Current Feature Inventory):**
   - Core Scanning: Document Full HD / Max / HD resolution presets, 3-state auto-flash with native ambient light sensor, live brightness/contrast adjustment, inverted barcode mode, and tap-to-focus.
   - Smart Payloads: Clearly enumerate all 12 supported payload types (Wi-Fi, Contact, Location, Calendar, Payments, TOTP, Email, Phone, SMS, App Links, Product Barcodes, ISBN).
   - Localization: Document full tri-lingual support (`en`, `ml`, `sa`) with 100% key parity, Sanskrit framework delegates, and in-app language switcher.
3. **Update Section 2 (Improvements to Existing Features):**
   - 2.1.2: Acknowledge existing Full HD/Max resolution and contrast controls; focus proposed improvement on zoom-crop-sharpen pipeline.
   - 2.4.1: Acknowledge existing `ACTION_WIFI_ADD_NETWORKS` intent; focus proposed improvement on native platform channel Wi-Fi suggestion API.
   - 2.4.4: Acknowledge existing Open Food Facts action card; focus proposed improvement on inline product parsing (ingredients, Nutri-Score) and offline caching.
   - 2.4.5: Add "App Links Rich Metadata & Platform Expansion" (moving 3.14 to an improvement of existing app links, adding Spotify/Instagram/Amazon and rich link previews).
4. **Update Section 3 (New Unique Features):**
   - Remove 3.14 (since basic deep linking is already implemented) and renumber items.
   - 3.1 (QR ThreatMap): Add architectural note clarifying the backend server requirement vs client-only offline design, and propose open public threat feed download (e.g. URLhaus) as a serverless alternative.
   - 3.3 (ScanLens AI): Note binary footprint trade-offs of TFLite; recommend pure-Dart regex/heuristics as phase 1.
   - 3.4 (CodeForge): Note existing `AirQrCodePainter` matrix engine as a baseline.
   - 3.5 (GhostScan): Note Google Play policy restrictions on MediaProjection/overlay permissions.
5. **Update Section 4 (Priority Matrix) & Section 5 (Competitive Edge):**
   - Synchronize table entries and priorities with the updated sections.

---

## 3. Verification Plan

1. Verify markdown formatting and table alignment.
2. Confirm all relative links exist and resolve.
3. Verify compliance with `AGENTS.md`, `CLAUDE.md`, and `docs/guidelines/DOCS_FOLDER_GUIDELINE.md`.
