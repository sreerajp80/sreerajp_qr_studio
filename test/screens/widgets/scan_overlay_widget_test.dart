import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/providers/theme_provider.dart';
import 'package:sreerajp_qr_studio/screens/widgets/scan_overlay_widget.dart';

void main() {
  group('ScanOverlayWidget Micro-Interaction Tests', () {
    testWidgets('renders normally across all scan overlay styles', (
      tester,
    ) async {
      for (final style in ScanOverlayStyle.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(child: ScanOverlayWidget(style: style)),
            ),
          ),
        );
        expect(find.byType(ScanOverlayWidget), findsOneWidget);
        expect(find.byType(CustomPaint), findsWidgets);
      }
    });

    testWidgets('triggers success micro-animation and onAnimationComplete', (
      tester,
    ) async {
      var completed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: ScanOverlayWidget(
                style: ScanOverlayStyle.laserLine,
                isSuccess: true,
                onAnimationComplete: () {
                  completed = true;
                },
              ),
            ),
          ),
        ),
      );

      // Animation starts
      expect(completed, isFalse);

      // Advance through the 380ms animation duration
      await tester.pump(const Duration(milliseconds: 200));
      expect(completed, isFalse);

      await tester.pump(const Duration(milliseconds: 250));
      expect(completed, isTrue);
    });

    testWidgets(
      'transitions from idle to success upon widget property update',
      (tester) async {
        var completed = false;

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Center(
                child: ScanOverlayWidget(
                  style: ScanOverlayStyle.pulsingCorners,
                ),
              ),
            ),
          ),
        );

        await tester.pump(const Duration(milliseconds: 50));
        expect(completed, isFalse);

        // Update widget with isSuccess: true
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: ScanOverlayWidget(
                  style: ScanOverlayStyle.pulsingCorners,
                  isSuccess: true,
                  onAnimationComplete: () {
                    completed = true;
                  },
                ),
              ),
            ),
          ),
        );

        // Advance animation
        await tester.pump(const Duration(milliseconds: 400));
        expect(completed, isTrue);
      },
    );

    testWidgets('renders with detectedCorners and detectedBoundingBox', (
      tester,
    ) async {
      const corners = [
        Offset(20, 20),
        Offset(120, 20),
        Offset(120, 120),
        Offset(20, 120),
      ];

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: ScanOverlayWidget(
                style: ScanOverlayStyle.cyberneticGrid,
                detectedCorners: corners,
                isSuccess: true,
              ),
            ),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 100));
      expect(find.byType(ScanOverlayWidget), findsOneWidget);
    });
  });
}
