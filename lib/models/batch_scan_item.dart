import 'package:sreerajp_qr_studio/models/parsed_payload.dart';
import 'package:sreerajp_qr_studio/models/safety_check_result.dart';
import 'package:sreerajp_qr_studio/models/scan_record.dart';
import 'package:sreerajp_qr_studio/models/code_content_type.dart';

/// Domain model representing an individual scanned item in a continuous batch.
class BatchScanItem {
  final String id;
  final DateTime timestamp;
  final String rawValue;
  final CodeContentType format;
  final ParsedPayload? parsedPayload;
  final bool isUrl;
  final bool? isSafeUrl;
  final int safetyScore;
  final List<SafetyCheckResult> safetyChecks;
  final bool isAnalyzing;

  const BatchScanItem({
    required this.id,
    required this.timestamp,
    required this.rawValue,
    required this.format,
    this.parsedPayload,
    this.isUrl = false,
    this.isSafeUrl,
    this.safetyScore = 100,
    this.safetyChecks = const [],
    this.isAnalyzing = false,
  });

  BatchScanItem copyWith({
    String? id,
    DateTime? timestamp,
    String? rawValue,
    CodeContentType? format,
    ParsedPayload? parsedPayload,
    bool? isUrl,
    bool? isSafeUrl,
    int? safetyScore,
    List<SafetyCheckResult>? safetyChecks,
    bool? isAnalyzing,
  }) {
    return BatchScanItem(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      rawValue: rawValue ?? this.rawValue,
      format: format ?? this.format,
      parsedPayload: parsedPayload ?? this.parsedPayload,
      isUrl: isUrl ?? this.isUrl,
      isSafeUrl: isSafeUrl ?? this.isSafeUrl,
      safetyScore: safetyScore ?? this.safetyScore,
      safetyChecks: safetyChecks ?? this.safetyChecks,
      isAnalyzing: isAnalyzing ?? this.isAnalyzing,
    );
  }

  /// Converts this batch item into a persistent [ScanRecord].
  ScanRecord toScanRecord({String? notes, String? locationTag}) {
    String category = 'text';
    if (parsedPayload != null && parsedPayload!.type != PayloadType.generic) {
      category = parsedPayload!.type.name;
    } else if (isUrl) {
      category = 'url';
    } else if (format != CodeContentType.unknown) {
      category = 'barcode';
    }

    return ScanRecord(
      id: id,
      timestamp: timestamp,
      rawContent: rawValue,
      barcodeFormat: format.name,
      category: category,
      safetyScore: safetyScore,
      notes: notes ?? 'Batch Scan',
      locationTag: locationTag,
      metadata: {
        'isBatch': true,
        'isSafeUrl': isSafeUrl,
        'payloadType': parsedPayload?.type.name,
      },
    );
  }
}
