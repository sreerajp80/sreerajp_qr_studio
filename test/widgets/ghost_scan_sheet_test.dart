import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sreeraj_qr_reader/l10n/gen/app_localizations.dart';
import 'package:sreeraj_qr_reader/services/ghost_scan_service.dart';
import 'package:sreeraj_qr_reader/widgets/ghost_scan_sheet.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channelName = 'in.sreeraj.qr_reader/ghost_scan';
  late MethodChannel channel;
  final List<MethodCall> methodCalls = [];
  bool mockIsTileRequestSupported = true;

  setUp(() {
    methodCalls.clear();
    mockIsTileRequestSupported = true;

    channel = const MethodChannel(channelName);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
          methodCalls.add(call);
          switch (call.method) {
            case 'isTileRequestSupported':
              return mockIsTileRequestSupported;
            case 'requestAddTile':
              return true;
            case 'startGhostScan':
              return true;
            default:
              return null;
          }
        });
  });

  Widget buildTestWidget({
    required GhostScanService service,
    VoidCallback? onScanTriggered,
  }) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: GhostScanSheet(
          ghostScanService: service,
          onScanTriggered: onScanTriggered,
        ),
      ),
    );
  }

  testWidgets('GhostScanSheet renders title, subtitle, and instructions', (
    tester,
  ) async {
    final service = GhostScanService(channel: channel);

    await tester.pumpWidget(buildTestWidget(service: service));
    await tester.pumpAndSettle();

    expect(find.text('GhostScan'), findsWidgets);
    expect(find.text('Screen Content QR Detector'), findsOneWidget);
    expect(find.text('How to use GhostScan'), findsOneWidget);
    expect(find.byIcon(Icons.screenshot_monitor), findsOneWidget);
    expect(find.text('Scan Screen Now'), findsOneWidget);
    expect(find.text('Add Quick Settings Tile'), findsOneWidget);

    service.dispose();
  });

  testWidgets('Tapping Scan Screen Now triggers scan and invokes platform', (
    tester,
  ) async {
    final service = GhostScanService(channel: channel);
    bool scanTriggered = false;

    await tester.pumpWidget(
      buildTestWidget(
        service: service,
        onScanTriggered: () {
          scanTriggered = true;
        },
      ),
    );
    await tester.pumpAndSettle();

    final scanButton = find.text('Scan Screen Now');
    expect(scanButton, findsOneWidget);
    await tester.tap(scanButton);
    await tester.pumpAndSettle();

    expect(scanTriggered, isTrue);
    expect(methodCalls.any((c) => c.method == 'startGhostScan'), isTrue);

    service.dispose();
  });

  testWidgets('Tapping Add Quick Settings Tile invokes requestAddTile', (
    tester,
  ) async {
    final service = GhostScanService(channel: channel);

    await tester.pumpWidget(buildTestWidget(service: service));
    await tester.pumpAndSettle();

    final addTileButton = find.text('Add Quick Settings Tile');
    expect(addTileButton, findsOneWidget);
    await tester.tap(addTileButton);
    await tester.pumpAndSettle();

    expect(methodCalls.any((c) => c.method == 'requestAddTile'), isTrue);

    service.dispose();
  });
}
