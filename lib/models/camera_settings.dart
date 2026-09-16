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

/// Immutable state model encapsulating user camera settings and tuning parameters.
class CameraSettings {
  final CameraFlashMode flashMode;
  final CameraResolutionPreset resolutionPreset;
  final double brightness;
  final double contrast;
  final bool invertColors;

  const CameraSettings({
    this.flashMode = CameraFlashMode.off,
    this.resolutionPreset = CameraResolutionPreset.fullHd,
    this.brightness = 0.0,
    this.contrast = 1.0,
    this.invertColors = false,
  });

  CameraSettings copyWith({
    CameraFlashMode? flashMode,
    CameraResolutionPreset? resolutionPreset,
    double? brightness,
    double? contrast,
    bool? invertColors,
  }) {
    return CameraSettings(
      flashMode: flashMode ?? this.flashMode,
      resolutionPreset: resolutionPreset ?? this.resolutionPreset,
      brightness: brightness ?? this.brightness,
      contrast: contrast ?? this.contrast,
      invertColors: invertColors ?? this.invertColors,
    );
  }
}
