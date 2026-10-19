import 'dart:async';

import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sreerajp_qr_studio/core/logging/app_logger.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/providers/app_lock_provider.dart';
import 'package:sreerajp_qr_studio/providers/history_provider.dart';
import 'package:sreerajp_qr_studio/providers/locale_provider.dart';
import 'package:sreerajp_qr_studio/providers/scan_provider.dart';
import 'package:sreerajp_qr_studio/providers/screen_security_provider.dart';
import 'package:sreerajp_qr_studio/providers/theme_provider.dart';
import 'package:sreerajp_qr_studio/screens/about_screen.dart';
import 'package:sreerajp_qr_studio/screens/appearance_screen.dart';
import 'package:sreerajp_qr_studio/screens/features_screen.dart';
import 'package:sreerajp_qr_studio/screens/help/help_home_screen.dart';
import 'package:sreerajp_qr_studio/screens/onboarding_screen.dart';
import 'package:sreerajp_qr_studio/screens/scan_bubble_settings_screen.dart';
import 'package:sreerajp_qr_studio/services/data_wipe_service.dart';
import 'package:sreerajp_qr_studio/services/url_safety_service.dart';
import 'package:sreerajp_qr_studio/widgets/app_restart_scope.dart';
import 'package:sreerajp_qr_studio/widgets/secure_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _activeProbing = false;
  bool _hasApiKey = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSummary();
  }

  Future<void> _loadSummary() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Count active providers: saved API keys + enabled feed toggles.
      final activeProviders = await UrlSafetyService().countActiveProviders();

      if (mounted) {
        setState(() {
          _activeProbing =
              prefs.getBool(UrlSafetyService.activeProbingPrefKey) ?? false;
          _hasApiKey = activeProviders > 0;
          _isLoading = false;
        });
      }
    } catch (e, st) {
      AppLogger.error(
        'Error loading settings summary',
        error: e,
        stackTrace: st,
      );
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final scanProvider = Provider.of<ScanProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);

    final themeModeName = switch (themeProvider.themeMode) {
      AppThemeMode.system => l10n.labelThemeSystemDefault,
      AppThemeMode.light => l10n.labelThemeLight,
      AppThemeMode.dark => l10n.labelThemeDark,
      AppThemeMode.oled => l10n.labelThemeOled,
    };

    final currentLanguageName = switch (localeProvider.languageCode) {
      'en' => l10n.labelLanguageEnglish,
      'ml' => l10n.labelLanguageMalayalam,
      'sa' => l10n.labelLanguageSanskrit,
      _ => l10n.labelLanguageSystemDefault,
    };

    final feedbackStatus = l10n.descFeedbackSummary(
      scanProvider.isVibrationEnabled ? l10n.labelOn : l10n.labelOff,
      scanProvider.isSoundEnabled ? l10n.labelOn : l10n.labelOff,
    );

    final privacyStatus = _activeProbing
        ? l10n.descPrivacySummaryOn
        : l10n.descPrivacySummaryOff;

    // Count how many providers are active for the subtitle.
    // _hasApiKey is true if at least one provider is configured.
    final activeCount = _hasApiKey ? '1+' : '0';

    return Scaffold(
      appBar: AppBar(title: Text(l10n.titleSettings)),
      body: SafeArea(
        top: false,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                child: Column(
                  children: [
                    _buildSettingsCard(
                      context: context,
                      icon: Icons.palette_outlined,
                      title: l10n.titleAppearanceHub,
                      subtitle: l10n.descSettingsAppearanceSummary(
                        themeModeName,
                      ),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AppearanceScreen(),
                          ),
                        );
                        _loadSummary();
                      },
                    ),
                    _buildSettingsCard(
                      context: context,
                      icon: Icons.language,
                      title: l10n.labelSettingsLanguage,
                      subtitle: currentLanguageName,
                      onTap: () => _showLanguageDialog(context, localeProvider),
                    ),
                    _buildSettingsCard(
                      context: context,
                      icon: Icons.stars_outlined,
                      title: l10n.titleSettingsFeatures,
                      subtitle: l10n.descSettingsFeatures,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FeaturesScreen(),
                          ),
                        );
                      },
                    ),
                    _buildSettingsCard(
                      context: context,
                      icon: Icons.vibration,
                      title: l10n.labelSettingsFeedback,
                      subtitle: feedbackStatus,
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ScanFeedbackSettingsScreen(),
                          ),
                        );
                        _loadSummary();
                      },
                    ),
                    _buildSettingsCard(
                      context: context,
                      icon: Icons.security,
                      title: l10n.labelSettingsPrivacy,
                      subtitle: privacyStatus,
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PrivacySettingsScreen(),
                          ),
                        );
                        _loadSummary();
                      },
                    ),
                    _buildSettingsCard(
                      context: context,
                      icon: Icons.hub_outlined,
                      title: l10n.labelSettingsUrlSafetyProviders,
                      subtitle: l10n.descSettingsUrlSafetyProviders(
                        _hasApiKey ? activeCount : '0',
                      ),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const UrlSafetyProvidersScreen(),
                          ),
                        );
                        _loadSummary();
                      },
                    ),
                    _buildSettingsCard(
                      context: context,
                      icon: Icons.sync_lock,
                      title: l10n.titleAirQrSyncSettings,
                      subtitle: l10n.descAirQrSyncSettings,
                      onTap: () async {
                        await Navigator.pushNamed(
                          context,
                          '/air_qr_transmitter',
                          arguments: {'syncMode': true},
                        );
                        _loadSummary();
                      },
                    ),
                    _buildSettingsCard(
                      context: context,
                      icon: Icons.bubble_chart_outlined,
                      title: l10n.labelScanBubble,
                      subtitle: l10n.descScanBubbleSettings,
                      onTap: () => Navigator.pushNamed(
                        context,
                        ScanBubbleSettingsScreen.routeName,
                      ),
                    ),
                    _buildSettingsCard(
                      context: context,
                      icon: Icons.admin_panel_settings_outlined,
                      title: l10n.labelSettingsPermissions,
                      subtitle: l10n.descSettingsPermissions,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const PermissionsSettingsScreen(),
                          ),
                        );
                      },
                    ),
                    _buildSettingsCard(
                      context: context,
                      icon: Icons.help_outline,
                      title: l10n.labelSettingsHelp,
                      subtitle: l10n.descSettingsHelp,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HelpHomeScreen(),
                          ),
                        );
                      },
                    ),
                    _buildSettingsCard(
                      context: context,
                      icon: Icons.auto_stories_outlined,
                      title: l10n.labelSettingsOnboardingTour,
                      subtitle: l10n.descSettingsOnboardingTour,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const OnboardingScreen(isReplay: true),
                          ),
                        );
                      },
                    ),
                    _buildSettingsCard(
                      context: context,
                      icon: Icons.info_outline,
                      title: l10n.titleAbout,
                      subtitle: l10n.descSettingsAbout,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AboutScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildSettingsCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final accent = theme.colorScheme.primary;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(icon, color: accent, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLanguageDialog(
    BuildContext context,
    LocaleProvider localeProvider,
  ) {
    final l10n = AppLocalizations.of(context);
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(l10n.labelSettingsLanguage),
          content: RadioGroup<String>(
            groupValue: localeProvider.languageCode,
            onChanged: (val) {
              if (val != null) {
                localeProvider.setLanguage(val);
                Navigator.pop(dialogContext);
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<String>(
                  title: Text(l10n.labelLanguageSystemDefault),
                  value: LocaleProvider.systemValue,
                ),
                RadioListTile<String>(
                  title: Text(l10n.labelLanguageEnglish),
                  value: 'en',
                ),
                RadioListTile<String>(
                  title: Text(l10n.labelLanguageMalayalam),
                  value: 'ml',
                ),
                RadioListTile<String>(
                  title: Text(l10n.labelLanguageSanskrit),
                  value: 'sa',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(l10n.actionCancel),
            ),
          ],
        );
      },
    );
  }
}

