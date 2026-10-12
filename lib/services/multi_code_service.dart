import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:sreerajp_qr_studio/models/visible_barcode.dart';
import 'package:sreerajp_qr_studio/models/code_content_type.dart';

/// Pure service handling coordinate transformations, bounding box calculations,
/// decay management, and display label formatting for Multi-Code Tappable Selection.
class MultiCodeService {
  /// Minimum touch target size in logical pixels for accessibility.
  static const double minTouchTargetSize = 48.0;

  /// Transforms camera frame coordinates to screen viewport logical coordinates
  /// taking [BoxFit.cover] scaling and letterboxing/cropping offsets into account.
  Offset convertFrameToScreenOffset({
    required Offset framePoint,
    required Size frameSize,
    required Size screenSize,
    BoxFit fit = BoxFit.cover,
  }) {
    if (frameSize.width <= 0 ||
        frameSize.height <= 0 ||
        screenSize.width <= 0 ||
        screenSize.height <= 0) {
      return framePoint;
    }

    if (fit == BoxFit.cover) {
      final scale = math.max(
        screenSize.width / frameSize.width,
        screenSize.height / frameSize.height,
      );
      final scaledWidth = frameSize.width * scale;
      final scaledHeight = frameSize.height * scale;
      final offsetX = (screenSize.width - scaledWidth) / 2.0;
      final offsetY = (screenSize.height - scaledHeight) / 2.0;

      return Offset(
        framePoint.dx * scale + offsetX,
        framePoint.dy * scale + offsetY,
      );
    } else {
      final scaleX = screenSize.width / frameSize.width;
      final scaleY = screenSize.height / frameSize.height;
      return Offset(framePoint.dx * scaleX, framePoint.dy * scaleY);
    }
  }

  /// Projects a list of camera frame corners to screen logical offsets.
  List<Offset> projectCornersToScreen({
    required List<Offset> corners,
    required Size frameSize,
    required Size screenSize,
    BoxFit fit = BoxFit.cover,
  }) {
    if (corners.isEmpty) return const [];
    return corners.map((corner) {
      return convertFrameToScreenOffset(
        framePoint: corner,
        frameSize: frameSize,
        screenSize: screenSize,
        fit: fit,
      );
    }).toList();
  }

  /// Projects a camera frame bounding [Rect] to screen logical pixels,
  /// ensuring a minimum tap target dimension of [minTouchTargetSize].
  Rect projectFrameToScreenRect({
    required Rect frameRect,
    required Size frameSize,
    required Size screenSize,
    BoxFit fit = BoxFit.cover,
  }) {
    final topLeft = convertFrameToScreenOffset(
      framePoint: frameRect.topLeft,
      frameSize: frameSize,
      screenSize: screenSize,
      fit: fit,
    );
    final bottomRight = convertFrameToScreenOffset(
      framePoint: frameRect.bottomRight,
      frameSize: frameSize,
      screenSize: screenSize,
      fit: fit,
    );

    var screenRect = Rect.fromPoints(topLeft, bottomRight);

    // Expand to minimum touch target size if necessary, centered on original rect
    if (screenRect.width < minTouchTargetSize ||
        screenRect.height < minTouchTargetSize) {
      final targetWidth = math.max(screenRect.width, minTouchTargetSize);
      final targetHeight = math.max(screenRect.height, minTouchTargetSize);
      final center = screenRect.center;
      screenRect = Rect.fromCenter(
        center: center,
        width: targetWidth,
        height: targetHeight,
      );
    }

    return screenRect;
  }

  /// Computes the enclosing bounding [Rect] from a list of corner offsets.
  Rect computeBoundingBox(List<Offset> corners) {
    if (corners.isEmpty) return Rect.zero;
    double minX = corners.first.dx;
    double maxX = corners.first.dx;
    double minY = corners.first.dy;
    double maxY = corners.first.dy;

    for (final c in corners) {
      if (c.dx < minX) minX = c.dx;
      if (c.dx > maxX) maxX = c.dx;
      if (c.dy < minY) minY = c.dy;
      if (c.dy > maxY) maxY = c.dy;
    }
    return Rect.fromLTRB(minX, minY, maxX, maxY);
  }

  /// Filters out barcodes that have not been refreshed within [decayDuration].
  List<VisibleBarcode> decayStaleBarcodes(
    List<VisibleBarcode> items, {
    Duration decayDuration = const Duration(milliseconds: 1500),
  }) {
    final now = DateTime.now();
    return items.where((item) {
      return now.difference(item.lastSeen) <= decayDuration;
    }).toList();
  }

  /// Returns a concise display label for the barcode type and content.
  String getDisplayLabel(CodeContentType type, String rawValue) {
    switch (type) {
      case CodeContentType.url:
        return 'URL';
      case CodeContentType.wifi:
        return 'Wi-Fi';
      case CodeContentType.contactInfo:
        return 'Contact';
      case CodeContentType.email:
        return 'Email';
      case CodeContentType.phone:
        return 'Phone';
      case CodeContentType.sms:
        return 'SMS';
      case CodeContentType.geo:
        return 'Location';
      case CodeContentType.calendarEvent:
        return 'Event';
      case CodeContentType.isbn:
        return 'ISBN';
      case CodeContentType.product:
        return 'Product';
      case CodeContentType.text:
      default:
        if (rawValue.startsWith('http://') || rawValue.startsWith('https://')) {
          return 'URL';
        }
        if (rawValue.startsWith('WIFI:')) {
          return 'Wi-Fi';
        }
        if (rawValue.startsWith('BEGIN:VCARD') ||
            rawValue.startsWith('MECARD:')) {
          return 'Contact';
        }
        if (rawValue.startsWith('upi://')) {
          return 'UPI Pay';
        }
        if (RegExp(r'^\d{8}$|^\d{12,13}$').hasMatch(rawValue)) {
          return 'ScannedCode';
        }
        return 'Code';
    }
  }
}
