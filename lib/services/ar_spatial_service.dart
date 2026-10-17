import 'dart:ui';

import 'package:sreerajp_qr_studio/models/app_message.dart';
import 'package:sreerajp_qr_studio/models/ar_code_target.dart';
import 'package:sreerajp_qr_studio/models/code_content_type.dart';

/// Pure service handling coordinate transformations, target decay,
/// and metadata formatting for AR CodeVision HUD mode.
class ArSpatialService {
  /// Transforms camera frame coordinates to screen viewport logical coordinates.
  Offset convertFrameToScreenOffset({
    required Offset framePoint,
    required Size imageSize,
    required Size screenSize,
  }) {
    if (imageSize.width <= 0 || imageSize.height <= 0) {
      return framePoint;
    }

    final scaleX = screenSize.width / imageSize.width;
    final scaleY = screenSize.height / imageSize.height;

    return Offset(framePoint.dx * scaleX, framePoint.dy * scaleY);
  }

  /// Calculates the center anchor point for placing an AR chip over a target.
  Offset calculateTargetCenter(List<Offset> corners, Rect boundingBox) {
    if (corners.isNotEmpty) {
      double sumX = 0;
      double sumY = 0;
      for (final corner in corners) {
        sumX += corner.dx;
        sumY += corner.dy;
      }
      return Offset(sumX / corners.length, sumY / corners.length);
    }
    return boundingBox.center;
  }

  /// Filters out targets that have not been updated within [decayDuration].
  List<ArCodeTarget> decayStaleTargets(
    List<ArCodeTarget> targets, {
    Duration decayDuration = const Duration(milliseconds: 1500),
  }) {
    final now = DateTime.now();
    return targets.where((target) {
      return now.difference(target.lastSeen) <= decayDuration;
    }).toList();
  }

  /// Names the kind of code that was seen, as a message key.
  AppMessage getFormatDisplayName(CodeContentType type, String rawValue) {
    switch (type) {
      case CodeContentType.url:
        return const AppMessage(AppMessageKey.formatQrUrl);
      case CodeContentType.email:
        return const AppMessage(AppMessageKey.formatQrEmail);
      case CodeContentType.phone:
        return const AppMessage(AppMessageKey.formatQrPhone);
      case CodeContentType.sms:
        return const AppMessage(AppMessageKey.formatQrSms);
      case CodeContentType.wifi:
        return const AppMessage(AppMessageKey.formatQrWifi);
      case CodeContentType.geo:
        return const AppMessage(AppMessageKey.formatQrLocation);
      case CodeContentType.contactInfo:
        return const AppMessage(AppMessageKey.formatQrContact);
      case CodeContentType.isbn:
        return const AppMessage(AppMessageKey.formatIsbn);
      case CodeContentType.product:
        return const AppMessage(AppMessageKey.formatEanUpc);
      case CodeContentType.text:
      default:
        if (rawValue.startsWith('http://') || rawValue.startsWith('https://')) {
          return const AppMessage(AppMessageKey.formatQrCode);
        }
        if (RegExp(r'^\d{8}$|^\d{12,13}$').hasMatch(rawValue)) {
          return const AppMessage(AppMessageKey.formatEanUpcProduct);
        }
        return const AppMessage(AppMessageKey.formatBarcode);
    }
  }

  /// Generates price tag / retail label for Warehouse Mode.
  String generatePriceTag(String rawValue, CodeContentType type) {
    if (rawValue.isEmpty) return '\$0.00';
    // Generate deterministic price representation based on barcode content hash
    final hash = rawValue.codeUnits.fold(0, (prev, elem) => prev + elem);
    final dollars = (hash % 95) + 5;
    final cents = (hash % 100).toString().padLeft(2, '0');
    return '\$$dollars.$cents';
  }
}
