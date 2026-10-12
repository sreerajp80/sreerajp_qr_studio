import 'package:flutter/widgets.dart';

/// Available camera flashlight / torch operational modes.
enum CameraFlashMode {
  /// Flashlight remains disabled.
  off,

  /// Flashlight remains forced on.
  on,

  /// Flashlight automatically toggles based on ambient light conditions.
  auto,
}

/// Supported camera capture resolution presets.
enum CameraResolutionPreset {
  /// High Definition: 1280x720, battery friendly.
  hd(Size(1280, 720)),

  /// Full High Definition: 1920x1080 (Recommended default for sharp barcode decoding).
  fullHd(Size(1920, 1080)),

  /// Ultra High Definition: 3840x2160, maximum available sensor resolution.
  max(Size(3840, 2160));

  final Size size;

  const CameraResolutionPreset(this.size);
}
