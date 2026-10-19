import 'dart:async';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:sreerajp_qr_studio/core/logging/app_logger.dart';
import 'package:sreerajp_qr_studio/models/code_format.dart';
import 'package:sreerajp_qr_studio/models/decode_profile.dart';
import 'package:sreerajp_qr_studio/models/distance_enhanced_scan_result.dart';
import 'package:sreerajp_qr_studio/models/scan_frame_result.dart';
import 'package:sreerajp_qr_studio/models/scanned_code.dart';
import 'package:sreerajp_qr_studio/services/barcode_decoder/barcode_decoder_service.dart';
import 'package:sreerajp_qr_studio/services/barcode_decoder/barcode_ffi_bindings.dart';
import 'package:sreerajp_qr_studio/services/distance_enhancement_service.dart';

/// Torch (flashlight) state of the scanning camera.
enum TorchState { off, on, unavailable }

/// Why the scanning camera could not start.
enum ScanCameraError { permissionDenied, noCamera, failed }

/// Observable state of a [ScanCameraController].
@immutable
class ScanCameraState {
  /// True once the camera has started successfully at least once.
  final bool isInitialized;

  /// True while the camera is open and frames are being decoded.
  final bool isRunning;
  final TorchState torchState;
  final CameraLensDirection lensDirection;

  /// Current zoom as a 0–1 fraction between the minimum and maximum zoom.
  final double zoomScale;
  final ScanCameraError? error;

  const ScanCameraState({
    this.isInitialized = false,
    this.isRunning = false,
    this.torchState = TorchState.off,
    this.lensDirection = CameraLensDirection.back,
    this.zoomScale = 0.0,
    this.error,
  });

