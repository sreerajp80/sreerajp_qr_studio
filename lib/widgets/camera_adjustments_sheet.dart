import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/models/camera_settings.dart';
import 'package:sreerajp_qr_studio/providers/camera_settings_provider.dart';

/// Modal bottom sheet providing sliders and toggles for camera tuning.
class CameraAdjustmentsSheet extends StatelessWidget {
  final VoidCallback? onResolutionChanged;

  const CameraAdjustmentsSheet({super.key, this.onResolutionChanged});

  static Future<void> show(
    BuildContext context, {
    VoidCallback? onResolutionChanged,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      builder: (context) =>
          CameraAdjustmentsSheet(onResolutionChanged: onResolutionChanged),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Consumer<CameraSettingsProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: EdgeInsets.only(
            left: 24.0,
            right: 24.0,
            top: 16.0,
            bottom:
                MediaQuery.of(context).viewInsets.bottom +
                MediaQuery.of(context).viewPadding.bottom +
                24.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Drag handle
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSurfaceVariant.withValues(
                      alpha: 0.4,
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // Header title and reset button. They share one line when
              // there is room; otherwise Reset moves under the title, so
              // nothing runs off the screen in any language or text size.
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                runSpacing: 4,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.tune, color: theme.colorScheme.primary),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          l10n.titleCameraTune,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextButton.icon(
                    onPressed: () => provider.resetAdjustments(),
                    icon: const Icon(Icons.refresh, size: 18),
                    label: Text(
                      l10n.actionCameraReset,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Brightness Slider
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // The label shrinks so the value always fits.
                  Expanded(
                    child: Row(
                      children: [
                        const Icon(Icons.brightness_medium, size: 20),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            l10n.labelCameraBrightness,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${(provider.brightness * 100).round() > 0 ? '+' : ''}${(provider.brightness * 100).round()}%',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Slider(
                value: provider.brightness,
                min: -1.0,
                divisions: 40,
                label: '${(provider.brightness * 100).round()}%',
                onChanged: (val) => provider.setBrightness(val),
                onChangeEnd: (_) => provider.saveImageAdjustments(),
              ),

              // Contrast Slider
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const Icon(Icons.contrast, size: 20),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            l10n.labelCameraContrast,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${provider.contrast.toStringAsFixed(1)}x',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Slider(
                value: provider.contrast,
                min: 0.5,
                max: 2.5,
                divisions: 40,
                label: '${provider.contrast.toStringAsFixed(1)}x',
                onChanged: (val) => provider.setContrast(val),
                onChangeEnd: (_) => provider.saveImageAdjustments(),
              ),

              const Divider(height: 24),

              // Inverted Colors Toggle
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                secondary: const Icon(Icons.invert_colors),
                title: Text(
                  l10n.labelCameraInvert,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  l10n.descCameraInvert,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                value: provider.invertColors,
                onChanged: (val) {
                  provider.setInvertColors(val);
                },
              ),

              const Divider(height: 24),

              // Resolution Preset Selector
              Text(
                l10n.labelCameraResolution,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              SegmentedButton<CameraResolutionPreset>(
                segments: [
                  ButtonSegment(
                    value: CameraResolutionPreset.fullHd,
                    label: const Text(
                      '1080p',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    tooltip: l10n.tooltipCameraResolutionFullHd,
                  ),
                  ButtonSegment(
                    value: CameraResolutionPreset.max,
                    label: const Text(
                      '4K Max',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    tooltip: l10n.tooltipCameraResolutionMax,
                  ),
                  ButtonSegment(
                    value: CameraResolutionPreset.hd,
                    label: const Text(
                      '720p',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    tooltip: l10n.tooltipCameraResolutionHd,
                  ),
                ],
                selected: {provider.resolutionPreset},
                onSelectionChanged: (newSet) async {
                  final selected = newSet.first;
                  await provider.setResolutionPreset(selected);
                  onResolutionChanged?.call();
                },
              ),

              const Divider(height: 24),

              // Distance-Enhanced Scanning Section
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                secondary: const Icon(Icons.center_focus_strong),
                title: Text(
                  l10n.labelCameraDistanceEnhance,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  l10n.descCameraDistanceEnhance,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                value: provider.isDistanceEnhanceMode,
                onChanged: (val) => provider.setDistanceEnhanceMode(val),
              ),

              if (provider.isDistanceEnhanceMode) ...[
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        l10n.labelCameraDistanceZoom,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      '${provider.distanceZoomFactor.toStringAsFixed(1)}x',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Slider(
                  value: provider.distanceZoomFactor,
                  min: 1.5,
                  max: 4.0,
                  divisions: 25,
                  label: '${provider.distanceZoomFactor.toStringAsFixed(1)}x',
                  onChanged: (val) => provider.setDistanceZoomFactor(val),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        l10n.labelCameraUnsharp,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      '${provider.unsharpMaskStrength.toStringAsFixed(1)}x',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Slider(
                  value: provider.unsharpMaskStrength,
                  min: 0.5,
                  max: 2.5,
                  divisions: 20,
                  label: '${provider.unsharpMaskStrength.toStringAsFixed(1)}x',
                  onChanged: (val) => provider.setUnsharpMaskStrength(val),
                ),
              ],

              const Divider(height: 24),

              // Multi-Code Tappable Selection Section
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                secondary: const Icon(Icons.qr_code_scanner),
                title: Text(
                  l10n.labelMultiCodeSelection,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  l10n.descMultiCodeSelection,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                value: provider.multiCodeSelectionEnabled,
                onChanged: (val) => provider.setMultiCodeSelectionEnabled(val),
              ),
            ],
          ),
        );
      },
    );
  }
}
