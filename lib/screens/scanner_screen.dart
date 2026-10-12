import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:sreerajp_qr_studio/l10n/app_message_text.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/main.dart';
import 'package:sreerajp_qr_studio/models/camera_settings.dart';
import 'package:sreerajp_qr_studio/models/clipboard_scan_data.dart';
import 'package:sreerajp_qr_studio/models/visible_barcode.dart';
import 'package:sreerajp_qr_studio/providers/batch_scan_provider.dart';
import 'package:sreerajp_qr_studio/providers/camera_settings_provider.dart';
import 'package:sreerajp_qr_studio/providers/history_provider.dart';
import 'package:sreerajp_qr_studio/providers/multi_code_selection_provider.dart';
import 'package:sreerajp_qr_studio/providers/scan_provider.dart';
import 'package:sreerajp_qr_studio/providers/theme_provider.dart';
import 'package:sreerajp_qr_studio/screens/widgets/batch_review_sheet.dart';
import 'package:sreerajp_qr_studio/screens/widgets/multi_code_bounding_box_widget.dart';
import 'package:sreerajp_qr_studio/screens/widgets/multi_code_hint_banner.dart';
import 'package:sreerajp_qr_studio/screens/widgets/pdf_scan_results_sheet.dart';
import 'package:sreerajp_qr_studio/screens/widgets/scan_overlay_widget.dart';
import 'package:sreerajp_qr_studio/services/clipboard_scan_service.dart';
import 'package:sreerajp_qr_studio/models/ghost_scan_capture.dart';
import 'package:sreerajp_qr_studio/models/scan_record.dart';
import 'package:sreerajp_qr_studio/screens/scan_bubble_settings_screen.dart';
import 'package:sreerajp_qr_studio/services/ghost_scan_service.dart';
import 'package:sreerajp_qr_studio/services/media_scan_service.dart';
import 'package:sreerajp_qr_studio/widgets/camera_adjustments_sheet.dart';
import 'package:sreerajp_qr_studio/widgets/focus_ring_widget.dart';
import 'package:sreerajp_qr_studio/widgets/ghost_scan_sheet.dart';
import 'package:sreerajp_qr_studio/models/code_format.dart';
import 'package:sreerajp_qr_studio/models/code_content_type.dart';
import 'package:sreerajp_qr_studio/models/scanned_code.dart';
import 'package:sreerajp_qr_studio/models/distance_enhanced_scan_result.dart';
import 'package:sreerajp_qr_studio/models/scan_frame_result.dart';
import 'package:sreerajp_qr_studio/services/scan_camera/scan_camera_controller.dart';
import 'package:sreerajp_qr_studio/screens/widgets/scan_camera_view.dart';

class ScannerScreen extends StatefulWidget {
  final bool isActive;
  const ScannerScreen({super.key, this.isActive = true});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen>
    with WidgetsBindingObserver, RouteAware {
  ScanCameraController? controller;
  bool _isScanning = true;
  bool _hasPermission = false;
  bool _isInitialized = false;

  // Viewport & camera control states
  CameraSettingsProvider? _cameraSettingsProvider;
  bool _isFrontCamera = false;
  double _zoomScale = 1.0;
  double _baseZoomScale = 1.0;
  bool _showZoomBar = false;
  List<Offset>? _detectedCorners;
  bool _isScanSuccess = false;
  String? _batchToastMessage;
  Timer? _batchToastTimer;

  // Media scanning & Android share sheet target
  late final MediaScanService _mediaScanService;
  StreamSubscription<List<SharedMediaFile>>? _intentSubscription;

  // Clipboard detection & scanning
  late final ClipboardScanService _clipboardScanService;
  ClipboardScanData? _detectedClipboardData;
  String? _lastDismissedClipboardContent;
  String? _lastScannedClipboardContent;

  // GhostScan screen content detection
  late final GhostScanService _ghostScanService;
  StreamSubscription<GhostScanCapture>? _ghostScanSubscription;

  @override
  void initState() {
    super.initState();
    _mediaScanService = MediaScanService();
    _clipboardScanService = ClipboardScanService();
    _ghostScanService = GhostScanService();
    WidgetsBinding.instance.addObserver(this);
    _initializeScanner();
    _listenToShareIntents();
    _listenToGhostScan();
    _checkClipboard();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final modalRoute = ModalRoute.of(context);
    if (modalRoute is PageRoute) {
      routeObserver.subscribe(this, modalRoute);
    }

    final newProvider = Provider.of<CameraSettingsProvider>(context);
    if (_cameraSettingsProvider != newProvider) {
      _cameraSettingsProvider?.removeListener(_onCameraSettingsChanged);
      _cameraSettingsProvider = newProvider;
      _cameraSettingsProvider?.addListener(_onCameraSettingsChanged);
    }
  }

  @override
  void didUpdateWidget(ScannerScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isActive != widget.isActive) {
      if (widget.isActive) {
        _resumeCamera();
      } else {
        _pauseCamera();
      }
    }
  }

