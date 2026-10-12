import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/screens/features_screen.dart';

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

      expect(find.text(l10n.settingsFeaturesTitle), findsOneWidget);
      expect(find.text(l10n.featuresHeaderTitle), findsOneWidget);
      expect(find.text(l10n.featureBarcodeEngineTitle), findsOneWidget);

      // The last feature card is reachable by scrolling.
      await tester.scrollUntilVisible(
        find.text(l10n.featureOfflinePrivacyTitle),
        400,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text(l10n.featureOfflinePrivacyTitle), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }
}
