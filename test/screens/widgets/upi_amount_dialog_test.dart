import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/screens/widgets/upi_amount_dialog.dart';

void main() {
  String? result;
  var closed = false;

  Future<void> openDialog(WidgetTester tester) async {
    result = null;
    closed = false;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () async {
                result = await UpiAmountDialog.show(context, payeeName: 'Shop');
                closed = true;
              },
              child: const Text('open'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
  }

  FilledButton payButton(WidgetTester tester) =>
      tester.widget<FilledButton>(find.widgetWithText(FilledButton, 'Pay'));

  testWidgets('Pay is off until a valid amount is typed', (tester) async {
    await openDialog(tester);

    expect(find.text('Enter amount'), findsOneWidget);
    expect(find.textContaining('Shop'), findsOneWidget);
    expect(payButton(tester).onPressed, isNull);

    await tester.enterText(find.byType(TextField), '0.5');
    await tester.pump();
    expect(find.text('Enter ₹1 or more'), findsOneWidget);
    expect(payButton(tester).onPressed, isNull);

    await tester.enterText(find.byType(TextField), '150');
    await tester.pump();
    expect(find.text('Enter ₹1 or more'), findsNothing);
    expect(payButton(tester).onPressed, isNotNull);
  });

  testWidgets('Pay returns the entered amount', (tester) async {
    await openDialog(tester);
    await tester.enterText(find.byType(TextField), '42.50');
    await tester.pump();
    await tester.tap(find.text('Pay'));
    await tester.pumpAndSettle();

    expect(closed, isTrue);
    expect(result, '42.50');
  });

  testWidgets('Cancel returns null', (tester) async {
    await openDialog(tester);
    await tester.enterText(find.byType(TextField), '10');
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(closed, isTrue);
    expect(result, isNull);
  });
}
