import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sreeraj_qr_reader/l10n/gen/app_localizations.dart';
import 'package:sreeraj_qr_reader/models/camera_settings.dart';
import 'package:sreeraj_qr_reader/providers/camera_settings_provider.dart';

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
            bottom: MediaQuery.of(context).viewInsets.bottom + 24.0,
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

              // Header title and reset button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.tune, color: theme.colorScheme.primary),
                      const SizedBox(width: 10),
                      Text(
                        l10n.cameraTuneTitle,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  TextButton.icon(
                    onPressed: () => provider.resetAdjustments(),
                    icon: const Icon(Icons.refresh, size: 18),
                    label: Text(l10n.cameraResetAdjustments),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Brightness Slider
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.brightness_medium, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        l10n.cameraBrightnessLabel,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
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
              ),

              // Contrast Slider
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.contrast, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        l10n.cameraContrastLabel,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
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
              ),

              const Divider(height: 24),

              // Inverted Colors Toggle
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                secondary: const Icon(Icons.invert_colors),
                title: Text(
                  l10n.cameraInvertLabel,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  l10n.cameraInvertHint,
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
                l10n.cameraResolutionLabel,
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
                    tooltip: l10n.cameraResolutionFullHd,
                  ),
                  ButtonSegment(
                    value: CameraResolutionPreset.max,
                    label: const Text(
                      '4K Max',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    tooltip: l10n.cameraResolutionMax,
                  ),
                  ButtonSegment(
                    value: CameraResolutionPreset.hd,
                    label: const Text(
                      '720p',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    tooltip: l10n.cameraResolutionHd,
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
                  l10n.cameraDistanceEnhanceLabel,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  l10n.cameraDistanceEnhanceHint,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                value: provider.isDistanceEnhanceMode,
                onChanged: (val) async {
                  await provider.setDistanceEnhanceMode(val);
                  onResolutionChanged?.call();
                },
              ),

              if (provider.isDistanceEnhanceMode) ...[
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.cameraUnsharpLabel,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
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
            ],
          ),
        );
      },
    );
  }
}
