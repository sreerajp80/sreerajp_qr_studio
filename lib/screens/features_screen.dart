import 'package:flutter/material.dart';
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
        name: l10n.featuresCatScanningName,
        subtitle: l10n.featuresCatScanningSubtitle,
        icon: Icons.qr_code_scanner,
        features: [
          _AppFeature(
            title: l10n.featureBarcodeEngineTitle,
            description: l10n.featureBarcodeEngineDesc,
            icon: Icons.document_scanner_outlined,
            highlights: [
              l10n.featureBarcodeEngineChip1,
              l10n.featureBarcodeEngineChip2,
              l10n.featureBarcodeEngineChip3,
            ],
          ),
          _AppFeature(
            title: l10n.featureMediaSourcesTitle,
            description: l10n.featureMediaSourcesDesc,
            icon: Icons.photo_library_outlined,
            highlights: [
              l10n.featureMediaSourcesChip1,
              l10n.featureMediaSourcesChip2,
              l10n.featureMediaSourcesChip3,
            ],
          ),
          _AppFeature(
            title: l10n.featureGhostScanTitle,
            description: l10n.featureGhostScanDesc,
            icon: Icons.screenshot_monitor,
            highlights: [
              l10n.featureGhostScanChip1,
              l10n.featureGhostScanChip2,
              l10n.featureGhostScanChip3,
            ],
          ),
          _AppFeature(
            title: l10n.featureCameraControlsTitle,
            description: l10n.featureCameraControlsDesc,
            icon: Icons.camera_alt_outlined,
            highlights: [
              l10n.featureCameraControlsChip1,
              l10n.featureCameraControlsChip2,
              l10n.featureCameraControlsChip3,
            ],
          ),
          _AppFeature(
            title: l10n.featureScanOverlaysTitle,
            description: l10n.featureScanOverlaysDesc,
            icon: Icons.layers_outlined,
            highlights: [
              l10n.featureScanOverlaysChip1,
              l10n.featureScanOverlaysChip2,
              l10n.featureScanOverlaysChip3,
            ],
          ),
          _AppFeature(
            title: l10n.featureFeedbackTitle,
            description: l10n.featureFeedbackDesc,
            icon: Icons.vibration,
            highlights: [
              l10n.featureFeedbackChip1,
              l10n.featureFeedbackChip2,
              l10n.featureFeedbackChip3,
            ],
          ),
        ],
      ),
      _FeatureCategory(
        name: l10n.featuresCatSafetyName,
        subtitle: l10n.featuresCatSafetySubtitle,
        icon: Icons.security_outlined,
        features: [
          _AppFeature(
            title: l10n.featureProtocolGuardTitle,
            description: l10n.featureProtocolGuardDesc,
            icon: Icons.lock_outline,
            highlights: [
              l10n.featureProtocolGuardChip1,
              l10n.featureProtocolGuardChip2,
              l10n.featureProtocolGuardChip3,
            ],
          ),
          _AppFeature(
            title: l10n.featureHomographShieldTitle,
            description: l10n.featureHomographShieldDesc,
            icon: Icons.spellcheck,
            highlights: [
              l10n.featureHomographShieldChip1,
              l10n.featureHomographShieldChip2,
              l10n.featureHomographShieldChip3,
            ],
          ),
          _AppFeature(
            title: l10n.featureTldEntropyTitle,
            description: l10n.featureTldEntropyDesc,
            icon: Icons.dns_outlined,
            highlights: [
              l10n.featureTldEntropyChip1,
              l10n.featureTldEntropyChip2,
              l10n.featureTldEntropyChip3,
            ],
          ),
          _AppFeature(
            title: l10n.featureIpPortTitle,
            description: l10n.featureIpPortDesc,
            icon: Icons.router_outlined,
            highlights: [
              l10n.featureIpPortChip1,
              l10n.featureIpPortChip2,
              l10n.featureIpPortChip3,
            ],
          ),
          _AppFeature(
            title: l10n.featureHeadProbeTitle,
            description: l10n.featureHeadProbeDesc,
            icon: Icons.travel_explore,
            highlights: [
              l10n.featureHeadProbeChip1,
              l10n.featureHeadProbeChip2,
              l10n.featureHeadProbeChip3,
            ],
          ),
          _AppFeature(
            title: l10n.featureSafeBrowsingTitle,
            description: l10n.featureSafeBrowsingDesc,
            icon: Icons.shield_outlined,
            highlights: [
              l10n.featureSafeBrowsingChip1,
              l10n.featureSafeBrowsingChip2,
              l10n.featureSafeBrowsingChip3,
            ],
          ),
        ],
      ),
      _FeatureCategory(
        name: l10n.featuresCatVisionName,
        subtitle: l10n.featuresCatVisionSubtitle,
        icon: Icons.remove_red_eye_outlined,
        features: [
          _AppFeature(
            title: l10n.featureQuishingGuardTitle,
            description: l10n.featureQuishingGuardDesc,
            icon: Icons.policy_outlined,
            highlights: [
              l10n.featureQuishingGuardChip1,
              l10n.featureQuishingGuardChip2,
              l10n.featureQuishingGuardChip3,
            ],
          ),
          _AppFeature(
            title: l10n.featureArCodeVisionTitle,
            description: l10n.featureArCodeVisionDesc,
            icon: Icons.view_in_ar_outlined,
            highlights: [
              l10n.featureArCodeVisionChip1,
              l10n.featureArCodeVisionChip2,
              l10n.featureArCodeVisionChip3,
            ],
          ),
          _AppFeature(
            title: l10n.featureAirQrTitle,
            description: l10n.featureAirQrDesc,
            icon: Icons.stream,
            highlights: [
              l10n.featureAirQrChip1,
              l10n.featureAirQrChip2,
              l10n.featureAirQrChip3,
            ],
          ),
          _AppFeature(
            title: l10n.featureStegoQrTitle,
            description: l10n.featureStegoQrDesc,
            icon: Icons.vpn_key_outlined,
            highlights: [
              l10n.featureStegoQrChip1,
              l10n.featureStegoQrChip2,
              l10n.featureStegoQrChip3,
            ],
          ),
        ],
      ),
      _FeatureCategory(
        name: l10n.featuresCatPayloadsName,
        subtitle: l10n.featuresCatPayloadsSubtitle,
        icon: Icons.touch_app_outlined,
        features: [
          _AppFeature(
            title: l10n.featureWifiTitle,
            description: l10n.featureWifiDesc,
            icon: Icons.wifi,
            highlights: [
              l10n.featureWifiChip1,
              l10n.featureWifiChip2,
              l10n.featureWifiChip3,
            ],
          ),
          _AppFeature(
            title: l10n.featurePaymentsTitle,
            description: l10n.featurePaymentsDesc,
            icon: Icons.payment_outlined,
            highlights: [
              l10n.featurePaymentsChip1,
              l10n.featurePaymentsChip2,
              l10n.featurePaymentsChip3,
            ],
          ),
          _AppFeature(
            title: l10n.featureTotpTitle,
            description: l10n.featureTotpDesc,
            icon: Icons.timer_outlined,
            highlights: [
              l10n.featureTotpChip1,
              l10n.featureTotpChip2,
              l10n.featureTotpChip3,
            ],
          ),
          _AppFeature(
            title: l10n.featureContactsTitle,
            description: l10n.featureContactsDesc,
            icon: Icons.contact_phone_outlined,
            highlights: [
              l10n.featureContactsChip1,
              l10n.featureContactsChip2,
              l10n.featureContactsChip3,
            ],
          ),
          _AppFeature(
            title: l10n.featureCalendarTitle,
            description: l10n.featureCalendarDesc,
            icon: Icons.event_outlined,
            highlights: [
              l10n.featureCalendarChip1,
              l10n.featureCalendarChip2,
              l10n.featureCalendarChip3,
            ],
          ),
          _AppFeature(
            title: l10n.featureGeoTitle,
            description: l10n.featureGeoDesc,
            icon: Icons.location_on_outlined,
            highlights: [
              l10n.featureGeoChip1,
              l10n.featureGeoChip2,
              l10n.featureGeoChip3,
            ],
          ),
        ],
      ),
      _FeatureCategory(
        name: l10n.featuresCatHistoryName,
        subtitle: l10n.featuresCatHistorySubtitle,
        icon: Icons.history_edu_outlined,
        features: [
          _AppFeature(
            title: l10n.featureScanHistoryTitle,
            description: l10n.featureScanHistoryDesc,
            icon: Icons.history,
            highlights: [
              l10n.featureScanHistoryChip1,
              l10n.featureScanHistoryChip2,
              l10n.featureScanHistoryChip3,
            ],
          ),
          _AppFeature(
            title: l10n.featureBackupsTitle,
            description: l10n.featureBackupsDesc,
            icon: Icons.import_export,
            highlights: [
              l10n.featureBackupsChip1,
              l10n.featureBackupsChip2,
              l10n.featureBackupsChip3,
            ],
          ),
          _AppFeature(
            title: l10n.featureBiometricGuardTitle,
            description: l10n.featureBiometricGuardDesc,
            icon: Icons.fingerprint,
            highlights: [
              l10n.featureBiometricGuardChip1,
              l10n.featureBiometricGuardChip2,
              l10n.featureBiometricGuardChip3,
            ],
          ),
          _AppFeature(
            title: l10n.featureOfflinePrivacyTitle,
            description: l10n.featureOfflinePrivacyDesc,
            icon: Icons.lock_person_outlined,
            highlights: [
              l10n.featureOfflinePrivacyChip1,
              l10n.featureOfflinePrivacyChip2,
              l10n.featureOfflinePrivacyChip3,
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
      appBar: AppBar(title: Text(l10n.settingsFeaturesTitle)),
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
                    l10n.featuresHeaderTitle,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.featuresHeaderSubtitle,
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
