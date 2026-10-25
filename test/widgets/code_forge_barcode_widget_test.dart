import 'dart:ui' as ui;

import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sreerajp_qr_studio/models/code_forge_config.dart';
import 'package:sreerajp_qr_studio/services/code_forge_service.dart';
import 'package:sreerajp_qr_studio/widgets/code_forge_barcode_widget.dart';

/// Counts filled rectangles, so a test can see that bars were drawn.
class _CountingCanvas extends Fake implements Canvas {
  int rects = 0;
  int texts = 0;

  @override
  void drawRect(Rect rect, Paint paint) => rects++;

  @override
  void drawParagraph(ui.Paragraph paragraph, Offset offset) => texts++;

  @override
  void save() {}

  @override
  void restore() {}

  @override
  void translate(double dx, double dy) {}

  @override
  void clipRect(
    Rect rect, {
    ui.ClipOp clipOp = ui.ClipOp.intersect,
    bool doAntiAlias = true,
  }) {}
}

/// Valid sample data for every barcode type CodeForge can make.
const Map<CodeForgeBarcodeType, String> _samples = {
  CodeForgeBarcodeType.qrCode: 'https://example.com',
  CodeForgeBarcodeType.code128: 'ABC-12345',
  CodeForgeBarcodeType.ean13: '400638133393',
  CodeForgeBarcodeType.ean8: '9638507',
  CodeForgeBarcodeType.upcA: '03600029145',
  CodeForgeBarcodeType.code39: 'CODE39',
  CodeForgeBarcodeType.pdf417: 'Hello PDF417',
  CodeForgeBarcodeType.dataMatrix: 'Hello Matrix',
};

/// Types that print the data as text under the bars.
const Set<CodeForgeBarcodeType> _oneDimensional = {
  CodeForgeBarcodeType.code128,
  CodeForgeBarcodeType.ean13,
  CodeForgeBarcodeType.ean8,
  CodeForgeBarcodeType.upcA,
  CodeForgeBarcodeType.code39,
};

void main() {
  final service = CodeForgeService();

  test('every barcode type has a sample', () {
    expect(_samples.keys.toSet(), CodeForgeBarcodeType.values.toSet());
  });

  for (final entry in _samples.entries) {
    for (final withLabel in [true, false]) {
      test('paints ${entry.key.name} bars (text label: $withLabel)', () {
        final canvas = _CountingCanvas();
        CodeForgeBarcodePainter(
          config: CodeForgeConfig(
            barcodeType: entry.key,
            includeTextLabel: withLabel,
          ),
          barcode: service.getBarcodeInstance(entry.key),
          data: entry.value,
        ).paint(canvas, const Size(360, 200));

        // One rectangle is the background; the rest are bars or modules.
        expect(canvas.rects, greaterThan(1));
        if (withLabel && _oneDimensional.contains(entry.key)) {
          // The human-readable digits are drawn under the bars.
          expect(canvas.texts, greaterThan(0));
        }
        if (!withLabel) expect(canvas.texts, 0);
      });
    }
  }

  test('bad data paints only the background and does not throw', () {
    final canvas = _CountingCanvas();
    CodeForgeBarcodePainter(
      config: const CodeForgeConfig(barcodeType: CodeForgeBarcodeType.ean13),
      barcode: service.getBarcodeInstance(CodeForgeBarcodeType.ean13),
      data: 'not digits',
    ).paint(canvas, const Size(360, 200));

    expect(canvas.rects, 1);
  });

  test('shouldRepaint only when the input changes', () {
    const config = CodeForgeConfig(barcodeType: CodeForgeBarcodeType.code128);
    final barcode = service.getBarcodeInstance(CodeForgeBarcodeType.code128);
    final painter = CodeForgeBarcodePainter(
      config: config,
      barcode: barcode,
      data: 'A',
    );

    expect(
      painter.shouldRepaint(
        CodeForgeBarcodePainter(config: config, barcode: barcode, data: 'A'),
      ),
      isFalse,
    );
    expect(
      painter.shouldRepaint(
        CodeForgeBarcodePainter(config: config, barcode: barcode, data: 'B'),
      ),
      isTrue,
    );
  });
}
