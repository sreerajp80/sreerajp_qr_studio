# Smart Quick-Action Cards for All Payload Types

**Status:** Approved

## Problem

When the app scans a QR code containing a Wi-Fi config, email address, phone number, SMS, or app deep link, it only shows the raw text with a "Copy" button. Users must manually copy and paste data into the right app. We want to add 1-tap action buttons for every recognized payload type.

## Scope

Add new payload types, parser logic, action service methods, action card widgets, and localization strings for the following content categories:

| # | Payload Type | Example Input | Primary Action |
|---|---|---|---|
| 1 | Email / Mailto | `mailto:user@example.com` or `MATMSG:TO:...` or `name@domain.com` | Open default mail app |
| 2 | Phone | `tel:+1234567890` or raw phone number | Open phone dialer |
| 3 | SMS | `sms:+1234567890?body=Hello` or `SMSTO:...` | Open messaging app |
| 4 | App / Deep Link | `market://details?id=...`, `wa.me/...`, `https://play.google.com/store/apps/details?id=...` | Open in native app |
| 5 | Product Barcode | EAN-13, UPC-A barcodes | Search product online |
| 6 | ISBN (Book) | ISBN-10/13 barcodes | Look up book info |

Additionally, enhance the existing Wi-Fi action card to use the Android Wi-Fi suggestion API (via platform channel or `ACTION_WIFI_ADD_NETWORKS` intent) instead of just opening Wi-Fi settings.

---

## Proposed Changes

### Models Layer

#### [NEW] `lib/models/parsed_payload.dart` — Add new payload types

Add new `PayloadType` enum values and payload classes:

- Add to `PayloadType` enum: `email`, `phone`, `sms`, `appLink`, `productBarcode`, `isbn`
- `EmailPayload` — fields: `toAddress`, `subject`, `body`, `cc`, `bcc`
- `PhonePayload` — fields: `number`, `label`
- `SmsPayload` — fields: `number`, `body`
- `AppLinkPayload` — fields: `appName`, `packageId`, `storeName`, `deepLinkUri`
- `ProductBarcodePayload` — fields: `code`, `format` (EAN-13, UPC-A, etc.)
- `IsbnPayload` — fields: `isbn`, `isIsbn13`

All classes will use `const` constructors and be immutable per architecture rules.

---

### Services Layer

#### [MODIFY] `lib/services/payload_parser_service.dart`

Add new parser branches (inserted before the `GenericPayload` fallback):

1. **Email**: Detect `mailto:`, `MATMSG:TO:`, and raw email regex `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$`
2. **Phone**: Detect `tel:`, `TEL:`, and raw phone regex (international format with +)
3. **SMS**: Detect `sms:`, `smsto:`, `SMSTO:`, `mms:`
4. **App Link**: Detect `market://`, Play Store URLs, `wa.me/`, `whatsapp://`, `tg://`, `https://t.me/`, `youtube://`, `vnd.youtube:`
5. **Product Barcode**: When `BarcodeType` is `ean13` or `upcA` and not matching other patterns, check if numeric-only and the right length
6. **ISBN**: When content is 10 or 13 digits starting with 978/979 (ISBN-13) or a 10-char ISBN-10

> [!NOTE]
> The parser ordering matters — email/phone/SMS checks must come before the generic URL check so that `mailto:` is not treated as a URL.

#### [MODIFY] `lib/services/payload_action_service.dart`

Add new static action methods:

- `sendEmail(EmailPayload)` — builds `mailto:` URI with subject/body/cc and launches
- `dialPhone(PhonePayload)` — builds `tel:` URI and launches dialer
- `sendSms(SmsPayload)` — builds `sms:` URI with body and launches messaging
- `openAppLink(AppLinkPayload)` — launches the deep link URI directly
- `searchProduct(ProductBarcodePayload)` — opens search URL (Open Food Facts or Google Shopping)
- `lookupBook(IsbnPayload)` — opens Google Books or Open Library URL
- `connectToWifi(WifiPayload)` — uses `ACTION_WIFI_ADD_NETWORKS` intent to trigger system Wi-Fi save/connect prompt (falls back to `openWifiSettings()` on older Android versions)

---

### Widgets Layer

#### [NEW] `lib/screens/widgets/email_action_card.dart`

Email action card showing:
- Mail icon with recipient name/address
- Subject and body preview (if present)
- "Send Email" primary button (opens default mail app)
- "Copy Email" secondary button

#### [NEW] `lib/screens/widgets/phone_action_card.dart`

Phone action card showing:
- Phone icon with the number displayed
- Label if available
- "Call" primary button (opens dialer)
- "Copy Number" secondary button

