# Change Log — Smart Action Cards Gaps and History Integration

**Plan:** `plans/20260914_204800_smart_action_cards_gaps_and_history.md`

## Summary
Addressed test gaps and integrated the six recently added smart payload categories (Email, Phone, SMS, App Link, Product Barcode, ISBN) into the scan history screen and database query layer.

## Changes Made

### Database Layer
- **`lib/services/history_database_service.dart`**:
  - Updated `getRecords()` to use `LOWER(category) = ?` in the WHERE clause, ensuring case-insensitive matching for camelCase categories such as `appLink` and `productBarcode`.

### UI Layer
- **`lib/screens/history_screen.dart`**:
  - Added filter chips for `email`, `phone`, `sms`, `applink`, `productbarcode`, and `isbn` using existing localized strings (`historyFilterEmail`, `historyFilterPhone`, etc.).
- **`lib/screens/widgets/history_card.dart`**:
  - Added icon mapping in `_getCategoryIcon()` for all new categories (`Icons.email`, `Icons.phone`, `Icons.sms`, `Icons.launch`, `Icons.qr_code_scanner`, `Icons.menu_book`).
  - Added theme color mapping in `_getCategoryColor()` for all new categories.
- **`lib/screens/widgets/app_link_action_card.dart`**:
  - Replaced the hardcoded `'APP'` string literal with `l10n.appLinkCardTitle.toUpperCase()`.

### Test Suite Layer
- **`test/services/payload_parser_service_test.dart`**:
  - Added unit tests for `EmailPayload` (`mailto:`, `MATMSG:`, and raw email fallback).
  - Added unit tests for `PhonePayload` (`tel:` and raw phone number fallback).
  - Added unit tests for `SmsPayload` (`sms:`, `smsto:`, `mms:`).
  - Added unit tests for `AppLinkPayload` (Play Store, WhatsApp, Telegram, YouTube).
  - Added unit tests for `IsbnPayload` (ISBN-10, ISBN-13 checksum validation and rejection).
  - Added unit tests for `ProductBarcodePayload` (EAN-13, UPC-A, EAN-8).
- **`test/services/payload_action_service_test.dart`**:
  - Added unit tests for `sendEmail`, `dialPhone`, `sendSms`, `openAppLink`, `searchProduct`, and `lookupBook` using `plugins.flutter.io/url_launcher` mock channel.

## Verification
- `dart format .`: Formatted cleanly.
- `flutter analyze`: 0 issues found.
- `flutter test`: All 227 tests passed.
