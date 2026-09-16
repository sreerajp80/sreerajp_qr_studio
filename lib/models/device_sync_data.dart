import 'package:flutter/foundation.dart';
import 'package:sreeraj_qr_reader/models/scan_record.dart';

/// Immutable container carrying scan history records and app configuration
/// for air-gapped device synchronization via AirQR.
@immutable
class DeviceSyncData {
  static const int currentVersion = 1;

  final int version;
  final DateTime exportedAt;
  final List<ScanRecord> records;
  final Map<String, dynamic> settings;

  const DeviceSyncData({
    this.version = currentVersion,
    required this.exportedAt,
    required this.records,
    required this.settings,
  });

  Map<String, dynamic> toJson() {
    return {
      'app': 'SreerajP QR Reader',
      'version': version,
      'exportedAt': exportedAt.toIso8601String(),
      'totalRecords': records.length,
      'records': records.map((r) => r.toJson()).toList(),
      'settings': settings,
    };
  }

  factory DeviceSyncData.fromJson(Map<String, dynamic> json) {
    final version = (json['version'] as num?)?.toInt() ?? 1;
    final exportedAt = json['exportedAt'] != null
        ? DateTime.tryParse(json['exportedAt'] as String) ?? DateTime.now()
        : DateTime.now();

    final rawRecords = json['records'] as List<dynamic>? ?? [];
    final records = rawRecords
        .whereType<Map<String, dynamic>>()
        .map((m) => ScanRecord.fromJson(m))
        .toList();

    final settings = json['settings'] != null && json['settings'] is Map
        ? Map<String, dynamic>.from(json['settings'] as Map)
        : <String, dynamic>{};

    return DeviceSyncData(
      version: version,
      exportedAt: exportedAt,
      records: records,
      settings: settings,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceSyncData &&
          runtimeType == other.runtimeType &&
          version == other.version &&
          exportedAt.isAtSameMomentAs(other.exportedAt) &&
          listEquals(records, other.records) &&
          mapEquals(settings, other.settings);

  @override
  int get hashCode => Object.hash(
    version,
    exportedAt.millisecondsSinceEpoch,
    Object.hashAll(records),
    Object.hashAll(settings.entries),
  );
}
