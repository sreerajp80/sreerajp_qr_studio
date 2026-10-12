import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/l10n/sa_material_localizations.dart';
import 'package:sreerajp_qr_studio/providers/scan_bubble_provider.dart';
import 'package:sreerajp_qr_studio/screens/scan_bubble_settings_screen.dart';

import '../providers/scan_bubble_provider_test.dart' show FakeScanBubbleService;

void main() {
  Widget buildScreen(FakeScanBubbleService fake, {Locale? locale}) {
    return ChangeNotifierProvider(
      create: (_) => ScanBubbleProvider(service: fake),
      child: MaterialApp(
        locale: locale,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          SaMaterialLocalizationsDelegate(),
          SaCupertinoLocalizationsDelegate(),
          SaWidgetsLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: const ScanBubbleSettingsScreen(),
      ),
    );
  }

  testWidgets('shows switch, permission row and help text', (tester) async {
    await tester.pumpWidget(buildScreen(FakeScanBubbleService()));
    await tester.pumpAndSettle();

    expect(find.text('Scan bubble'), findsOneWidget);
    expect(find.text('Show scan bubble'), findsOneWidget);
    expect(find.text('Display over other apps'), findsOneWidget);
    expect(find.text('Allow'), findsOneWidget);
    expect(find.text('Start after restart'), findsOneWidget);
    expect(find.text('Add to Quick Settings'), findsOneWidget);
    expect(find.text('How to use it'), findsOneWidget);
  });

  testWidgets('turning on without permission shows the explain dialog', (
    tester,
  ) async {
    final fake = FakeScanBubbleService();
    await tester.pumpWidget(buildScreen(fake));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Show scan bubble'));
    await tester.pumpAndSettle();

    expect(find.text('Allow the bubble'), findsOneWidget);
    await tester.tap(find.text('Open settings'));
    await tester.pumpAndSettle();
    expect(fake.permissionPageOpened, 1);
    expect(fake.running, isFalse);
  });

  testWidgets('turning on with permission starts the bubble', (tester) async {
    final fake = FakeScanBubbleService(permission: true);
    await tester.pumpWidget(buildScreen(fake));
    await tester.pumpAndSettle();

    expect(find.text('Allowed'), findsOneWidget);
    await tester.tap(find.text('Show scan bubble'));
    await tester.pumpAndSettle();

    expect(fake.running, isTrue);
    final tile = tester.widget<SwitchListTile>(
      find.widgetWithText(SwitchListTile, 'Show scan bubble'),
    );
    expect(tile.value, isTrue);
  });

  for (final code in ['ml', 'sa']) {
    testWidgets('renders in $code without errors', (tester) async {
      await tester.pumpWidget(
        buildScreen(FakeScanBubbleService(), locale: Locale(code)),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(find.byType(SwitchListTile), findsNWidgets(2));
    });
  }
}