  void _pauseCamera() {
    try {
      if (controller != null &&
          controller!.value.isInitialized &&
          controller!.value.isRunning) {
        controller?.stop();
      }
    } catch (_) {}
    if (mounted) {
      Provider.of<MultiCodeSelectionProvider>(context, listen: false).reset();
    }
  }

  Future<void> _resumeCamera() async {
    if (mounted &&
        _isScanning &&
        controller != null &&
        controller!.value.isInitialized) {
      try {
        if (!controller!.value.isRunning) {
          await controller!.start();
        }
      } catch (e) {
        if (kDebugMode) debugPrint('Resume camera error: $e');
      }
    }
  }

  void _onCameraSettingsChanged() {
    controller?.distanceAssist = _liveDistanceAssist;
    _syncTorchState();
  }

  /// Distance pipeline settings for picked, shared, and captured images.
  DistanceScanConfig get _distanceConfig =>
      _cameraSettingsProvider?.distanceScanConfig ?? const DistanceScanConfig();

  /// Live camera Distance Scan Assist settings; null when the switch is off.
  DistanceScanConfig? get _liveDistanceAssist {
    final settings = _cameraSettingsProvider;
    if (settings == null || !settings.isDistanceEnhanceMode) return null;
    return settings.distanceScanConfig;
  }

  Future<void> _syncTorchState() async {
    if (controller == null ||
        !controller!.value.isInitialized ||
        !controller!.value.isRunning) {
      return;
    }
    final shouldBeOn = _cameraSettingsProvider?.shouldTorchBeOn ?? false;
    final currentTorch = controller!.value.torchState == TorchState.on;
    if (shouldBeOn != currentTorch) {
      try {
        await controller!.toggleTorch();
      } catch (e) {
        if (kDebugMode) debugPrint('Error syncing torch state: $e');
      }
    }
  }

  Future<void> _initializeScanner() async {
    await _checkPermissions();
    if (_hasPermission && mounted) {
      final cameraSettings = Provider.of<CameraSettingsProvider>(
        context,
        listen: false,
      );
      setState(() {
        controller = ScanCameraController(
          cameraResolution: cameraSettings.targetResolution,
          invertImage: cameraSettings.invertColors,
          distanceAssist: cameraSettings.isDistanceEnhanceMode
              ? cameraSettings.distanceScanConfig
              : null,
        );
        _isInitialized = true;
      });
    }
  }

  Future<void> _restartScanner() async {
    if (controller != null) {
      try {
        await controller!.stop();
        controller!.dispose();
      } catch (e) {
        if (kDebugMode) debugPrint('Error disposing controller on restart: $e');
      }
      controller = null;
    }
    if (mounted) {
      await _initializeScanner();
      await _syncTorchState();
    }
  }

  Future<void> _checkPermissions() async {
    final status = await Permission.camera.request();
    if (mounted) {
      setState(() {
        _hasPermission = status.isGranted;
      });
    }
  }

  void _listenToShareIntents() {
    // Media shared while app is running in foreground/background
    _intentSubscription = ReceiveSharingIntent.instance.getMediaStream().listen(
      _handleSharedFiles,
      onError: (err) {
        if (kDebugMode) debugPrint('Error receiving share intent stream: $err');
      },
    );

    // Media shared when launching app from closed state
    ReceiveSharingIntent.instance.getInitialMedia().then((files) {
      if (files.isNotEmpty) {
        _handleSharedFiles(files);
        ReceiveSharingIntent.instance.reset();
      }
    });
  }

  Future<void> _handleSharedFiles(List<SharedMediaFile> files) async {
    if (files.isEmpty || !mounted) return;
    final sharedFile = files.first;

    final path = sharedFile.path;
    if (path.toLowerCase().endsWith('.pdf') ||
        sharedFile.mimeType == 'application/pdf') {
      _scanPdfPath(path);
    } else {
      _scanImagePath(path);
    }
  }

  @override
  void dispose() {
    _batchToastTimer?.cancel();
    _cameraSettingsProvider?.removeListener(_onCameraSettingsChanged);
    _intentSubscription?.cancel();
    _ghostScanSubscription?.cancel();
    _ghostScanService.dispose();
    routeObserver.unsubscribe(this);
    WidgetsBinding.instance.removeObserver(this);
    controller?.dispose();
    super.dispose();
  }

