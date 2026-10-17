import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/services/payload_action_service.dart';

/// Asks the user for a payment amount when a scanned UPI code has none.
class UpiAmountDialog extends StatefulWidget {
  final String payeeName;

  const UpiAmountDialog({super.key, required this.payeeName});

  /// Shows the dialog. Returns the entered amount, or `null` if cancelled.
  static Future<String?> show(
    BuildContext context, {
    required String payeeName,
  }) {
    return showDialog<String>(
      context: context,
      builder: (_) => UpiAmountDialog(payeeName: payeeName),
    );
  }

  @override
  State<UpiAmountDialog> createState() => _UpiAmountDialogState();
}

class _UpiAmountDialogState extends State<UpiAmountDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _isValid => PayloadActionService.isValidUpiAmount(_controller.text);

  void _submit() {
    if (_isValid) Navigator.of(context).pop(_controller.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final showError = _controller.text.trim().isNotEmpty && !_isValid;

    return AlertDialog(
      title: Text(l10n.titlePaymentAmountDialog),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.bodyPaymentAmountDialog(widget.payeeName)),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            autofocus: true,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
            ],
            decoration: InputDecoration(
              labelText: l10n.labelPaymentAmountField,
              prefixText: '₹ ',
              errorText: showError ? l10n.errorPaymentAmountInvalid : null,
              border: const OutlineInputBorder(),
            ),
            onChanged: (_) => setState(() {}),
            onSubmitted: (_) => _submit(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.actionCancel),
        ),
        FilledButton(
          onPressed: _isValid ? _submit : null,
          child: Text(l10n.actionPaymentAmountPay),
        ),
      ],
    );
  }
}
