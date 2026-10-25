import 'package:flutter/foundation.dart';
import 'package:sreerajp_qr_studio/core/logging/app_logger.dart';
import 'package:sreerajp_qr_studio/models/history_report_labels.dart';
import 'package:sreerajp_qr_studio/models/scan_record.dart';
import 'package:sreerajp_qr_studio/services/history_database_service.dart';
import 'package:sreerajp_qr_studio/services/history_export_service.dart';
import 'package:sreerajp_qr_studio/services/payload_parser_service.dart';

enum ExportFormat { csv, json, txt, pdf }

/// Provider for managing scan history state, filtering, searching, and export/import operations.
class HistoryProvider extends ChangeNotifier {
  final HistoryDatabaseService _dbService;
  final HistoryExportService _exportService;

  List<ScanRecord> _records = [];
  String _selectedCategory = 'all';
  String _searchQuery = '';
  bool _showFavoritesOnly = false;
  bool _isLoading = false;
  bool _hasLoadError = false;

  HistoryProvider({
    HistoryDatabaseService? dbService,
    HistoryExportService? exportService,
  }) : _dbService = dbService ?? HistoryDatabaseService(),
       _exportService = exportService ?? HistoryExportService();

  List<ScanRecord> get records => List.unmodifiable(_records);
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;
  bool get showFavoritesOnly => _showFavoritesOnly;
  bool get isLoading => _isLoading;

  /// True when the last load failed (for example the history key could not
  /// be read). The screen shows its own localized message.
  bool get hasLoadError => _hasLoadError;

  int get totalCount => _records.length;
  int get favoritesCount => _records.where((r) => r.isFavorite).length;

  /// Closes and deletes the history database and clears the list in memory
  /// ("Delete all data").
  Future<void> closeAndDeleteDatabase() async {
    _records = [];
    _hasLoadError = false;
    await _dbService.closeAndDeleteDatabase();
    notifyListeners();
  }

  /// Loads scan history records from encrypted SQLite database based on filters and search query.
  Future<void> loadRecords() async {
    _isLoading = true;
    _hasLoadError = false;
    notifyListeners();

    try {
      _records = await _dbService.getRecords(
        category: _selectedCategory,
        onlyFavorites: _showFavoritesOnly,
        searchQuery: _searchQuery,
      );
    } catch (e, st) {
      _hasLoadError = true;
      AppLogger.error(
        'Loading history records failed',
        error: e,
        stackTrace: st,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Sets current category filter ('all', 'url', 'wifi', 'contact', 'text', 'barcode', 'favorites').
  void setCategory(String category) {
    if (_selectedCategory == category) return;
    _selectedCategory = category;
    loadRecords();
  }

  /// Updates current full-text search query.
  void setSearchQuery(String query) {
    if (_searchQuery == query) return;
    _searchQuery = query;
    loadRecords();
  }

  /// Toggles favorites-only filter mode.
  void toggleFavoritesOnly() {
    _showFavoritesOnly = !_showFavoritesOnly;
    loadRecords();
  }

  /// Adds a new scan record to history.
  ///
  /// Driving licence / ID card scans are personal ID data and are never
  /// saved.
  Future<void> addScanRecord(ScanRecord record) async {
    if (PayloadParserService.isIdCardData(record.rawContent)) {
      AppLogger.info('ID card scan not saved to history');
      return;
    }
    try {
      await _dbService.insertRecord(record);
      await loadRecords();
    } catch (e, st) {
      AppLogger.error('Error inserting scan record', error: e, stackTrace: st);
    }
  }

  /// Toggles star/favorite status for a scan record.
  Future<void> toggleFavorite(String id) async {
    final index = _records.indexWhere((r) => r.id == id);
    if (index == -1) return;

    final currentStatus = _records[index].isFavorite;
    try {
      await _dbService.toggleFavorite(id, currentStatus);
      await loadRecords();
    } catch (e, st) {
      AppLogger.error('Error toggling favorite', error: e, stackTrace: st);
    }
  }

  /// Updates user notes for a scan record.
  Future<void> updateNotes(String id, String? notes) async {
    try {
      await _dbService.updateNotes(id, notes);
      await loadRecords();
    } catch (e, st) {
      AppLogger.error('Error updating notes', error: e, stackTrace: st);
    }
  }

  /// Updates location tag for a scan record.
  Future<void> updateLocationTag(String id, String? locationTag) async {
    try {
      await _dbService.updateLocationTag(id, locationTag);
      await loadRecords();
    } catch (e, st) {
      AppLogger.error('Error updating location tag', error: e, stackTrace: st);
    }
  }

  /// Deletes a scan record by ID.
  Future<void> deleteRecord(String id) async {
    try {
      await _dbService.deleteRecord(id);
      await loadRecords();
    } catch (e, st) {
      AppLogger.error('Error deleting record', error: e, stackTrace: st);
    }
  }

  /// Clears all history records.
  Future<void> clearAll() async {
    try {
      await _dbService.clearAll();
      await loadRecords();
    } catch (e, st) {
      AppLogger.error('Error clearing history', error: e, stackTrace: st);
    }
  }

  /// Exports history dataset to string or PDF bytes based on format.
  ///
  /// [labels] carries the report wording, already localized by the screen.
  /// CSV and JSON ignore it: their headers are a fixed interchange format that
  /// the import path reads back, so they stay in English on purpose.
  dynamic exportData(ExportFormat format, HistoryReportLabels labels) {
    switch (format) {
      case ExportFormat.csv:
        return _exportService.exportToCsv(_records);
      case ExportFormat.json:
        return _exportService.exportToJson(_records);
      case ExportFormat.txt:
        return _exportService.exportToFormattedTxt(_records, labels);
      case ExportFormat.pdf:
        return _exportService.exportToPdf(_records, labels);
    }
  }

  /// Generates password-encrypted local backup string (`.sreerajqr`).
  /// The slow key derivation runs in a background isolate.
  Future<String> createEncryptedBackup(String passphrase) {
    return _exportService.createEncryptedBackup(_records, passphrase);
  }

  /// Restores records from password-encrypted local backup payload.
  Future<int> restoreEncryptedBackup(
    String backupContent,
    String passphrase,
  ) async {
    final restoredRecords = await _exportService.restoreEncryptedBackup(
      backupContent,
      passphrase,
    );
    for (final record in restoredRecords) {
      await _dbService.insertRecord(record);
    }
    await loadRecords();
    return restoredRecords.length;
  }
}
