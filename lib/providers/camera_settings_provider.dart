import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sreerajp_qr_studio/models/camera_settings.dart';
import 'package:sreerajp_qr_studio/models/distance_enhanced_scan_result.dart';
import 'package:sreerajp_qr_studio/services/color_matrix_service.dart';
import 'package:sreerajp_qr_studio/services/light_sensor_service.dart';

/// Provider managing camera settings, image adjustments, flash modes, and resolution.
class CameraSettingsProvider extends ChangeNotifier {
  static const String _prefFlashModeKey = 'camera_flash_mode';
  static const String _prefResolutionPresetKey = 'camera_resolution_preset';
  static const String _prefDistanceEnhanceModeKey =
      'camera_distance_enhance_mode';
  static const String _prefDistanceZoomKey = 'camera_distance_zoom';
  static const String _prefUnsharpStrengthKey = 'camera_unsharp_strength';
  static const String _prefMultiCodeSelectionKey =
      'camera_multi_code_selection';

  /// Saved preview image adjustments. Public so device sync can copy them.
  static const String prefBrightnessKey = 'camera_brightness';
  static const String prefContrastKey = 'camera_contrast';
  static const String prefInvertColorsKey = 'camera_invert_colors';

  static const double _minBrightness = -1.0;
  static const double _maxBrightness = 1.0;
  static const double _minContrast = 0.5;
  static const double _maxContrast = 2.5;

  final LightSensorService _lightSensorService;
  final ColorMatrixService _colorMatrixService;

  CameraFlashMode _flashMode = CameraFlashMode.off;
  CameraResolutionPreset _resolutionPreset = CameraResolutionPreset.fullHd;
  double _brightness = 0.0;
  double _contrast = 1.0;
  bool _invertColors = false;

  bool _isDistanceEnhanceMode = false;
  double _distanceZoomFactor = 2.5;
  double _unsharpMaskStrength = 1.5;
  bool _multiCodeSelectionEnabled = true;

  double? _currentLux;
  bool _isLightSensorAvailable = true;
  bool _autoTorchActive = false;
  StreamSubscription<double>? _lightSubscription;

  Offset? _focusPoint;
  DateTime? _focusPointTimestamp;

  CameraSettingsProvider({
    LightSensorService? lightSensorService,
    ColorMatrixService? colorMatrixService,
  }) : _lightSensorService = lightSensorService ?? LightSensorService(),
       _colorMatrixService = colorMatrixService ?? const ColorMatrixService() {
    _loadPreferences();
    _startLightSensorMonitoring();
  }

  CameraFlashMode get flashMode => _flashMode;
  CameraResolutionPreset get resolutionPreset => _resolutionPreset;
  double get brightness => _brightness;
  double get contrast => _contrast;
  bool get invertColors => _invertColors;
  double? get currentLux => _currentLux;
  bool get isLightSensorAvailable => _isLightSensorAvailable;
  bool get autoTorchActive => _autoTorchActive;
  Offset? get focusPoint => _focusPoint;
  DateTime? get focusPointTimestamp => _focusPointTimestamp;

  bool get isDistanceEnhanceMode => _isDistanceEnhanceMode;
  double get distanceZoomFactor => _distanceZoomFactor;
  double get unsharpMaskStrength => _unsharpMaskStrength;
  bool get multiCodeSelectionEnabled => _multiCodeSelectionEnabled;

  /// Distance pipeline settings built from the saved zoom and sharpness.
  DistanceScanConfig get distanceScanConfig => DistanceScanConfig(
    zoomFactor: _distanceZoomFactor,
    unsharpAmount: _unsharpMaskStrength,
  );

  /// Whether the camera flash should physically be illuminated right now.
  bool get shouldTorchBeOn {
    switch (_flashMode) {
      case CameraFlashMode.off:
        return false;
      case CameraFlashMode.on:
        return true;
      case CameraFlashMode.auto:
        return _autoTorchActive;
    }
  }

  /// Target camera resolution dimensions for the active preset.
  Size get targetResolution => _resolutionPreset.size;

  /// Current 4x5 color matrix for Skia ColorFiltered preview tuning.
  List<double> get colorMatrix => _colorMatrixService.calculateMatrix(
    brightness: _brightness,
    contrast: _contrast,
    invert: _invertColors,
  );

