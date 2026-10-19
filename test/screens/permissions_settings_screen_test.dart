import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sreerajp_qr_studio/screens/settings_screen.dart';

import '../helpers/test_app.dart';

/// A very tall phone, so the whole list is built without scrolling.
void _useTallView(WidgetTester tester) {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = const Size(400, 12000);
  addTearDown(tester.view.reset);
}

void main() {
  for (final locale in appTestLocales) {
    testWidgets('shows every permission group and row in $locale', (
      tester,
    ) async {
      _useTallView(tester);
      await tester.pumpWidget(
        buildTestApp(home: const PermissionsSettingsScreen(), locale: locale),
      );
      await tester.pumpAndSettle();
      final l10n = l10nFor(locale);

      expect(find.text(l10n.titlePermissionsScreen), findsOneWidget);
      expect(find.text(l10n.helpPermissionsIntro), findsOneWidget);
      for (final group in kPermissionGroups) {
        expect(find.text(group.title(l10n)), findsOneWidget);
        expect(find.text(group.note(l10n)), findsOneWidget);
        for (final entry in group.entries) {
          expect(find.text(entry.title(l10n)), findsOneWidget);
          expect(find.text(entry.description(l10n)), findsOneWidget);
        }
      }
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('shows the Android names for each permission row', (
    tester,
  ) async {
    _useTallView(tester);
    await tester.pumpWidget(
      buildTestApp(home: const PermissionsSettingsScreen()),
    );
    await tester.pumpAndSettle();

    for (final group in kPermissionGroups) {
      for (final entry in group.entries) {
        if (entry.androidPermissions.isEmpty) continue;
        expect(find.text(entry.androidPermissions.join(', ')), findsOneWidget);
      }
    }
  });
}
