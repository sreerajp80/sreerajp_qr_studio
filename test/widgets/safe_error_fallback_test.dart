import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/widgets/safe_error_fallback.dart';

void main() {
  testWidgets('renders without any app, theme or localizations', (
    tester,
  ) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: SafeErrorFallback(),
      ),
    );
    expect(tester.takeException(), isNull);
    expect(find.byType(SafeErrorFallback), findsOneWidget);
    expect(find.byType(Text), findsNothing);
  });
}
