import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sreeraj_qr_reader/core/config/config_service.dart';
import 'package:sreeraj_qr_reader/l10n/gen/app_localizations.dart';
import 'package:sreeraj_qr_reader/screens/about_screen.dart';
import 'package:sreeraj_qr_reader/widgets/made_with_love.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    PackageInfo.setMockInitialValues(
      appName: 'Test QR Reader',
      packageName: 'in.sreeraj.qr_reader',
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
        "appName": "Test QR Reader",
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
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: AboutScreen(configService: configService),
      ),
    );

    await tester.pumpAndSettle();

    // Verify app name and description
    expect(find.text('Test QR Reader'), findsOneWidget);
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
}
