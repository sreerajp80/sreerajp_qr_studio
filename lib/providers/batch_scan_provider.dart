import 'package:flutter/foundation.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sreeraj_qr_reader/models/batch_scan_item.dart';
import 'package:sreeraj_qr_reader/models/history_report_labels.dart';
import 'package:sreeraj_qr_reader/models/safety_check_result.dart';
import 'package:sreeraj_qr_reader/providers/history_provider.dart';
import 'package:sreeraj_qr_reader/services/history_export_service.dart';
import 'package:sreeraj_qr_reader/services/payload_parser_service.dart';
import 'package:sreeraj_qr_reader/services/url_safety_service.dart';

/// Provider managing Continuous Batch Scan Mode state, queuing, deduplication,
/// background 6-layer URL safety verification, and batch export formatting.
class BatchScanProvider extends ChangeNotifier {
  bool _isBatchMode = false;
  final List<BatchScanItem> _batchItems = [];
  bool _preventDuplicates = true;
  String? _lastScanContent;
  DateTime? _lastScanTime;
  BatchScanItem? _lastScannedItem;

  final UrlSafetyService _urlSafetyService;
  final PayloadParserService _payloadParserService;
  final HistoryExportService _historyExportService;

  BatchScanProvider({
    UrlSafetyService? urlSafetyService,
    PayloadParserService? payloadParserService,
    HistoryExportService? historyExportService,
  }) : _urlSafetyService = urlSafetyService ?? UrlSafetyService(),
       _payloadParserService = payloadParserService ?? PayloadParserService(),
       _historyExportService = historyExportService ?? HistoryExportService();

  bool get isBatchMode => _isBatchMode;
  List<BatchScanItem> get items => List.unmodifiable(_batchItems);
  int get count => _batchItems.length;
  bool get preventDuplicates => _preventDuplicates;
  BatchScanItem? get lastScannedItem => _lastScannedItem;

  /// Counts of URL safety verification in the current batch.
  int get totalUrls => _batchItems.where((i) => i.isUrl).length;
  int get safeUrlsCount =>
      _batchItems.where((i) => i.isUrl && (i.isSafeUrl ?? false)).length;
  int get suspiciousUrlsCount =>
      _batchItems.where((i) => i.isUrl && i.isSafeUrl == false).length;

  /// Toggles continuous batch scan mode on or off.
  void toggleBatchMode([bool? enabled]) {
    _isBatchMode = enabled ?? !_isBatchMode;
    notifyListeners();
  }

  /// Sets whether duplicate barcodes should be prevented from being added.
  void setPreventDuplicates(bool enabled) {
    _preventDuplicates = enabled;
    notifyListeners();
  }

  /// Evaluates whether a barcode can be accepted based on cooldown and duplicate rules.
  bool canAccept(String rawValue) {
    final now = DateTime.now();

    // 1. Cooldown check: Prevent rapid-fire multi-frame capture of the exact same code
    if (_lastScanContent == rawValue && _lastScanTime != null) {
      if (now.difference(_lastScanTime!).inMilliseconds < 1500) {
        return false;
      }
    }

    // 2. Duplicate prevention check across the active batch
    if (_preventDuplicates) {
      if (_batchItems.any((item) => item.rawValue == rawValue)) {
        return false;
      }
    }

    return true;
  }

  /// Adds a newly scanned barcode into the continuous batch queue.
  /// If it contains a URL, triggers background 6-layer URL safety verification.
  Future<BatchScanItem?> addBarcode(String rawValue, BarcodeType format) async {
    if (!canAccept(rawValue)) return null;

    final now = DateTime.now();
    _lastScanContent = rawValue;
    _lastScanTime = now;

    final isUrl = _checkIfUrl(rawValue);
    final parsed = _payloadParserService.parse(rawValue);
    final id = '${now.millisecondsSinceEpoch}_${_batchItems.length}';

    final item = BatchScanItem(
      id: id,
      timestamp: now,
      rawValue: rawValue,
      format: format,
      parsedPayload: parsed,
      isUrl: isUrl,
      isAnalyzing: isUrl,
    );

    _batchItems.insert(0, item);
    _lastScannedItem = item;
    notifyListeners();

    // If it's a URL, execute the 6-layer URL safety check asynchronously in background
    if (isUrl) {
      _runBackgroundUrlSafety(id, rawValue);
    }

    return item;
  }

  Future<void> _runBackgroundUrlSafety(String itemId, String url) async {
    try {
      final checks = await _urlSafetyService.runAllChecks(url);
      final failedChecks = checks.where((c) => !c.passed).length;
      final isSafe = failedChecks == 0;
      final score = checks.isNotEmpty
          ? (((checks.length - failedChecks) / checks.length) * 100).round()
          : 100;

      final index = _batchItems.indexWhere((i) => i.id == itemId);
      if (index != -1) {
        _batchItems[index] = _batchItems[index].copyWith(
          isAnalyzing: false,
          isSafeUrl: isSafe,
          safetyScore: score,
          safetyChecks: List<SafetyCheckResult>.unmodifiable(checks),
        );
        notifyListeners();
      }
    } catch (e) {
      final index = _batchItems.indexWhere((i) => i.id == itemId);
      if (index != -1) {
        _batchItems[index] = _batchItems[index].copyWith(
          isAnalyzing: false,
          isSafeUrl: false,
          safetyScore: 0,
        );
        notifyListeners();
      }
    }
  }

  /// Removes an individual item from the batch.
  void removeItem(String id) {
    _batchItems.removeWhere((item) => item.id == id);
    if (_lastScannedItem?.id == id) {
      _lastScannedItem = _batchItems.isNotEmpty ? _batchItems.first : null;
    }
    notifyListeners();
  }

  /// Clears all queued items in the batch.
  void clearBatch() {
    _batchItems.clear();
    _lastScannedItem = null;
    _lastScanContent = null;
    _lastScanTime = null;
    notifyListeners();
  }

  /// Exports the batch items into the chosen format (CSV, JSON, TXT, PDF).
  Future<dynamic> exportBatch(
    ExportFormat format,
    HistoryReportLabels labels,
  ) async {
    final records = _batchItems
        .map((item) => item.toScanRecord())
        .toList(growable: false);

    switch (format) {
      case ExportFormat.csv:
        return _historyExportService.exportToCsv(records);
      case ExportFormat.json:
        return _historyExportService.exportToJson(records);
      case ExportFormat.txt:
        return _historyExportService.exportToFormattedTxt(records, labels);
      case ExportFormat.pdf:
        return await _historyExportService.exportToPdf(records, labels);
    }
  }

  bool _checkIfUrl(String text) {
    final urlRegex = RegExp(
      r'^https?://[\w\-]+(\.[\w\-]+)+[/#?]?.*$',
      caseSensitive: false,
    );
    return urlRegex.hasMatch(text.trim());
  }
}