class ScanFeedbackSettingsScreen extends StatelessWidget {
  const ScanFeedbackSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scanProvider = Provider.of<ScanProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.labelSettingsFeedback)),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Card(
            child: Column(
              children: [
                SwitchListTile(
                  secondary: const Icon(Icons.vibration),
                  title: Text(l10n.labelFeedbackVibration),
                  subtitle: Text(l10n.descFeedbackVibration),
                  value: scanProvider.isVibrationEnabled,
                  onChanged: (val) => scanProvider.setVibrationEnabled(val),
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                SwitchListTile(
                  secondary: const Icon(Icons.volume_up_outlined),
                  title: Text(l10n.labelFeedbackSound),
                  subtitle: Text(l10n.descFeedbackSound),
                  value: scanProvider.isSoundEnabled,
                  onChanged: (val) => scanProvider.setSoundEnabled(val),
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                SwitchListTile(
                  secondary: const Icon(Icons.check_circle_outline_rounded),
                  title: Text(l10n.labelFeedbackAnimation),
                  subtitle: Text(l10n.descFeedbackAnimation),
                  value: scanProvider.isAnimationEnabled,
                  onChanged: (val) => scanProvider.setAnimationEnabled(val),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key, this.dataWipeServiceBuilder});

  /// Builds the service used by "Delete all data". Tests pass a fake; the app
  /// uses the default, which closes the history database first.
  final DataWipeService Function(BuildContext context)? dataWipeServiceBuilder;

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  bool _activeProbing = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPrivacySetting();
  }

  Future<void> _loadPrivacySetting() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (mounted) {
        setState(() {
          _activeProbing =
              prefs.getBool(UrlSafetyService.activeProbingPrefKey) ?? false;
          _isLoading = false;
        });
      }
    } catch (e, st) {
      AppLogger.error(
        'Error loading privacy setting',
        error: e,
        stackTrace: st,
      );
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _setActiveProbing(bool value) async {
    setState(() => _activeProbing = value);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(UrlSafetyService.activeProbingPrefKey, value);
    } catch (e, st) {
      AppLogger.error(
        'Error saving active probing setting',
        error: e,
        stackTrace: st,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.titlePrivacyScreen)),
      body: SafeArea(
        top: false,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      color: isDark
                          ? (_activeProbing
                                    ? Colors.orange[900]!
                                    : Colors.blue[900]!)
                                .withValues(alpha: 0.35)
                          : (_activeProbing
                                ? Colors.orange[50]
                                : Colors.blue[50]),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            SwitchListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              value: _activeProbing,
                              onChanged: _setActiveProbing,
                              title: Text(
                                l10n.labelPrivacyActiveChecks,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(l10n.descPrivacyActiveChecks),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    _activeProbing
                                        ? Icons.warning_amber
                                        : Icons.lock_outline,
                                    size: 20,
                                    color: isDark
                                        ? (_activeProbing
                                              ? Colors.orange[200]
                                              : Colors.blue[200])
                                        : (_activeProbing
                                              ? Colors.orange[700]
                                              : Colors.blue[700]),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      _activeProbing
                                          ? l10n.bodyPrivacyExplainerOn
                                          : l10n.bodyPrivacyExplainerOff,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: isDark
                                            ? (_activeProbing
                                                  ? Colors.orange[200]
                                                  : Colors.blue[200])
                                            : (_activeProbing
                                                  ? Colors.orange[900]
                                                  : Colors.blue[900]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      child: SwitchListTile(
                        secondary: const Icon(Icons.lock_outline),
                        value: context.watch<AppLockProvider>().enabled,
                        onChanged:
                            context.watch<AppLockProvider>().authInProgress
                            ? null
                            : _setAppLock,
                        title: Text(
                          l10n.labelAppLock,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(l10n.descAppLock),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      child: SwitchListTile(
                        secondary: const Icon(Icons.screenshot_monitor),
                        value: context.watch<ScreenSecurityProvider>().enabled,
                        onChanged: context
                            .read<ScreenSecurityProvider>()
                            .setEnabled,
                        title: Text(
                          l10n.labelScreenshotGuard,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(l10n.descScreenshotGuard),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.delete_forever_outlined,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        title: Text(
                          l10n.labelDeleteAllData,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(l10n.descDeleteAllData),
                        onTap: _deleteAllData,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  /// Turns the optional app lock on or off; both need one authentication.
  Future<void> _setAppLock(bool value) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final lock = context.read<AppLockProvider>();
    final result = value
        ? await lock.enable(l10n.bodyAppLockReason)
        : await lock.disable(l10n.bodyAppLockReason);
    if (!mounted) return;
    final message = switch (result) {
      AppLockChange.done => null,
      AppLockChange.unavailable => l10n.errorAppLockUnavailable,
      AppLockChange.failed => l10n.errorAppLockFailed,
    };
    if (message != null) {
      messenger.showSnackBar(SnackBar(content: Text(message)));
    }
  }

  DataWipeService _defaultWipeService(BuildContext context) => DataWipeService(
    closeAndDeleteHistoryDatabase: context
        .read<HistoryProvider>()
        .closeAndDeleteDatabase,
  );

  /// Confirms, deletes every local store, then restarts the app so it opens
  /// like a fresh install (engineering standard §15.4).
  Future<void> _deleteAllData() async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.titleDeleteAllDataConfirm),
        content: Text(l10n.bodyDeleteAllDataConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.actionCancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.actionDeleteAll),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    final service = (widget.dataWipeServiceBuilder ?? _defaultWipeService)(
      context,
    );
    unawaited(
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => PopScope(
          canPop: false,
          child: AlertDialog(
            content: Row(
              children: [
                const CircularProgressIndicator(),
                const SizedBox(width: 16),
                Expanded(child: Text(l10n.bodyDeletingAllData)),
              ],
            ),
          ),
        ),
      ),
    );

    final failed = await service.deleteAll();
    if (!mounted) return;
    Navigator.of(context, rootNavigator: true).pop();
    unawaited(HapticFeedback.heavyImpact());

    if (failed.isNotEmpty && mounted) {
      // Shown before the restart, which would remove a snackbar.
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(l10n.errorDeleteAllDataPartial),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(MaterialLocalizations.of(context).okButtonLabel),
            ),
          ],
        ),
      );
    }
    if (mounted) AppRestartScope.restart(context);
  }
}

class UrlSafetyProvidersScreen extends StatefulWidget {
  const UrlSafetyProvidersScreen({super.key});

  @override
  State<UrlSafetyProvidersScreen> createState() =>
      _UrlSafetyProvidersScreenState();
}

class _UrlSafetyProvidersScreenState extends State<UrlSafetyProvidersScreen> {
  final _urlSafetyService = UrlSafetyService();

  // --- state for each key-based provider ---
  bool _loadingGsb = true;
  bool _hasGsbKey = false;
  int _gsbRequestsToday = 0;

  bool _loadingVt = true;
  bool _hasVtKey = false;
  int _vtRequestsToday = 0;

  bool _loadingUh = true;
  bool _hasUhKey = false;

  // --- state for toggle-based providers ---
  bool _phishTankEnabled = false;
  bool _openPhishEnabled = false;
  String? _openPhishLastUpdated;
  bool _refreshingFeed = false;

  // --- text controllers ---
  final _gsbKeyCtrl = TextEditingController();
  final _vtKeyCtrl = TextEditingController();
  final _vtEndpointCtrl = TextEditingController();
  final _uhKeyCtrl = TextEditingController();
  final _uhEndpointCtrl = TextEditingController();

  bool _gsbObscured = true;
  bool _vtObscured = true;
  bool _uhObscured = true;

  static const int _gsbMaxPerDay = 10000;
  static const int _vtMaxPerDay = 500;

  @override
  void initState() {
    super.initState();
    _loadAll();
  }

  @override
  void dispose() {
    _gsbKeyCtrl.dispose();
    _vtKeyCtrl.dispose();
    _vtEndpointCtrl.dispose();
    _uhKeyCtrl.dispose();
    _uhEndpointCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadAll() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().split('T')[0];

    // GSB
    final hasGsbKey = await _urlSafetyService.hasApiKey(
      UrlSafetyService.safeBrowsingApiKeyStorageKey,
    );
    final gsbLastReset = prefs.getString('safe_browsing_last_reset');
    final gsbCount = gsbLastReset == today
        ? prefs.getInt('safe_browsing_request_count') ?? 0
        : 0;

    // VirusTotal
    final hasVtKey = await _urlSafetyService.hasApiKey(
      UrlSafetyService.virusTotalApiKeyStorageKey,
    );
    final vtLastReset = prefs.getString(UrlSafetyService.vtLastResetKey);
    final vtCount = vtLastReset == today
        ? prefs.getInt(UrlSafetyService.vtRequestCountKey) ?? 0
        : 0;
    final vtEndpoint =
        prefs.getString(UrlSafetyService.vtEndpointPrefKey) ??
        UrlSafetyService.vtDefaultEndpoint;

    // URLhaus
    final hasUhKey = await _urlSafetyService.hasApiKey(
      UrlSafetyService.urlhausApiKeyStorageKey,
    );
    final uhEndpoint =
        prefs.getString(UrlSafetyService.urlhausEndpointPrefKey) ??
        UrlSafetyService.urlhausDefaultEndpoint;

    // Toggles
    final ptEnabled =
        prefs.getBool(UrlSafetyService.phishTankEnabledPrefKey) ?? false;
    final opEnabled =
        prefs.getBool(UrlSafetyService.openPhishEnabledPrefKey) ?? false;
    final opTimestamp = prefs.getString('openphish_feed_timestamp');

    if (mounted) {
      setState(() {
        _hasGsbKey = hasGsbKey;
        _gsbRequestsToday = gsbCount;
        _loadingGsb = false;

        _hasVtKey = hasVtKey;
        _vtRequestsToday = vtCount;
        _vtEndpointCtrl.text = vtEndpoint;
        _loadingVt = false;

        _hasUhKey = hasUhKey;
        _uhEndpointCtrl.text = uhEndpoint;
        _loadingUh = false;

        _phishTankEnabled = ptEnabled;
        _openPhishEnabled = opEnabled;
        _openPhishLastUpdated = opTimestamp;
      });
    }
  }

  // --- Save / delete helpers ---

  Future<void> _saveKey(
    String storageKey,
    TextEditingController ctrl,
    void Function() onSaved,
  ) async {
    final key = ctrl.text.trim();
    if (key.isEmpty) return;
    await _urlSafetyService.saveApiKey(storageKey, key);
    ctrl.clear();
    onSaved();
  }

  Future<void> _deleteKey(String storageKey, void Function() onDeleted) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.titleApiKeyDelete),
        content: Text(l10n.bodyApiKeyDelete),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.actionCancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.actionDelete),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await _urlSafetyService.deleteApiKey(storageKey);
    onDeleted();
  }

  Future<void> _savePrefString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<void> _savePrefBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<void> _refreshOpenPhishFeed() async {
    final l10n = AppLocalizations.of(context);
    setState(() => _refreshingFeed = true);
    final count = await _urlSafetyService.refreshOpenPhishFeed();
    if (!mounted) return;
    setState(() {
      _refreshingFeed = false;
      _openPhishLastUpdated = DateTime.now().toIso8601String();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          count >= 0
              ? l10n.bodyOpenPhishFeedRefreshed('$count')
              : l10n.errorOpenPhishFeedFailed,
        ),
        backgroundColor: count >= 0 ? Colors.green : Colors.red,
      ),
    );
  }

  // --- UI ---

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return SecureScreen(
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.labelSettingsUrlSafetyProviders)),
        body: SafeArea(
          top: false,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            children: [
              // Help card
              Card(
                color: theme.colorScheme.primaryContainer.withValues(
                  alpha: 0.3,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          l10n.helpUrlSafetyProviders,
                          style: TextStyle(
                            fontSize: 13,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // ── USER-SUPPLIED PROVIDERS ──────────────────────────────────────
              _buildSectionHeader(
                context,
                icon: Icons.key,
                title: l10n.titleUrlSafetyUserSupplied,
                note: l10n.descUrlSafetyUserSupplied,
                iconColor: theme.colorScheme.tertiary,
              ),
              const SizedBox(height: 8),

              // Google Safe Browsing
              _buildKeyProviderCard(
                context: context,
                icon: Icons.shield_outlined,
                iconColor: Colors.green,
                title: 'Google Safe Browsing',
                regUrl: 'console.cloud.google.com',
                isLoading: _loadingGsb,
                hasKey: _hasGsbKey,
                obscured: _gsbObscured,
                keyCtrl: _gsbKeyCtrl,
                onToggleObscure: () =>
                    setState(() => _gsbObscured = !_gsbObscured),
                usageText: _hasGsbKey
                    ? l10n.bodyProviderDailyUsage(
                        '$_gsbRequestsToday',
                        '$_gsbMaxPerDay',
                      )
                    : null,
                onSave: () => _saveKey(
                  UrlSafetyService.safeBrowsingApiKeyStorageKey,
                  _gsbKeyCtrl,
                  () => setState(() => _hasGsbKey = true),
                ),
                onDelete: () => _deleteKey(
                  UrlSafetyService.safeBrowsingApiKeyStorageKey,
                  () => setState(() {
                    _hasGsbKey = false;
                    _gsbRequestsToday = 0;
                  }),
                ),
              ),
              const SizedBox(height: 12),

              // VirusTotal
              _buildKeyProviderCard(
                context: context,
                icon: Icons.biotech_outlined,
                iconColor: Colors.blue,
                title: 'VirusTotal',
                regUrl: 'virustotal.com',
                isLoading: _loadingVt,
                hasKey: _hasVtKey,
                obscured: _vtObscured,
                keyCtrl: _vtKeyCtrl,
                endpointCtrl: _vtEndpointCtrl,
                onToggleObscure: () =>
                    setState(() => _vtObscured = !_vtObscured),
                usageText: _hasVtKey
                    ? l10n.bodyProviderDailyUsage(
                        '$_vtRequestsToday',
                        '$_vtMaxPerDay',
                      )
                    : null,
                onSave: () async {
                  await _saveKey(
                    UrlSafetyService.virusTotalApiKeyStorageKey,
                    _vtKeyCtrl,
                    () => setState(() => _hasVtKey = true),
                  );
                  final ep = _vtEndpointCtrl.text.trim();
                  if (ep.isNotEmpty) {
                    await _savePrefString(
                      UrlSafetyService.vtEndpointPrefKey,
                      ep,
                    );
                  }
                },
                onDelete: () => _deleteKey(
                  UrlSafetyService.virusTotalApiKeyStorageKey,
                  () => setState(() {
                    _hasVtKey = false;
                    _vtRequestsToday = 0;
                  }),
                ),
              ),
              const SizedBox(height: 12),

              // URLhaus
              _buildKeyProviderCard(
                context: context,
                icon: Icons.bug_report_outlined,
                iconColor: Colors.orange,
                title: 'URLhaus (abuse.ch)',
                regUrl: 'auth.abuse.ch',
                isLoading: _loadingUh,
                hasKey: _hasUhKey,
                obscured: _uhObscured,
                keyCtrl: _uhKeyCtrl,
                endpointCtrl: _uhEndpointCtrl,
                onToggleObscure: () =>
                    setState(() => _uhObscured = !_uhObscured),
                onSave: () async {
                  await _saveKey(
                    UrlSafetyService.urlhausApiKeyStorageKey,
                    _uhKeyCtrl,
                    () => setState(() => _hasUhKey = true),
                  );
                  final ep = _uhEndpointCtrl.text.trim();
                  if (ep.isNotEmpty) {
                    await _savePrefString(
                      UrlSafetyService.urlhausEndpointPrefKey,
                      ep,
                    );
                  }
                },
                onDelete: () => _deleteKey(
                  UrlSafetyService.urlhausApiKeyStorageKey,
                  () => setState(() => _hasUhKey = false),
                ),
              ),
              const SizedBox(height: 28),

              // ── BUILT-IN PROVIDERS ───────────────────────────────────────────
              _buildSectionHeader(
                context,
                icon: Icons.lock_open_outlined,
                title: l10n.titleUrlSafetyBuiltIn,
                note: l10n.descUrlSafetyBuiltIn,
                iconColor: theme.colorScheme.primary,
              ),
              const SizedBox(height: 8),

              // PhishTank
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.deepOrange.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.phishing_outlined,
                              color: Colors.deepOrange,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'PhishTank',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  l10n.labelPhishTankToggle,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: _phishTankEnabled,
                            onChanged: (val) {
                              setState(() => _phishTankEnabled = val);
                              _savePrefBool(
                                UrlSafetyService.phishTankEnabledPrefKey,
                                val,
                              );
                            },
                          ),
                        ],
                      ),
                      if (_phishTankEnabled) ...[
                        const SizedBox(height: 8),
                        Text(
                          'checkurl.phishtank.com',
                          style: TextStyle(
                            fontSize: 12,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // OpenPhish
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.teal.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.downloading_outlined,
                              color: Colors.teal,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'OpenPhish',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  l10n.labelOpenPhishToggle,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: _openPhishEnabled,
                            onChanged: (val) {
                              setState(() => _openPhishEnabled = val);
                              _savePrefBool(
                                UrlSafetyService.openPhishEnabledPrefKey,
                                val,
                              );
                            },
                          ),
                        ],
                      ),
                      if (_openPhishEnabled) ...[
                        const SizedBox(height: 10),
                        if (_openPhishLastUpdated != null)
                          Text(
                            l10n.bodyOpenPhishLastUpdated(
                              _openPhishLastUpdated!.split('T').first,
                            ),
                            style: TextStyle(
                              fontSize: 12,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          )
                        else
                          Text(
                            l10n.bodyOpenPhishFeedNotDownloaded,
                            style: TextStyle(
                              fontSize: 12,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            icon: _refreshingFeed
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(Icons.refresh, size: 18),
                            label: Text(l10n.actionOpenPhishRefresh),
                            onPressed: _refreshingFeed
                                ? null
                                : _refreshOpenPhishFeed,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String note,
    required Color iconColor,
  }) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 18),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(width: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            note,
            style: TextStyle(
              fontSize: 11,
              color: iconColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildKeyProviderCard({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String regUrl,
    required bool isLoading,
    required bool hasKey,
    required bool obscured,
    required TextEditingController keyCtrl,
    TextEditingController? endpointCtrl,
    required VoidCallback onToggleObscure,
    String? usageText,
    required Future<void> Function() onSave,
    required Future<void> Function() onDelete,
  }) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: isLoading
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: CircularProgressIndicator(),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header row
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: iconColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(icon, color: iconColor, size: 22),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: hasKey
                              ? Colors.green.withValues(alpha: 0.15)
                              : theme.colorScheme.surfaceContainerHighest
                                    .withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          hasKey
                              ? l10n.labelApiKeyConfigured
                              : l10n.labelApiKeyNotConfigured,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: hasKey
                                ? Colors.green[700]
                                : theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // API key field
                  if (!hasKey) ...[
                    TextField(
                      controller: keyCtrl,
                      obscureText: obscured,
                      decoration: InputDecoration(
                        labelText: l10n.labelProviderApiKey,
                        border: const OutlineInputBorder(),
                        isDense: true,
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscured
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          tooltip: obscured
                              ? l10n.actionReveal
                              : l10n.actionHide,
                          onPressed: onToggleObscure,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],

                  // Endpoint field (optional, shown always)
                  if (endpointCtrl != null) ...[
                    TextField(
                      controller: endpointCtrl,
                      decoration: InputDecoration(
                        labelText: l10n.labelProviderEndpoint,
                        border: const OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],

                  // Save / Delete buttons
                  if (!hasKey)
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: onSave,
                        child: Text(l10n.actionApiKeySave),
                      ),
                    )
                  else
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                          size: 18,
                        ),
                        label: Text(
                          l10n.actionDelete,
                          style: const TextStyle(color: Colors.red),
                        ),
                        onPressed: onDelete,
                      ),
                    ),

                  // Usage & registration
                  if (usageText != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      usageText,
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.open_in_new,
                        size: 14,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${l10n.bodyProviderGetKeyAt} $regUrl',
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}

/// One row on the Permissions screen.
///
/// [androidPermissions] holds the Android manifest names without the
/// `android.permission.` prefix (protocol tokens, never translated). It is
/// empty for a row that explains a setting rather than a permission.
@immutable
class PermissionInfoEntry {
  const PermissionInfoEntry({
    required this.icon,
    required this.color,
    required this.title,
    required this.description,
    this.androidPermissions = const [],
  });

  final IconData icon;
  final Color color;
  final String Function(AppLocalizations l10n) title;
  final String Function(AppLocalizations l10n) description;
  final List<String> androidPermissions;
}

/// One group of rows on the Permissions screen.
///
/// [requested] is false for the group that lists permissions the app does
/// not ask for; those must not be requested in the manifest.
@immutable
class PermissionInfoGroup {
  const PermissionInfoGroup({
    required this.icon,
    required this.title,
    required this.note,
    required this.requested,
    required this.entries,
  });

  final IconData icon;
  final String Function(AppLocalizations l10n) title;
  final String Function(AppLocalizations l10n) note;
  final bool requested;
  final List<PermissionInfoEntry> entries;
}

/// Everything the Permissions screen shows. A test checks this list against
/// `android/app/src/main/AndroidManifest.xml`, so a new manifest permission
/// cannot ship without an explanation here.
final List<PermissionInfoGroup> kPermissionGroups = [
  PermissionInfoGroup(
    icon: Icons.front_hand_outlined,
    title: (l10n) => l10n.labelPermGroupAsked,
    note: (l10n) => l10n.helpPermGroupAskedNote,
    requested: true,
    entries: [
      PermissionInfoEntry(
        icon: Icons.camera_alt_outlined,
        color: Colors.blue,
        title: (l10n) => l10n.labelPermCamera,
        description: (l10n) => l10n.helpPermCameraDesc,
        androidPermissions: const ['CAMERA'],
      ),
      PermissionInfoEntry(
        icon: Icons.location_on_outlined,
        color: Colors.green,
        title: (l10n) => l10n.labelPermLocation,
        description: (l10n) => l10n.helpPermLocationDesc,
        androidPermissions: const [
          'ACCESS_FINE_LOCATION',
          'ACCESS_COARSE_LOCATION',
        ],
      ),
      PermissionInfoEntry(
        icon: Icons.fingerprint,
        color: Colors.purple,
        title: (l10n) => l10n.labelPermBiometric,
        description: (l10n) => l10n.helpPermBiometricDesc,
        androidPermissions: const ['USE_BIOMETRIC', 'USE_FINGERPRINT'],
      ),
      PermissionInfoEntry(
        icon: Icons.notifications_outlined,
        color: Colors.pink,
        title: (l10n) => l10n.labelPermNotifications,
        description: (l10n) => l10n.helpPermNotificationsDesc,
        androidPermissions: const ['POST_NOTIFICATIONS'],
      ),
      PermissionInfoEntry(
        icon: Icons.bubble_chart_outlined,
        color: Colors.blueGrey,
        title: (l10n) => l10n.labelPermOverlay,
        description: (l10n) => l10n.helpPermOverlayDesc,
        androidPermissions: const ['SYSTEM_ALERT_WINDOW'],
      ),
      PermissionInfoEntry(
        icon: Icons.screenshot_monitor_outlined,
        color: Colors.indigo,
        title: (l10n) => l10n.labelPermScreenCapture,
        description: (l10n) => l10n.helpPermScreenCaptureDesc,
        androidPermissions: const ['FOREGROUND_SERVICE_MEDIA_PROJECTION'],
      ),
    ],
  ),
  PermissionInfoGroup(
    icon: Icons.settings_suggest_outlined,
    title: (l10n) => l10n.labelPermGroupInstall,
    note: (l10n) => l10n.helpPermGroupInstallNote,
    requested: true,
    entries: [
      PermissionInfoEntry(
        icon: Icons.public,
        color: Colors.teal,
        title: (l10n) => l10n.labelPermInternet,
        description: (l10n) => l10n.helpPermInternetDesc,
        androidPermissions: const ['INTERNET'],
      ),
      PermissionInfoEntry(
        icon: Icons.travel_explore,
        color: Colors.amber,
        title: (l10n) => l10n.labelPermProbing,
        description: (l10n) => l10n.helpPermProbingDesc,
      ),
      PermissionInfoEntry(
        icon: Icons.cloud_sync_outlined,
        color: Colors.lightBlue,
        title: (l10n) => l10n.labelPermLinkServices,
        description: (l10n) => l10n.helpPermLinkServicesDesc,
      ),
      PermissionInfoEntry(
        icon: Icons.wifi,
        color: Colors.cyan,
        title: (l10n) => l10n.labelPermWifi,
        description: (l10n) => l10n.helpPermWifiDesc,
        androidPermissions: const [
          'ACCESS_WIFI_STATE',
          'CHANGE_WIFI_STATE',
          'ACCESS_NETWORK_STATE',
          'CHANGE_NETWORK_STATE',
        ],
      ),
      PermissionInfoEntry(
        icon: Icons.play_circle_outline,
        color: Colors.deepOrange,
        title: (l10n) => l10n.labelPermBackground,
        description: (l10n) => l10n.helpPermBackgroundDesc,
        androidPermissions: const [
          'FOREGROUND_SERVICE',
          'FOREGROUND_SERVICE_SPECIAL_USE',
        ],
      ),
      PermissionInfoEntry(
        icon: Icons.restart_alt,
        color: Colors.brown,
        title: (l10n) => l10n.labelPermBoot,
        description: (l10n) => l10n.helpPermBootDesc,
        androidPermissions: const ['RECEIVE_BOOT_COMPLETED'],
      ),
    ],
  ),
  PermissionInfoGroup(
    icon: Icons.block_outlined,
    title: (l10n) => l10n.labelPermGroupNotUsed,
    note: (l10n) => l10n.helpPermGroupNotUsedNote,
    requested: false,
    entries: [
      PermissionInfoEntry(
        icon: Icons.photo_library_outlined,
        color: Colors.grey,
        title: (l10n) => l10n.labelPermStorage,
        description: (l10n) => l10n.helpPermStorageDesc,
        androidPermissions: const [
          'READ_EXTERNAL_STORAGE',
          'WRITE_EXTERNAL_STORAGE',
        ],
      ),
      PermissionInfoEntry(
        icon: Icons.mic_off_outlined,
        color: Colors.grey,
        title: (l10n) => l10n.labelPermMicrophone,
        description: (l10n) => l10n.helpPermMicrophoneDesc,
        androidPermissions: const ['RECORD_AUDIO'],
      ),
      PermissionInfoEntry(
        icon: Icons.vibration,
        color: Colors.grey,
        title: (l10n) => l10n.labelPermVibration,
        description: (l10n) => l10n.helpPermVibrationDesc,
        androidPermissions: const ['VIBRATE'],
      ),
    ],
  ),
];

class PermissionsSettingsScreen extends StatelessWidget {
  const PermissionsSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.titlePermissionsScreen)),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4, right: 4, bottom: 20),
              child: Text(
                l10n.helpPermissionsIntro,
                style: theme.textTheme.bodyMedium,
              ),
            ),
            for (final group in kPermissionGroups) ...[
              _buildSectionHeader(
                context,
                title: group.title(l10n),
                icon: group.icon,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4, right: 4, bottom: 8),
                child: Text(
                  group.note(l10n),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    for (final (index, entry) in group.entries.indexed) ...[
                      if (index > 0) const Divider(height: 1),
                      _buildEntry(context, l10n, entry),
                    ],
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildEntry(
    BuildContext context,
    AppLocalizations l10n,
    PermissionInfoEntry entry,
  ) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(entry.icon, color: entry.color),
      title: Text(
        entry.title(l10n),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 2),
          Text(entry.description(l10n)),
          if (entry.androidPermissions.isNotEmpty) ...[
            const SizedBox(height: 6),
            // Android names, for people who want to match them with the
            // system settings or the store listing. Protocol tokens, not UI
            // text, so they are not translated.
            Text(
              entry.androidPermissions.join(', '),
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required String title,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Theme.of(context).primaryColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
