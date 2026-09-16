# Change Log — Smart Quick-Action Cards

**Plan:** `plans/20260914_191600_smart_action_cards.md`

## Summary

Added six new smart payload types with dedicated action card widgets, plus enhanced the existing Wi-Fi card with a direct Wi-Fi connect attempt.

## Changes Made

### Models (`lib/models/parsed_payload.dart`)
- Extended `PayloadType` enum with: `email`, `phone`, `sms`, `appLink`, `productBarcode`, `isbn`
- Added six new immutable payload classes: `EmailPayload`, `PhonePayload`, `SmsPayload`, `AppLinkPayload`, `ProductBarcodePayload`, `IsbnPayload`
- Added `AppStoreName` enum for app link store identification

### Services (`lib/services/payload_parser_service.dart`)
- Added parser branches for `mailto:`, `MATMSG:`, raw email addresses
- Added parser branches for `tel:`, raw phone numbers
- Added parser branches for `sms:`, `smsto:`, `mms:`
- Added parser for Play Store (`market://`, `play.google.com`), WhatsApp, Telegram, YouTube links
- Added ISBN-10 and ISBN-13 detection with checksum validation
- Added EAN-13, UPC-A, EAN-8 product barcode detection (excludes ISBN prefix 978/979)

### Services (`lib/services/payload_action_service.dart`)
- Added `sendEmail()`, `dialPhone()`, `sendSms()`, `openAppLink()`, `searchProduct()`, `lookupBook()`, `connectToWifi()`
- Product search supports Open Food Facts and Google
- Book lookup supports Google Books and Open Library
- Wi-Fi connect attempts `ACTION_WIFI_ADD_NETWORKS` intent, falls back to Wi-Fi settings

### Widgets (6 new files in `lib/screens/widgets/`)
- `email_action_card.dart` — Send Email + Copy, with subject/body preview
- `phone_action_card.dart` — Call + Copy Number
- `sms_action_card.dart` — Send Message + Copy, with body preview
- `app_link_action_card.dart` — Open in App, with branded icons (Play Store, WhatsApp, Telegram, YouTube)
- `product_barcode_action_card.dart` — Food Info + Search Web + Copy Barcode
- `isbn_action_card.dart` — Google Books + Open Library + Copy ISBN

### Widgets (1 updated)
- `wifi_action_card.dart` — Connect button now uses `connectToWifi()` instead of `openWifiSettings()`

### Screens (`lib/screens/result_screen.dart`)
- Added imports for all six new card widgets
- Extended `_buildSmartPayloadCard()` with six new `else if` branches
- Extended `_buildResultTypeCard()` icon mapping for all new types

### Localization (`lib/l10n/app_en.arb`)
- Added ~45 new localization strings with `@key` descriptions for all new card types and history filters

## Verification

- `flutter gen-l10n` — successful
- `flutter analyze` — 0 issues found
- `flutter test` — 170 tests passed