  ScanCameraState copyWith({
    bool? isInitialized,
    bool? isRunning,
    TorchState? torchState,
    CameraLensDirection? lensDirection,
    double? zoomScale,
    ScanCameraError? error,
    bool clearError = false,
  }) {
    return ScanCameraState(
      isInitialized: isInitialized ?? this.isInitialized,
      isRunning: isRunning ?? this.isRunning,
      torchState: torchState ?? this.torchState,
      lensDirection: lensDirection ?? this.lensDirection,
      zoomScale: zoomScale ?? this.zoomScale,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

/// Runs the camera and feeds its frames to the app's own barcode decoder.
///
/// Only the luminance (Y) plane of each YUV frame is used, so no colour
/// conversion or copy is needed. While one frame is being decoded, newer
/// frames are dropped, so the decoder always works on a recent frame and
/// never builds a queue. With the live profile, most frames get a quick pass
/// and every few frames a full pass (see [profileForFrame]).
///
/// When [distanceAssist] is set and a frame has no code, an enlarged and
/// sharpened centre crop of that frame is also tried, at most once per
/// [distanceAssistInterval], in the background.
class ScanCameraController extends ValueNotifier<ScanCameraState> {
  /// Requested frame size (landscape). Null keeps the 720p default.
  final Size? cameraResolution;

  /// Also look for light-on-dark (inverted) codes.
  final bool invertImage;
  final List<CodeFormat> formats;
  final DecodeProfile profile;
  final int maxSymbols;
  final BarcodeDecoder _decoder;
  final DistanceEnhancementService _distanceService;

  /// Distance Scan Assist settings. Null turns the assist off. Can be
  /// changed while the camera runs.
  DistanceScanConfig? distanceAssist;

  /// Shortest gap between two frame decodes. [Duration.zero] decodes every
  /// frame (AirQR needs this to catch fast-changing frames).
  final Duration minFrameGap;

  /// Gap between decodes after [idleAfter] with no code and no user action.
  final Duration idleFrameGap;

  /// Time with no code and no user action before [idleFrameGap] is used.
  final Duration idleAfter;

  DateTime? _lastDecodeStart;
  DateTime _lastActivity = DateTime.now();

  /// Shortest gap between two distance assist tries.
  static const Duration distanceAssistInterval = Duration(milliseconds: 600);

  /// With the [DecodeProfile.live] profile, every this-many-th frame gets the
  /// full live pass; the frames in between get a quick pass.
  static const int heavyFrameInterval = 3;

  /// The profile to use for frame number [frameIndex] (0-based).
  ///
  /// A [DecodeProfile.live] controller decodes most frames with the quick
  /// [DecodeProfile.fast] pass, which reads clean codes much sooner, and
  /// every [heavyFrameInterval]-th frame with the full live pass, so small,
  /// damaged or turned codes are still found. Other profiles are used as is.
  static DecodeProfile profileForFrame(int frameIndex, DecodeProfile base) {
    if (base != DecodeProfile.live) return base;
    return frameIndex % heavyFrameInterval == heavyFrameInterval - 1
        ? DecodeProfile.live
        : DecodeProfile.fast;
  }

  /// Default shortest gap between two frame decodes (about 15 a second).
  /// Fast enough to feel instant, but keeps the CPU from running flat out.
  static const Duration defaultMinFrameGap = Duration(milliseconds: 66);

  /// Default gap once no code has been seen for [defaultIdleAfter]
  /// (about 5 decodes a second), to save battery while nothing is in view.
  static const Duration defaultIdleFrameGap = Duration(milliseconds: 200);

  /// Default time with no code and no user action before the slower
  /// [defaultIdleFrameGap] is used.
  static const Duration defaultIdleAfter = Duration(seconds: 8);

  /// The gap to wait between decodes, given how long it has been since the
  /// last code was found or the user last touched the camera.
  static Duration frameGapFor({
    required Duration sinceActivity,
    required Duration minGap,
    required Duration idleGap,
    required Duration idleAfter,
  }) {
    return sinceActivity >= idleAfter ? idleGap : minGap;
  }

  /// Frames per debug timing log line.
  static const int _timingLogFrames = 30;

  ScanCameraController({
    this.cameraResolution,
    this.invertImage = false,
    this.formats = CodeFormat.standardScanFormats,
    this.profile = DecodeProfile.live,
    this.maxSymbols = 8,
    this.distanceAssist,
    this.minFrameGap = defaultMinFrameGap,
    this.idleFrameGap = defaultIdleFrameGap,
    this.idleAfter = defaultIdleAfter,
    CameraLensDirection facing = CameraLensDirection.back,
    BarcodeDecoder? decoder,
    DistanceEnhancementService? distanceEnhancementService,
  }) : _decoder = decoder ?? BarcodeDecoderService.instance,
       _distanceService =
           distanceEnhancementService ??
           DistanceEnhancementService(decoder: decoder),
       super(ScanCameraState(lensDirection: facing));

  static List<CameraDescription>? _cameras;

  final StreamController<ScanFrameResult> _results =
      StreamController<ScanFrameResult>.broadcast();

  CameraController? _camera;
  Future<void> _queue = Future.value();
  bool _decoding = false;
  int _frameIndex = 0;
  int _timedFrames = 0;
  int _timedMicros = 0;
  bool _assisting = false;
  DateTime? _lastAssistEnd;
  bool _disposed = false;
  double _minZoom = 1.0;
  double _maxZoom = 1.0;

  /// Codes found in camera frames. Only frames with at least one code emit.
  Stream<ScanFrameResult> get barcodes => _results.stream;

  /// The underlying camera, for the preview widget. Null while stopped.
  CameraController? get cameraController => _camera;

  /// Runs [operation] after every earlier start/stop/switch has finished.
  Future<void> _serial(Future<void> Function() operation) {
    final next = _queue.then((_) => operation()).catchError((Object e) {
      AppLogger.error('Scan camera operation failed', error: e);
    });
    _queue = next;
    return next;
  }

  /// Opens the camera and starts decoding frames.
  Future<void> start() => _serial(_start);

  /// Stops decoding and releases the camera.
  Future<void> stop() => _serial(_stop);

  Future<void> _start() async {
    if (_disposed || _camera != null) return;
    try {
      // Start the decoder isolate while the camera opens.
      final decoder = _decoder;
      if (decoder is BarcodeDecoderService) unawaited(decoder.warmUp());
      _cameras ??= await availableCameras();
      final cameras = _cameras!;
      if (cameras.isEmpty) {
        _setValue(value.copyWith(error: ScanCameraError.noCamera));
        return;
      }
      final description = cameras.firstWhere(
        (c) => c.lensDirection == value.lensDirection,
        orElse: () => cameras.first,
      );

      final camera = CameraController(
        description,
        _presetFor(cameraResolution),
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );
      await camera.initialize();
      if (_disposed) {
        await camera.dispose();
        return;
      }
      _camera = camera;

      try {
        _minZoom = await camera.getMinZoomLevel();
        _maxZoom = await camera.getMaxZoomLevel();
      } catch (_) {
        _minZoom = 1.0;
        _maxZoom = 1.0;
      }
      if (value.zoomScale > 0) await _applyZoom(value.zoomScale);

      _lastDecodeStart = null;
      noteActivity();
      await camera.startImageStream(_onFrame);
      _setValue(
        value.copyWith(
          isInitialized: true,
          isRunning: true,
          torchState: TorchState.off,
          lensDirection: description.lensDirection,
          clearError: true,
        ),
      );
    } on CameraException catch (e) {
      await _releaseCamera();
      final denied =
          e.code == 'CameraAccessDenied' ||
          e.code == 'CameraAccessDeniedWithoutPrompt' ||
          e.code == 'CameraAccessRestricted';
      _setValue(
        value.copyWith(
          isRunning: false,
          error: denied
              ? ScanCameraError.permissionDenied
              : ScanCameraError.failed,
        ),
      );
    } catch (e, st) {
      await _releaseCamera();
      AppLogger.error('Scan camera start failed', error: e, stackTrace: st);
      _setValue(
        value.copyWith(isRunning: false, error: ScanCameraError.failed),
      );
    }
  }

  Future<void> _stop() async {
    await _releaseCamera();
    _setValue(value.copyWith(isRunning: false, torchState: TorchState.off));
  }

  Future<void> _releaseCamera() async {
    final camera = _camera;
    _camera = null;
    if (camera == null) return;
    try {
      if (camera.value.isStreamingImages) await camera.stopImageStream();
    } catch (_) {}
    try {
      await camera.dispose();
    } catch (_) {}
  }

  /// Turns the torch on or off.
  Future<void> toggleTorch() async {
    final camera = _camera;
    if (camera == null || !camera.value.isInitialized) return;
    final turnOn = value.torchState != TorchState.on;
    try {
      await camera.setFlashMode(turnOn ? FlashMode.torch : FlashMode.off);
      _setValue(
        value.copyWith(torchState: turnOn ? TorchState.on : TorchState.off),
      );
    } catch (_) {
      _setValue(value.copyWith(torchState: TorchState.unavailable));
    }
  }

  /// Switches between the back and front camera.
  Future<void> switchCamera() => _serial(() async {
    final wasRunning = _camera != null;
    await _releaseCamera();
    final next = value.lensDirection == CameraLensDirection.front
        ? CameraLensDirection.back
        : CameraLensDirection.front;
    _setValue(
      value.copyWith(
        lensDirection: next,
        isRunning: false,
        torchState: TorchState.off,
      ),
    );
    if (wasRunning) await _start();
  });

  /// Sets zoom as a 0–1 fraction between minimum and maximum zoom.
  Future<void> setZoomScale(double scale) async {
    final clamped = scale.clamp(0.0, 1.0);
    noteActivity();
    _setValue(value.copyWith(zoomScale: clamped));
    await _applyZoom(clamped);
  }

  Future<void> _applyZoom(double scale) async {
    final camera = _camera;
    if (camera == null || !camera.value.isInitialized) return;
    try {
      await camera.setZoomLevel(_minZoom + (_maxZoom - _minZoom) * scale);
    } catch (_) {}
  }

  /// Focuses (and meters exposure) on a point given as 0–1 fractions of the
  /// preview width and height.
  Future<void> setFocusPoint(Offset normalized) async {
    noteActivity();
    final camera = _camera;
    if (camera == null || !camera.value.isInitialized) return;
    final point = Offset(
      normalized.dx.clamp(0.0, 1.0),
      normalized.dy.clamp(0.0, 1.0),
    );
    try {
      if (camera.value.focusPointSupported) {
        await camera.setFocusPoint(point);
      }
      if (camera.value.exposurePointSupported) {
        await camera.setExposurePoint(point);
      }
    } catch (_) {}
  }

  /// Marks user activity (focus tap, zoom), so decoding goes back to the
  /// full speed right away.
  void noteActivity() => _lastActivity = DateTime.now();

  Future<void> _onFrame(CameraImage image) async {
    if (_decoding || _disposed || _camera == null) return;
    if (image.planes.isEmpty) return;
    final now = DateTime.now();
    final lastStart = _lastDecodeStart;
    if (lastStart != null) {
      final gap = frameGapFor(
        sinceActivity: now.difference(_lastActivity),
        minGap: minFrameGap,
        idleGap: idleFrameGap,
        idleAfter: idleAfter,
      );
      // Skip this frame to save battery; a newer one comes soon.
      if (now.difference(lastStart) < gap) return;
    }
    _lastDecodeStart = now;
    _decoding = true;
    try {
      final description = _camera?.description;
      if (description == null) return;
      final luminance = image.planes.first;
      final rotation = description.sensorOrientation % 360;
      final mirror = description.lensDirection == CameraLensDirection.front;
      final frameProfile = profileForFrame(_frameIndex++, profile);
      final stopwatch = kDebugMode ? (Stopwatch()..start()) : null;

      final codes = await _decoder.decodePixels(
        DecodeRequest(
          pixels: luminance.bytes,
          width: image.width,
          height: image.height,
          rowStride: luminance.bytesPerRow,
          imageFormat: SrbImageFormat.lum,
          rotationDegrees: rotation,
          formatMask: CodeFormat.maskOf(formats),
          profile: frameProfile,
          tryInvert: invertImage,
          maxSymbols: maxSymbols,
        ),
      );
      if (stopwatch != null) _logTiming(stopwatch.elapsedMicroseconds);
      if (_disposed || _camera == null) return;

      final upright = rotation == 90 || rotation == 270
          ? Size(image.height.toDouble(), image.width.toDouble())
          : Size(image.width.toDouble(), image.height.toDouble());
      if (codes.isEmpty) {
        _maybeRunDistanceAssist(
          luminance: luminance,
          width: image.width,
          height: image.height,
          rotation: rotation,
          mirror: mirror,
          upright: upright,
        );
        return;
      }
      _emit(codes, upright, mirror);
    } catch (e, st) {
      AppLogger.error('Frame decode failed', error: e, stackTrace: st);
    } finally {
      _decoding = false;
    }
  }

  /// Debug builds only: logs the average decode time every few frames.
  void _logTiming(int micros) {
    _timedMicros += micros;
    if (++_timedFrames < _timingLogFrames) return;
    final averageMs = _timedMicros / _timedFrames / 1000;
    AppLogger.debug(
      'Live decode: ${averageMs.toStringAsFixed(1)} ms average '
      'over $_timedFrames frames',
    );
    _timedFrames = 0;
    _timedMicros = 0;
  }

  void _emit(List<ScannedCode> codes, Size upright, bool mirror) {
    noteActivity();
    final visible = mirror
        ? codes.map((c) => _mirror(c, upright.width)).toList()
        : codes;
    if (!_results.isClosed) {
      _results.add(ScanFrameResult(barcodes: visible, size: upright));
    }
  }

  /// Starts one background distance assist try on this frame, unless the
  /// assist is off, already running, or ran too recently.
  void _maybeRunDistanceAssist({
    required Plane luminance,
    required int width,
    required int height,
    required int rotation,
    required bool mirror,
    required Size upright,
  }) {
    final config = distanceAssist;
    if (config == null || _assisting || _disposed) return;
    final last = _lastAssistEnd;
    if (last != null &&
        DateTime.now().difference(last) < distanceAssistInterval) {
      return;
    }
    _assisting = true;
    // The service copies the crop before its first await, so the frame
    // buffer is not used after this call returns.
    final pending = _distanceService.processLuminanceFrame(
      luminance: luminance.bytes,
      width: width,
      height: height,
      rowStride: luminance.bytesPerRow,
      rotationDegrees: rotation,
      config: config,
      formats: formats,
    );
    unawaited(
      pending
          .then((codes) {
            if (codes.isEmpty || _disposed || _camera == null) return;
            if (distanceAssist == null) return;
            _emit(codes, upright, mirror);
          })
          .catchError((Object e) {
            AppLogger.error('Distance assist failed', error: e);
          })
          .whenComplete(() {
            _assisting = false;
            _lastAssistEnd = DateTime.now();
          }),
    );
  }

  /// The front camera preview is shown mirrored, so mirror corners to match.
  ScannedCode _mirror(ScannedCode code, double width) {
    return code.copyWith(
      corners: code.corners.map((p) => Offset(width - p.dx, p.dy)).toList(),
    );
  }

  static ResolutionPreset _presetFor(Size? size) {
    if (size == null) return ResolutionPreset.high;
    final longest = size.longestSide;
    if (longest <= 1280) return ResolutionPreset.high;
    if (longest <= 1920) return ResolutionPreset.veryHigh;
    return ResolutionPreset.ultraHigh;
  }

  void _setValue(ScanCameraState next) {
    if (!_disposed) value = next;
  }

  @override
  void dispose() {
    if (_disposed) return;
    _disposed = true;
    final camera = _camera;
    _camera = null;
    _queue.whenComplete(() async {
      try {
        if (camera != null && camera.value.isStreamingImages) {
          await camera.stopImageStream();
        }
      } catch (_) {}
      try {
        await camera?.dispose();
      } catch (_) {}
    });
    _results.close();
    super.dispose();
  }
}
