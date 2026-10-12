import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/services/color_matrix_service.dart';

void main() {
  group('ColorMatrixService Tests', () {
    const service = ColorMatrixService();

    test('Default values return identity matrix', () {
      final matrix = service.calculateMatrix();
      expect(matrix.length, equals(20));

      // Diagonal elements should be 1.0
      expect(matrix[0], equals(1.0)); // R
      expect(matrix[6], equals(1.0)); // G
      expect(matrix[12], equals(1.0)); // B
      expect(matrix[18], equals(1.0)); // A

      // Offsets should be 0.0
      expect(matrix[4], equals(0.0));
      expect(matrix[9], equals(0.0));
      expect(matrix[14], equals(0.0));
      expect(matrix[19], equals(0.0));
    });

    test('Positive brightness shifts offset positively', () {
      final matrix = service.calculateMatrix(brightness: 0.5);
      // Brightness offset = 0.5 * 255 = 127.5
      expect(matrix[4], closeTo(127.5, 0.01));
      expect(matrix[9], closeTo(127.5, 0.01));
      expect(matrix[14], closeTo(127.5, 0.01));
    });

    test('Contrast scaling adjusts diagonals and midpoint offset', () {
      final matrix = service.calculateMatrix(contrast: 2.0);
      // Diagonals should be 2.0
      expect(matrix[0], equals(2.0));
      expect(matrix[6], equals(2.0));
      expect(matrix[12], equals(2.0));

      // Offset = 128 * (1 - 2) = -128.0
      expect(matrix[4], equals(-128.0));
      expect(matrix[9], equals(-128.0));
      expect(matrix[14], equals(-128.0));
    });

    test('Inverted colors mode inverts scale and offsets from 255', () {
      final matrix = service.calculateMatrix(invert: true);
      // Diagonals should be -1.0
      expect(matrix[0], equals(-1.0));
      expect(matrix[6], equals(-1.0));
      expect(matrix[12], equals(-1.0));

      // Offset should be 255.0
      expect(matrix[4], equals(255.0));
      expect(matrix[9], equals(255.0));
      expect(matrix[14], equals(255.0));
    });

    test('Extreme brightness and contrast values are clamped safely', () {
      final matrix = service.calculateMatrix(
        brightness: 999.0,
        contrast: 999.0,
      );
      expect(matrix[0], equals(4.0)); // contrast clamped to 4.0
    });
  });
}
