import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sreerajp_qr_studio/models/app_message.dart';
import 'package:sreerajp_qr_studio/models/backup_exception.dart';
import 'package:sreerajp_qr_studio/models/device_sync_data.dart';
import 'package:sreerajp_qr_studio/providers/scan_provider.dart';
import 'package:sreerajp_qr_studio/services/history_export_service.dart';
import 'package:sreerajp_qr_studio/services/passphrase_cipher.dart';
import 'package:sreerajp_qr_studio/services/url_safety_service.dart';

/// Service handling packaging, encryption, decryption, and restoration of
/// scan history and application preferences for AirQR air-gapped device sync.
class DeviceSyncService {
  DeviceSyncService({PassphraseCipher? cipher})
    : _cipher = cipher ?? PassphraseCipher();

  final PassphraseCipher _cipher;

  /// Sync packages written by this version (docs/security.md §6.3).
  static const String syncHeaderV2 = 'SREERAJ_AIRQR_SYNC_V2';

  /// Old sync packages; still read, never written.
  static const String syncHeaderV1 = 'SREERAJ_AIRQR_SYNC_V1';

  /// History backups that can also arrive over AirQR.
  static const String backupHeaderV2 = HistoryExportService.backupHeaderV2;
  static const String legacyBackupHeader = HistoryExportService.backupHeaderV1;

  static const Set<String> _knownHeaders = {
    syncHeaderV2,
    syncHeaderV1,
    backupHeaderV2,
    legacyBackupHeader,
  };

  // Preference keys for app settings synchronization
  static const String prefThemeModeKey = 'app_theme_mode';
  static const String prefUseDynamicColorKey = 'use_dynamic_color';
  static const String prefScanOverlayStyleKey = 'scan_overlay_style';
  static const String prefLanguageKey = 'app_language';
  static const String prefVibrationKey = ScanProvider.vibrationPrefKey;
  static const String prefSoundKey = ScanProvider.soundPrefKey;
  static const String prefActiveProbingKey =
      UrlSafetyService.activeProbingPrefKey;
  static const String prefFlashModeKey = 'camera_flash_mode';
  static const String prefResolutionPresetKey = 'camera_resolution_preset';
  static const String prefBrightnessKey = 'camera_brightness';
  static const String prefContrastKey = 'camera_contrast';
  static const String prefInvertColorsKey = 'camera_invert_colors';

  /// Packages and encrypts [data] with [passphrase] into an AirQR sync
  /// package (format v2, [PassphraseCipher]). Only counts, the "has settings"
  /// flag and the time stay readable without the passphrase.
  Future<String> createEncryptedSyncPackage(
    DeviceSyncData data,
    String passphrase,
  ) async {
    final fields = await _cipher.seal(jsonEncode(data.toJson()), passphrase);
    return jsonEncode({
      'header': syncHeaderV2,
      'recordsCount': data.records.length,
      'hasSettings': data.settings.isNotEmpty,
      'timestamp': data.exportedAt.toIso8601String(),
      ...fields,
    });
  }

  /// Checks if [content] is a recognizable AirQR sync package or encrypted
  /// history backup (v1 or v2).
  bool isSyncPackage(String content) {
    try {
      final trimmed = content.trim();
      if (!trimmed.startsWith('{') || !trimmed.endsWith('}')) return false;
      final map = jsonDecode(trimmed) as Map<String, dynamic>;
      final header = map['header'];
      if (!_knownHeaders.contains(header)) return false;
      return _isV1(header) ? map['encryptedData'] != null : map['data'] != null;
    } catch (_) {
      return false;
    }
  }

  static bool _isV1(Object? header) =>
      header == syncHeaderV1 || header == legacyBackupHeader;

  static bool _isSync(Object? header) =>
      header == syncHeaderV2 || header == syncHeaderV1;

  /// Inspects package header and returns unencrypted metadata summary without requiring passphrase.
  Map<String, dynamic>? inspectPackageHeader(String content) {
    try {
      final trimmed = content.trim();
      final map = jsonDecode(trimmed) as Map<String, dynamic>;
      final header = map['header'] as String?;
      if (_isSync(header)) {
        return {
          'header': header,
          'recordsCount': map['recordsCount'] ?? 0,
          'hasSettings': map['hasSettings'] ?? false,
          'timestamp': map['timestamp'],
        };
      } else if (_knownHeaders.contains(header)) {
        return {
          'header': header,
          'recordsCount': 0,
          'hasSettings': false,
          'timestamp': null,
        };
      }
    } catch (_) {}
    return null;
  }

