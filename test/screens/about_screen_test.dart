import 'dart:io';

import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sreerajp_qr_studio/core/config/config_service.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/screens/about_screen.dart';
import 'package:sreerajp_qr_studio/widgets/made_with_love.dart';

import '../helpers/accessibility_checks.dart';
import '../helpers/test_app.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    PackageInfo.setMockInitialValues(
      appName: 'Test QR Studio',
      packageName: 'in.sreerajp.qr_studio',
      version: '1.0.0',
      buildNumber: '1',
      buildSignature: '',
    );
  });

  testWidgets('AboutScreen renders app details and MadeWithLove widget', (
    tester,
  ) async {
    Future<String> mockLoader(String path) async {
      return '''
      {
        "appName": "Test QR Studio",
        "description": "A test QR scanner application.",
        "version": "1.0.0",
        "build": "1",
        "details": {
          "author": "Test Author",
          "email": "test@example.com",
          "license": "Open Source"
        }
      }
      ''';
    }

    final configService = ConfigService(loadAsset: mockLoader);

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          ...GlobalMaterialLocalizations.delegates,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: AboutScreen(configService: configService),
      ),
    );

    await tester.pumpAndSettle();

    // Verify app name and description
    expect(find.text('Test QR Studio'), findsOneWidget);
    expect(find.text('A test QR scanner application.'), findsOneWidget);

    // Verify localized detail titles
    expect(find.text('Author'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('License'), findsOneWidget);

    // Verify detail values
    expect(find.text('Test Author'), findsOneWidget);
    expect(find.text('test@example.com'), findsOneWidget);
    expect(find.text('Open Source'), findsOneWidget);

    // Verify MadeWithLove widget is present
    expect(find.byType(MadeWithLove), findsOneWidget);
  });

  for (final locale in appTestLocales) {
    testWidgets(
      'renders in ${locale.languageCode} without overflow; icon buttons have '
      'tooltips',
      (tester) async {
        final configService = ConfigService(
          loadAsset: (_) async =>
              File('assets/config/app_config.json').readAsStringSync(),
        );
        await tester.pumpWidget(
          buildTestApp(
            locale: locale,
            home: AboutScreen(configService: configService),
          ),
        );
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        expectAllIconButtonsHaveTooltips(tester);
      },
    );
  }

  testWidgets('shows the privacy policy row with its localized label', (
    tester,
  ) async {
    final l10n = l10nFor(const Locale('en'));
    final configService = ConfigService(
      loadAsset: (_) async =>
          File('assets/config/app_config.json').readAsStringSync(),
    );
    await tester.pumpWidget(
      buildTestApp(home: AboutScreen(configService: configService)),
    );
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text(l10n.aboutDetailPrivacyPolicy),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text(l10n.aboutDetailPrivacyPolicy), findsOneWidget);
    expect(find.textContaining('PRIVACY_POLICY.md'), findsOneWidget);
  });
}
