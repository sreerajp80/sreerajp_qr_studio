/// Service calculating Skia 4x5 color matrices for real-time camera preview tuning.
class ColorMatrixService {
  const ColorMatrixService();

  /// Computes a 20-element list representing a 4x5 RGBA transformation matrix.
  ///
  /// - [brightness]: Normal range [-1.0, 1.0], where 0.0 is neutral.
  /// - [contrast]: Normal range [0.5, 2.5], where 1.0 is neutral.
  /// - [invert]: When true, produces an inverted (negative) color profile.
  List<double> calculateMatrix({
    double brightness = 0.0,
    double contrast = 1.0,
    bool invert = false,
  }) {
    final clampedBrightness = brightness.clamp(-1.0, 1.0);
    final clampedContrast = contrast.clamp(0.1, 4.0);

    // Standard contrast formula around midpoint 128.0
    // f(x) = contrast * (x - 128) + 128 = contrast * x + 128 * (1 - contrast)
    final contrastOffset = 128.0 * (1.0 - clampedContrast);
    final brightnessOffset = clampedBrightness * 255.0;
    final totalOffset = contrastOffset + brightnessOffset;

    if (invert) {
      final invScale = -clampedContrast;
      final invOffset = 255.0 - totalOffset;

      return <double>[
        invScale,
        0.0,
        0.0,
        0.0,
        invOffset,
        0.0,
        invScale,
        0.0,
        0.0,
        invOffset,
        0.0,
        0.0,
        invScale,
        0.0,
        invOffset,
        0.0,
        0.0,
        0.0,
        1.0,
        0.0,
      ];
    }

    return <double>[
      clampedContrast,
      0.0,
      0.0,
      0.0,
      totalOffset,
      0.0,
      clampedContrast,
      0.0,
      0.0,
      totalOffset,
      0.0,
      0.0,
      clampedContrast,
      0.0,
      totalOffset,
      0.0,
      0.0,
      0.0,
      1.0,
      0.0,
    ];
  }
}
