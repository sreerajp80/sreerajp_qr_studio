import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/providers/theme_provider.dart';
import 'package:sreerajp_qr_studio/screens/widgets/scan_overlay_widget.dart';

void main() {
  group('ScanOverlayWidget Tests', () {
    testWidgets('renders with default 290.0 scanAreaSize', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ScanOverlayWidget(style: ScanOverlayStyle.subtleDotMatrix),
          ),
        ),
      );
      await tester.pump();

      final customPaintFinder = find.byType(CustomPaint);
      expect(customPaintFinder, findsWidgets);

      // Verify widget instance properties
      final overlayFinder = find.byType(ScanOverlayWidget);
      expect(overlayFinder, findsOneWidget);
      final widget = tester.widget<ScanOverlayWidget>(overlayFinder);
      expect(widget.scanAreaSize, equals(290.0));
      expect(widget.style, equals(ScanOverlayStyle.subtleDotMatrix));
    });

    testWidgets('renders with custom expanded scanAreaSize', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ScanOverlayWidget(
              style: ScanOverlayStyle.laserLine,
              scanAreaSize: 320.0,
            ),
          ),
        ),
      );
      await tester.pump();

      final overlayFinder = find.byType(ScanOverlayWidget);
      expect(overlayFinder, findsOneWidget);
      final widget = tester.widget<ScanOverlayWidget>(overlayFinder);
      expect(widget.scanAreaSize, equals(320.0));
      expect(widget.style, equals(ScanOverlayStyle.laserLine));
    });

    testWidgets('renders all styles without errors', (tester) async {
      for (final style in ScanOverlayStyle.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ScanOverlayWidget(style: style, scanAreaSize: 300.0),
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 100));
        expect(find.byType(ScanOverlayWidget), findsOneWidget);
      }
    });
  });
}