#### [NEW] `lib/screens/widgets/sms_action_card.dart`

SMS action card showing:
- Message icon with recipient number
- Body preview if present
- "Send Message" primary button (opens messaging app)
- "Copy" secondary button

#### [NEW] `lib/screens/widgets/app_link_action_card.dart`

App/deep link action card showing:
- App icon (Play Store, WhatsApp, Telegram, YouTube, or generic app)
- App name and package ID
- "Open in App" primary button

#### [NEW] `lib/screens/widgets/product_barcode_action_card.dart`

Product barcode card showing:
- Barcode icon with the product code
- Barcode format label (EAN-13, UPC-A)
- "Search Product" primary button (opens browser search)

#### [NEW] `lib/screens/widgets/isbn_action_card.dart`

Book/ISBN card showing:
- Book icon with ISBN number
- ISBN format label (ISBN-10, ISBN-13)
- "Look Up Book" primary button (opens Google Books / Open Library)

---

### Screens Layer

#### [MODIFY] `lib/screens/result_screen.dart`

1. Add imports for all six new action card widgets
2. Extend `_buildSmartPayloadCard()` with `else if` branches for `EmailPayload`, `PhonePayload`, `SmsPayload`, `AppLinkPayload`, `ProductBarcodePayload`, `IsbnPayload`
3. Extend `_buildResultTypeCard()` icon/label mapping for the new types

#### [MODIFY] `lib/screens/widgets/wifi_action_card.dart`

Update the "Connect to Wi-Fi" button's `onPressed` to call `PayloadActionService.connectToWifi()` (the new system Wi-Fi save intent), falling back to the old `openWifiSettings()` behavior.

---

### Localization

#### [MODIFY] `lib/l10n/app_en.arb`

Add localization strings for all new cards:
- `emailCardTitle`, `emailSendButton`, `emailCopyButton`, `emailLaunchFailed`, `emailSubjectLabel`, `emailBodyLabel`
- `phoneCardTitle`, `phoneCallButton`, `phoneCopyButton`, `phoneLaunchFailed`
- `smsCardTitle`, `smsSendButton`, `smsCopyButton`, `smsLaunchFailed`, `smsBodyLabel`
- `appLinkCardTitle`, `appLinkOpenButton`, `appLinkLaunchFailed`
- `productBarcodeCardTitle`, `productSearchButton`, `productLaunchFailed`
- `isbnCardTitle`, `isbnLookupButton`, `isbnLaunchFailed`
- `wifiConnectFailed` (for the new Wi-Fi connect attempt)
- History filter labels: `historyFilterEmail`, `historyFilterPhone`, `historyFilterSms`, `historyFilterAppLink`, `historyFilterProductBarcode`, `historyFilterIsbn`

After editing, run `flutter gen-l10n`.

---

### Provider Layer

#### [MODIFY] `lib/providers/scan_provider.dart`

No structural changes needed. The existing `_parsedPayload = _payloadParserService.parse(result)` flow automatically picks up new payload types returned by the parser. The `createScanRecord()` method already uses `_parsedPayload!.type.name` for the category field, so new types will be saved correctly.

---

## Open Questions

> [!IMPORTANT]
> **Wi-Fi direct connect**: The `ACTION_WIFI_ADD_NETWORKS` intent needs Android 11+ (API 30). Since `minSdk` is 24, do you want a platform channel (Kotlin method channel) to handle this, or is it acceptable to keep the current "copy password + open Wi-Fi settings" behavior for Android 10 and below?

> [!IMPORTANT]
> **Product search provider**: For product barcode lookups, which search provider do you prefer?
> - **Open Food Facts** (free, open-source, food-focused)
> - **Google Shopping** (general products, opens in browser)
> - **Both** (show two buttons: "Food Info" and "Search Product")

> [!IMPORTANT]
> **App link scope**: Should we detect only the major apps (Play Store, WhatsApp, Telegram, YouTube) as app links, or also detect any custom URI scheme (e.g., `spotify:`, `instagram://`, etc.) and show a generic "Open in App" button for them?

---

## Verification Plan

### Automated Tests
```bash
flutter analyze
flutter test
```

### Manual Verification
- Scan Wi-Fi QR → verify system Wi-Fi save prompt appears (Android 11+) or Wi-Fi settings open (Android 10 and below)
- Scan `mailto:test@example.com?subject=Hello` → verify Gmail/email app opens
- Scan `tel:+1234567890` → verify phone dialer opens
- Scan `sms:+1234567890?body=Test` → verify messaging app opens
- Scan a Play Store URL → verify Play Store opens
- Scan an EAN-13 product barcode → verify product search opens
- Scan an ISBN → verify book lookup opens
