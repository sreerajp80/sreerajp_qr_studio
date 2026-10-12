import 'package:flutter/material.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/models/visible_barcode.dart';
import 'package:sreerajp_qr_studio/models/code_format.dart';

/// Interactive bounding box overlay widget for a single visible barcode in the camera view.
/// Displays subtle corner reticles, a floating format chip, and handles tap selection.
class MultiCodeBoundingBoxWidget extends StatelessWidget {
  final VisibleBarcode barcode;
  final bool isSelected;
  final VoidCallback onTap;

  const MultiCodeBoundingBoxWidget({
    super.key,
    required this.barcode,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final rect = barcode.screenRect;

    final primaryColor = isSelected
        ? const Color(0xFF00E676) // Bright green on selection
        : theme.colorScheme.primary;

    return Positioned(
      left: rect.left,
      top: rect.top,
      width: rect.width,
      height: rect.height,
      child: Material(
        color: Colors.transparent,
        child: Tooltip(
          message: l10n.multiCodeTapToScan,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(10),
            splashColor: primaryColor.withValues(alpha: 0.3),
            highlightColor: primaryColor.withValues(alpha: 0.15),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              decoration: BoxDecoration(
                color: isSelected
                    ? primaryColor.withValues(alpha: 0.22)
                    : primaryColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isSelected
                      ? primaryColor
                      : primaryColor.withValues(alpha: 0.7),
                  width: isSelected ? 2.5 : 1.6,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isSelected
                        ? primaryColor.withValues(alpha: 0.5)
                        : Colors.black38,
                    blurRadius: isSelected ? 12 : 6,
                    spreadRadius: isSelected ? 2 : 0,
                  ),
                ],
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Corner L-brackets
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _CornerBracketsPainter(
                        color: primaryColor,
                        cornerLength: 12.0,
                        strokeWidth: 2.8,
                      ),
                    ),
                  ),

                  // Floating interactive badge pill
                  Positioned(
                    bottom: -16,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.88),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: primaryColor.withValues(alpha: 0.8),
                            width: 1.2,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _getBarcodeIcon(barcode.format),
                              size: 13,
                              color: primaryColor,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              barcode.displayLabel,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.touch_app,
                              size: 12,
                              color: primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Selected Checkmark Badge
                  if (isSelected)
                    const Center(
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Color(0xFF00E676),
                        child: Icon(Icons.check, size: 18, color: Colors.black),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getBarcodeIcon(CodeFormat format) {
    switch (format) {
      case CodeFormat.qrCode:
        return Icons.qr_code_2;
      case CodeFormat.dataMatrix:
        return Icons.grid_4x4;
      case CodeFormat.aztec:
        return Icons.blur_on;
      case CodeFormat.pdf417:
        return Icons.view_column;
      default:
        return Icons.view_week;
    }
  }
}

class _CornerBracketsPainter extends CustomPainter {
  final Color color;
  final double cornerLength;
  final double strokeWidth;

  _CornerBracketsPainter({
    required this.color,
    required this.cornerLength,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

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

  @override
  bool shouldRepaint(covariant _CornerBracketsPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.cornerLength != cornerLength ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
