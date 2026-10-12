import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:sreerajp_qr_studio/models/code_content_type.dart';
import 'package:sreerajp_qr_studio/models/code_format.dart';

/// One barcode or QR code found by the app's own decoder.
@immutable
class ScannedCode {
  /// Decoded text (UTF-8). Null only for synthetic codes with no text.
  final String? rawValue;

  /// Raw decoded bytes, when the decoder provides them.
  final Uint8List? rawBytes;

  /// Barcode symbology.
  final CodeFormat format;

  /// Kind of data carried by the code.
  final CodeContentType type;

  /// Corner points (top-left, top-right, bottom-right, bottom-left) in the
  /// coordinate space of the upright analysed frame or image.
  final List<Offset> corners;

  const ScannedCode({
    this.rawValue,
    this.rawBytes,
    this.format = CodeFormat.unknown,
    this.type = CodeContentType.unknown,
    this.corners = const [],
  });

  /// Text shown to people. Same as [rawValue].
  String? get displayValue => rawValue;

  ScannedCode copyWith({
    String? rawValue,
    Uint8List? rawBytes,
    CodeFormat? format,
    CodeContentType? type,
    List<Offset>? corners,
  }) {
    return ScannedCode(
      rawValue: rawValue ?? this.rawValue,
      rawBytes: rawBytes ?? this.rawBytes,
      format: format ?? this.format,
      type: type ?? this.type,
      corners: corners ?? this.corners,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScannedCode &&
          rawValue == other.rawValue &&
          format == other.format &&
          type == other.type &&
          listEquals(corners, other.corners);

  @override
  int get hashCode =>
      Object.hash(rawValue, format, type, Object.hashAll(corners));

  @override
  String toString() =>
      'ScannedCode(format: ${format.name}, type: ${type.name}, '
      'length: ${rawValue?.length ?? 0})';
}
