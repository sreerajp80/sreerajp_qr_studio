import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/widgets/plain_text_export_confirm.dart';

import '../helpers/accessibility_checks.dart';
import '../helpers/test_app.dart';

void main() {
  Future<bool?> openAndChoose(
    WidgetTester tester, {
    required Locale locale,
    required bool exportAnyway,
    bool suggestBackup = false,
  }) async {
    final l10n = l10nFor(locale);
    bool? result;
    await tester.pumpWidget(
      buildTestApp(
        locale: locale,
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: TextButton(
                onPressed: () async {
                  result = await confirmPlainTextExport(
                    context,
                    suggestBackup: suggestBackup,
                  );
                },
                child: const Text('open'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    expect(find.text(l10n.titlePlainExport), findsOneWidget);
    expect(tester.takeException(), isNull);
    expectAllIconButtonsHaveTooltips(tester);
    if (suggestBackup) {
      expect(
        find.textContaining(l10n.bodyPlainExportBackupHint),
        findsOneWidget,
      );
    }
    await tester.tap(
      find.text(exportAnyway ? l10n.actionExportAnyway : l10n.actionCancel),
    );
    await tester.pumpAndSettle();
    return result;
  }

  testWidgets('Cancel returns false', (tester) async {
    expect(
      await openAndChoose(
        tester,
        locale: const Locale('en'),
        exportAnyway: false,
      ),
      isFalse,
    );
  });

  for (final locale in appTestLocales) {
    testWidgets('Export anyway returns true in ${locale.languageCode}', (
      tester,
    ) async {
      expect(
        await openAndChoose(
          tester,
          locale: locale,
          exportAnyway: true,
          suggestBackup: true,
        ),
        isTrue,
      );
    });
  }
}