  Future<void> _loadPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final savedFlash = prefs.getString(_prefFlashModeKey);
      if (savedFlash != null) {
        _flashMode = CameraFlashMode.values.firstWhere(
          (e) => e.name == savedFlash,
          orElse: () => CameraFlashMode.off,
        );
      }

      final savedRes = prefs.getString(_prefResolutionPresetKey);
      if (savedRes != null) {
        _resolutionPreset = CameraResolutionPreset.values.firstWhere(
          (e) => e.name == savedRes,
          orElse: () => CameraResolutionPreset.fullHd,
        );
      }

      _isDistanceEnhanceMode =
          prefs.getBool(_prefDistanceEnhanceModeKey) ?? false;
      _distanceZoomFactor = prefs.getDouble(_prefDistanceZoomKey) ?? 2.5;
      _unsharpMaskStrength = prefs.getDouble(_prefUnsharpStrengthKey) ?? 1.5;
      _multiCodeSelectionEnabled =
          prefs.getBool(_prefMultiCodeSelectionKey) ?? true;

      // Clamp saved values so a bad stored number cannot break the preview.
      _brightness = (_readDouble(prefs, prefBrightnessKey) ?? 0.0)
          .clamp(_minBrightness, _maxBrightness)
          .toDouble();
      _contrast = (_readDouble(prefs, prefContrastKey) ?? 1.0)
          .clamp(_minContrast, _maxContrast)
          .toDouble();
      final savedInvert = prefs.get(prefInvertColorsKey);
      _invertColors = savedInvert is bool ? savedInvert : false;
    } catch (e) {
      if (kDebugMode) debugPrint('Error loading camera settings: $e');
    } finally {
      notifyListeners();
    }
  }

  void _startLightSensorMonitoring() {
    try {
      _lightSubscription = _lightSensorService.luxStream.listen(
        (lux) {
          _currentLux = lux;
          _isLightSensorAvailable = true;

          // Auto-flash logic with hysteresis:
          // Low light: lux < 12.0 -> turn torch ON
          // Normal/bright light: lux > 28.0 -> turn torch OFF
          if (_flashMode == CameraFlashMode.auto) {
            if (!_autoTorchActive && lux < 12.0) {
              _autoTorchActive = true;
              notifyListeners();
            } else if (_autoTorchActive && lux > 28.0) {
              _autoTorchActive = false;
              notifyListeners();
            }
          }
        },
        onError: (err) {
          _isLightSensorAvailable = false;
          _currentLux = null;
          notifyListeners();
        },
      );
    } catch (_) {
      _isLightSensorAvailable = false;
    }
  }

  /// Sets the operational flash mode (Off, On, or Auto).
  Future<void> setFlashMode(CameraFlashMode mode) async {
    if (_flashMode == mode) return;
    _flashMode = mode;
    if (mode != CameraFlashMode.auto) {
      _autoTorchActive = false;
    } else if (_currentLux != null && _currentLux! < 12.0) {
      _autoTorchActive = true;
    }
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefFlashModeKey, mode.name);
    } catch (_) {}
  }

  /// Cycles through flash modes: Off -> On -> Auto -> Off.
  Future<void> cycleFlashMode() async {
    final next = switch (_flashMode) {
      CameraFlashMode.off => CameraFlashMode.on,
      CameraFlashMode.on => CameraFlashMode.auto,
      CameraFlashMode.auto => CameraFlashMode.off,
    };
    await setFlashMode(next);
  }

  /// Sets live brightness adjustment [-1.0, 1.0].
  void setBrightness(double value) {
    final clamped = value.clamp(_minBrightness, _maxBrightness);
    if ((_brightness - clamped).abs() < 0.001) return;
    _brightness = clamped;
    notifyListeners();
  }

  /// Sets live contrast adjustment [0.5, 2.5].
  void setContrast(double value) {
    final clamped = value.clamp(_minContrast, _maxContrast);
    if ((_contrast - clamped).abs() < 0.001) return;
    _contrast = clamped;
    notifyListeners();
  }

  /// Toggles negative / inverted color mode.
  void setInvertColors(bool value) {
    if (_invertColors == value) return;
    _invertColors = value;
    notifyListeners();
    _saveBool(prefInvertColorsKey, value);
  }

  /// Saves the current brightness and contrast. The adjustment sliders call
  /// this once when the user lets go, not on every small move.
  Future<void> saveImageAdjustments() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(prefBrightnessKey, _brightness);
      await prefs.setDouble(prefContrastKey, _contrast);
    } catch (e) {
      if (kDebugMode) debugPrint('Error saving image adjustments: $e');
    }
  }

  Future<void> _saveBool(String key, bool value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(key, value);
    } catch (e) {
      if (kDebugMode) debugPrint('Error saving camera setting: $e');
    }
  }

  /// Reads a saved number as a double. Accepts an int too (for example a
  /// value copied in by device sync), and returns null for anything else.
  static double? _readDouble(SharedPreferences prefs, String key) {
    final value = prefs.get(key);
    return value is num ? value.toDouble() : null;
  }

  /// Sets the desired camera capture resolution preset.
  Future<void> setResolutionPreset(CameraResolutionPreset preset) async {
    if (_resolutionPreset == preset) return;
    _resolutionPreset = preset;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefResolutionPresetKey, preset.name);
    } catch (_) {}
  }

  /// Toggles distance-enhanced scanning pipeline.
  Future<void> toggleDistanceEnhanceMode() async {
    await setDistanceEnhanceMode(!_isDistanceEnhanceMode);
  }

  /// Sets whether distance-enhanced scanning pipeline is enabled.
  Future<void> setDistanceEnhanceMode(bool enabled) async {
    if (_isDistanceEnhanceMode == enabled) return;
    _isDistanceEnhanceMode = enabled;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_prefDistanceEnhanceModeKey, enabled);
    } catch (_) {}
  }

  /// Sets digital zoom factor applied to candidate distant ROIs (1.5 to 4.0).
  Future<void> setDistanceZoomFactor(double factor) async {
    final clamped = factor.clamp(1.5, 4.0);
    if ((_distanceZoomFactor - clamped).abs() < 0.01) return;
    _distanceZoomFactor = clamped;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(_prefDistanceZoomKey, clamped);
    } catch (_) {}
  }

  /// Sets unsharp masking sharpening strength (0.5 to 2.5).
  Future<void> setUnsharpMaskStrength(double strength) async {
    final clamped = strength.clamp(0.5, 2.5);
    if ((_unsharpMaskStrength - clamped).abs() < 0.01) return;
    _unsharpMaskStrength = clamped;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(_prefUnsharpStrengthKey, clamped);
    } catch (_) {}
  }

  /// Sets whether multi-code tappable selection is enabled on the main scanner.
  Future<void> setMultiCodeSelectionEnabled(bool enabled) async {
    if (_multiCodeSelectionEnabled == enabled) return;
    _multiCodeSelectionEnabled = enabled;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_prefMultiCodeSelectionKey, enabled);
    } catch (_) {}
  }

  /// Resets brightness, contrast, inverted colors, distance zoom, edge
  /// sharpness, and multi-code selection to factory defaults. The Distance
  /// Scan Assist switch is left as it is. Saved values are reset too.
  Future<void> resetAdjustments() async {
    _brightness = 0.0;
    _contrast = 1.0;
    _invertColors = false;
    _distanceZoomFactor = 2.5;
    _unsharpMaskStrength = 1.5;
    _multiCodeSelectionEnabled = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(_prefDistanceZoomKey, _distanceZoomFactor);
      await prefs.setDouble(_prefUnsharpStrengthKey, _unsharpMaskStrength);
      await prefs.setBool(
        _prefMultiCodeSelectionKey,
        _multiCodeSelectionEnabled,
      );
      await prefs.remove(prefBrightnessKey);
      await prefs.remove(prefContrastKey);
      await prefs.remove(prefInvertColorsKey);
    } catch (_) {}
  }

  /// Records tap-to-focus point and timestamp for animation.
  void setFocusPoint(Offset point) {
    _focusPoint = point;
    _focusPointTimestamp = DateTime.now();
    notifyListeners();
  }

  /// Clears active focus point.
  void clearFocusPoint() {
    _focusPoint = null;
    _focusPointTimestamp = null;
    notifyListeners();
  }

  bool _isDisposed = false;

  @override
  void notifyListeners() {
    if (!_isDisposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _lightSubscription?.cancel();
    super.dispose();
  }
}
