import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sreerajp_qr_studio/l10n/app_message_text.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/models/air_qr_progress.dart';
import 'package:sreerajp_qr_studio/models/backup_exception.dart';
import 'package:sreerajp_qr_studio/providers/air_qr_provider.dart';
import 'package:sreerajp_qr_studio/providers/history_provider.dart';
import 'package:sreerajp_qr_studio/providers/locale_provider.dart';
import 'package:sreerajp_qr_studio/providers/scan_provider.dart';
import 'package:sreerajp_qr_studio/providers/theme_provider.dart';
import 'package:sreerajp_qr_studio/services/device_sync_service.dart';
import 'package:sreerajp_qr_studio/models/code_format.dart';
import 'package:sreerajp_qr_studio/models/decode_profile.dart';
import 'package:sreerajp_qr_studio/models/scan_frame_result.dart';
import 'package:sreerajp_qr_studio/services/scan_camera/scan_camera_controller.dart';
import 'package:sreerajp_qr_studio/screens/widgets/scan_camera_view.dart';
import 'package:sreerajp_qr_studio/widgets/secure_screen.dart';

class AirQrScreen extends StatefulWidget {
  const AirQrScreen({super.key});

  @override
  State<AirQrScreen> createState() => _AirQrScreenState();
}

class _AirQrScreenState extends State<AirQrScreen> with WidgetsBindingObserver {
  final DeviceSyncService _deviceSyncService = DeviceSyncService();
  final TextEditingController _syncPassphraseController =
      TextEditingController();
  ScanCameraController? controller;
  bool _isTorchOn = false;
  bool _isFrontCamera = false;
  bool _hasSavedRecord = false;
  bool _syncRestoreHistory = true;
  bool _syncApplySettings = true;
  bool _isSyncing = false;
  String? _syncError;
  bool _permissionDenied = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _requestCameraAndStart();

