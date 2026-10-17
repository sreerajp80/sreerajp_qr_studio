import 'package:material_ui/material_ui.dart';
import 'package:qr/qr.dart';
import 'package:sreerajp_qr_studio/models/code_forge_config.dart';

/// Canvas painter that renders highly customized QR codes with tailored
/// eye shapes, inner pupils, pattern module shapes, linear gradients, and center badges.
class CodeForgeQrPainter extends CustomPainter {
  final CodeForgeConfig config;
  final QrImage qrImage;
  final double quietZoneModules;

  CodeForgeQrPainter({
    required this.config,
    required this.qrImage,
    this.quietZoneModules = 2.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final moduleCount = qrImage.moduleCount;
    final totalModules = moduleCount + (quietZoneModules * 2);
    final moduleSize = size.width / totalModules;
    final quietOffset = quietZoneModules * moduleSize;

    // 1. Draw Background
    final bgPaint = Paint()..color = config.backgroundColor;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // Prepare Paints for Data Modules
    final dataPaint = Paint()..style = PaintingStyle.fill;
    if (config.gradientColors != null && config.gradientColors!.length >= 2) {
      dataPaint.shader = RadialGradient(
        colors: config.gradientColors!,
        radius: 0.9,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    } else {
      dataPaint.color = config.foregroundColor;
    }

    // Prepare Eye Paints
    final eyeOuterPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = moduleSize
      ..color = config.eyeOuterColor ?? config.foregroundColor;

    final eyeInnerPaint = Paint()
      ..style = PaintingStyle.fill
      ..color =
          config.eyeInnerColor ??
          config.eyeOuterColor ??
          config.foregroundColor;

    // Calculate center badge cutout region (if badge is enabled)
    final hasBadge = config.centerBadge != QrCenterBadge.none;
    const badgeSizeModules = 7;
    final badgeCenterModule = moduleCount / 2;
    final badgeStart = (badgeCenterModule - badgeSizeModules / 2).floor();
    final badgeEnd = (badgeCenterModule + badgeSizeModules / 2).ceil();

    // 2. Render Data Modules (excluding 7x7 finder patterns and center badge)
    for (int r = 0; r < moduleCount; r++) {
      for (int c = 0; c < moduleCount; c++) {
        // Skip finder pattern zones
        if (_isFinderPattern(r, c, moduleCount)) continue;

        // Skip center badge zone
        if (hasBadge &&
            r >= badgeStart &&
            r < badgeEnd &&
            c >= badgeStart &&
            c < badgeEnd) {
          continue;
        }

        if (qrImage.isDark(r, c)) {
          final x = quietOffset + (c * moduleSize);
          final y = quietOffset + (r * moduleSize);
          _drawModule(canvas, x, y, moduleSize, dataPaint);
        }
      }
    }

    // 3. Render the 3 Eye Finder Patterns with custom shapes
    _drawEye(
      canvas,
      quietOffset,
      quietOffset,
      moduleSize,
      eyeOuterPaint,
      eyeInnerPaint,
      EyeCorner.topLeft,
    );

    _drawEye(
      canvas,
      quietOffset + ((moduleCount - 7) * moduleSize),
      quietOffset,
      moduleSize,
      eyeOuterPaint,
      eyeInnerPaint,
      EyeCorner.topRight,
    );

    _drawEye(
      canvas,
      quietOffset,
      quietOffset + ((moduleCount - 7) * moduleSize),
      moduleSize,
      eyeOuterPaint,
      eyeInnerPaint,
      EyeCorner.bottomLeft,
    );

    // 4. Render Center Badge if enabled
    if (hasBadge) {
      _drawCenterBadge(
        canvas,
        size,
        quietOffset + (badgeStart * moduleSize),
        quietOffset + (badgeStart * moduleSize),
        (badgeEnd - badgeStart) * moduleSize,
      );
    }
  }

  bool _isFinderPattern(int r, int c, int moduleCount) {
    // Top-left 7x7
    if (r < 7 && c < 7) return true;
    // Top-right 7x7
    if (r < 7 && c >= moduleCount - 7) return true;
    // Bottom-left 7x7
    if (r >= moduleCount - 7 && c < 7) return true;
    return false;
  }

  void _drawModule(
    Canvas canvas,
    double x,
    double y,
    double size,
    Paint paint,
  ) {
    switch (config.patternShape) {
      case QrPatternShape.square:
        canvas.drawRect(Rect.fromLTWH(x, y, size, size), paint);
        break;

      case QrPatternShape.dots:
        final cx = x + (size / 2);
        final cy = y + (size / 2);
        canvas.drawCircle(Offset(cx, cy), (size / 2) * 0.88, paint);
        break;

      case QrPatternShape.rounded:
        final radius = Radius.circular(size * 0.35);
        canvas.drawRRect(
          RRect.fromRectAndRadius(Rect.fromLTWH(x, y, size, size), radius),
          paint,
        );
        break;

      case QrPatternShape.classy:
        final radius = Radius.circular(size * 0.5);
        canvas.drawRRect(
          RRect.fromRectAndCorners(
            Rect.fromLTWH(x, y, size, size),
            topLeft: radius,
            bottomRight: radius,
          ),
          paint,
        );
        break;

      case QrPatternShape.diamond:
        final path = Path()
          ..moveTo(x + size / 2, y)
          ..lineTo(x + size, y + size / 2)
          ..lineTo(x + size / 2, y + size)
          ..lineTo(x, y + size / 2)
          ..close();
        canvas.drawPath(path, paint);
        break;
    }
  }

  void _drawEye(
    Canvas canvas,
    double x,
    double y,
    double moduleSize,
    Paint outerPaint,
    Paint innerPaint,
    EyeCorner corner,
  ) {
    // Outer frame is 7x7 modules. The stroke width is 1 module,
    // so the stroke path sits at offset 0.5 modules from the bounding box.
    final outerRect = Rect.fromLTWH(
      x + (moduleSize * 0.5),
      y + (moduleSize * 0.5),
      moduleSize * 6,
      moduleSize * 6,
    );

    // Inner ball sits in the center 3x3 modules (offset 2 modules inward)
    final innerRect = Rect.fromLTWH(
      x + (moduleSize * 2),
      y + (moduleSize * 2),
      moduleSize * 3,
      moduleSize * 3,
    );

    // 1. Draw Outer Eye Frame
    switch (config.eyeShape) {
      case QrEyeShape.square:
        canvas.drawRect(outerRect, outerPaint);
        break;

      case QrEyeShape.rounded:
        canvas.drawRRect(
          RRect.fromRectAndRadius(outerRect, Radius.circular(moduleSize * 1.8)),
          outerPaint,
        );
        break;

      case QrEyeShape.circle:
        canvas.drawOval(outerRect, outerPaint);
        break;

      case QrEyeShape.leaf:
        final cornerRadius = Radius.circular(moduleSize * 2.8);
        RRect rrect;
        switch (corner) {
          case EyeCorner.topLeft:
            rrect = RRect.fromRectAndCorners(
              outerRect,
              topLeft: cornerRadius,
              bottomRight: cornerRadius,
            );
            break;
          case EyeCorner.topRight:
            rrect = RRect.fromRectAndCorners(
              outerRect,
              topRight: cornerRadius,
              bottomLeft: cornerRadius,
            );
            break;
          case EyeCorner.bottomLeft:
            rrect = RRect.fromRectAndCorners(
              outerRect,
              bottomLeft: cornerRadius,
              topRight: cornerRadius,
            );
            break;
        }
        canvas.drawRRect(rrect, outerPaint);
        break;
    }

    // 2. Draw Inner Eye Ball (Pupil)
    switch (config.eyeBallShape) {
      case QrEyeBallShape.square:
        canvas.drawRect(innerRect, innerPaint);
        break;

      case QrEyeBallShape.rounded:
        canvas.drawRRect(
          RRect.fromRectAndRadius(innerRect, Radius.circular(moduleSize * 0.8)),
          innerPaint,
        );
        break;

      case QrEyeBallShape.circle:
        canvas.drawOval(innerRect, innerPaint);
        break;

      case QrEyeBallShape.diamond:
        final path = Path()
          ..moveTo(innerRect.center.dx, innerRect.top)
          ..lineTo(innerRect.right, innerRect.center.dy)
          ..lineTo(innerRect.center.dx, innerRect.bottom)
          ..lineTo(innerRect.left, innerRect.center.dy)
          ..close();
        canvas.drawPath(path, innerPaint);
        break;
    }
  }

  void _drawCenterBadge(
    Canvas canvas,
    Size size,
    double x,
    double y,
    double badgePixelSize,
  ) {
    final badgeRect = Rect.fromLTWH(x, y, badgePixelSize, badgePixelSize);

    // Draw clean background pill/box for badge with soft shadow
    final badgeBgPaint = Paint()..color = config.backgroundColor;
    final badgeBorderPaint = Paint()
      ..color = config.foregroundColor.withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final badgeRRect = RRect.fromRectAndRadius(
      badgeRect,
      Radius.circular(badgePixelSize * 0.28),
    );

    canvas.drawRRect(badgeRRect, badgeBgPaint);
    canvas.drawRRect(badgeRRect, badgeBorderPaint);

    // Draw Icon in center
    IconData icon;
    Color iconColor;

    if (config.centerBadge == QrCenterBadge.shieldVerified) {
      icon = Icons.verified_user;
      iconColor = const Color(0xFF2E7D32); // Trust green
    } else {
      iconColor = config.foregroundColor;
      switch (config.payloadType) {
        case CodeForgePayloadType.wifi:
          icon = Icons.wifi;
          break;
        case CodeForgePayloadType.contactVCard:
          icon = Icons.contact_phone;
          break;
        case CodeForgePayloadType.upiPayment:
          icon = Icons.currency_rupee;
          break;
        case CodeForgePayloadType.sms:
          icon = Icons.sms;
          break;
        case CodeForgePayloadType.email:
          icon = Icons.email;
          break;
        case CodeForgePayloadType.geo:
          icon = Icons.location_on;
          break;
        case CodeForgePayloadType.url:
          icon = Icons.link;
          break;
        case CodeForgePayloadType.text:
          icon = Icons.text_fields;
          break;
      }
    }

    final textPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: badgePixelSize * 0.55,
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
          color: iconColor,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    final iconOffset = Offset(
      badgeRect.center.dx - (textPainter.width / 2),
      badgeRect.center.dy - (textPainter.height / 2),
    );
    textPainter.paint(canvas, iconOffset);
  }

  @override
  bool shouldRepaint(covariant CodeForgeQrPainter oldDelegate) {
    return oldDelegate.config != config || oldDelegate.qrImage != qrImage;
  }
}

enum EyeCorner { topLeft, topRight, bottomLeft }
