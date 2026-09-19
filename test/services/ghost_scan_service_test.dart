import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sreeraj_qr_reader/services/ghost_scan_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channelName = 'in.sreeraj.qr_reader/ghost_scan';
  late GhostScanService service;
  late MethodChannel channel;
  final List<MethodCall> methodCalls = [];

  bool mockIsSupported = true;
  bool mockIsTileRequestSupported = true;
  bool mockRequestAddTile = true;
  bool mockStartGhostScan = true;
  String? mockInitialImage = '/mock/path/image.jpg';
  bool shouldThrowError = false;

  setUp(() {
    methodCalls.clear();
    mockIsSupported = true;
    mockIsTileRequestSupported = true;
    mockRequestAddTile = true;
    mockStartGhostScan = true;
    mockInitialImage = '/mock/path/image.jpg';
    shouldThrowError = false;

    channel = const MethodChannel(channelName);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
          methodCalls.add(call);
          if (shouldThrowError) {
            throw PlatformException(
              code: 'TEST_ERROR',
              message: 'Test failure',
            );
          }

          switch (call.method) {
            case 'isSupported':
              return mockIsSupported;
            case 'isTileRequestSupported':
              return mockIsTileRequestSupported;
            case 'requestAddTile':
              return mockRequestAddTile;
            case 'startGhostScan':
              return mockStartGhostScan;
            case 'getInitialGhostScanImage':
              return mockInitialImage;
            default:
              return null;
          }
        });

    service = GhostScanService(channel: channel);
  });

  tearDown(() {
    service.dispose();
  });

  group('GhostScanService - Platform Channel Calls', () {
    test('isSupported returns true when platform returns true', () async {
      final result = await service.isSupported();
      expect(result, isTrue);
      expect(methodCalls.any((c) => c.method == 'isSupported'), isTrue);
    });

    test('isSupported returns false when platform returns false', () async {
      mockIsSupported = false;
      final result = await service.isSupported();
      expect(result, isFalse);
    });

    test('isSupported returns false on platform exception', () async {
      shouldThrowError = true;
      final result = await service.isSupported();
      expect(result, isFalse);
    });

    test('isTileRequestSupported returns true when supported', () async {
      final result = await service.isTileRequestSupported();
      expect(result, isTrue);
      expect(
        methodCalls.any((c) => c.method == 'isTileRequestSupported'),
        isTrue,
      );
    });

    test('requestAddTile invokes channel method and returns boolean', () async {
      final result = await service.requestAddTile();
      expect(result, isTrue);
      expect(methodCalls.any((c) => c.method == 'requestAddTile'), isTrue);
    });

    test('startGhostScan triggers on-demand capture flow', () async {
      final result = await service.startGhostScan();
      expect(result, isTrue);
      expect(methodCalls.any((c) => c.method == 'startGhostScan'), isTrue);
    });

    test('getInitialGhostScanImage retrieves pending image path', () async {
      final result = await service.getInitialGhostScanImage();
      expect(result, equals('/mock/path/image.jpg'));
    });

    test('getInitialGhostScanImage handles null safely', () async {
      mockInitialImage = null;
      final result = await service.getInitialGhostScanImage();
      expect(result, isNull);
    });
  });

  group('GhostScanService - Stream Emission', () {
    test(
      'onGhostScanImage emits image path when native channel pushes',
      () async {
        final completer = Completer<String>();
        final sub = service.onGhostScanImage.listen((path) {
          completer.complete(path);
        });

        // Simulate native platform invoking method on Flutter
        final message = const StandardMethodCodec().encodeMethodCall(
          const MethodCall(
            'onGhostScanImage',
            '/data/cache/ghost_scan_test.jpg',
          ),
        );
        await TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .handlePlatformMessage(channelName, message, (data) {});

        final emittedPath = await completer.future.timeout(
          const Duration(seconds: 2),
        );
        expect(emittedPath, equals('/data/cache/ghost_scan_test.jpg'));
        await sub.cancel();
      },
    );
  });
}
