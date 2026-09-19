import 'package:flutter/widgets.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sreeraj_qr_reader/models/visible_barcode.dart';
import 'package:sreeraj_qr_reader/services/multi_code_service.dart';

/// Provider managing multi-code detection, spatial coordinate projections,
/// target decay, and interactive user selection on the main camera scanner.
class MultiCodeSelectionProvider extends ChangeNotifier {
  final MultiCodeService _service;

  bool _enabled = true;
  bool _isMultiCodeActive = false;
  List<VisibleBarcode> _visibleBarcodes = [];
  String? _selectedBarcodeId;

  MultiCodeSelectionProvider({MultiCodeService? service})
    : _service = service ?? MultiCodeService();

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
    required BarcodeCapture capture,
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
            barcode.type == BarcodeType.url;

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
      final activeList = _service.decayStaleBarcodes(updatedList);
      _visibleBarcodes = activeList;

      if (capture.barcodes.length > 1 || _visibleBarcodes.length > 1) {
        _isMultiCodeActive = true;
      } else if (_visibleBarcodes.isEmpty) {
        _isMultiCodeActive = false;
      }

      notifyListeners();
    }
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
    notifyListeners();
  }

  /// Resets state when leaving scanner screen or pausing camera.
  void reset() {
    _isMultiCodeActive = false;
    _visibleBarcodes = [];
    _selectedBarcodeId = null;
    notifyListeners();
  }
}
