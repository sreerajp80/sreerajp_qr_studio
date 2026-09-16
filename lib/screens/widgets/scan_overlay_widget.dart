import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:sreeraj_qr_reader/providers/theme_provider.dart';

/// Customizable animated scanner frame overlay supporting 4 styles:
/// Laser Line, Pulsing Corners, Cybernetic Grid, and Subtle Dot Matrix,
/// along with dynamic barcode bounding box reticles.
class ScanOverlayWidget extends StatefulWidget {
  final ScanOverlayStyle style;
  final double scanAreaSize;
  final Rect? detectedBoundingBox;
  final List<Offset>? detectedCorners;
  final bool isSuccess;
  final VoidCallback? onAnimationComplete;

  const ScanOverlayWidget({
    super.key,
    required this.style,
    this.scanAreaSize = 250.0,
    this.detectedBoundingBox,
    this.detectedCorners,
    this.isSuccess = false,
    this.onAnimationComplete,
  });

  @override
  State<ScanOverlayWidget> createState() => _ScanOverlayWidgetState();
}

class _ScanOverlayWidgetState extends State<ScanOverlayWidget>
    with TickerProviderStateMixin {
  late AnimationController _idleController;
  late AnimationController _successController;

  @override
  void initState() {
    super.initState();
    _idleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _successController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    );

    if (widget.isSuccess) {
      _idleController.stop();
      _successController.forward(from: 0.0).then((_) {
        if (mounted) widget.onAnimationComplete?.call();
      });
    }
  }

  @override
  void didUpdateWidget(ScanOverlayWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.isSuccess && widget.isSuccess) {
      _idleController.stop();
      _successController.forward(from: 0.0).then((_) {
        if (mounted) widget.onAnimationComplete?.call();
      });
    } else if (oldWidget.isSuccess && !widget.isSuccess) {
      _successController.reset();
      _idleController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _idleController.dispose();
    _successController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_idleController, _successController]),
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.scanAreaSize, widget.scanAreaSize),
          painter: _ScanOverlayPainter(
            style: widget.style,
            progress: _idleController.value,
            colorScheme: Theme.of(context).colorScheme,
            detectedBoundingBox: widget.detectedBoundingBox,
            detectedCorners: widget.detectedCorners,
            isSuccess: widget.isSuccess,
            successProgress: _successController.value,
          ),
        );
      },
    );
  }
}

class _ScanOverlayPainter extends CustomPainter {
  final ScanOverlayStyle style;
  final double progress;
  final ColorScheme colorScheme;
  final Rect? detectedBoundingBox;
  final List<Offset>? detectedCorners;
  final bool isSuccess;
  final double successProgress;

