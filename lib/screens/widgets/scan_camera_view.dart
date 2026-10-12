import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sreerajp_qr_studio/models/scan_frame_result.dart';
import 'package:sreerajp_qr_studio/services/scan_camera/scan_camera_controller.dart';

/// Live camera preview that reports codes found by [ScanCameraController].
///
/// The preview fills the widget with [BoxFit.cover], matching how the
/// multi-code and AR overlays project frame coordinates to the screen.
class ScanCameraView extends StatefulWidget {
  final ScanCameraController controller;
  final void Function(ScanFrameResult result)? onDetect;
  final Widget Function(BuildContext context, ScanCameraError error)?
  errorBuilder;
  final WidgetBuilder? placeholderBuilder;

  /// Start the camera when the view is first shown (if it never started).
  final bool autoStart;

  const ScanCameraView({
    super.key,
    required this.controller,
    this.onDetect,
    this.errorBuilder,
    this.placeholderBuilder,
    this.autoStart = true,
  });

  @override
  State<ScanCameraView> createState() => _ScanCameraViewState();
}

class _ScanCameraViewState extends State<ScanCameraView> {
  StreamSubscription<ScanFrameResult>? _subscription;

  @override
  void initState() {
    super.initState();
    _attach();
  }

  @override
  void didUpdateWidget(ScanCameraView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      _subscription?.cancel();
      _attach();
    }
  }

  void _attach() {
    _subscription = widget.controller.barcodes.listen((result) {
      if (mounted) widget.onDetect?.call(result);
    });
    final state = widget.controller.value;
    if (widget.autoStart && !state.isInitialized && !state.isRunning) {
      widget.controller.start();
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ScanCameraState>(
      valueListenable: widget.controller,
      builder: (context, state, _) {
        final error = state.error;
        if (error != null && !state.isRunning) {
          return widget.errorBuilder?.call(context, error) ??
              const ColoredBox(color: Colors.black);
        }
        final camera = widget.controller.cameraController;
        final previewSize = camera?.value.previewSize;
        if (camera == null ||
            !camera.value.isInitialized ||
            previewSize == null ||
            !state.isRunning) {
          return widget.placeholderBuilder?.call(context) ??
              const ColoredBox(color: Colors.black);
        }
        // previewSize is reported in landscape; the app is portrait-only.
        return ColoredBox(
          color: Colors.black,
          child: ClipRect(
            child: SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: previewSize.height,
                  height: previewSize.width,
                  child: CameraPreview(camera),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
