# Plan: Smart Action Cards Gaps and History Integration

**Status:** completed

## Files to be changed
- `lib/services/history_database_service.dart`
- `lib/screens/history_screen.dart`
- `lib/screens/widgets/history_card.dart`
- `lib/screens/widgets/app_link_action_card.dart`
- `test/services/payload_parser_service_test.dart`
- `test/services/payload_action_service_test.dart`

## What the issue is
In the previous smart action cards implementation, six new payload types (`EmailPayload`, `PhonePayload`, `SmsPayload`, `AppLinkPayload`, `ProductBarcodePayload`, `IsbnPayload`) were added with dedicated action cards, but:
1. **Missing Unit Tests:** `test/services/payload_parser_service_test.dart` and `test/services/payload_action_service_test.dart` lack test cases for the 6 new types.
2. **Missing History Filter Chips:** `lib/screens/history_screen.dart` lacks filter chips for Email, Phone, SMS, App Link, Product, and Book, even though localization strings exist.
3. **Missing Category Visuals in History:** `lib/screens/widgets/history_card.dart` does not map the new categories to icons and colors, showing a generic text icon.
4. **SQLite Case Sensitivity:** `ScanProvider` stores camelCase category names (`appLink`, `productBarcode`), but `HistoryDatabaseService` filters with `category.toLowerCase()`. Without `LOWER(category)` in the query, filtering these categories fails.
5. **Hardcoded Fallback String:** In `lib/screens/widgets/app_link_action_card.dart`, `'APP'` is hardcoded rather than localized.

## Plan for the fix
1. **Database:** Update `getRecords()` in `lib/services/history_database_service.dart` to use `LOWER(category) = ?` for case-insensitive matching.
2. **History Screen:** Add the 6 category chips (`email`, `phone`, `sms`, `applink`, `productbarcode`, `isbn`) to `categoryChips` in `lib/screens/history_screen.dart`.
3. **History Card:** Add icon and color mappings for the new categories in `lib/screens/widgets/history_card.dart`.
4. **Action Card:** Replace the hardcoded `'APP'` text in `lib/screens/widgets/app_link_action_card.dart` with localized text.
5. **Tests:**
   - Add unit tests in `test/services/payload_parser_service_test.dart` for email, phone, sms, app link, isbn, and product barcode parsing.
   - Add unit tests in `test/services/payload_action_service_test.dart` for action methods.
6. Verify with `flutter analyze` and `flutter test`.