    // Reset stream state on enter
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AirQrProvider>(context, listen: false).resetStream();
    });
  }

  /// Asks for camera permission at point of use. The camera controller is
  /// created only once permission is granted.
  Future<void> _requestCameraAndStart() async {
    final status = await Permission.camera.request();
    if (!mounted) return;
    setState(() {
      _permissionDenied = !status.isGranted;
      if (status.isGranted) {
        controller ??= ScanCameraController(
          cameraResolution: const Size(1920, 1080),
          formats: const [CodeFormat.qrCode],
          profile: DecodeProfile.fast,
          maxSymbols: 1,
          // AirQR frames change fast: decode every frame, never slow down.
          minFrameGap: Duration.zero,
          idleFrameGap: Duration.zero,
        );
      }
    });
  }

  /// Message shown instead of the camera, with one action button.
  Widget _buildCameraMessage({
    required IconData icon,
    required String message,
    required String buttonLabel,
    required VoidCallback onPressed,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 160),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: onPressed, child: Text(buttonLabel)),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionMessage(AppLocalizations l10n) {
    return _buildCameraMessage(
      icon: Icons.camera_alt,
      message: l10n.bodyScanCameraPermissionRequired,
      buttonLabel: l10n.actionGrantPermission,
      onPressed: _requestCameraAndStart,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller?.dispose();
    _syncPassphraseController.dispose();
    super.dispose();
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
        try {
          if (!controller!.value.isRunning) {
            controller?.start();
          }
        } catch (_) {}
        break;
      case AppLifecycleState.inactive:
        break;
    }
  }

  void _onDetect(ScanFrameResult capture) {
    final barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;

    final airQrProvider = Provider.of<AirQrProvider>(context, listen: false);
    for (final barcode in barcodes) {
      if (barcode.rawValue != null) {
        airQrProvider.processScannedCode(barcode.rawValue!);
      }
    }

    if (airQrProvider.isCompleted && !_hasSavedRecord) {
      _hasSavedRecord = true;
      final scanProvider = Provider.of<ScanProvider>(context, listen: false);
      if (scanProvider.isVibrationEnabled) {
        HapticFeedback.heavyImpact();
      }
      if (scanProvider.isSoundEnabled) {
        SystemSound.play(SystemSoundType.click);
      }

      final content = airQrProvider.progress.reassembledContent ?? '';
      final isSync = _deviceSyncService.isSyncPackage(content);

      if (!isSync) {
        final record = airQrProvider.createScanRecord();
        if (record != null) {
          Provider.of<HistoryProvider>(
            context,
            listen: false,
          ).addScanRecord(record);
        }
      }
    }
  }

  Future<void> _handleBack() async {
    try {
      if (controller != null) {
        await controller!.stop();
        controller!.dispose();
        controller = null;
      }
    } catch (_) {}
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final airQrProvider = Provider.of<AirQrProvider>(context);
    final progress = airQrProvider.progress;

    return SecureScreen(
      child: PopScope(
        onPopInvokedWithResult: (didPop, result) async {
          try {
            if (controller != null) {
              await controller!.stop();
              controller!.dispose();
              controller = null;
            }
          } catch (_) {}
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              tooltip: l10n.tooltipBack,
              onPressed: _handleBack,
            ),
            title: Text(l10n.titleAirQrReceiver),
            elevation: 0,
            backgroundColor: Colors.black87,
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  setState(() {
                    _hasSavedRecord = false;
                  });
                  airQrProvider.resetStream();
                },
                tooltip: l10n.tooltipAirQrResetStream,
              ),
            ],
          ),
          body: Stack(
            children: [
              if (_permissionDenied)
                _buildPermissionMessage(l10n)
              else if (controller != null)
                ScanCameraView(
                  controller: controller!,
                  onDetect: _onDetect,
                  placeholderBuilder: (context) => Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.sensors_outlined,
                          size: 48,
                          color: Colors.cyanAccent,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          l10n.bodyAirQrInitializing,
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  errorBuilder: (context, error) {
                    switch (error) {
                      case ScanCameraError.permissionDenied:
                        return _buildPermissionMessage(l10n);
                      case ScanCameraError.noCamera:
                      case ScanCameraError.failed:
                        return _buildCameraMessage(
                          icon: Icons.no_photography_outlined,
                          message: error == ScanCameraError.noCamera
                              ? l10n.errorCameraNotFound
                              : l10n.errorCameraStartFailed,
                          buttonLabel: l10n.actionCameraRetry,
                          onPressed: () => controller?.start(),
                        );
                    }
                  },
                ),
              // HUD Controls Bar (Top)
              Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.75),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.cyanAccent.withValues(alpha: 0.4),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.sensors,
                            color: Colors.cyanAccent,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${progress.fps.toStringAsFixed(1)} FPS',
                            style: const TextStyle(
                              color: Colors.cyanAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              _isTorchOn ? Icons.flash_on : Icons.flash_off,
                              color: _isTorchOn ? Colors.amber : Colors.white,
                            ),
                            tooltip: l10n.tooltipToggleFlash,
                            onPressed: () async {
                              await controller?.toggleTorch();
                              setState(() => _isTorchOn = !_isTorchOn);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.cameraswitch,
                              color: _isFrontCamera
                                  ? Colors.cyanAccent
                                  : Colors.white,
                            ),
                            tooltip: l10n.tooltipSwitchCamera,
                            onPressed: () async {
                              await controller?.switchCamera();
                              setState(() => _isFrontCamera = !_isFrontCamera);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // HUD Matrix & Progress Panel (Bottom)
              Positioned(
                bottom: 24 + MediaQuery.viewPaddingOf(context).bottom,
                left: 16,
                right: 16,
                child: _buildHudPanel(l10n, progress),
              ),
              // Complete Payload Result Dialog Overlay
              if (progress.status == AirQrStatus.completed &&
                  progress.reassembledContent != null)
                _buildCompletedOverlay(
                  context,
                  l10n,
                  progress.reassembledContent!,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHudPanel(AppLocalizations l10n, AirQrProgress progress) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                progress.status == AirQrStatus.completed
                    ? l10n.bodyAirQrStatusReassembled
                    : progress.status == AirQrStatus.receiving
                    ? l10n.bodyAirQrStatusCapturing
                    : l10n.bodyAirQrStatusIdle,
                style: TextStyle(
                  color: progress.status == AirQrStatus.completed
                      ? Colors.greenAccent
                      : Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                ),
              ),
              Text(
                '${(progress.progressPercentage * 100).toInt()}%',
                style: const TextStyle(
                  color: Colors.cyanAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress.progressPercentage,
              minHeight: 10,
              backgroundColor: Colors.white10,
              valueColor: const AlwaysStoppedAnimation<Color>(
                Colors.cyanAccent,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.bodyAirQrCaptured(
                  progress.receivedBlockCount,
                  progress.totalBlocks,
                ),
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
              Text(
                l10n.bodyAirQrMissing(progress.missingBlockCount),
                style: const TextStyle(color: Colors.amberAccent, fontSize: 13),
              ),
            ],
          ),
          if (progress.totalBlocks > 0) ...[
            const SizedBox(height: 12),
            SizedBox(
              height: 48,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(progress.totalBlocks, (index) {
                    final isCaptured = progress.capturedIndices.contains(index);
                    return Container(
                      width: 14,
                      height: 36,
                      margin: const EdgeInsets.only(right: 4),
                      decoration: BoxDecoration(
                        color: isCaptured ? Colors.cyanAccent : Colors.white10,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCompletedOverlay(
    BuildContext context,
    AppLocalizations l10n,
    String content,
  ) {
    if (_deviceSyncService.isSyncPackage(content)) {
      return _buildSyncRestoreOverlay(context, l10n, content);
    }
    return _buildStandardCompletedOverlay(context, l10n, content);
  }

  Widget _buildSyncRestoreOverlay(
    BuildContext context,
    AppLocalizations l10n,
    String content,
  ) {
    final header = _deviceSyncService.inspectPackageHeader(content);
    final recordsCount = header?['recordsCount'] as int? ?? 0;

    return Container(
      color: Colors.black.withValues(alpha: 0.85),
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(24),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.cyanAccent, width: 2),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(
                  child: Icon(
                    Icons.sync_lock,
                    color: Colors.cyanAccent,
                    size: 56,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  l10n.titleAirQrSyncPackage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.bodyAirQrSyncPackageSummary(recordsCount),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
                const SizedBox(height: 16),
                CheckboxListTile(
                  value: _syncRestoreHistory,
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.labelAirQrSyncRestoreHistory),
                  onChanged: (val) {
                    setState(() => _syncRestoreHistory = val ?? true);
                  },
                ),
                CheckboxListTile(
                  value: _syncApplySettings,
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.labelAirQrSyncApplySettings),
                  onChanged: (val) {
                    setState(() => _syncApplySettings = val ?? true);
                  },
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _syncPassphraseController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: l10n.labelAirQrSyncEnterPassphrase,
                    hintText: l10n.helpAirQrSyncPassphrase,
                    border: const OutlineInputBorder(),
                  ),
                ),
                if (_syncError != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    _syncError!,
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontSize: 13,
                    ),
                  ),
                ],
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _hasSavedRecord = false;
                        });
                        Provider.of<AirQrProvider>(
                          context,
                          listen: false,
                        ).resetStream();
                      },
                      child: Text(l10n.actionCancel),
                    ),
                    ElevatedButton.icon(
                      onPressed: _isSyncing
                          ? null
                          : () => _handleSyncRestore(context, l10n, content),
                      icon: _isSyncing
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.check),
                      label: Text(l10n.actionAirQrSyncDecrypt),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleSyncRestore(
    BuildContext context,
    AppLocalizations l10n,
    String content,
  ) async {
    final passphrase = _syncPassphraseController.text.trim();
    if (passphrase.isEmpty) {
      setState(() => _syncError = l10n.errorExportPassphraseRequired);
      return;
    }

    setState(() {
      _isSyncing = true;
      _syncError = null;
    });

    try {
      final historyProvider = Provider.of<HistoryProvider>(
        context,
        listen: false,
      );
      final syncData = await _deviceSyncService.decryptSyncPackage(
        content,
        passphrase,
      );
      int restoredCount = 0;

      if (_syncRestoreHistory && syncData.records.isNotEmpty) {
        for (final record in syncData.records) {
          await historyProvider.addScanRecord(record);
        }
        await historyProvider.loadRecords();
        restoredCount = syncData.records.length;
      }

      if (_syncApplySettings && syncData.settings.isNotEmpty) {
        final prefs = await SharedPreferences.getInstance();
        await _deviceSyncService.applySettings(syncData.settings, prefs);

        if (context.mounted) {
          final themeProvider = Provider.of<ThemeProvider>(
            context,
            listen: false,
          );
          final localeProvider = Provider.of<LocaleProvider>(
            context,
            listen: false,
          );
          final scanProvider = Provider.of<ScanProvider>(
            context,
            listen: false,
          );

          final themeModeStr =
              syncData.settings[DeviceSyncService.prefThemeModeKey] as String?;
          if (themeModeStr != null) {
            final mode = AppThemeMode.values.firstWhere(
              (e) => e.name == themeModeStr,
              orElse: () => AppThemeMode.system,
            );
            await themeProvider.setThemeMode(mode);
          }

          final dynamicColor =
              syncData.settings[DeviceSyncService.prefUseDynamicColorKey]
                  as bool?;
          if (dynamicColor != null) {
            await themeProvider.setUseDynamicColor(dynamicColor);
          }

          final overlayStr =
              syncData.settings[DeviceSyncService.prefScanOverlayStyleKey]
                  as String?;
          if (overlayStr != null) {
            final style = ScanOverlayStyle.values.firstWhere(
              (e) => e.name == overlayStr,
              orElse: () => ScanOverlayStyle.laserLine,
            );
            await themeProvider.setScanOverlayStyle(style);
          }

          final lang =
              syncData.settings[DeviceSyncService.prefLanguageKey] as String?;
          if (lang != null) {
            await localeProvider.setLanguage(lang);
          }

          final vib =
              syncData.settings[DeviceSyncService.prefVibrationKey] as bool?;
          if (vib != null) scanProvider.setVibrationEnabled(vib);
          final sound =
              syncData.settings[DeviceSyncService.prefSoundKey] as bool?;
          if (sound != null) scanProvider.setSoundEnabled(sound);
        }
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.bodyAirQrSyncSuccess(restoredCount)),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } on BackupException catch (e) {
      if (mounted) {
        setState(() {
          _isSyncing = false;
          _syncError = appMessageText(l10n, e.message);
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isSyncing = false;
          _syncError = e.toString();
        });
      }
    }
  }

  Widget _buildStandardCompletedOverlay(
    BuildContext context,
    AppLocalizations l10n,
    String content,
  ) {
    return Container(
      color: Colors.black.withValues(alpha: 0.85),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.greenAccent, width: 2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: Colors.greenAccent,
                size: 56,
              ),
              const SizedBox(height: 12),
              Text(
                l10n.titleAirQrTransferComplete,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.bodyAirQrTransferComplete,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 180),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      content,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: content));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.bodyAirQrPayloadCopied)),
                      );
                    },
                    icon: const Icon(Icons.copy, size: 18),
                    label: Text(l10n.actionArCopy),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.check),
                    label: Text(l10n.actionDone),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
