import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:sreerajp_qr_studio/models/visible_barcode.dart';
import 'package:sreerajp_qr_studio/services/multi_code_service.dart';
import 'package:sreerajp_qr_studio/models/code_content_type.dart';
import 'package:sreerajp_qr_studio/models/scan_frame_result.dart';

/// Provider managing multi-code detection, spatial coordinate projections,
/// target decay, and interactive user selection on the main camera scanner.
class MultiCodeSelectionProvider extends ChangeNotifier {
  final MultiCodeService _service;

  /// How long a code may go unseen before its tap box is removed.
  final Duration staleAfter;

  /// How often stale tap boxes are checked while multi-code mode is active.
  /// The camera sends no frames when it sees no codes, so this timer is what
  /// clears the boxes once every code has left the view.
  final Duration cleanupInterval;

  Timer? _cleanupTimer;
  bool _enabled = true;
  bool _isMultiCodeActive = false;
  List<VisibleBarcode> _visibleBarcodes = [];
  String? _selectedBarcodeId;

  MultiCodeSelectionProvider({
    MultiCodeService? service,
    this.staleAfter = const Duration(milliseconds: 1500),
    this.cleanupInterval = const Duration(milliseconds: 250),
  }) : _service = service ?? MultiCodeService();

  bool get enabled => _enabled;
  bool get isMultiCodeActive => _isMultiCodeActive;
  List<VisibleBarcode> get visibleBarcodes =>
      List.unmodifiable(_visibleBarcodes);
  String? get selectedBarcodeId => _selectedBarcodeId;
  int get visibleCount => _visibleBarcodes.length;

  /// Updates whether multi-code detection is enabled.
  void setEnabled(bool value) {
    if (_enabled != value) {
      _enabled = value;
      if (!_enabled) {
        reset();
      } else {
        notifyListeners();
      }
    }
  }

  /// Processes a camera frame capture from [MobileScanner].
  void processCapture({
    required ScanFrameResult capture,
    required Size screenSize,
    required Size frameSize,
  }) {
    if (!_enabled) return;

    final now = DateTime.now();
    final updatedList = List<VisibleBarcode>.from(_visibleBarcodes);

    // If multiple barcodes are in the capture, or if multi-code is already active
    if (capture.barcodes.length > 1 || _isMultiCodeActive) {
      for (final barcode in capture.barcodes) {
        final rawValue = barcode.rawValue;
        if (rawValue == null || rawValue.isEmpty) continue;

        final id = '${rawValue.hashCode}_${barcode.format.name}';
        final frameBox = _service.computeBoundingBox(barcode.corners);
        final screenRect = _service.projectFrameToScreenRect(
          frameRect: frameBox,
          frameSize: frameSize,
          screenSize: screenSize,
        );

        final isUrl =
            rawValue.startsWith('http://') ||
            rawValue.startsWith('https://') ||
            barcode.type == CodeContentType.url;

        final displayLabel = _service.getDisplayLabel(barcode.type, rawValue);

        final existingIdx = updatedList.indexWhere((item) => item.id == id);
        if (existingIdx >= 0) {
          updatedList[existingIdx] = updatedList[existingIdx].copyWith(
            corners: barcode.corners,
            boundingBox: frameBox,
            screenRect: screenRect,
            lastSeen: now,
          );
        } else {
          updatedList.add(
            VisibleBarcode(
              id: id,
              rawValue: rawValue,
              format: barcode.format,
              type: barcode.type,
              corners: barcode.corners,
              boundingBox: frameBox,
              screenRect: screenRect,
              lastSeen: now,
              isUrl: isUrl,
              displayLabel: displayLabel,
            ),
          );
        }
      }

      // Decay stale targets not seen recently
      final activeList = _service.decayStaleBarcodes(
        updatedList,
        decayDuration: staleAfter,
      );
      _visibleBarcodes = activeList;

      if (capture.barcodes.length > 1 || _visibleBarcodes.length > 1) {
        _isMultiCodeActive = true;
      } else if (_visibleBarcodes.isEmpty) {
        _isMultiCodeActive = false;
      }

      _updateCleanupTimer();
      notifyListeners();
    }
  }

  /// Starts the stale-box cleanup timer while multi-code mode is active and
  /// stops it otherwise.
  void _updateCleanupTimer() {
    if (_isMultiCodeActive) {
      _cleanupTimer ??= Timer.periodic(cleanupInterval, (_) => _removeStale());
    } else {
      _cleanupTimer?.cancel();
      _cleanupTimer = null;
    }
  }

  /// Removes tap boxes whose codes have not been seen recently. Ends
  /// multi-code mode when none are left.
  void _removeStale() {
    final activeList = _service.decayStaleBarcodes(
      _visibleBarcodes,
      decayDuration: staleAfter,
    );
    if (activeList.length == _visibleBarcodes.length) return;

    _visibleBarcodes = activeList;
    if (_visibleBarcodes.isEmpty) {
      _isMultiCodeActive = false;
      _selectedBarcodeId = null;
    }
    _updateCleanupTimer();
    notifyListeners();
  }

  /// Records the tapped barcode ID for confirmation micro-interaction.
  void selectBarcode(String id) {
    _selectedBarcodeId = id;
    notifyListeners();
  }

  /// Dismisses multi-code selection mode on user demand.
  void dismiss() {
    _isMultiCodeActive = false;
    _visibleBarcodes = [];
    _selectedBarcodeId = null;
    _updateCleanupTimer();
    notifyListeners();
  }

  /// Resets state when leaving scanner screen or pausing camera.
  void reset() {
    _isMultiCodeActive = false;
    _visibleBarcodes = [];
    _selectedBarcodeId = null;
    _updateCleanupTimer();
    notifyListeners();
  }

  @override
  void dispose() {
    _cleanupTimer?.cancel();
    _cleanupTimer = null;
    super.dispose();
  }
}
