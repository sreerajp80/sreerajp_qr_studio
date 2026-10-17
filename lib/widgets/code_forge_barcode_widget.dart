import 'package:barcode/barcode.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sreerajp_qr_studio/models/code_forge_config.dart';

/// Canvas painter for rendering 1D and 2D barcodes (Code 128, EAN-13, UPC-A, etc.)
class CodeForgeBarcodePainter extends CustomPainter {
  final CodeForgeConfig config;
  final Barcode barcode;
  final String data;

  CodeForgeBarcodePainter({
    required this.config,
    required this.barcode,
    required this.data,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Draw Background
    final bgPaint = Paint()..color = config.backgroundColor;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final fgPaint = Paint()
      ..color = config.foregroundColor
      ..style = PaintingStyle.fill;

    try {
      final elements = barcode.make(
        data,
        width: size.width,
        height: size.height,
        drawText: config.includeTextLabel,
      );

      for (final element in elements) {
        if (element is BarcodeBar) {
          if (element.black) {
            canvas.drawRect(
              Rect.fromLTWH(
                element.left,
                element.top,
                element.width,
                element.height,
              ),
              fgPaint,
            );
          }
        } else if (element is BarcodeText) {
          final textPainter = TextPainter(
            text: TextSpan(
              text: element.text,
              style: TextStyle(
                color: config.foregroundColor,
                fontSize: element.height * 0.9,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
              ),
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
          );
          textPainter.layout(minWidth: element.width, maxWidth: element.width);
          textPainter.paint(canvas, Offset(element.left, element.top));
        }
      }
    } catch (_) {
      // Fallback message if parameters cannot fit the canvas
    }
  }

  @override
  bool shouldRepaint(covariant CodeForgeBarcodePainter oldDelegate) {
    return oldDelegate.config != config ||
        oldDelegate.barcode != barcode ||
        oldDelegate.data != data;
  }
}
