import 'package:material_ui/material_ui.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';

/// One feature item displayed on the Features screen.
class _AppFeature {
  final String title;
  final String description;
  final IconData icon;
  final List<String> highlights;

  const _AppFeature({
    required this.title,
    required this.description,
    required this.icon,
    required this.highlights,
  });
}

/// A category grouping related features.
class _FeatureCategory {
  final String name;
  final String subtitle;
  final IconData icon;
  final List<_AppFeature> features;

  const _FeatureCategory({
    required this.name,
    required this.subtitle,
    required this.icon,
    required this.features,
  });
}

/// Lists all features of SreerajP QR Studio, grouped by category with visual cards.
class FeaturesScreen extends StatelessWidget {
  const FeaturesScreen({super.key});

  /// Builds the feature list from localized strings.
  static List<_FeatureCategory> _buildCategories(AppLocalizations l10n) {
    return [
      _FeatureCategory(
        name: l10n.titleFeaturesCatScanning,
        subtitle: l10n.descFeaturesCatScanning,
        icon: Icons.qr_code_scanner,
        features: [
          _AppFeature(
            title: l10n.titleFeatureBarcodeEngine,
            description: l10n.descFeatureBarcodeEngine,
            icon: Icons.document_scanner_outlined,
            highlights: [
              l10n.labelFeatureBarcodeEngineChip1,
              l10n.labelFeatureBarcodeEngineChip2,
              l10n.labelFeatureBarcodeEngineChip3,
            ],
          ),
          _AppFeature(
            title: l10n.titleFeatureMediaSources,
            description: l10n.descFeatureMediaSources,
            icon: Icons.photo_library_outlined,
            highlights: [
              l10n.labelFeatureMediaSourcesChip1,
              l10n.labelFeatureMediaSourcesChip2,
              l10n.labelFeatureMediaSourcesChip3,
            ],
          ),
          _AppFeature(
            title: l10n.titleFeatureGhostScan,
            description: l10n.descFeatureGhostScan,
            icon: Icons.screenshot_monitor,
            highlights: [
              l10n.labelFeatureGhostScanChip1,
              l10n.labelFeatureGhostScanChip2,
              l10n.labelFeatureGhostScanChip3,
            ],
          ),
          _AppFeature(
            title: l10n.titleFeatureCameraControls,
            description: l10n.descFeatureCameraControls,
            icon: Icons.camera_alt_outlined,
            highlights: [
              l10n.labelFeatureCameraControlsChip1,
              l10n.labelFeatureCameraControlsChip2,
              l10n.labelFeatureCameraControlsChip3,
            ],
          ),
          _AppFeature(
            title: l10n.titleFeatureScanOverlays,
            description: l10n.descFeatureScanOverlays,
            icon: Icons.layers_outlined,
            highlights: [
              l10n.labelFeatureScanOverlaysChip1,
              l10n.labelFeatureScanOverlaysChip2,
              l10n.labelFeatureScanOverlaysChip3,
            ],
          ),
          _AppFeature(
            title: l10n.titleFeatureFeedback,
            description: l10n.descFeatureFeedback,
            icon: Icons.vibration,
            highlights: [
              l10n.labelFeatureFeedbackChip1,
              l10n.labelFeatureFeedbackChip2,
              l10n.labelFeatureFeedbackChip3,
            ],
          ),
        ],
      ),
      _FeatureCategory(
        name: l10n.titleFeaturesCatSafety,
        subtitle: l10n.descFeaturesCatSafety,
        icon: Icons.security_outlined,
        features: [
          _AppFeature(
            title: l10n.titleFeatureProtocolGuard,
            description: l10n.descFeatureProtocolGuard,
            icon: Icons.lock_outline,
            highlights: [
              l10n.labelFeatureProtocolGuardChip1,
              l10n.labelFeatureProtocolGuardChip2,
              l10n.labelFeatureProtocolGuardChip3,
            ],
          ),
          _AppFeature(
            title: l10n.titleFeatureHomographShield,
            description: l10n.descFeatureHomographShield,
            icon: Icons.spellcheck,
            highlights: [
              l10n.labelFeatureHomographShieldChip1,
              l10n.labelFeatureHomographShieldChip2,
              l10n.labelFeatureHomographShieldChip3,
            ],
          ),
          _AppFeature(
            title: l10n.titleFeatureTldEntropy,
            description: l10n.descFeatureTldEntropy,
            icon: Icons.dns_outlined,
            highlights: [
              l10n.labelFeatureTldEntropyChip1,
              l10n.labelFeatureTldEntropyChip2,
              l10n.labelFeatureTldEntropyChip3,
            ],
          ),
          _AppFeature(
            title: l10n.titleFeatureIpPort,
            description: l10n.descFeatureIpPort,
            icon: Icons.router_outlined,
            highlights: [
              l10n.labelFeatureIpPortChip1,
              l10n.labelFeatureIpPortChip2,
              l10n.labelFeatureIpPortChip3,
            ],
          ),
          _AppFeature(
            title: l10n.titleFeatureHeadProbe,
            description: l10n.descFeatureHeadProbe,
            icon: Icons.travel_explore,
            highlights: [
              l10n.labelFeatureHeadProbeChip1,
              l10n.labelFeatureHeadProbeChip2,
              l10n.labelFeatureHeadProbeChip3,
            ],
          ),
          _AppFeature(
            title: l10n.titleFeatureSafeBrowsing,
            description: l10n.descFeatureSafeBrowsing,
            icon: Icons.shield_outlined,
            highlights: [
              l10n.labelFeatureSafeBrowsingChip1,
              l10n.labelFeatureSafeBrowsingChip2,
              l10n.labelFeatureSafeBrowsingChip3,
            ],
          ),
        ],
      ),
      _FeatureCategory(
        name: l10n.titleFeaturesCatVision,
        subtitle: l10n.descFeaturesCatVision,
        icon: Icons.remove_red_eye_outlined,
        features: [
          _AppFeature(
            title: l10n.titleFeatureQuishingGuard,
            description: l10n.descFeatureQuishingGuard,
            icon: Icons.policy_outlined,
            highlights: [
              l10n.labelFeatureQuishingGuardChip1,
              l10n.labelFeatureQuishingGuardChip2,
              l10n.labelFeatureQuishingGuardChip3,
            ],
          ),
          _AppFeature(
            title: l10n.titleFeatureArCodeVision,
            description: l10n.descFeatureArCodeVision,
            icon: Icons.view_in_ar_outlined,
            highlights: [
              l10n.labelFeatureArCodeVisionChip1,
              l10n.labelFeatureArCodeVisionChip2,
              l10n.labelFeatureArCodeVisionChip3,
            ],
          ),
          _AppFeature(
            title: l10n.titleFeatureAirQr,
            description: l10n.descFeatureAirQr,
            icon: Icons.stream,
            highlights: [
              l10n.labelFeatureAirQrChip1,
              l10n.labelFeatureAirQrChip2,
              l10n.labelFeatureAirQrChip3,
            ],
          ),
          _AppFeature(
            title: l10n.titleFeatureStegoQr,
            description: l10n.descFeatureStegoQr,
            icon: Icons.vpn_key_outlined,
            highlights: [
              l10n.labelFeatureStegoQrChip1,
              l10n.labelFeatureStegoQrChip2,
              l10n.labelFeatureStegoQrChip3,
            ],
          ),
        ],
      ),
      _FeatureCategory(
        name: l10n.titleFeaturesCatPayloads,
        subtitle: l10n.descFeaturesCatPayloads,
        icon: Icons.touch_app_outlined,
        features: [
          _AppFeature(
            title: l10n.titleFeatureWifi,
            description: l10n.descFeatureWifi,
            icon: Icons.wifi,
            highlights: [
              l10n.labelFeatureWifiChip1,
              l10n.labelFeatureWifiChip2,
              l10n.labelFeatureWifiChip3,
            ],
          ),
          _AppFeature(
            title: l10n.titleFeaturePayments,
            description: l10n.descFeaturePayments,
            icon: Icons.payment_outlined,
            highlights: [
              l10n.labelFeaturePaymentsChip1,
              l10n.labelFeaturePaymentsChip2,
              l10n.labelFeaturePaymentsChip3,
            ],
          ),
          _AppFeature(
            title: l10n.titleFeatureTotp,
            description: l10n.descFeatureTotp,
            icon: Icons.timer_outlined,
            highlights: [
              l10n.labelFeatureTotpChip1,
              l10n.labelFeatureTotpChip2,
              l10n.labelFeatureTotpChip3,
            ],
          ),
          _AppFeature(
            title: l10n.titleFeatureContacts,
            description: l10n.descFeatureContacts,
            icon: Icons.contact_phone_outlined,
            highlights: [
              l10n.labelFeatureContactsChip1,
              l10n.labelFeatureContactsChip2,
              l10n.labelFeatureContactsChip3,
            ],
          ),
          _AppFeature(
            title: l10n.titleFeatureCalendar,
            description: l10n.descFeatureCalendar,
            icon: Icons.event_outlined,
            highlights: [
              l10n.labelFeatureCalendarChip1,
              l10n.labelFeatureCalendarChip2,
              l10n.labelFeatureCalendarChip3,
            ],
          ),
          _AppFeature(
            title: l10n.titleFeatureGeo,
            description: l10n.descFeatureGeo,
            icon: Icons.location_on_outlined,
            highlights: [
              l10n.labelFeatureGeoChip1,
              l10n.labelFeatureGeoChip2,
              l10n.labelFeatureGeoChip3,
            ],
          ),
        ],
      ),
      _FeatureCategory(
        name: l10n.titleFeaturesCatHistory,
        subtitle: l10n.descFeaturesCatHistory,
        icon: Icons.history_edu_outlined,
        features: [
          _AppFeature(
            title: l10n.titleFeatureScanHistory,
            description: l10n.descFeatureScanHistory,
            icon: Icons.history,
            highlights: [
              l10n.labelFeatureScanHistoryChip1,
              l10n.labelFeatureScanHistoryChip2,
              l10n.labelFeatureScanHistoryChip3,
            ],
          ),
          _AppFeature(
            title: l10n.titleFeatureBackups,
            description: l10n.descFeatureBackups,
            icon: Icons.import_export,
            highlights: [
              l10n.labelFeatureBackupsChip1,
              l10n.labelFeatureBackupsChip2,
              l10n.labelFeatureBackupsChip3,
            ],
          ),
          _AppFeature(
            title: l10n.titleFeatureBiometricGuard,
            description: l10n.descFeatureBiometricGuard,
            icon: Icons.fingerprint,
            highlights: [
              l10n.labelFeatureBiometricGuardChip1,
              l10n.labelFeatureBiometricGuardChip2,
              l10n.labelFeatureBiometricGuardChip3,
            ],
          ),
          _AppFeature(
            title: l10n.titleFeatureOfflinePrivacy,
            description: l10n.descFeatureOfflinePrivacy,
            icon: Icons.lock_person_outlined,
            highlights: [
              l10n.labelFeatureOfflinePrivacyChip1,
              l10n.labelFeatureOfflinePrivacyChip2,
              l10n.labelFeatureOfflinePrivacyChip3,
            ],
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final categories = _buildCategories(l10n);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.titleSettingsFeatures)),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          children: [
            _buildHeaderCard(context, l10n),
            const SizedBox(height: 20),
            for (final category in categories) ...[
              _buildCategoryHeader(context, category),
              const SizedBox(height: 10),
              _buildCategoryCard(context, category),
              const SizedBox(height: 24),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              primary.withValues(alpha: 0.14),
              theme.colorScheme.secondary.withValues(alpha: 0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primary, primary.withValues(alpha: 0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: primary.withValues(alpha: 0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Icon(
                Icons.stars_rounded,
                color: Colors.white,
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.titleFeaturesHeader,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.descFeaturesHeader,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryHeader(BuildContext context, _FeatureCategory category) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(category.icon, size: 18, color: primary),
              const SizedBox(width: 8),
              Text(
                category.name.toUpperCase(),
                style: theme.textTheme.labelLarge?.copyWith(
                  color: primary,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            category.subtitle,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, _FeatureCategory category) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          for (var i = 0; i < category.features.length; i++) ...[
            if (i > 0)
              Divider(
                height: 1,
                indent: 16,
                endIndent: 16,
                color: theme.dividerColor.withValues(alpha: 0.4),
              ),
            _buildFeatureTile(context, category.features[i]),
          ],
        ],
      ),
    );
  }

  Widget _buildFeatureTile(BuildContext context, _AppFeature feature) {
    final theme = Theme.of(context);
    final accent = theme.colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(feature.icon, color: accent, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feature.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  feature.description,
                  style: TextStyle(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontSize: 13,
                    height: 1.35,
                  ),
                ),
                if (feature.highlights.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: feature.highlights.map((h) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: accent.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: accent.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Text(
                          h,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: accent,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