  /// Decrypts [containerJson] using [passphrase] and returns [DeviceSyncData].
  Future<DeviceSyncData> decryptSyncPackage(
    String containerJson,
    String passphrase,
  ) async {
    Map<String, dynamic> container;
    try {
      container = jsonDecode(containerJson) as Map<String, dynamic>;
    } catch (_) {
      throw const BackupException(
        AppMessage(AppMessageKey.backupInvalidFormat),
      );
    }

    final header = container['header'];
    if (!_knownHeaders.contains(header)) {
      throw const BackupException(AppMessage(AppMessageKey.backupBadHeader));
    }

    final String decryptedJson;
    if (_isV1(header)) {
      final encryptedB64 = container['encryptedData'];
      if (encryptedB64 is! String) {
        throw const BackupException(AppMessage(AppMessageKey.backupBadHeader));
      }
      decryptedJson = PassphraseCipher.openLegacyV1(encryptedB64, passphrase);
    } else {
      decryptedJson = await _cipher.open(container, passphrase);
    }

    if (!_isSync(header)) {
      // A history backup (v1 or v2): history only, no settings.
      final records = HistoryExportService.recordsFromJson(decryptedJson);
      DateTime exportedAt = DateTime.now();
      try {
        final raw =
            (jsonDecode(decryptedJson) as Map<String, dynamic>)['exportedAt'];
        if (raw is String) exportedAt = DateTime.tryParse(raw) ?? exportedAt;
      } catch (_) {}
      return DeviceSyncData(
        exportedAt: exportedAt,
        records: records,
        settings: const {},
      );
    }

    try {
      final data = jsonDecode(decryptedJson) as Map<String, dynamic>;
      return DeviceSyncData.fromJson(data);
    } catch (_) {
      throw const BackupException(
        AppMessage(AppMessageKey.backupInvalidFormat),
      );
    }
  }

  /// Collects user settings and preferences from [SharedPreferences] into a map.
  Map<String, dynamic> collectSettings(SharedPreferences prefs) {
    final map = <String, dynamic>{};

    if (prefs.containsKey(prefThemeModeKey)) {
      map[prefThemeModeKey] = prefs.getString(prefThemeModeKey);
    }
    if (prefs.containsKey(prefUseDynamicColorKey)) {
      map[prefUseDynamicColorKey] = prefs.getBool(prefUseDynamicColorKey);
    }
    if (prefs.containsKey(prefScanOverlayStyleKey)) {
      map[prefScanOverlayStyleKey] = prefs.getString(prefScanOverlayStyleKey);
    }
    if (prefs.containsKey(prefLanguageKey)) {
      map[prefLanguageKey] = prefs.getString(prefLanguageKey);
    }
    if (prefs.containsKey(prefVibrationKey)) {
      map[prefVibrationKey] = prefs.getBool(prefVibrationKey);
    }
    if (prefs.containsKey(prefSoundKey)) {
      map[prefSoundKey] = prefs.getBool(prefSoundKey);
    }
    if (prefs.containsKey(prefActiveProbingKey)) {
      map[prefActiveProbingKey] = prefs.getBool(prefActiveProbingKey);
    }
    if (prefs.containsKey(prefFlashModeKey)) {
      map[prefFlashModeKey] = prefs.getString(prefFlashModeKey);
    }
    if (prefs.containsKey(prefResolutionPresetKey)) {
      map[prefResolutionPresetKey] = prefs.getString(prefResolutionPresetKey);
    }
    for (final key in const [prefBrightnessKey, prefContrastKey]) {
      final value = prefs.get(key);
      if (value is num) map[key] = value.toDouble();
    }
    if (prefs.containsKey(prefInvertColorsKey)) {
      map[prefInvertColorsKey] = prefs.getBool(prefInvertColorsKey);
    }

    return map;
  }

  /// Applies synchronized settings to local [SharedPreferences].
  Future<void> applySettings(
    Map<String, dynamic> settings,
    SharedPreferences prefs,
  ) async {
    for (final entry in settings.entries) {
      final key = entry.key;
      final val = entry.value;

      if (val is String) {
        await prefs.setString(key, val);
      } else if (val is bool) {
        await prefs.setBool(key, val);
      } else if (val is int) {
        await prefs.setInt(key, val);
      } else if (val is double) {
        await prefs.setDouble(key, val);
      }
    }
  }
}
