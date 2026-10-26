import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sreerajp_qr_studio/core/logging/app_logger.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/providers/ar_codevision_provider.dart';
import 'package:sreerajp_qr_studio/services/ar_spatial_service.dart';
import 'package:sreerajp_qr_studio/screens/widgets/ar_action_sheet.dart';
import 'package:sreerajp_qr_studio/screens/widgets/ar_floating_chip_widget.dart';
import 'package:sreerajp_qr_studio/services/scan_camera/scan_camera_controller.dart';
import 'package:sreerajp_qr_studio/screens/widgets/scan_camera_view.dart';

/// AR CodeVision Spatial Multi-Target Camera HUD Screen.
class ArCodevisionScreen extends StatefulWidget {
  const ArCodevisionScreen({super.key});

  @override
  State<ArCodevisionScreen> createState() => _ArCodevisionScreenState();
}

class _ArCodevisionScreenState extends State<ArCodevisionScreen>
    with WidgetsBindingObserver {
  ScanCameraController? _controller;
  bool _hasPermission = false;
  bool _isInitialized = false;
  bool _isTorchOn = false;
  final ArSpatialService _spatialService = ArSpatialService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeScanner();
  }

  Future<void> _initializeScanner() async {
    final status = await Permission.camera.request();
    if (status.isGranted && mounted) {
      setState(() {
        _hasPermission = true;
        _controller = ScanCameraController(
          cameraResolution: const Size(1920, 1080),
        );
        _isInitialized = true;
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_controller == null || !_controller!.value.isInitialized) return;
    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        try {
          if (_controller!.value.isRunning) {
            _controller?.stop();
          }
        } catch (_) {}
        break;
      case AppLifecycleState.resumed:
        try {
          if (!_controller!.value.isRunning) {
            _controller?.start();
          }
        } catch (_) {}
        break;
      case AppLifecycleState.inactive:
        break;
    }
  }

  Future<void> _toggleTorch() async {
    try {
      await _controller?.toggleTorch();
      setState(() {
        _isTorchOn = !_isTorchOn;
      });
    } catch (e, st) {
      AppLogger.error('Error toggling torch', error: e, stackTrace: st);
    }
  }

  Future<void> _handleBack() async {
    try {
      if (_controller != null) {
        await _controller!.stop();
        _controller!.dispose();
        _controller = null;
      }
    } catch (_) {}
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final arProvider = Provider.of<ArCodevisionProvider>(context);

    return PopScope(
      onPopInvokedWithResult: (didPop, result) async {
        try {
          if (_controller != null) {
            await _controller!.stop();
            _controller!.dispose();
            _controller = null;
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
          title: Row(
            children: [
              const Icon(Icons.view_in_ar),
              const SizedBox(width: 8),
              Text(l10n.titleArScreen),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: SizedBox(
                width: double.infinity,
                child: SegmentedButton<ArHudMode>(
                  segments: [
                    ButtonSegment(
                      value: ArHudMode.warehouse,
                      icon: const Icon(Icons.inventory_2_outlined),
                      label: Text(l10n.labelArModeWarehouse),
                      tooltip: l10n.tooltipArModeWarehouse,
                    ),
                    ButtonSegment(
                      value: ArHudMode.safety,
                      icon: const Icon(Icons.shield_outlined),
                      label: Text(l10n.labelArModeSafety),
                      tooltip: l10n.tooltipArModeSafety,
                    ),
                  ],
                  selected: {arProvider.hudMode},
                  showSelectedIcon: false,
                  onSelectionChanged: (selection) =>
                      arProvider.setHudMode(selection.first),
                ),
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                _isTorchOn ? Icons.flash_on : Icons.flash_off,
                color: _isTorchOn ? Colors.amber : null,
              ),
              onPressed: _toggleTorch,
              tooltip: l10n.tooltipToggleFlashlight,
            ),
          ],
        ),
        body: _hasPermission && _isInitialized && _controller != null
            ? LayoutBuilder(
                builder: (context, constraints) {
                  final screenSize = Size(
                    constraints.maxWidth,
                    constraints.maxHeight,
                  );

                  return Stack(
                    children: [
                      // Live MobileScanner Viewport
                      ScanCameraView(
                        controller: _controller!,
                        onDetect: (capture) {
                          arProvider.processBarcodeCapture(capture);
                        },
                        errorBuilder: (context, error) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.view_in_ar_outlined,
                                  size: 48,
                                  color: Colors.cyanAccent,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  l10n.bodyArInitializing,
                                  style: const TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      // Spatial Overlay Layer — Floating M3 Chips
                      ...arProvider.targets.map((target) {
                        // Estimate image frame size from scanner ratio
                        const imageSize = Size(720, 1280);
                        final frameCenter = _spatialService
                            .calculateTargetCenter(
                              target.corners,
                              target.boundingBox,
                            );
                        final screenPosition = _spatialService
                            .convertFrameToScreenOffset(
                              framePoint: frameCenter,
                              imageSize: imageSize,
                              screenSize: screenSize,
                            );

                        return ArFloatingChipWidget(
                          key: ValueKey(target.id),
                          target: target,
                          position: screenPosition,
                          hudMode: arProvider.hudMode,
                          onTap: () {
                            arProvider.selectTargetForSheet(target);
                          },
                          onSelectionChanged: (val) {
                            arProvider.toggleTargetSelection(target.id);
                          },
                        );
                      }),

                      // Expanded Action Sheet overlay for tapped item
                      if (arProvider.sheetTarget != null)
                        ArActionSheet(
                          target: arProvider.sheetTarget!,
                          onClose: () {
                            arProvider.clearSheetTarget();
                          },
                        ),

                      // Warehouse Batch Selection Footer
                      if (arProvider.hudMode == ArHudMode.warehouse &&
                          arProvider.selectedCount > 0)
                        Positioned(
                          bottom: 16 + MediaQuery.viewPaddingOf(context).bottom,
                          left: 16,
                          right: 16,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surface,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: theme.colorScheme.outlineVariant,
                              ),
                              boxShadow: const [
                                BoxShadow(color: Colors.black38, blurRadius: 8),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  l10n.bodyArItemsSelected(
                                    arProvider.selectedCount,
                                  ),
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        arProvider.clearSelection();
                                      },
                                      child: Text(l10n.actionArClearSelection),
                                    ),
                                    const SizedBox(width: 8),
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        final selectedValues = arProvider
                                            .targets
                                            .where((t) => t.isSelected)
                                            .map((t) => t.rawValue)
                                            .join('\n');
                                        Clipboard.setData(
                                          ClipboardData(text: selectedValues),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  l10n.bodyArBatchCopied(
                                                    arProvider.selectedCount,
                                                  ),
                                                ),
                                              ),
                                            );
                                      },
                                      icon: const Icon(Icons.copy, size: 18),
                                      label: Text(l10n.actionArBatchCopy),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  );
                },
              )
            : _buildPermissionDeniedState(),
      ),
    );
  }

  Widget _buildPermissionDeniedState() {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.camera_alt, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            l10n.bodyArCameraPermission,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: _initializeScanner,
            child: Text(l10n.actionGrantCameraPermission),
          ),
        ],
      ),
    );
  }
}
