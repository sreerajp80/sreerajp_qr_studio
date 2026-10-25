import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sreerajp_qr_studio/l10n/app_message_text.dart';
import 'package:sreerajp_qr_studio/models/app_message.dart';
import 'package:sreerajp_qr_studio/models/ar_code_target.dart';
import 'package:sreerajp_qr_studio/models/code_content_type.dart';
import 'package:sreerajp_qr_studio/providers/ar_codevision_provider.dart';
import 'package:sreerajp_qr_studio/screens/widgets/ar_floating_chip_widget.dart';

import '../../helpers/test_app.dart';

ArCodeTarget _target({bool isUrl = false, bool isSelected = false}) {
  return ArCodeTarget(
    id: 't1',
    rawValue: isUrl ? 'https://example.com/a/very/long/path' : 'HELLO',
    type: isUrl ? CodeContentType.url : CodeContentType.text,
    corners: const [],
    boundingBox: const Rect.fromLTWH(100, 200, 80, 80),
    isUrl: isUrl,
    safetyStatus: isUrl ? TargetSafetyStatus.safe : TargetSafetyStatus.unknown,
    priceTag: '₹199',
    formatName: const AppMessage(AppMessageKey.formatQrWifi),
    isSelected: isSelected,
    lastSeen: DateTime(2026, 10, 22),
  );
}

Widget _host(Widget chip, Locale locale) => buildTestApp(
  locale: locale,
  home: Scaffold(body: Stack(children: [chip])),
);

void main() {
  for (final locale in appTestLocales) {
    testWidgets('warehouse mode shows the price and a checkbox in '
        '${locale.languageCode}', (tester) async {
      bool? selected;
      var taps = 0;
      await tester.pumpWidget(
        _host(
          ArFloatingChipWidget(
            target: _target(),
            position: const Offset(200, 300),
            hudMode: ArHudMode.warehouse,
            onTap: () => taps++,
            onSelectionChanged: (value) => selected = value,
          ),
          locale,
        ),
      );
      final l10n = l10nFor(locale);

      expect(find.text('₹199'), findsOneWidget);
      expect(
        find.text(
          appMessageText(l10n, const AppMessage(AppMessageKey.formatQrWifi)),
        ),
        findsOneWidget,
      );
      await tester.tap(find.byType(Checkbox));
      expect(selected, isTrue);
      await tester.tap(find.text('₹199'));
      expect(taps, 1);
      expect(tester.takeException(), isNull);
    });

    testWidgets('safety mode shows the link instead of the price in '
        '${locale.languageCode}', (tester) async {
      await tester.pumpWidget(
        _host(
          ArFloatingChipWidget(
            target: _target(isUrl: true),
            position: const Offset(200, 300),
            hudMode: ArHudMode.safety,
            onTap: () {},
            onSelectionChanged: (_) {},
          ),
          locale,
        ),
      );

      expect(find.text('₹199'), findsNothing);
      expect(find.byType(Checkbox), findsNothing);
      expect(find.textContaining('example.com'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }
}