  void _listenToGhostScan() {
    _ghostScanSubscription = _ghostScanService.onCapture.listen(
      (capture) {
        _handleGhostScanCapture(capture);
      },
      onError: (err) {
        if (kDebugMode) debugPrint('Error in GhostScan stream: $err');
      },
    );

    // Handle any image captured if app was launched cold by GhostScan
    _ghostScanService.getInitialCapture().then((capture) {
      if (capture != null) {
        _handleGhostScanCapture(capture);
      }
    });
  }

  Future<void> _handleGhostScanCapture(GhostScanCapture capture) async {
    if (!mounted) {
      await _ghostScanService.deleteCapture(capture.imagePath);
      return;
    }
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    if (capture.blocked) {
      await _ghostScanService.deleteCapture(capture.imagePath);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.scanBubbleBlockedCapture),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            const SizedBox(width: 12),
            Text(l10n.ghostScanAnalyzing),
          ],
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );

    final result = await _mediaScanService.scanImageFile(
      capture.imagePath,
      distanceConfig: _distanceConfig,
    );
    await _ghostScanService.deleteCapture(capture.imagePath);
    _processMediaScanResult(
      result,
      source: capture.fromBubble
          ? ScanRecord.sourceScreenBubble
          : ScanRecord.sourceScreen,
    );
  }

  void _showGhostScanSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => GhostScanSheet(ghostScanService: _ghostScanService),
    );
  }

  @override
  void didPushNext() {
    try {
      if (controller != null &&
          controller!.value.isInitialized &&
          controller!.value.isRunning) {
        controller?.stop();
      }
    } catch (_) {}
  }

  @override
  void didPopNext() async {
    if (mounted &&
        _isScanning &&
        controller != null &&
        controller!.value.isInitialized) {
      await Future.delayed(const Duration(milliseconds: 300));
      if (mounted && _isScanning && controller != null) {
        try {
          if (!controller!.value.isRunning) {
            await controller!.start();
          }
        } catch (e) {
          if (kDebugMode) {
            debugPrint('didPopNext camera start failed, retrying: $e');
          }
          await Future.delayed(const Duration(milliseconds: 400));
          if (mounted &&
              _isScanning &&
              controller != null &&
              !controller!.value.isRunning) {
            try {
              await controller!.start();
            } catch (_) {}
          }
        }
      }
    }
    _checkClipboard();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (controller == null || !controller!.value.isInitialized) return;
    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        try {
          if (controller!.value.isRunning) {
            controller?.stop();
          }
        } catch (_) {}
        break;
      case AppLifecycleState.resumed:
        if (_isScanning) {
          try {
            if (!controller!.value.isRunning) {
              controller?.start();
            }
          } catch (_) {}
        }
        _checkClipboard();
        break;
      case AppLifecycleState.inactive:
        break;
    }
  }

  Future<void> _navigateToRoute(String routeName) async {
    if (routeName == '/ghost_scan') {
      _showGhostScanSheet();
      return;
    }
    if (routeName == ScanBubbleSettingsScreen.routeName) {
      Navigator.of(context).pushNamed(routeName);
      return;
    }

    try {
      if (controller != null &&
          controller!.value.isInitialized &&
          controller!.value.isRunning) {
        await controller!.stop();
      }
    } catch (e) {
      if (kDebugMode) debugPrint('Error stopping camera before navigation: $e');
    }

    if (!mounted) return;
    await Navigator.pushNamed(context, routeName);

    if (mounted &&
        _isScanning &&
        controller != null &&
        controller!.value.isInitialized) {
      await Future.delayed(const Duration(milliseconds: 300));
      if (mounted && _isScanning && controller != null) {
        try {
          if (!controller!.value.isRunning) {
            await controller!.start();
          }
        } catch (e) {
          if (kDebugMode) {
            debugPrint('Initial camera start failed, retrying: $e');
          }
          await Future.delayed(const Duration(milliseconds: 400));
          if (mounted &&
              _isScanning &&
              controller != null &&
              !controller!.value.isRunning) {
            try {
              await controller!.start();
            } catch (_) {}
          }
        }
      }
    }
  }

  void _handleBarcode(ScanFrameResult capture) async {
    if (!_isScanning) return;

    final List<ScannedCode> barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;

    final cameraSettings = Provider.of<CameraSettingsProvider>(
      context,
      listen: false,
    );
    final multiCodeProvider = Provider.of<MultiCodeSelectionProvider>(
      context,
      listen: false,
    );

    if (cameraSettings.multiCodeSelectionEnabled) {
      final screenSize = MediaQuery.sizeOf(context);
      final frameSize = capture.size != Size.zero
          ? capture.size
          : cameraSettings.targetResolution;

      if (barcodes.length > 1 || multiCodeProvider.isMultiCodeActive) {
        multiCodeProvider.processCapture(
          capture: capture,
          screenSize: screenSize,
          frameSize: frameSize,
        );
        if (multiCodeProvider.isMultiCodeActive) {
          return;
        }
      }
    }

    final barcode = barcodes.first;
    if (barcode.rawValue == null) return;

    final batchProvider = Provider.of<BatchScanProvider>(
      context,
      listen: false,
    );

    if (batchProvider.isBatchMode) {
      _processBatchBarcode(barcode);
    } else {
      _processSingleBarcode(
        barcode.rawValue!,
        barcode.type,
        corners: barcode.corners,
      );
    }
  }

  void _onSelectVisibleBarcode(VisibleBarcode visibleBarcode) async {
    final multiCodeProvider = Provider.of<MultiCodeSelectionProvider>(
      context,
      listen: false,
    );
    multiCodeProvider.selectBarcode(visibleBarcode.id);

    final scanProvider = Provider.of<ScanProvider>(context, listen: false);
    if (scanProvider.isVibrationEnabled) {
      HapticFeedback.mediumImpact();
    }
    if (scanProvider.isSoundEnabled) {
      SystemSound.play(SystemSoundType.click);
    }

    final batchProvider = Provider.of<BatchScanProvider>(
      context,
      listen: false,
    );

    if (batchProvider.isBatchMode) {
      _processBatchBarcode(visibleBarcode.toScannedCode());
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          multiCodeProvider.selectBarcode('');
        }
      });
    } else {
      await Future.delayed(const Duration(milliseconds: 200));
      if (mounted) {
        multiCodeProvider.dismiss();
        _processSingleBarcode(
          visibleBarcode.rawValue,
          visibleBarcode.type,
          corners: visibleBarcode.corners,
        );
      }
    }
  }

  void _processBatchBarcode(ScannedCode barcode) async {
    final rawValue = barcode.rawValue;
    if (rawValue == null || rawValue.isEmpty) return;

    final batchProvider = Provider.of<BatchScanProvider>(
      context,
      listen: false,
    );
    if (!batchProvider.canAccept(rawValue)) return;

    final scanProvider = Provider.of<ScanProvider>(context, listen: false);

    // Haptic & Audible feedback based on user configuration
    if (scanProvider.isVibrationEnabled) {
      HapticFeedback.mediumImpact();
    }
    if (scanProvider.isSoundEnabled) {
      SystemSound.play(SystemSoundType.click);
    }

    // Brief reticle pulse micro-interaction (250ms) without stopping camera
    if (barcode.corners.isNotEmpty) {
      setState(() {
        _detectedCorners = barcode.corners;
        _isScanSuccess = true;
      });
    } else {
      setState(() {
        _isScanSuccess = true;
      });
    }

    Future.delayed(const Duration(milliseconds: 250), () {
      if (mounted) {
        setState(() {
          _isScanSuccess = false;
          _detectedCorners = null;
        });
      }
    });

    final item = await batchProvider.addBarcode(rawValue, barcode.type);
    if (item != null && mounted) {
      // Save to encrypted history database
      final historyProvider = Provider.of<HistoryProvider>(
        context,
        listen: false,
      );
      historyProvider.addScanRecord(item.toScanRecord());

      // Show brief non-blocking HUD pill in camera viewport
      final l10n = AppLocalizations.of(context);
      final shortContent = rawValue.length > 25
          ? '${rawValue.substring(0, 22)}...'
          : rawValue;
      _showBatchToast(
        l10n.batchScannedToast(batchProvider.count, shortContent),
      );
    }
  }

  void _showBatchToast(String message) {
    _batchToastTimer?.cancel();
    setState(() {
      _batchToastMessage = message;
    });
    _batchToastTimer = Timer(const Duration(milliseconds: 1800), () {
      if (mounted) {
        setState(() {
          _batchToastMessage = null;
        });
      }
    });
  }

  void _processSingleBarcode(
    String rawValue,
    CodeContentType format, {
    List<Offset>? corners,
    String? source,
  }) async {
    final scanProvider = Provider.of<ScanProvider>(context, listen: false);

    // Haptic & Audible Feedback based on user configuration
    if (scanProvider.isVibrationEnabled) {
      HapticFeedback.mediumImpact();
    }
    if (scanProvider.isSoundEnabled) {
      SystemSound.play(SystemSoundType.click);
    }

    if (corners != null && corners.isNotEmpty) {
      setState(() {
        _detectedCorners = corners;
      });
    }

    setState(() {
      _isScanning = false;
      _isScanSuccess = true;
    });

    scanProvider.setScanResult(rawValue, format);

    final record = scanProvider.createScanRecord(source: source);
    if (record != null) {
      Provider.of<HistoryProvider>(
        context,
        listen: false,
      ).addScanRecord(record);
    }

    if (scanProvider.isUrl) {
      scanProvider.checkUrlSafety(rawValue);
    }

    // Micro-interaction animation duration before navigation (if enabled)
    if (scanProvider.isAnimationEnabled) {
      await Future.delayed(const Duration(milliseconds: 380));
    }

    try {
      if (controller != null &&
          controller!.value.isInitialized &&
          controller!.value.isRunning) {
        await controller!.stop();
      }
    } catch (_) {}
    if (!mounted) return;

    Navigator.pushNamed(context, '/result').then((_) async {
      // Reset scanning state when returning from result screen
      if (mounted) {
        setState(() {
          _isScanning = true;
          _isScanSuccess = false;
          _detectedCorners = null;
        });
        if (controller != null &&
            controller!.value.isInitialized &&
            !controller!.value.isRunning) {
          try {
            await controller!.start();
          } catch (_) {}
        }
      }
    });
  }

  Future<void> _scanGalleryImage() async {
    final result = await _mediaScanService.pickAndScanImage(
      distanceConfig: _distanceConfig,
    );
    _processMediaScanResult(result);
  }

  Future<void> _scanImagePath(String path) async {
    final result = await _mediaScanService.scanImageFile(
      path,
      distanceConfig: _distanceConfig,
    );
    _processMediaScanResult(result);
  }

  Future<void> _scanPdfDocument() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 20),
            Expanded(child: Text(AppLocalizations.of(context).scanPdfProgress)),
          ],
        ),
      ),
    );

    final result = await _mediaScanService.pickAndScanPdf();

    if (mounted) {
      Navigator.of(context, rootNavigator: true).pop(); // Dismiss progress
      _processMediaScanResult(result);
    }
  }

  Future<void> _scanPdfPath(String pdfPath) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 20),
            Expanded(
              child: Text(AppLocalizations.of(context).scanSharedPdfProgress),
            ),
          ],
        ),
      ),
    );

    final result = await _mediaScanService.scanPdfFile(pdfPath);

    if (mounted) {
      Navigator.of(context, rootNavigator: true).pop(); // Dismiss progress
      _processMediaScanResult(result);
    }
  }

  Future<void> _checkClipboard() async {
    try {
      final data = await _clipboardScanService.checkClipboard();
      if (!mounted) return;
      if (data != null &&
          data.content != _lastDismissedClipboardContent &&
          data.content != _lastScannedClipboardContent) {
        setState(() {
          _detectedClipboardData = data;
        });
      } else if (data == null && _detectedClipboardData != null) {
        setState(() {
          _detectedClipboardData = null;
        });
      }
    } catch (_) {}
  }

  Future<void> _scanFromClipboard({ClipboardScanData? data}) async {
    final targetData =
        data ??
        await _clipboardScanService.checkClipboard(includeGenericText: true);
    if (!mounted) return;

    if (targetData == null) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).clipboardNoValidContent),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _lastScannedClipboardContent = targetData.content;
      _detectedClipboardData = null;
    });

    if (targetData.type == ClipboardContentType.image) {
      await _scanImagePath(targetData.content);
    } else {
      final batchProvider = Provider.of<BatchScanProvider>(
        context,
        listen: false,
      );
      if (batchProvider.isBatchMode) {
        final barcodeFormat = switch (targetData.barcodeType) {
          CodeContentType.product => CodeFormat.ean13,
          CodeContentType.isbn => CodeFormat.ean13,
          _ => CodeFormat.qrCode,
        };
        final syntheticBarcode = ScannedCode(
          rawValue: targetData.content,
          format: barcodeFormat,
        );
        _processBatchBarcode(syntheticBarcode);
      } else {
        _processSingleBarcode(targetData.content, targetData.barcodeType);
      }
    }
  }

  void _processMediaScanResult(MediaScanResult result, {String? source}) {
    if (!mounted) return;

    if (!result.hasBarcodes) {
      if (result.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              appMessageText(
                AppLocalizations.of(context),
                result.errorMessage!,
              ),
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
      return;
    }

    if (result.isPdf && result.pdfBarcodes.length > 1) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) => PdfScanResultsSheet(
          pdfBarcodes: result.pdfBarcodes,
          onSelect: (selectedBarcode) {
            _processSingleBarcode(
              selectedBarcode.rawValue,
              selectedBarcode.format,
            );
          },
        ),
      );
    } else if (result.isPdf && result.pdfBarcodes.isNotEmpty) {
      final first = result.pdfBarcodes.first;
      _processSingleBarcode(first.rawValue, first.format);
    } else if (result.barcodes.isNotEmpty) {
      final first = result.barcodes.first;
      if (first.rawValue != null) {
        _processSingleBarcode(first.rawValue!, first.type, source: source);
      }
    }
  }

  Future<void> _switchCamera() async {
    try {
      await controller?.switchCamera();
      setState(() {
        _isFrontCamera = !_isFrontCamera;
      });
    } catch (e) {
      if (kDebugMode) debugPrint('Error switching camera: $e');
    }
  }

  Future<void> _setZoom(double zoom) async {
    setState(() {
      _zoomScale = zoom;
    });
    try {
      final zoomFactor = ((zoom - 1.0) / 7.0).clamp(0.0, 1.0);
      await controller?.setZoomScale(zoomFactor);
    } catch (e) {
      if (kDebugMode) debugPrint('Error setting zoom: $e');
    }
  }

  void _toggleScanning() {
    setState(() {
      _isScanning = !_isScanning;
    });
    if (_isScanning) {
      controller?.start();
    } else {
      controller?.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.appTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        elevation: 2,
        actionsPadding: const EdgeInsets.only(right: 4),
        actions: [
          IconButton(
            visualDensity: VisualDensity.compact,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
            icon: const Icon(Icons.photo_library),
            onPressed: _scanGalleryImage,
            tooltip: l10n.scanFromGallery,
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: _scanPdfDocument,
            tooltip: l10n.scanPdfDocument,
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
            icon: const Icon(Icons.content_paste_go),
            onPressed: () => _scanFromClipboard(),
            tooltip: l10n.scanFromClipboard,
          ),
          Consumer<BatchScanProvider>(
            builder: (context, batchProvider, _) {
              final isBatch = batchProvider.isBatchMode;
              return IconButton(
                visualDensity: VisualDensity.compact,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                icon: Icon(
                  isBatch ? Icons.inventory_2 : Icons.inventory_2_outlined,
                  color: isBatch ? Theme.of(context).colorScheme.primary : null,
                ),
                tooltip: l10n.batchModeTooltip,
                onPressed: () {
                  batchProvider.toggleBatchMode();
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        batchProvider.isBatchMode
                            ? l10n.batchModeEnabledToast
                            : l10n.batchModeDisabledToast,
                      ),
                      duration: const Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              );
            },
          ),
          PopupMenuButton<String>(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
            icon: const Icon(Icons.more_vert),
            tooltip: l10n.moreOptions,
            onSelected: _navigateToRoute,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: '/ghost_scan',
                child: Row(
                  children: [
                    const Icon(Icons.screenshot_monitor),
                    const SizedBox(width: 12),
                    Text(l10n.ghostScanTitle),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: ScanBubbleSettingsScreen.routeName,
                child: Row(
                  children: [
                    const Icon(Icons.bubble_chart_outlined),
                    const SizedBox(width: 12),
                    Text(l10n.scanBubbleTitle),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: '/code_forge',
                child: Row(
                  children: [
                    const Icon(Icons.qr_code_2),
                    const SizedBox(width: 12),
                    Text(l10n.tabCodeForge),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: '/ar_codevision',
                child: Row(
                  children: [
                    const Icon(Icons.view_in_ar),
                    const SizedBox(width: 12),
                    Text(l10n.arScreenTitle),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: '/air_qr',
                child: Row(
                  children: [
                    const Icon(Icons.sensors),
                    const SizedBox(width: 12),
                    Text(l10n.airQrReceiverTitle),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: '/history',
                child: Row(
                  children: [
                    const Icon(Icons.history),
                    const SizedBox(width: 12),
                    Text(l10n.menuHistory),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: '/settings',
                child: Row(
                  children: [
                    const Icon(Icons.settings),
                    const SizedBox(width: 12),
                    Text(l10n.menuSettings),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: !_hasPermission
          ? _buildPermissionRequest()
          : (_isInitialized && controller != null
                ? _buildScanner()
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(height: 16),
                        Text(
                          l10n.scanInitializingCamera,
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  )),
      floatingActionButton: _hasPermission && _isInitialized
          ? FloatingActionButton(
              onPressed: _toggleScanning,
              tooltip: _isScanning
                  ? l10n.scanPauseTooltip
                  : l10n.scanResumeTooltip,
              child: Icon(_isScanning ? Icons.pause : Icons.play_arrow),
            )
          : null,
    );
  }

  Widget _buildScanner() {
    final l10n = AppLocalizations.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final cameraSettings = Provider.of<CameraSettingsProvider>(context);
    final screenWidth = MediaQuery.sizeOf(context).width;
    final scanAreaSize = (screenWidth * 0.74).clamp(280.0, 330.0);

    return GestureDetector(
      onScaleStart: (details) {
        _baseZoomScale = _zoomScale;
      },
      onScaleUpdate: (details) {
        final newZoom = (_baseZoomScale * details.scale).clamp(1.0, 8.0);
        _setZoom(newZoom);
      },
      onTapDown: (details) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null && box.size.width > 0 && box.size.height > 0) {
          final normalizedX = (details.localPosition.dx / box.size.width).clamp(
            0.0,
            1.0,
          );
          final normalizedY = (details.localPosition.dy / box.size.height)
              .clamp(0.0, 1.0);
          try {
            controller?.setFocusPoint(Offset(normalizedX, normalizedY));
          } catch (_) {}
          cameraSettings.setFocusPoint(details.localPosition);
        }
      },
      child: Stack(
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.matrix(cameraSettings.colorMatrix),
            child: ScanCameraView(
              key: ValueKey(controller),
              controller: controller!,
              onDetect: _handleBarcode,
              errorBuilder: (context, error) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.camera_alt_outlined,
                        size: 48,
                        color: Colors.amber,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        l10n.scanInitializingFeed,
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Dynamic customizable scanning overlay & barcode focus box
          Center(
            child: ScanOverlayWidget(
              scanAreaSize: scanAreaSize,
              style: themeProvider.scanOverlayStyle,
              detectedCorners: _detectedCorners,
              isSuccess: _isScanSuccess,
            ),
          ),
          // Interactive Focus Ring overlay on user tap
          if (cameraSettings.focusPoint != null)
            FocusRingWidget(
              key: ValueKey(cameraSettings.focusPointTimestamp),
              position: cameraSettings.focusPoint!,
              onAnimationComplete: () => cameraSettings.clearFocusPoint(),
            ),
          // Multi-Code Tappable Selection Bounding Boxes & HUD Banner
          Consumer<MultiCodeSelectionProvider>(
            builder: (context, multiCodeProvider, _) {
              if (!multiCodeProvider.isMultiCodeActive ||
                  multiCodeProvider.visibleBarcodes.isEmpty) {
                return const SizedBox.shrink();
              }
              return Stack(
                children: [
                  ...multiCodeProvider.visibleBarcodes.map((visible) {
                    return MultiCodeBoundingBoxWidget(
                      key: ValueKey(visible.id),
                      barcode: visible,
                      isSelected:
                          multiCodeProvider.selectedBarcodeId == visible.id,
                      onTap: () => _onSelectVisibleBarcode(visible),
                    );
                  }),
                  MultiCodeHintBanner(
                    onDismiss: () => multiCodeProvider.dismiss(),
                  ),
                ],
              );
            },
          ),
          // Viewport Controls Suite Bar (Top Overlay)
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.65),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // 3-State Flash mode button: Off -> On -> Auto
                  IconButton(
                    icon: Icon(
                      switch (cameraSettings.flashMode) {
                        CameraFlashMode.off => Icons.flash_off,
                        CameraFlashMode.on => Icons.flash_on,
                        CameraFlashMode.auto => Icons.flash_auto,
                      },
                      color: switch (cameraSettings.flashMode) {
                        CameraFlashMode.off => Colors.white,
                        CameraFlashMode.on => Colors.amber,
                        CameraFlashMode.auto => Colors.cyanAccent,
                      },
                    ),
                    onPressed: () => cameraSettings.cycleFlashMode(),
                    tooltip: switch (cameraSettings.flashMode) {
                      CameraFlashMode.off => l10n.scanFlashOff,
                      CameraFlashMode.on => l10n.scanFlashOn,
                      CameraFlashMode.auto => l10n.scanFlashAuto,
                    },
                  ),
                  // Camera tuning / adjustments button
                  IconButton(
                    icon: Icon(
                      Icons.tune,
                      color:
                          (cameraSettings.brightness != 0.0 ||
                              cameraSettings.contrast != 1.0 ||
                              cameraSettings.invertColors)
                          ? Theme.of(context).colorScheme.primary
                          : Colors.white,
                    ),
                    onPressed: () => CameraAdjustmentsSheet.show(
                      context,
                      onResolutionChanged: () => _restartScanner(),
                    ),
                    tooltip: l10n.cameraTuneTooltip,
                  ),
                  IconButton(
                    icon: Icon(
                      _showZoomBar ? Icons.zoom_in_map : Icons.search,
                      color: _showZoomBar
                          ? Theme.of(context).colorScheme.primary
                          : Colors.white,
                    ),
                    onPressed: () {
                      setState(() => _showZoomBar = !_showZoomBar);
                    },
                    tooltip: l10n.scanZoomTooltip,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${_zoomScale.toStringAsFixed(1)}x',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.cameraswitch,
                      color: _isFrontCamera ? Colors.cyanAccent : Colors.white,
                    ),
                    onPressed: _switchCamera,
                    tooltip: l10n.scanFlipCameraTooltip,
                  ),
                ],
              ),
            ),
          ),
          // Ambient lux badge (visible when flash is in Auto mode)
          if (cameraSettings.flashMode == CameraFlashMode.auto &&
              cameraSettings.currentLux != null)
            Positioned(
              top: 68,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.75),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: cameraSettings.autoTorchActive
                          ? Colors.amber
                          : Colors.cyanAccent.withValues(alpha: 0.6),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        cameraSettings.autoTorchActive
                            ? Icons.flash_on
                            : Icons.light_mode,
                        size: 13,
                        color: cameraSettings.autoTorchActive
                            ? Colors.amber
                            : Colors.cyanAccent,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        l10n.scanFlashAutoActive(
                          cameraSettings.currentLux!.toStringAsFixed(0),
                        ),
                        style: TextStyle(
                          color: cameraSettings.autoTorchActive
                              ? Colors.amber
                              : Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          // Visual Zoom Slider Bar (Collapsible)
          if (_showZoomBar)
            Positioned(
              top:
                  (cameraSettings.flashMode == CameraFlashMode.auto &&
                      cameraSettings.currentLux != null)
                  ? 104
                  : 76,
              left: 24,
              right: 24,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Text(
                      l10n.scanZoomValue('1.0'),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    Expanded(
                      child: Slider(
                        value: _zoomScale,
                        min: 1.0,
                        max: 8.0,
                        divisions: 28,
                        label: l10n.scanZoomValue(
                          _zoomScale.toStringAsFixed(1),
                        ),
                        onChanged: (val) {
                          _setZoom(val);
                        },
                      ),
                    ),
                    Text(
                      l10n.scanZoomValue('8.0'),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          // Floating Clipboard Scan Quick-Action Pill
          if (_detectedClipboardData != null)
            Positioned(
              bottom: 154,
              left: 20,
              right: 20,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.88),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 1.5,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        switch (_detectedClipboardData!.type) {
                          ClipboardContentType.image => Icons.image_outlined,
                          ClipboardContentType.url => Icons.link,
                          ClipboardContentType.barcodePayload => Icons.qr_code,
                          ClipboardContentType.text =>
                            Icons.text_snippet_outlined,
                        },
                        color: Theme.of(context).colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  l10n.clipboardBannerTitle,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 1,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer
                                        .withValues(alpha: 0.8),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    switch (_detectedClipboardData!.type) {
                                      ClipboardContentType.url =>
                                        l10n.clipboardTypeUrl,
                                      ClipboardContentType.barcodePayload =>
                                        l10n.clipboardTypeBarcode,
                                      ClipboardContentType.image =>
                                        l10n.clipboardTypeImage,
                                      ClipboardContentType.text =>
                                        l10n.clipboardTypeText,
                                    },
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              _detectedClipboardData!.preview,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      FilledButton.tonal(
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          visualDensity: VisualDensity.compact,
                        ),
                        onPressed: () =>
                            _scanFromClipboard(data: _detectedClipboardData),
                        child: Text(
                          l10n.clipboardActionScan,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          size: 18,
                          color: Colors.white70,
                        ),
                        tooltip: l10n.clipboardDismiss,
                        visualDensity: VisualDensity.compact,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          setState(() {
                            _lastDismissedClipboardContent =
                                _detectedClipboardData!.content;
                            _detectedClipboardData = null;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          // Viewport instructions
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  l10n.scanViewfinderHint,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          // Batch Scan HUD Toast & Floating Counter Badge
          Consumer<BatchScanProvider>(
            builder: (context, batchProvider, _) {
              return Stack(
                children: [
                  if (_batchToastMessage != null)
                    Positioned(
                      top: 76,
                      left: 24,
                      right: 24,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1.2,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black45,
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: Theme.of(context).colorScheme.primary,
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  _batchToastMessage!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (batchProvider.isBatchMode || batchProvider.count > 0)
                    Positioned(
                      bottom: 24,
                      left: 16,
                      right: 88,
                      child: GestureDetector(
                        onTap: () => BatchReviewSheet.show(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.85),
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(
                              color: batchProvider.isBatchMode
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.white30,
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.4),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.inventory_2,
                                  size: 16,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimary,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      l10n.batchCounterBadge(
                                        batchProvider.count,
                                      ),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      batchProvider.isBatchMode
                                          ? l10n.batchReviewTitle
                                          : l10n.batchReviewSubtitle,
                                      style: TextStyle(
                                        color: Colors.white.withValues(
                                          alpha: 0.7,
                                        ),
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer
                                      .withValues(alpha: 0.8),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      l10n.batchReviewTitle,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimaryContainer,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Icon(
                                      Icons.chevron_right,
                                      size: 14,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionRequest() {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.camera_alt, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            l10n.scanCameraPermissionRequired,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              await _checkPermissions();
              if (_hasPermission) {
                _initializeScanner();
              }
            },
            child: Text(l10n.grantPermission),
          ),
        ],
      ),
    );
  }
}
