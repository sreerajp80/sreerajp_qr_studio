import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/models/ghost_scan_capture.dart';
import 'package:sreerajp_qr_studio/services/ghost_scan_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channelName = 'in.sreerajp.qr_studio/ghost_scan';
  late GhostScanService service;
  late MethodChannel channel;
  final List<MethodCall> methodCalls = [];

  bool mockIsSupported = true;
  bool mockIsTileRequestSupported = true;
  bool mockRequestAddTile = true;
  bool mockStartGhostScan = true;
  Object? mockInitialImage = '/mock/path/image.jpg';
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

    test('instance is one shared service', () {
      expect(
        identical(GhostScanService.instance, GhostScanService.instance),
        isTrue,
      );
    });

    test('a capture still arrives after another listener cancels', () async {
      // Screens come and go; one leaving must not stop captures for the next.
      final first = service.onCapture.listen((_) {});
      await first.cancel();

      final completer = Completer<GhostScanCapture>();
      final second = service.onCapture.listen(completer.complete);

      final message = const StandardMethodCodec().encodeMethodCall(
        const MethodCall('onGhostScanImage', {
          'imagePath': '/data/cache/ghost_scan_after.jpg',
          'fromBubble': true,
        }),
      );
      await TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .handlePlatformMessage(channelName, message, (data) {});

      final capture = await completer.future.timeout(
        const Duration(seconds: 2),
      );
      expect(capture.imagePath, '/data/cache/ghost_scan_after.jpg');
      expect(capture.fromBubble, isTrue);
      await second.cancel();
    });
  });

  group('GhostScanService - Capture details', () {
    test('getInitialCapture reads the map form with flags', () async {
      mockInitialImage = {
        'imagePath': '/mock/bubble.jpg',
        'fromBubble': true,
        'blocked': false,
      };
      final capture = await service.getInitialCapture();
      expect(capture, isNotNull);
      expect(capture!.imagePath, '/mock/bubble.jpg');
      expect(capture.fromBubble, isTrue);
      expect(capture.blocked, isFalse);
      expect(
        await service.getInitialGhostScanImage(),
        equals('/mock/bubble.jpg'),
      );
    });

    test('getInitialCapture returns null on platform error', () async {
      shouldThrowError = true;
      expect(await service.getInitialCapture(), isNull);
    });

    test('onCapture emits map pushes with flags', () async {
      final completer = Completer<GhostScanCapture>();
      final sub = service.onCapture.listen(completer.complete);

      final message = const StandardMethodCodec().encodeMethodCall(
        const MethodCall('onGhostScanImage', {
          'imagePath': '/data/cache/ghost_bubble.jpg',
          'fromBubble': true,
          'blocked': true,
        }),
      );
      await TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .handlePlatformMessage(channelName, message, (data) {});

      final capture = await completer.future.timeout(
        const Duration(seconds: 2),
      );
      expect(capture.imagePath, '/data/cache/ghost_bubble.jpg');
      expect(capture.fromBubble, isTrue);
      expect(capture.blocked, isTrue);
      await sub.cancel();
    });
  });

  group('own capture check (only our cache files are scanned or deleted)', () {
    late Directory root;
    late Directory cacheDir;
    late Directory otherDir;
    late GhostScanService cacheService;

    Future<File> makeFile(Directory dir, String name) async {
      final file = File('${dir.path}${Platform.pathSeparator}$name');
      await file.writeAsBytes([1, 2, 3]);
      return file;
    }

    setUp(() async {
      root = await Directory.systemTemp.createTemp('ghost_scan_test');
      cacheDir = await Directory('${root.path}${Platform.pathSeparator}cache')
          .create();
      otherDir = await Directory(
        '${root.path}${Platform.pathSeparator}databases',
      ).create();
      cacheService = GhostScanService(
        channel: channel,
        cacheDirectory: () async => cacheDir,
      );
    });

    tearDown(() async {
      cacheService.dispose();
      await root.delete(recursive: true);
    });

    test('accepts ghost_scan_<digits>.jpg inside the cache folder', () async {
      final file = await makeFile(cacheDir, 'ghost_scan_123.jpg');
      expect(await cacheService.isOwnCapture(file.path), isTrue);
    });

    test('rejects a capture-named file outside the cache folder', () async {
      final file = await makeFile(otherDir, 'ghost_scan_1.jpg');
      expect(await cacheService.isOwnCapture(file.path), isFalse);
    });

    test('rejects a path that climbs out of the cache with ..', () async {
      await makeFile(otherDir, 'history.db');
      final sep = Platform.pathSeparator;
      final sneaky = '${cacheDir.path}$sep..${sep}databases${sep}history.db';
      expect(await cacheService.isOwnCapture(sneaky), isFalse);
    });

    test('rejects other file names inside the cache folder', () async {
      final clip = await makeFile(cacheDir, 'clipboard_image_1.png');
      final db = await makeFile(cacheDir, 'history.db');
      final noDigits = await makeFile(cacheDir, 'ghost_scan_.jpg');
      expect(await cacheService.isOwnCapture(clip.path), isFalse);
      expect(await cacheService.isOwnCapture(db.path), isFalse);
      expect(await cacheService.isOwnCapture(noDigits.path), isFalse);
    });

    test('rejects a missing file', () async {
      final sep = Platform.pathSeparator;
      final missing = '${cacheDir.path}${sep}ghost_scan_9.jpg';
      expect(await cacheService.isOwnCapture(missing), isFalse);
    });

    test('deleteCapture removes our own cached picture', () async {
      final file = await makeFile(cacheDir, 'ghost_scan_42.jpg');

      await cacheService.deleteCapture(file.path);
      expect(await file.exists(), isFalse);

      // A missing file is ignored.
      await cacheService.deleteCapture(file.path);
    });

    test('deleteCapture never deletes a file outside the cache', () async {
      final db = await makeFile(otherDir, 'history.db');
      final prefs = await makeFile(otherDir, 'ghost_scan_7.jpg');

      await cacheService.deleteCapture(db.path);
      await cacheService.deleteCapture(prefs.path);
      final sep = Platform.pathSeparator;
      await cacheService.deleteCapture(
        '${cacheDir.path}$sep..${sep}databases${sep}history.db',
      );

      expect(await db.exists(), isTrue);
      expect(await prefs.exists(), isTrue);
    });
  });
}
