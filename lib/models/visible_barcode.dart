import 'package:flutter/widgets.dart';
import 'package:sreerajp_qr_studio/models/code_format.dart';
import 'package:sreerajp_qr_studio/models/code_content_type.dart';
import 'package:sreerajp_qr_studio/models/scanned_code.dart';

/// Immutable model representing a visible barcode in the main scanner viewport
/// with both camera-frame and screen-logical coordinates for interactive selection.
@immutable
class VisibleBarcode {
  final String id;
  final String rawValue;
  final CodeFormat format;
  final CodeContentType type;
  final List<Offset> corners;
  final Rect boundingBox;
  final Rect screenRect;
  final DateTime lastSeen;
  final bool isUrl;
  final String displayLabel;

  const VisibleBarcode({
    required this.id,
    required this.rawValue,
    required this.format,
    required this.type,
    required this.corners,
    required this.boundingBox,
    required this.screenRect,
    required this.lastSeen,
    required this.isUrl,
    required this.displayLabel,
  });

  VisibleBarcode copyWith({
    String? id,
    String? rawValue,
    CodeFormat? format,
    CodeContentType? type,
    List<Offset>? corners,
    Rect? boundingBox,
    Rect? screenRect,
    DateTime? lastSeen,
    bool? isUrl,
    String? displayLabel,
  }) {
    return VisibleBarcode(
      id: id ?? this.id,
      rawValue: rawValue ?? this.rawValue,
      format: format ?? this.format,
      type: type ?? this.type,
      corners: corners ?? this.corners,
      boundingBox: boundingBox ?? this.boundingBox,
      screenRect: screenRect ?? this.screenRect,
      lastSeen: lastSeen ?? this.lastSeen,
      isUrl: isUrl ?? this.isUrl,
      displayLabel: displayLabel ?? this.displayLabel,
    );
  }

  /// Converts this visible barcode back to a standard MobileScanner [ScannedCode] instance.
  ScannedCode toScannedCode() {
    return ScannedCode(rawValue: rawValue, format: format, corners: corners);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VisibleBarcode &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          rawValue == other.rawValue &&
          format == other.format &&
          screenRect == other.screenRect;

  @override
  int get hashCode =>
      id.hashCode ^ rawValue.hashCode ^ format.hashCode ^ screenRect.hashCode;
}
