import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sreerajp_qr_studio/core/logging/app_logger.dart';
import 'package:sreerajp_qr_studio/services/scan_bubble_service.dart';

/// One store that "Delete all data" clears.
enum DataWipeStep {
  historyDatabase,
  secureStorage,
  preferences,
  scanBubble,
  cacheFiles,
}

/// Deletes all local app data (engineering standard §15.4).
///
/// Every step runs even if an earlier one fails. The result lists the steps
/// that failed; it holds no user-visible text.
class DataWipeService {
  DataWipeService({
    required this._closeAndDeleteHistoryDatabase,
    FlutterSecureStorage? secureStorage,
    Future<SharedPreferences> Function()? loadPrefs,
    ScanBubbleService? scanBubbleService,
    Future<Directory> Function()? cacheDirectory,
  }) : _secureStorage = secureStorage ?? const FlutterSecureStorage(),
       _loadPrefs = loadPrefs ?? SharedPreferences.getInstance,
       _scanBubbleService = scanBubbleService ?? ScanBubbleService(),
       _cacheDirectory = cacheDirectory ?? getTemporaryDirectory;

  final Future<void> Function() _closeAndDeleteHistoryDatabase;
  final FlutterSecureStorage _secureStorage;
  final Future<SharedPreferences> Function() _loadPrefs;
  final ScanBubbleService _scanBubbleService;
  final Future<Directory> Function() _cacheDirectory;

  /// Runs every step and returns the ones that failed (empty = all done).
  Future<Set<DataWipeStep>> deleteAll() async {
    final failed = <DataWipeStep>{};

    Future<void> run(DataWipeStep step, Future<void> Function() action) async {
      try {
        await action();
        AppLogger.info('Delete all data: ${step.name} cleared');
      } catch (e, st) {
        failed.add(step);
        AppLogger.error(
          'Delete all data: ${step.name} failed',
          error: e,
          stackTrace: st,
        );
      }
    }

    await run(DataWipeStep.historyDatabase, _closeAndDeleteHistoryDatabase);
    await run(DataWipeStep.secureStorage, _secureStorage.deleteAll);
    await run(DataWipeStep.preferences, () async {
      final prefs = await _loadPrefs();
      if (!await prefs.clear()) throw StateError('preferences not cleared');
    });
    await run(DataWipeStep.scanBubble, () async {
      if (!await _scanBubbleService.clearNativeData()) {
        throw StateError('scan bubble data not cleared');
      }
    });
    await run(DataWipeStep.cacheFiles, () async {
      final dir = await _cacheDirectory();
      if (!dir.existsSync()) return;
      for (final entity in dir.listSync()) {
        entity.deleteSync(recursive: true);
      }
    });

    return failed;
  }
}
