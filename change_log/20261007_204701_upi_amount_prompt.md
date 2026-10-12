# Ask for the amount when a UPI QR has none

Implements plan: [plans/20261007_204215_upi_amount_prompt.md](../plans/20261007_204215_upi_amount_prompt.md)

## Why

Static shop UPI QRs have no `am` (amount) value. Some UPI apps, such as Amazon Pay, do not
let the user type an amount when another app opens the link. They show "Invalid amount,
at least ₹1 needed", so the payment could not go ahead.

## What changed

### Service — `lib/services/payload_action_service.dart`

- New `upiNeedsAmount(payment)`: true for a UPI payload whose amount is missing, empty,
  not a number, or 0 or less.
- New `isValidUpiAmount(text)`: digits with up to 2 decimal places, value ₹1 or more.
- New `withUpiAmount(raw, amount)`: sets `am` to the amount with 2 decimal places. It
  replaces an existing `am` value or adds one at the end. The rest of the link is kept
  exactly as scanned.
- `payViaApp(payment, {amount})`: when an amount is given for a UPI payload, it opens the
  link with that amount. Otherwise it behaves as before.

### Screens

- New `lib/screens/widgets/upi_amount_dialog.dart`: an **Enter amount** dialog. It shows
  the payee name and a number field with a `₹` prefix. The **Pay** button stays off until
  the amount is valid, and an error is shown for a bad amount. It returns the amount, or
  `null` on cancel.
- `lib/screens/widgets/payment_action_card.dart`: **Pay via App** shows the dialog when
  `upiNeedsAmount` is true. If the user cancels, no app is opened.

### Text (`lib/l10n/app_en.arb`, `app_ml.arb`, `app_sa.arb`, regenerated `lib/l10n/gen/*`)

New keys in all three languages: `paymentAmountDialogTitle`, `paymentAmountDialogBody`
(with a `payee` placeholder), `paymentAmountFieldLabel`, `paymentAmountInvalid`,
`paymentAmountPayButton`. The dialog reuses the existing `cancelButton` key.

Change from the plan: the Sanskrit text uses passive imperative forms
(`धनराशिः लिख्यताम्`, `दीयताम्`), to match the style of the existing Sanskrit strings
(for example `प्रतिलिख्यताम्`).

### Tests

- `test/services/payload_action_service_test.dart`: tests for `upiNeedsAmount`,
  `isValidUpiAmount`, `withUpiAmount` (add, replace `am=` / `am=0`, keeps spaces in `pn`,
  does not touch `tam=`) and `payViaApp` with and without an amount.
- New `test/screens/widgets/upi_amount_dialog_test.dart`: Pay is off at first, error for
  `0.5`, Pay turns on for a valid amount, Pay returns the amount, Cancel returns `null`.

### Docs

- `docs/features.md`: one line about the amount prompt under "Payment links".

## Checks

- `flutter gen-l10n` — done.
- `dart format` — done on changed files.
- `flutter analyze` — no issues.
- `flutter test` — all 483 tests passed, including the l10n key parity and Sanskrit
  Hindi-marker tests.
- Not tested on a phone yet.
