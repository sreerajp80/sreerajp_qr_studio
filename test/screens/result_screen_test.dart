import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/l10n/sa_material_localizations.dart';
import 'package:sreerajp_qr_studio/models/app_message.dart';
import 'package:sreerajp_qr_studio/models/code_content_type.dart';
import 'package:sreerajp_qr_studio/models/dom_sandbox_result.dart';
import 'package:sreerajp_qr_studio/models/safety_check_result.dart';
import 'package:sreerajp_qr_studio/providers/scan_provider.dart';
import 'package:sreerajp_qr_studio/screens/result_screen.dart';
import 'package:sreerajp_qr_studio/services/dom_sandbox_service.dart';
import 'package:sreerajp_qr_studio/services/url_safety_service.dart';

/// Returns a fixed mix of checks: 1 failed, 2 passed, 2 skipped.
class _FakeUrlSafetyService extends UrlSafetyService {
  final bool withFailure;
  _FakeUrlSafetyService({this.withFailure = true});

  @override
  Future<bool> isActiveProbingEnabled() async => false;

  @override
  Future<List<SafetyCheckResult>> runAllChecks(String url) async => [
    const SafetyCheckResult(
      checkName: AppMessage(AppMessageKey.checkNameHttps),
      passed: true,
      message: AppMessage(AppMessageKey.sslValid),
    ),
    const SafetyCheckResult(
      checkName: AppMessage(AppMessageKey.checkNamePattern),
      passed: true,
      message: AppMessage(AppMessageKey.sslValid),
    ),
    SafetyCheckResult(
      checkName: const AppMessage(AppMessageKey.checkNameShortener),
      passed: !withFailure,
      message: const AppMessage(AppMessageKey.shortenerPossibleRandomPath),
    ),
    const SafetyCheckResult(
      checkName: AppMessage(AppMessageKey.checkNameVirusTotal),
      passed: true,
      message: AppMessage(AppMessageKey.virusTotalSkippedNoKey),
      skipped: true,
    ),
    const SafetyCheckResult(
      checkName: AppMessage(AppMessageKey.checkNamePhishTank),
      passed: true,
      message: AppMessage(AppMessageKey.phishTankSkippedDisabled),
      skipped: true,
    ),
  ];
}

class _FakeDomSandboxService extends DomSandboxService {
  @override
  Future<DomSandboxResult> analyzeAndRender(
    String url, {
    bool activeProbing = false,
  }) async => DomSandboxResult(
    url: url,
    blockedScriptsCount: 0,
    blockedTrackersCount: 0,
    blockedIframesCount: 0,
    hasOpenRedirect: false,
    sslValid: true,
    sslDetails: const AppMessage(AppMessageKey.sslValid),
    isSanitized: true,
    statusMessage: const AppMessage(AppMessageKey.domStatusSafe),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    FlutterSecureStorage.setMockInitialValues({});
  });

  Future<ScanProvider> pumpResult(
    WidgetTester tester, {
    bool withFailure = true,
    Locale locale = const Locale('en'),
  }) async {
    // Phone-sized screen so "visible without scrolling" means something.
    tester.view.physicalSize = const Size(1080, 2340);
    tester.view.devicePixelRatio = 2.625;
    addTearDown(tester.view.reset);

    const url = 'https://l.ead.me/bfbQcY';
    final provider = ScanProvider(
      urlSafetyService: _FakeUrlSafetyService(withFailure: withFailure),
      domSandboxService: _FakeDomSandboxService(),
    );
    provider.setScanResult(url, CodeContentType.url);
    await tester.runAsync(() => provider.checkUrlSafety(url));

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: provider,
        child: MaterialApp(
          locale: locale,
          localizationsDelegates: const [
            ...AppLocalizations.localizationsDelegates,
            SaMaterialLocalizationsDelegate(),
            SaCupertinoLocalizationsDelegate(),
            SaWidgetsLocalizationsDelegate(),
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: const ResultScreen(),
        ),
      ),
    );
    await tester.pump();
    return provider;
  }

  bool isOnScreen(WidgetTester tester, Finder finder) {
    final rect = tester.getRect(finder);
    final size = tester.view.physicalSize / tester.view.devicePixelRatio;
    return rect.top >= 0 && rect.bottom <= size.height;
  }

  group('ResultScreen compact layout', () {
    testWidgets('Open, Copy, Share and More are visible without scrolling', (
      tester,
    ) async {
      await pumpResult(tester);

      for (final label in ['Open in Browser', 'Copy Text', 'Share Text']) {
        final finder = find.text(label);
        expect(finder, findsOneWidget, reason: label);
        expect(isOnScreen(tester, finder), isTrue, reason: label);
      }
      expect(find.byTooltip('More actions'), findsOneWidget);
    });

    testWidgets('Verdict card shows failed count and checks passed', (
      tester,
    ) async {
      await pumpResult(tester);

      expect(find.text('1 issue found'), findsOneWidget);
      // 3 checks ran (2 skipped are not counted), 2 of them passed.
      expect(find.textContaining('2 of 3 checks passed'), findsOneWidget);
    });

    testWidgets('Passed and skipped checks are folded by default', (
      tester,
    ) async {
      await pumpResult(tester);

      expect(find.text('Show 2 passed checks'), findsOneWidget);
      expect(find.text('2 checks skipped'), findsOneWidget);
      expect(find.text('VirusTotal'), findsNothing);

      await tester.ensureVisible(find.text('2 checks skipped'));
      await tester.tap(find.text('2 checks skipped'));
      await tester.pump();

      expect(find.text('VirusTotal'), findsOneWidget);
      expect(find.text('Set up in Settings'), findsOneWidget);
    });

    testWidgets('More sheet holds Decrypt and Scan another', (tester) async {
      await pumpResult(tester);

      await tester.tap(find.byTooltip('More actions'));
      await tester.pumpAndSettle();

      expect(find.text('Decrypt Payload'), findsOneWidget);
      expect(find.text('Scan Another Code'), findsOneWidget);
    });

    testWidgets('Confirm dialog names the issue count', (tester) async {
      await pumpResult(tester);

      await tester.tap(find.text('Open in Browser'));
      await tester.pumpAndSettle();

      expect(
        find.text('This link has 1 issue. Open it anyway?'),
        findsOneWidget,
      );
    });

    testWidgets('No failures shows the no-issues verdict', (tester) async {
      await pumpResult(tester, withFailure: false);

      expect(find.text('No issues found'), findsOneWidget);
      expect(find.textContaining('3 of 3 checks passed'), findsOneWidget);
    });

    for (final code in ['ml', 'sa']) {
      testWidgets('Lays out without overflow in $code', (tester) async {
        await pumpResult(tester, locale: Locale(code));
        await tester.tap(
          find.byTooltip(
            lookupAppLocalizations(Locale(code)).resultMoreActions,
          ),
        );
        // Any overflow is reported by the framework and fails the test.
        await tester.pumpAndSettle();
      });
    }
  });
}
