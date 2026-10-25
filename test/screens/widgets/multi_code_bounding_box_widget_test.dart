import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sreerajp_qr_studio/models/code_content_type.dart';
import 'package:sreerajp_qr_studio/models/code_format.dart';
import 'package:sreerajp_qr_studio/models/visible_barcode.dart';
import 'package:sreerajp_qr_studio/screens/widgets/multi_code_bounding_box_widget.dart';

import '../../helpers/test_app.dart';

final _barcode = VisibleBarcode(
  id: 'b1',
  rawValue: 'https://example.com',
  format: CodeFormat.qrCode,
  type: CodeContentType.url,
  corners: const [],
  boundingBox: const Rect.fromLTWH(0, 0, 100, 100),
  screenRect: const Rect.fromLTWH(40, 80, 160, 160),
  lastSeen: DateTime(2026, 10, 22),
  isUrl: true,
  displayLabel: 'example.com',
);

void main() {
  for (final locale in appTestLocales) {
    for (final isSelected in [false, true]) {
      testWidgets('renders (selected: $isSelected) and taps in '
          '${locale.languageCode}', (tester) async {
        var taps = 0;
        await tester.pumpWidget(
          buildTestApp(
            locale: locale,
            home: Scaffold(
              body: Stack(
                children: [
                  MultiCodeBoundingBoxWidget(
                    barcode: _barcode,
                    isSelected: isSelected,
                    onTap: () => taps++,
                  ),
                ],
              ),
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 300));

        expect(find.text('example.com'), findsOneWidget);
        final tooltip = tester.widget<Tooltip>(find.byType(Tooltip));
        expect(tooltip.message, l10nFor(locale).tooltipMultiCodeTapToScan);
        await tester.tap(find.byType(InkWell));
        expect(taps, 1);
        expect(tester.takeException(), isNull);
      });
    }
  }

  testWidgets('a very long label in a small box does not overflow', (
    tester,
  ) async {
    final longLabel = _barcode.copyWith(
      screenRect: const Rect.fromLTWH(40, 80, 80, 80),
      displayLabel: 'https://example.com/a/very/long/path/that/never/ends',
    );
    await tester.pumpWidget(
      buildTestApp(
        home: Scaffold(
          body: Stack(
            children: [
              MultiCodeBoundingBoxWidget(
                barcode: longLabel,
                isSelected: false,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text(longLabel.displayLabel), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
