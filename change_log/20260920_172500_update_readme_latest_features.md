# Change Log — Update README.md with Latest Features

**Plan:** [plans/20260920_172500_update_readme_latest_features.md](plans/20260920_172500_update_readme_latest_features.md)  
**Date:** 2026-09-20  
**Status:** Completed  

## Summary
Updated `README.md` to comprehensively document all recent features and improvements added to the application, ensuring alignment between project documentation and the live codebase.

## Changes Made

### Documentation (`README.md`)
1. **Overview & Header**:
   - Highlighted multi-provider threat intelligence and air-gapped device-to-device optical sync in the header tagline and overview bullets.
2. **6-Layer URL Safety & Threat Intelligence**:
   - Detailed all 5 supported threat intelligence providers:
     - Google Safe Browsing (personal API key)
     - VirusTotal v3 (personal API key, 500 req/day quota tracking, customizable endpoint)
     - URLhaus by abuse.ch (Auth-Key, malware campaign tags, customizable endpoint)
     - PhishTank (built-in phishing verification database, 1-tap toggle)
     - OpenPhish (built-in community feed, 12-hour offline local caching)
3. **Smart Payload Action Engine**:
   - Added native 1-tap direct connection for Wi-Fi via Android network suggestions API (`Settings.ACTION_WIFI_ADD_NETWORKS` / `WifiManager`) with copy and settings fallback.
   - Documented SEPA bank transfer (EPC QR / `BCD\n` / `sepa:`) and crypto payment links (Bitcoin, Ethereum, Solana) alongside UPI.
4. **AirQR Optical Data Transfer & Device Sync**:
   - Documented air-gapped encrypted device-to-device sync for backing up and restoring scan history and app preferences over animated QR sequences.
5. **AR CodeVision & Viewfinder Intelligence**:
   - Documented Multi-Code Tappable Viewport Selection: glowing bounding boxes, corner brackets, and touch targeting when multiple barcodes appear in frame.
   - Documented Distance-Enhanced Scanning Pipeline and GhostScan™ Quick Settings screen reader.
6. **Interactive Onboarding & Feature Guides**:
   - Added documentation for the 3-slide welcome carousel on first launch and tour replay options in Settings and Help.
7. **Dependencies & Credits**:
   - Added `qr_flutter` to the core open-source libraries list.

## Verification
- Ran `flutter analyze`: clean analysis with 0 warnings and 0 errors.
- Ran `flutter test test/l10n/l10n_parity_test.dart`: all 5 tests passed with full tri-lingual parity.
