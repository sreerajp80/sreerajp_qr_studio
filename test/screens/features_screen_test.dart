import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/screens/features_screen.dart';

import '../helpers/accessibility_checks.dart';
import '../helpers/test_app.dart';

void main() {
  for (final locale in appTestLocales) {
    testWidgets('builds and lists features in ${locale.languageCode}', (
      tester,
    ) async {
      final l10n = l10nFor(locale);
      await tester.pumpWidget(
        buildTestApp(locale: locale, home: const FeaturesScreen()),
      );
      await tester.pumpAndSettle();

      expect(find.text(l10n.titleSettingsFeatures), findsOneWidget);
      expect(find.text(l10n.titleFeaturesHeader), findsOneWidget);
      expect(find.text(l10n.titleFeatureBarcodeEngine), findsOneWidget);

      // The last feature card is reachable by scrolling.
      await tester.scrollUntilVisible(
        find.text(l10n.titleFeatureOfflinePrivacy),
        400,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text(l10n.titleFeatureOfflinePrivacy), findsOneWidget);
      expect(tester.takeException(), isNull);
      expectAllIconButtonsHaveTooltips(tester);
    });
  }
}