  _ScanOverlayPainter({
    required this.style,
    required this.progress,
    required this.colorScheme,
    this.detectedBoundingBox,
    this.detectedCorners,
    this.isSuccess = false,
    this.successProgress = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    double scale = 1.0;
    if (isSuccess && successProgress > 0.0) {
      if (successProgress < 0.25) {
        scale = 1.0 - (0.05 * (successProgress / 0.25));
      } else if (successProgress < 0.65) {
        final t = (successProgress - 0.25) / 0.40;
        scale = 0.95 + (0.11 * Curves.easeOutBack.transform(t));
      } else {
        final t = (successProgress - 0.65) / 0.35;
        scale = 1.06 - (0.06 * Curves.easeInOut.transform(t));
      }
    }

    final center = rect.center;
    final didScale = scale != 1.0;
    if (didScale) {
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.scale(scale);
      canvas.translate(-center.dx, -center.dy);
    }

    switch (style) {
      case ScanOverlayStyle.laserLine:
        _drawLaserLine(canvas, rect);
        break;
      case ScanOverlayStyle.pulsingCorners:
        _drawPulsingCorners(canvas, rect);
        break;
      case ScanOverlayStyle.cyberneticGrid:
        _drawCyberneticGrid(canvas, rect);
        break;
      case ScanOverlayStyle.subtleDotMatrix:
        _drawSubtleDotMatrix(canvas, rect);
        break;
    }

    if (isSuccess) {
      _drawSuccessReticlePulse(canvas, rect);
    }

    if (detectedBoundingBox != null ||
        (detectedCorners != null && detectedCorners!.isNotEmpty)) {
      _drawDetectedFocusBox(canvas, rect);
    }

    if (didScale) {
      canvas.restore();
    }

    if (isSuccess) {
      _drawCheckmarkMorph(canvas, center, successProgress);
    }
  }

  /// 1. Laser Line Style: Frame with animated vertical scanning beam line.
  void _drawLaserLine(Canvas canvas, Rect rect) {
    final borderPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Outer bounding frame
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(12));
    canvas.drawRRect(rrect, borderPaint);

    // Corner reticles
    _drawCornerBrackets(canvas, rect, colorScheme.primary);

    // Animated laser sweep line
    final laserY = rect.top + (rect.height * progress);
    final laserPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          colorScheme.primary.withValues(alpha: 0.0),
          colorScheme.primary,
          Colors.cyanAccent,
          colorScheme.primary,
          colorScheme.primary.withValues(alpha: 0.0),
        ],
        stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
      ).createShader(Rect.fromLTWH(rect.left, laserY, rect.width, 3))
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(rect.left + 8, laserY),
      Offset(rect.right - 8, laserY),
      laserPaint,
    );

    // Laser glow gradient below/above laser
    final glowPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          colorScheme.primary.withValues(alpha: 0.35),
          colorScheme.primary.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromLTWH(rect.left, laserY - 20, rect.width, 20));

    canvas.drawRect(
      Rect.fromLTRB(rect.left + 8, laserY - 20, rect.right - 8, laserY),
      glowPaint,
    );
  }

  /// 2. Pulsing Corners Style: Glowing/breathing corner L-brackets.
  void _drawPulsingCorners(Canvas canvas, Rect rect) {
    final pulseFactor = 0.5 + 0.5 * math.sin(progress * math.pi * 2);
    final cornerLength = 28.0 + (pulseFactor * 6.0);
    final opacity = 0.6 + (pulseFactor * 0.4);
    final glowColor = Color.lerp(
      colorScheme.primary,
      Colors.greenAccent,
      pulseFactor,
    )!;

    final borderPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(12)),
      borderPaint,
    );

    _drawCornerBrackets(
      canvas,
      rect,
      glowColor.withValues(alpha: opacity),
      cornerLength: cornerLength,
      strokeWidth: 4.0,
    );

    // Subtle center breathing circle
    final centerCirclePaint = Paint()
      ..color = glowColor.withValues(alpha: 0.15 * pulseFactor)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      rect.center,
      24.0 + (pulseFactor * 8.0),
      centerCirclePaint,
    );
  }

  /// 3. Cybernetic Grid Style: Sci-fi grid lines with crosshair target reticle.
  void _drawCyberneticGrid(Canvas canvas, Rect rect) {
    final gridPaint = Paint()
      ..color = Colors.cyanAccent.withValues(alpha: 0.18)
      ..strokeWidth = 1.0;

    const gridDivisions = 5;
    final stepX = rect.width / gridDivisions;
    final stepY = rect.height / gridDivisions;

    // Draw inner grid lines
    for (int i = 1; i < gridDivisions; i++) {
      canvas.drawLine(
        Offset(rect.left + i * stepX, rect.top),
        Offset(rect.left + i * stepX, rect.bottom),
        gridPaint,
      );
      canvas.drawLine(
        Offset(rect.left, rect.top + i * stepY),
        Offset(rect.right, rect.top + i * stepY),
        gridPaint,
      );
    }

    // Outer sci-fi frame
    final framePaint = Paint()
      ..color = Colors.cyanAccent.withValues(alpha: 0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawRect(rect, framePaint);

    // Center crosshairs
    final crosshairPaint = Paint()
      ..color = Colors.cyanAccent
      ..strokeWidth = 2.0;

    final center = rect.center;
    const crosshairSize = 16.0;
    canvas.drawLine(
      Offset(center.dx - crosshairSize, center.dy),
      Offset(center.dx + crosshairSize, center.dy),
      crosshairPaint,
    );
    canvas.drawLine(
      Offset(center.dx, center.dy - crosshairSize),
      Offset(center.dx, center.dy + crosshairSize),
      crosshairPaint,
    );

    // Rotating/pulsing target ring
    final ringRadius = 32.0 + (progress * 4.0);
    final ringPaint = Paint()
      ..color = Colors.cyanAccent.withValues(alpha: 0.5 + 0.3 * progress)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, ringRadius, ringPaint);
  }

  /// 4. Subtle Dot Matrix Style: Minimalist corner dot grid accents.
  void _drawSubtleDotMatrix(Canvas canvas, Rect rect) {
    final framePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(8)),
      framePaint,
    );

    final dotPulse = (math.sin(progress * math.pi * 2) + 1) / 2;
    final dotColor = Color.lerp(colorScheme.primary, Colors.white, dotPulse)!;

    final activeDotPaint = Paint()
      ..color = dotColor
      ..style = PaintingStyle.fill;

    const dotRadius = 3.0;
    const dotSpacing = 10.0;
    const dotsPerCorner = 3;

    // Draw 3x3 dot matrix grid on each of the 4 corners
    final cornerOffsets = [
      rect.topLeft + const Offset(12, 12),
      rect.topRight + const Offset(-12 - (dotsPerCorner - 1) * dotSpacing, 12),
      rect.bottomLeft +
          const Offset(12, -12 - (dotsPerCorner - 1) * dotSpacing),
      rect.bottomRight +
          const Offset(
            -12 - (dotsPerCorner - 1) * dotSpacing,
            -12 - (dotsPerCorner - 1) * dotSpacing,
          ),
    ];

    for (final baseOffset in cornerOffsets) {
      for (int row = 0; row < dotsPerCorner; row++) {
        for (int col = 0; col < dotsPerCorner; col++) {
          final dotCenter = Offset(
            baseOffset.dx + col * dotSpacing,
            baseOffset.dy + row * dotSpacing,
          );
          canvas.drawCircle(dotCenter, dotRadius, activeDotPaint);
        }
      }
    }
  }

  /// Helper to draw thick corner L-brackets.
  void _drawCornerBrackets(
    Canvas canvas,
    Rect rect,
    Color color, {
    double cornerLength = 24.0,
    double strokeWidth = 3.5,
  }) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Top-Left
    canvas.drawLine(
      rect.topLeft,
      rect.topLeft + Offset(cornerLength, 0),
      paint,
    );
    canvas.drawLine(
      rect.topLeft,
      rect.topLeft + Offset(0, cornerLength),
      paint,
    );

    // Top-Right
    canvas.drawLine(
      rect.topRight,
      rect.topRight + Offset(-cornerLength, 0),
      paint,
    );
    canvas.drawLine(
      rect.topRight,
      rect.topRight + Offset(0, cornerLength),
      paint,
    );

    // Bottom-Left
    canvas.drawLine(
      rect.bottomLeft,
      rect.bottomLeft + Offset(cornerLength, 0),
      paint,
    );
    canvas.drawLine(
      rect.bottomLeft,
      rect.bottomLeft + Offset(0, -cornerLength),
      paint,
    );

    // Bottom-Right
    canvas.drawLine(
      rect.bottomRight,
      rect.bottomRight + Offset(-cornerLength, 0),
      paint,
    );
    canvas.drawLine(
      rect.bottomRight,
      rect.bottomRight + Offset(0, -cornerLength),
      paint,
    );
  }

  /// Dynamic auto-resizing bounding box reticle drawn over detected code
  void _drawDetectedFocusBox(Canvas canvas, Rect frameRect) {
    final box = detectedBoundingBox ?? _rectFromCorners(detectedCorners!);
    if (box == null) return;

    final pulseAlpha = 0.6 + 0.4 * math.sin(progress * math.pi * 2);
    final focusPaint = Paint()
      ..color = Colors.greenAccent.withValues(alpha: pulseAlpha)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    final fillPaint = Paint()
      ..color = Colors.greenAccent.withValues(alpha: 0.15 * pulseAlpha)
      ..style = PaintingStyle.fill;

    final rrect = RRect.fromRectAndRadius(box, const Radius.circular(8));
    canvas.drawRRect(rrect, fillPaint);
    canvas.drawRRect(rrect, focusPaint);

    _drawCornerBrackets(
      canvas,
      box,
      Colors.greenAccent,
      cornerLength: 14.0,
      strokeWidth: 3.0,
    );
  }

  Rect? _rectFromCorners(List<Offset> corners) {
    if (corners.isEmpty) return null;
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

  /// Reticle bloom & glowing corner brackets during scan confirmation.
  void _drawSuccessReticlePulse(Canvas canvas, Rect rect) {
    final glowAlpha = (0.5 * (1.0 - (successProgress - 0.5).abs() * 0.8)).clamp(
      0.15,
      0.65,
    );
    final glowPaint = Paint()
      ..color = const Color(0xFF00E676).withValues(alpha: glowAlpha)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8.0);

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(12)),
      glowPaint,
    );

    _drawCornerBrackets(
      canvas,
      rect,
      const Color(0xFF00E676),
      cornerLength: 28.0,
      strokeWidth: 4.0,
    );
  }

  /// Center badge with animated checkmark path morph and shockwave ripple.
  void _drawCheckmarkMorph(Canvas canvas, Offset center, double progress) {
    if (progress <= 0.0) return;

    // 1. Expanding shockwave ripple
    if (progress > 0.05 && progress < 0.95) {
      final rippleProgress = Curves.easeOut.transform(
        ((progress - 0.05) / 0.90).clamp(0.0, 1.0),
      );
      final rippleRadius = 24.0 + (rippleProgress * 55.0);
      final rippleAlpha = ((1.0 - rippleProgress) * 0.75).clamp(0.0, 1.0);
      final ripplePaint = Paint()
        ..color = const Color(0xFF00E676).withValues(alpha: rippleAlpha)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5;
      canvas.drawCircle(center, rippleRadius, ripplePaint);
    }

    // 2. Center Success Disc Badge
    final badgeProgress = (progress / 0.5).clamp(0.0, 1.0);
    final badgeScale = Curves.easeOutBack.transform(badgeProgress);
    if (badgeScale <= 0.01) return;

    const discRadius = 32.0;

    // Outer glow for the badge
    final badgeGlowPaint = Paint()
      ..color = const Color(0xFF00E676).withValues(alpha: 0.45 * badgeScale)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10.0);
    canvas.drawCircle(center, discRadius * badgeScale, badgeGlowPaint);

    // Gradient filled badge circle
    final badgePaint = Paint()
      ..shader =
          const RadialGradient(
            colors: [Color(0xFF00E676), Color(0xFF00B0FF)],
          ).createShader(
            Rect.fromCircle(center: center, radius: discRadius * badgeScale),
          )
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, discRadius * badgeScale, badgePaint);

    // Subtle white border on the badge
    final badgeBorderPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.85)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;
    canvas.drawCircle(center, discRadius * badgeScale, badgeBorderPaint);

    // 3. Checkmark Stroke Morph (Draw along path from progress 0.20 to 0.85)
    if (progress > 0.20) {
      final checkProgress = Curves.easeOutCubic.transform(
        ((progress - 0.20) / 0.65).clamp(0.0, 1.0),
      );

      final p1 = center + const Offset(-11, 1);
      final p2 = center + const Offset(-3, 9);
      final p3 = center + const Offset(12, -7);

      final d1 = (p2 - p1).distance;
      final d2 = (p3 - p2).distance;
      final totalDist = d1 + d2;
      final currentDist = totalDist * checkProgress;

      final checkPath = Path();
      checkPath.moveTo(p1.dx, p1.dy);

      if (currentDist <= d1) {
        final t = currentDist / d1;
        final currentPoint = Offset.lerp(p1, p2, t)!;
        checkPath.lineTo(currentPoint.dx, currentPoint.dy);
      } else {
        checkPath.lineTo(p2.dx, p2.dy);
        final t = (currentDist - d1) / d2;
        final currentPoint = Offset.lerp(p2, p3, t)!;
        checkPath.lineTo(currentPoint.dx, currentPoint.dy);
      }

      // Checkmark subtle shadow for high contrast
      final checkShadowPaint = Paint()
        ..color = Colors.black26
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.2
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;
      canvas.drawPath(checkPath.shift(const Offset(0, 1.5)), checkShadowPaint);

      final checkPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.2
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;
      canvas.drawPath(checkPath, checkPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _ScanOverlayPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.style != style ||
        oldDelegate.colorScheme != colorScheme ||
        oldDelegate.detectedBoundingBox != detectedBoundingBox ||
        oldDelegate.detectedCorners != detectedCorners ||
        oldDelegate.isSuccess != isSuccess ||
        oldDelegate.successProgress != successProgress;
  }
}
