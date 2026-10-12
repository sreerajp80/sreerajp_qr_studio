# Update README.md with Latest Features

**Status:** completed

## Files to Change
- `README.md`: Update feature descriptions, URL safety engine details, smart action capabilities, AirQR sync, multi-code viewport selection, and onboarding tour to reflect all recent additions in the app.

## Issue
The repository `README.md` was last overhauled prior to several major feature implementations:
1. Multi-provider URL safety intelligence (Google Safe Browsing, VirusTotal v3, URLhaus, PhishTank, and OpenPhish).
2. Native 1-tap Wi-Fi direct connection via Android network suggestions API (`Settings.ACTION_WIFI_ADD_NETWORKS` / `WifiManager`).
3. Additional smart action payload support (SEPA bank transfers and crypto payments).
4. AirQR air-gapped encrypted device-to-device sync (history and preferences transfer).
5. Multi-code interactive viewport selection with glowing bounding boxes and touch targeting.
6. Interactive 3-slide onboarding tour on first launch with replay support.
7. Expanded package listings and technical specifications (e.g. `qr_flutter`).

Because of these omissions, users and contributors reading `README.md` do not get an accurate view of the application's full capabilities and privacy architecture.

## Proposed Fix
Update `README.md` to cleanly and accurately describe all current features:
1. **Overview & Header**: Mention multi-provider threat intelligence and device-to-device optical sync.
2. **6-Layer URL Safety Engine**: Detail the 5 supported threat intelligence providers:
   - Google Safe Browsing (API key)
   - VirusTotal v3 (free personal API key, customizable endpoint, 500 requests/day tracking)
   - URLhaus by abuse.ch (free Auth-Key, customizable endpoint, malware campaign tags)
   - PhishTank (built-in phishing verification database, 1-tap toggle)
   - OpenPhish (built-in feed with 12-hour offline local cache)
3. **Smart Payload Action Engine**:
   - Update Wi-Fi card description to include native 1-tap Wi-Fi suggestion connect alongside clipboard copy and settings fallback.
   - Mention SEPA bank transfer (EPC QR / `BCD\n` / `sepa:`) and cryptocurrency payment links (Bitcoin, Ethereum, Solana).
4. **AirQR Optical Air-Gapped Data Transfer**:
   - Add Device Sync Mode: beam encrypted SQLite scan history and app settings from phone to phone using optical animated QR sequences.
5. **Live Camera & Viewfinder Intelligence**:
   - Detail the Multi-Code Tappable Viewport Selection feature: interactive bounding boxes and touch targets when multiple codes appear in frame.
   - Clarify Distance-Enhanced Scanning Pipeline and Continuous Batch Scan Mode.
6. **Onboarding & User Experience**:
   - Add description of the Interactive Onboarding Carousel and tour replay from Settings and Help Center.
7. **Dependencies & Tech Stack**:
   - Include `qr_flutter` in core libraries list.
