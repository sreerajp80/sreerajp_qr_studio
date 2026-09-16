# Change Log: Update Feature Improvements & Roadmap Documentation

**Date:** 2026-09-14  
**Plan Reference:** [plans/20260914_202600_update_feature_improvements_roadmap.md](plans/20260914_202600_update_feature_improvements_roadmap.md)  
**Status:** Completed  

---

## Overview

Audited and updated `docs/feature_improvements_and_roadmap.md` to accurately reflect the app's current capabilities, recent feature additions, tri-lingual localization status, and architectural standards.

---

## Changes Made

### 1. Document Anatomy & Links
- Added standard "Read first" relative links to `CLAUDE.md`, `AGENTS.md`, `features.md`, `architecture.md`, and `dependencies.md` adhering to `docs/guidelines/DOCS_FOLDER_GUIDELINE.md`.

### 2. Section 1 (Current Feature Inventory)
- **Core Scanning:** Added documentation for Full HD / Max 4K / HD resolution presets, 3-state ambient light sensor flash (Off/On/Auto), live Skia brightness/contrast adjustment sliders, inverted barcode mode, and interactive tap-to-focus with exposure reticle.
- **Smart Payloads:** Clarified all 12 recognized payload types (Wi-Fi, Contact cards, Geo locations, Calendar events, UPI/SEPA/Crypto payments, TOTP 2FA, Email, Phone, SMS, App Links, Product Barcodes, ISBN).
- **Localization:** Updated from "English shipped, Malayalam and Sanskrit metadata" to full tri-lingual localization across English (`en`), Malayalam (`ml`), and Sanskrit (`sa`) with 100% key parity (632 keys each), custom Sanskrit framework delegates, and in-app language picker.

### 3. Section 2 (Improvements to Existing Features)
- **2.1.2 (Distance Scanning):** Acknowledged existing Full HD/Max capture and contrast boost; focused proposed change on digital zoom-crop-sharpen pipeline.
- **2.4.1 (Wi-Fi Connect):** Acknowledged existing `ACTION_WIFI_ADD_NETWORKS` intent; focused proposed change on native platform channel Wi-Fi suggestion API.
- **2.4.4 (Product Info):** Acknowledged existing `ProductBarcodeActionCard` and Open Food Facts integration; focused proposed change on inline parsing and offline caching.
- **2.4.5 (App Links Expansion):** Added expansion for existing deep link actions to support Spotify, Instagram, Amazon, Twitter/X, and rich metadata previews.

### 4. Section 3 (New Unique Features)
- Removed duplicate item 3.14 ("Deep Link Actions") since basic deep linking is already implemented in the app.
- Renumbered new feature items cleanly from 3.1 to 3.14.
- **3.1 (QR ThreatMap):** Added architectural constraint note clarifying the backend server requirement vs client-only offline design; proposed open threat blocklist subscriptions (e.g. URLhaus) as a serverless alternative.
- **3.3 (ScanLens AI):** Added APK binary size considerations for TensorFlow Lite; proposed pure-Dart heuristic classification as phase 1.
- **3.4 (CodeForge):** Noted the existing `AirQrCodePainter` matrix engine as a foundational asset.
- **3.5 (GhostScan):** Added Google Play policy warnings regarding background screen capture and overlay permissions.

### 5. Section 4 (Priority Summary Matrix) & Section 5 (Competitive Edge)
- Synchronized table entries, numbers, and categories with the updated sections.
- Updated competitive edge summary to highlight current camera enhancements, full tri-lingual localization, and 12 smart payload action cards.

---

## Verification

- `flutter analyze`: 0 issues found.
- All relative markdown links verified.
