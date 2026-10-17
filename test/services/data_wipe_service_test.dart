import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sreerajp_qr_studio/core/logging/app_logger.dart';
import 'package:sreerajp_qr_studio/services/data_wipe_service.dart';
import 'package:sreerajp_qr_studio/services/scan_bubble_service.dart';

class _FakeSecureStorage extends Fake implements FlutterSecureStorage {
  _FakeSecureStorage({this.fail = false});

  final bool fail;
  final Map<String, String> values = {'db_encryption_key_v1': 'k', 'api': 'v'};

  @override
  Future<void> deleteAll({
    AndroidOptions? aOptions,
    AppleOptions? iOptions,
    LinuxOptions? lOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
    WebOptions? webOptions,
  }) async {
    if (fail) throw Exception('keystore error');
    values.clear();
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('test/scan_bubble');
  late Directory cacheDir;
  late List<String> nativeCalls;
  late bool nativeResult;

  setUp(() async {
    AppLogger.overrideForTesting(
      verbose: false,
      sink: (level, message, {error, stackTrace}) {},
    );
    SharedPreferences.setMockInitialValues({
      'app_language': 'ml',
      'has_seen_onboarding': true,
    });
    cacheDir = await Directory.systemTemp.createTemp('wipe_cache');
    File('${cacheDir.path}/ghost_scan_1.jpg').writeAsStringSync('x');
    Directory('${cacheDir.path}/exports').createSync();
    File('${cacheDir.path}/exports/code.png').writeAsStringSync('y');

    nativeCalls = [];
    nativeResult = true;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
          nativeCalls.add(call.method);
          return nativeResult;
        });
  });

  tearDown(() async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
    if (cacheDir.existsSync()) await cacheDir.delete(recursive: true);
    AppLogger.resetForTesting();
  });

  DataWipeService service({
    required Future<void> Function() closeDb,
    _FakeSecureStorage? storage,
  }) => DataWipeService(
    closeAndDeleteHistoryDatabase: closeDb,
    secureStorage: storage ?? _FakeSecureStorage(),
    scanBubbleService: ScanBubbleService(channel: channel),
    cacheDirectory: () async => cacheDir,
  );

  test('clears every store', () async {
    var dbDeleted = 0;
    final storage = _FakeSecureStorage();
    final failed = await service(
      closeDb: () async => dbDeleted++,
      storage: storage,
    ).deleteAll();

    expect(failed, isEmpty);
    expect(dbDeleted, 1);
    expect(storage.values, isEmpty);
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getKeys(), isEmpty);
    expect(nativeCalls, ['clearData']);
    expect(cacheDir.existsSync(), isTrue, reason: 'the folder itself stays');
    expect(cacheDir.listSync(), isEmpty);
  });

  test('a failing step does not stop the others and is reported', () async {
    nativeResult = false;
    final failed = await service(
      closeDb: () async => throw Exception('db busy'),
      storage: _FakeSecureStorage(fail: true),
    ).deleteAll();

    expect(failed, {
      DataWipeStep.historyDatabase,
      DataWipeStep.secureStorage,
      DataWipeStep.scanBubble,
    });
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getKeys(), isEmpty, reason: 'later steps still ran');
    expect(cacheDir.listSync(), isEmpty);
  });
}
