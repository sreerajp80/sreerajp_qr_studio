import 'package:material_ui/material_ui.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sreerajp_qr_studio/providers/ar_codevision_provider.dart';
import 'package:sreerajp_qr_studio/screens/ar_codevision_screen.dart';

import '../helpers/accessibility_checks.dart';
import '../helpers/test_app.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    FlutterSecureStorage.setMockInitialValues({});
  });

  Future<ValueNotifier<int>> pumpScreen(
    WidgetTester tester, {
    Locale locale = const Locale('en'),
  }) async {
    final requests = fakeCameraPlatform();
    await tester.pumpWidget(
      buildTestApp(
        locale: locale,
        providers: [
          ChangeNotifierProvider(create: (_) => ArCodevisionProvider()),
        ],
        home: const ArCodevisionScreen(),
      ),
    );
    await tester.pumpAndSettle();
    return requests;
  }

  for (final locale in appTestLocales) {
    testWidgets(
      'camera permission denied shows the message in ${locale.languageCode}',
      (tester) async {
        final l10n = l10nFor(locale);
        final requests = await pumpScreen(tester, locale: locale);

        expect(requests.value, 1);
        expect(find.text(l10n.titleArScreen), findsOneWidget);
        expect(find.text(l10n.bodyArCameraPermission), findsOneWidget);
        expect(find.text(l10n.actionGrantCameraPermission), findsOneWidget);
        expect(find.byTooltip(l10n.tooltipBack), findsOneWidget);
        expect(tester.takeException(), isNull);
        expectAllIconButtonsHaveTooltips(tester);
      },
    );
  }

  testWidgets('"Grant camera permission" asks again', (tester) async {
    final l10n = l10nFor(const Locale('en'));
    final requests = await pumpScreen(tester);

    await tester.tap(find.text(l10n.actionGrantCameraPermission));
    await tester.pumpAndSettle();

    expect(requests.value, 2);
    expect(find.text(l10n.bodyArCameraPermission), findsOneWidget);
  });

  for (final locale in appTestLocales) {
    testWidgets('mode switch shows both modes in ${locale.languageCode}', (
      tester,
    ) async {
      final l10n = l10nFor(locale);
      await pumpScreen(tester, locale: locale);

      expect(find.byType(SegmentedButton<ArHudMode>), findsOneWidget);
      expect(find.text(l10n.labelArModeWarehouse), findsOneWidget);
      expect(find.text(l10n.labelArModeSafety), findsOneWidget);
      expect(find.byTooltip(l10n.tooltipArModeWarehouse), findsOneWidget);
      expect(find.byTooltip(l10n.tooltipArModeSafety), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('tapping Safety and Warehouse changes the mode', (tester) async {
    final l10n = l10nFor(const Locale('en'));
    await pumpScreen(tester);
    final provider = Provider.of<ArCodevisionProvider>(
      tester.element(find.byType(ArCodevisionScreen)),
      listen: false,
    );
    expect(provider.hudMode, ArHudMode.warehouse);

    await tester.tap(find.text(l10n.labelArModeSafety));
    await tester.pumpAndSettle();
    expect(provider.hudMode, ArHudMode.safety);

    await tester.tap(find.text(l10n.labelArModeWarehouse));
    await tester.pumpAndSettle();
    expect(provider.hudMode, ArHudMode.warehouse);
  });
}
