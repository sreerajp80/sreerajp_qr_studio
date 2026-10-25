import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sreerajp_qr_studio/widgets/focus_ring_widget.dart';

void main() {
  testWidgets('animates at the tap point and reports when done', (
    tester,
  ) async {
    var done = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Stack(
            children: [
              FocusRingWidget(
                position: const Offset(150, 250),
                onAnimationComplete: () => done++,
              ),
            ],
          ),
        ),
      ),
    );

    final positioned = tester.widget<Positioned>(find.byType(Positioned));
    expect(positioned.left, 150 - 32);
    expect(positioned.top, 250 - 32);
    expect(done, 0);

    await tester.pump(const Duration(milliseconds: 1000));
    await tester.pump();
    expect(done, 1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('does not report after it is removed early', (tester) async {
    var done = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Stack(
          children: [
            FocusRingWidget(
              position: Offset.zero,
              onAnimationComplete: () => done++,
            ),
          ],
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pumpWidget(const MaterialApp(home: SizedBox()));
    await tester.pump(const Duration(seconds: 1));

    expect(done, 0);
    expect(tester.takeException(), isNull);
  });
}
