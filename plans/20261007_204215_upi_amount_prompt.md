# Ask for the amount when a UPI QR has none

**Status:** completed

## What the issue is

Many shop QR codes are "static" UPI QRs. They have the payee but no amount, for example:

```
upi://pay?pa=<merchant-vpa>&pn=<MERCHANT NAME>&cu=INR
```

When the user taps **Pay via App**, `PayloadActionService.payViaApp` opens this link
exactly as it was scanned. Some UPI apps (seen with Amazon Pay) do not let the user type
an amount when another app opens the link. They read the missing amount as ₹0 and show an
"Invalid amount, at least ₹1 needed" error. The payment cannot go ahead.

We cannot send `am=0`. Under the UPI rules an amount must be above zero, so `am=0` gives
the same error. It can also break apps (like GPay) that work today.

## The fix (summary)

If a UPI QR has no amount, or its amount is 0 or empty, show a small **Enter amount**
dialog before opening the UPI app. The user types the amount (₹1 or more, up to 2 decimal
places). We add `am=<amount>` to the link and open the UPI app.

- If the QR already has a valid amount, nothing changes. No dialog is shown.
- SEPA and crypto links are not changed.
- If the user cancels the dialog, no app is opened.
- All other parts of the link stay exactly as scanned. We only add or replace `am`.

## Files to change

| File | Change |
| ---- | ------ |
| `lib/services/payload_action_service.dart` | Add pure helper methods. Let `payViaApp` take an optional amount. |
| `lib/screens/widgets/upi_amount_dialog.dart` (new, screens layer) | The **Enter amount** dialog widget. |
| `lib/screens/widgets/payment_action_card.dart` | Show the dialog when needed, then call `payViaApp` with the amount. |
| `lib/l10n/app_en.arb`, `app_ml.arb`, `app_sa.arb` | New text keys (with `@key` descriptions in English). |
| `lib/l10n/gen/*` | Regenerated with `flutter gen-l10n`. |
| `test/services/payload_action_service_test.dart` | Unit tests for the new helpers. |
| `test/screens/widgets/upi_amount_dialog_test.dart` (new) | Widget tests for the dialog. |
| `docs/features.md` | One line about the amount prompt under "Payment links". |
| `change_log/<timestamp>_upi_amount_prompt.md` (new) | Change log after the work is done. |

## Details

### 1. Service (`PayloadActionService`, services layer)

New static methods. They are pure (no UI, no `BuildContext`), so they are easy to test:

- `bool upiNeedsAmount(PaymentPayload p)`: true when `p.scheme == PaymentScheme.upi`
  and the amount is empty, cannot be read as a number, or is 0 or less.
- `bool isValidUpiAmount(String text)`: true when the text matches
  `^\d{1,7}(\.\d{1,2})?$` and its value is ≥ 1. We set no other upper limit, because
  the UPI app applies its own limits.
- `String withUpiAmount(String raw, String amount)`: returns the raw link with `am` set.
  - If the link already has an `am=` part (empty or 0), only that value is replaced.
  - If not, `&am=<amount>` is added to the end (or `?am=` if there is no query).
  - The rest of the string is not re-encoded, so the payee name and other values stay
    byte-for-byte as scanned.
  - The amount is normalised to 2 decimal places (for example `50` becomes `50.00`),
    which is the UPI format.

`payViaApp(PaymentPayload payment, {String? amount})`: if `amount` is given and the
scheme is UPI, it launches `withUpiAmount(payment.rawContent, amount)`. Otherwise it
launches the link as before. The error handling does not change: it never crashes and
returns `false` on failure.

### 2. Dialog (`UpiAmountDialog`, screens layer, new file)

- A `StatefulWidget` `AlertDialog` with:
  - title: "Enter amount"
  - a short line: "This QR has no amount. Enter the amount to pay."
  - one `TextField` with a decimal number keyboard, `₹` prefix, and autofocus
  - an error text under the field when the amount is not valid: "Enter ₹1 or more"
  - buttons: **Cancel** (reuse the existing `cancelButton` key) and **Pay**
- **Pay** is turned off until the amount is valid (checked with
  `PayloadActionService.isValidUpiAmount`).
- A static `show(context)` helper returns the amount as a `String`, or `null` when the
  user cancels.
- It shows the payee name, so the user knows who they are paying.

### 3. Payment card

In the **Pay via App** `onPressed`:

```
String? amount;
if (PayloadActionService.upiNeedsAmount(payment)) {
  amount = await UpiAmountDialog.show(context, payeeName: ...);
  if (amount == null || !context.mounted) return; // user cancelled
}
final launched = await PayloadActionService.payViaApp(payment, amount: amount);
```

The "could not open" snackbar stays as it is.

### 4. New text keys (all three languages)

All labels are short (22 characters or fewer for buttons and titles).

| Key | English | Malayalam | Sanskrit |
| --- | ------- | --------- | -------- |
| `paymentAmountDialogTitle` | Enter amount | തുക നൽകുക | धनराशिं लिखतु |
| `paymentAmountDialogBody` | This QR has no amount. Enter the amount to pay to {payee}. | ഈ QR-ൽ തുകയില്ല. {payee}-ന് നൽകേണ്ട തുക നൽകുക. | अस्मिन् QR-सङ्केते धनराशिः नास्ति। {payee} इत्यस्मै देयां धनराशिं लिखतु। |
| `paymentAmountFieldLabel` | Amount | തുക | धनराशिः |
| `paymentAmountInvalid` | Enter ₹1 or more | ₹1 അല്ലെങ്കിൽ കൂടുതൽ നൽകുക | ₹1 अथवा अधिकं लिखतु |
| `paymentAmountPayButton` | Pay | പണം നൽകുക | ददातु |

The Sanskrit text will be checked against the Hindi marker gate (§8.5). The Malayalam
text uses natural verb forms (§8.5.2). Each key gets an `@key` description in
`app_en.arb`. `paymentAmountDialogBody` gets a `payee` placeholder entry.

### 5. Tests

- `payload_action_service_test.dart`:
  - `upiNeedsAmount`: true for no `am`, `am=`, `am=0`, `am=0.00`, `am=abc`; false for
    `am=10`; false for SEPA and crypto.
  - `isValidUpiAmount`: accepts `1`, `1.5`, `250.75`; rejects `0`, `0.99`, `-5`,
    `1.234`, `abc`, empty.
  - `withUpiAmount`: adds `am` when it is missing; replaces `am=` and `am=0`; keeps the
    other parts (including spaces in `pn`) the same; formats `50` as `50.00`.
- `upi_amount_dialog_test.dart`: Pay is off at first; Pay turns on after a valid amount;
  the error shows for `0.5`; Cancel returns `null`; Pay returns the amount.
- The existing l10n parity and Sanskrit fallback tests must still pass.

### 6. Checks

- `flutter gen-l10n`
- `dart format .`
- `flutter analyze` (must be clean)
- `flutter test`

No install or test run on the phone without asking first.

## Out of scope

- Changing what the scan result screen shows (the amount badge stays as it is).
- Adding `cu=INR` when it is missing.
- Any change to the UPI QR maker (Code Forge).
