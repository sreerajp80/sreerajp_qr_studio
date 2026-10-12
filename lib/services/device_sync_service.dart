import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sreerajp_qr_studio/models/app_message.dart';
import 'package:sreerajp_qr_studio/models/backup_exception.dart';
import 'package:sreerajp_qr_studio/models/device_sync_data.dart';
import 'package:sreerajp_qr_studio/models/scan_record.dart';
import 'package:sreerajp_qr_studio/providers/scan_provider.dart';
import 'package:sreerajp_qr_studio/services/url_safety_service.dart';

/// Service handling packaging, encryption, decryption, and restoration of
/// scan history and application preferences for AirQR air-gapped device sync.
class DeviceSyncService {
  static const String syncHeaderV1 = 'SREERAJ_AIRQR_SYNC_V1';
  static const String legacyBackupHeader = 'SREERAJ_QR_BACKUP_V1';

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

  /// Packages and encrypts [data] with [passphrase] using AES-256-CBC into an AirQR Sync payload container.
  String createEncryptedSyncPackage(DeviceSyncData data, String passphrase) {
    final jsonStr = jsonEncode(data.toJson());

    final bytes = utf8.encode(passphrase);
    final digest = sha256.convert(bytes);
    final key = enc.Key(Uint8List.fromList(digest.bytes));
    final iv = enc.IV(Uint8List.fromList(digest.bytes.sublist(0, 16)));
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));

    final encrypted = encrypter.encrypt(jsonStr, iv: iv);

    final payload = {
      'header': syncHeaderV1,
      'recordsCount': data.records.length,
      'hasSettings': data.settings.isNotEmpty,
      'timestamp': data.exportedAt.toIso8601String(),
      'encryptedData': encrypted.base64,
    };

    return jsonEncode(payload);
  }

  /// Checks if [content] is a recognizable AirQR Sync or encrypted backup payload.
  bool isSyncPackage(String content) {
    try {
      final trimmed = content.trim();
      if (!trimmed.startsWith('{') || !trimmed.endsWith('}')) return false;
      final map = jsonDecode(trimmed) as Map<String, dynamic>;
      final header = map['header'];
      return (header == syncHeaderV1 || header == legacyBackupHeader) &&
          map['encryptedData'] != null;
    } catch (_) {
      return false;
    }
  }

  /// Inspects package header and returns unencrypted metadata summary without requiring passphrase.
  Map<String, dynamic>? inspectPackageHeader(String content) {
    try {
      final trimmed = content.trim();
      final map = jsonDecode(trimmed) as Map<String, dynamic>;
      final header = map['header'] as String?;
      if (header == syncHeaderV1) {
        return {
          'header': syncHeaderV1,
          'recordsCount': map['recordsCount'] ?? 0,
          'hasSettings': map['hasSettings'] ?? false,
          'timestamp': map['timestamp'],
        };
      } else if (header == legacyBackupHeader) {
        return {
          'header': legacyBackupHeader,
          'recordsCount': 0,
          'hasSettings': false,
          'timestamp': null,
        };
      }
    } catch (_) {}
    return null;
  }

  /// Decrypts [containerJson] using [passphrase] and returns [DeviceSyncData].
  DeviceSyncData decryptSyncPackage(String containerJson, String passphrase) {
    Map<String, dynamic> container;
    try {
      container = jsonDecode(containerJson) as Map<String, dynamic>;
    } catch (_) {
      throw const BackupException(
        AppMessage(AppMessageKey.backupInvalidFormat),
      );
    }

    final header = container['header'];
    final encryptedB64 = container['encryptedData'] as String?;

    if ((header != syncHeaderV1 && header != legacyBackupHeader) ||
        encryptedB64 == null) {
      throw const BackupException(AppMessage(AppMessageKey.backupBadHeader));
    }

    final bytes = utf8.encode(passphrase);
    final digest = sha256.convert(bytes);
    final key = enc.Key(Uint8List.fromList(digest.bytes));
    final iv = enc.IV(Uint8List.fromList(digest.bytes.sublist(0, 16)));
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));

    String decryptedJson;
    try {
      decryptedJson = encrypter.decrypt64(encryptedB64, iv: iv);
    } catch (_) {
      throw const BackupException(
        AppMessage(AppMessageKey.backupWrongPassphrase),
      );
    }

    try {
      final data = jsonDecode(decryptedJson) as Map<String, dynamic>;

      if (header == syncHeaderV1) {
        return DeviceSyncData.fromJson(data);
      } else {
        // Fallback for legacy SREERAJ_QR_BACKUP_V1 format (history-only)
        final recordsList = data['records'] as List<dynamic>? ?? [];
        final records = recordsList
            .whereType<Map<String, dynamic>>()
            .map((item) => ScanRecord.fromJson(item))
            .toList();

        return DeviceSyncData(
          exportedAt: data['exportedAt'] != null
              ? DateTime.tryParse(data['exportedAt'] as String) ??
                    DateTime.now()
              : DateTime.now(),
          records: records,
          settings: const {},
        );
      }
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
