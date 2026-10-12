import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:sreerajp_qr_studio/models/scanned_code.dart';

/// All codes found in one camera frame.
@immutable
class ScanFrameResult {
  /// Codes found in the frame, in decoder order.
  final List<ScannedCode> barcodes;

  /// Size of the upright analysed frame. Code corners use this coordinate
  /// space. [Size.zero] when unknown.
  final Size size;

  const ScanFrameResult({this.barcodes = const [], this.size = Size.zero});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScanFrameResult &&
          size == other.size &&
          listEquals(barcodes, other.barcodes);

  @override
  int get hashCode => Object.hash(size, Object.hashAll(barcodes));
}
