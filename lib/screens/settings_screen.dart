import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sreeraj_qr_reader/l10n/gen/app_localizations.dart';
import 'package:sreeraj_qr_reader/providers/locale_provider.dart';
import 'package:sreeraj_qr_reader/providers/scan_provider.dart';
import 'package:sreeraj_qr_reader/providers/theme_provider.dart';
import 'package:sreeraj_qr_reader/screens/about_screen.dart';
import 'package:sreeraj_qr_reader/screens/appearance_screen.dart';
import 'package:sreeraj_qr_reader/screens/features_screen.dart';
import 'package:sreeraj_qr_reader/screens/help/help_home_screen.dart';
import 'package:sreeraj_qr_reader/screens/onboarding_screen.dart';
import 'package:sreeraj_qr_reader/services/url_safety_service.dart';

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
      const secureStorage = FlutterSecureStorage();

      // Count active providers: non-empty API keys + enabled toggles.
      var activeProviders = 0;
      for (final key in const [
        'google_safe_browsing_api_key',
        'virustotal_api_key',
        'urlhaus_api_key',
      ]) {
        final val = await secureStorage.read(key: key);
        if (val != null && val.isNotEmpty) activeProviders++;
      }
      if (prefs.getBool(UrlSafetyService.phishTankEnabledPrefKey) ?? false) {
        activeProviders++;
      }
      if (prefs.getBool(UrlSafetyService.openPhishEnabledPrefKey) ?? false) {
        activeProviders++;
      }

      if (mounted) {
        setState(() {
          _activeProbing =
              prefs.getBool(UrlSafetyService.activeProbingPrefKey) ?? false;
          _hasApiKey = activeProviders > 0;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (kDebugMode) debugPrint('Error loading settings summary: $e');
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
      AppThemeMode.system => l10n.themeSystemDefault,
      AppThemeMode.light => l10n.themeLight,
      AppThemeMode.dark => l10n.themeDark,
      AppThemeMode.oled => l10n.themeOled,
    };

    final currentLanguageName = switch (localeProvider.languageCode) {
      'en' => l10n.languageEnglish,
      'ml' => l10n.languageMalayalam,
      'sa' => l10n.languageSanskrit,
      _ => l10n.languageSystemDefault,
    };

    final feedbackStatus = l10n.feedbackSummary(
      scanProvider.isVibrationEnabled ? l10n.onLabel : l10n.offLabel,
      scanProvider.isSoundEnabled ? l10n.onLabel : l10n.offLabel,
    );

    final privacyStatus = _activeProbing
        ? l10n.privacySummaryOn
        : l10n.privacySummaryOff;

    // Count how many providers are active for the subtitle.
    // _hasApiKey is true if at least one provider is configured.
    final activeCount = _hasApiKey ? '1+' : '0';

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              child: Column(
                children: [
                  _buildSettingsCard(
                    context: context,
                    icon: Icons.palette_outlined,
                    title: l10n.appearanceHubTitle,
                    subtitle: '$themeModeName • Dynamic colors',
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
                    title: l10n.settingsLanguageTitle,
                    subtitle: currentLanguageName,
                    onTap: () => _showLanguageDialog(context, localeProvider),
                  ),
                  _buildSettingsCard(
                    context: context,
                    icon: Icons.stars_outlined,
                    title: l10n.settingsFeaturesTitle,
                    subtitle: l10n.settingsFeaturesSubtitle,
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
                    title: l10n.settingsFeedbackTitle,
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
                    title: l10n.settingsPrivacyTitle,
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
                    title: l10n.settingsUrlSafetyProvidersTitle,
                    subtitle: l10n.settingsUrlSafetyProvidersSubtitle(
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
                    title: l10n.airQrSyncSettingsTitle,
                    subtitle: l10n.airQrSyncSettingsSubtitle,
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
                    icon: Icons.admin_panel_settings_outlined,
                    title: l10n.settingsPermissionsTitle,
                    subtitle: l10n.settingsPermissionsSubtitle,
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
                    title: l10n.settingsHelpTitle,
                    subtitle: l10n.settingsHelpSubtitle,
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
                    title: l10n.settingsOnboardingTourTitle,
                    subtitle: l10n.settingsOnboardingTourSubtitle,
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
                    title: l10n.aboutTitle,
                    subtitle: l10n.settingsAboutSubtitle,
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
          title: Text(l10n.settingsLanguageTitle),
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
                  title: Text(l10n.languageSystemDefault),
                  value: LocaleProvider.systemValue,
                ),
                RadioListTile<String>(
                  title: Text(l10n.languageEnglish),
                  value: 'en',
                ),
                RadioListTile<String>(
                  title: Text(l10n.languageMalayalam),
                  value: 'ml',
                ),
                RadioListTile<String>(
                  title: Text(l10n.languageSanskrit),
                  value: 'sa',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(l10n.cancelButton),
            ),
          ],
        );
      },
    );
  }
}

class AppearanceSettingsScreen extends StatelessWidget {
  const AppearanceSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsAppearanceTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.palette_outlined),
                      title: Text(
                        l10n.themeModeHeading,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        _getThemeModeName(l10n, themeProvider.themeMode),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SegmentedButton<AppThemeMode>(
                        segments: [
                          ButtonSegment<AppThemeMode>(
                            value: AppThemeMode.system,
                            label: Text(l10n.themeChipSystem),
                            icon: const Icon(Icons.brightness_auto, size: 18),
                          ),
                          ButtonSegment<AppThemeMode>(
                            value: AppThemeMode.light,
                            label: Text(l10n.themeChipLight),
                            icon: const Icon(Icons.light_mode, size: 18),
                          ),
                          ButtonSegment<AppThemeMode>(
                            value: AppThemeMode.dark,
                            label: Text(l10n.themeChipDark),
                            icon: const Icon(Icons.dark_mode, size: 18),
                          ),
                          ButtonSegment<AppThemeMode>(
                            value: AppThemeMode.oled,
                            label: Text(l10n.themeChipOled),
                            icon: const Icon(
                              Icons.power_settings_new,
                              size: 18,
                            ),
                          ),
                        ],
                        selected: {themeProvider.themeMode},
                        onSelectionChanged: (newSelection) {
                          themeProvider.setThemeMode(newSelection.first);
                        },
                      ),
                    ),
                    const Divider(height: 24),
                    SwitchListTile(
                      secondary: const Icon(Icons.color_lens_outlined),
                      title: Text(l10n.themeDynamicColorsTitle),
                      subtitle: Text(l10n.themeDynamicColorsSubtitle),
                      value: themeProvider.useDynamicColor,
                      onChanged: (val) => themeProvider.setUseDynamicColor(val),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getThemeModeName(AppLocalizations l10n, AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.system:
        return l10n.themeDescSystem;
      case AppThemeMode.light:
        return l10n.themeDescLight;
      case AppThemeMode.dark:
        return l10n.themeDescDark;
      case AppThemeMode.oled:
        return l10n.themeDescOled;
    }
  }
}

class ScanOverlaySettingsScreen extends StatelessWidget {
  const ScanOverlaySettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsOverlayTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          child: Column(
            children: [
              _buildOverlayTile(
                context: context,
                themeProvider: themeProvider,
                style: ScanOverlayStyle.laserLine,
                icon: Icons.linear_scale,
                title: l10n.overlayLaserLine,
                subtitle: l10n.overlayLaserLineDesc,
              ),
              const Divider(height: 1, indent: 16, endIndent: 16),
              _buildOverlayTile(
                context: context,
                themeProvider: themeProvider,
                style: ScanOverlayStyle.pulsingCorners,
                icon: Icons.crop_free,
                title: l10n.overlayPulsingCorners,
                subtitle: l10n.overlayPulsingCornersDesc,
              ),
              const Divider(height: 1, indent: 16, endIndent: 16),
              _buildOverlayTile(
                context: context,
                themeProvider: themeProvider,
                style: ScanOverlayStyle.cyberneticGrid,
                icon: Icons.grid_4x4,
                title: l10n.overlayCyberneticGrid,
                subtitle: l10n.overlayCyberneticGridDesc,
              ),
              const Divider(height: 1, indent: 16, endIndent: 16),
              _buildOverlayTile(
                context: context,
                themeProvider: themeProvider,
                style: ScanOverlayStyle.subtleDotMatrix,
                icon: Icons.grain,
                title: l10n.overlaySubtleDotMatrix,
                subtitle: l10n.overlaySubtleDotMatrixDesc,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverlayTile({
    required BuildContext context,
    required ThemeProvider themeProvider,
    required ScanOverlayStyle style,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final isSelected = themeProvider.scanOverlayStyle == style;

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? Theme.of(context).colorScheme.primary : null,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: isSelected
          ? Icon(
              Icons.check_circle,
              color: Theme.of(context).colorScheme.primary,
            )
          : const Icon(Icons.circle_outlined, color: Colors.grey),
      onTap: () => themeProvider.setScanOverlayStyle(style),
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
      appBar: AppBar(title: Text(l10n.settingsFeedbackTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          child: Column(
            children: [
              SwitchListTile(
                secondary: const Icon(Icons.vibration),
                title: Text(l10n.feedbackVibrationTitle),
                subtitle: Text(l10n.feedbackVibrationSubtitle),
                value: scanProvider.isVibrationEnabled,
                onChanged: (val) => scanProvider.setVibrationEnabled(val),
              ),
              const Divider(height: 1, indent: 16, endIndent: 16),
              SwitchListTile(
                secondary: const Icon(Icons.volume_up_outlined),
                title: Text(l10n.feedbackSoundTitle),
                subtitle: Text(l10n.feedbackSoundSubtitle),
                value: scanProvider.isSoundEnabled,
                onChanged: (val) => scanProvider.setSoundEnabled(val),
              ),
              const Divider(height: 1, indent: 16, endIndent: 16),
              SwitchListTile(
                secondary: const Icon(Icons.check_circle_outline_rounded),
                title: Text(l10n.feedbackAnimationTitle),
                subtitle: Text(l10n.feedbackAnimationSubtitle),
                value: scanProvider.isAnimationEnabled,
                onChanged: (val) => scanProvider.setAnimationEnabled(val),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});

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
    } catch (e) {
      if (kDebugMode) debugPrint('Error loading privacy setting: $e');
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _setActiveProbing(bool value) async {
    setState(() => _activeProbing = value);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(UrlSafetyService.activeProbingPrefKey, value);
    } catch (e) {
      if (kDebugMode) debugPrint('Error saving active probing setting: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.privacyScreenTitle)),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Card(
                color: _activeProbing ? Colors.orange[50] : Colors.blue[50],
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
                          l10n.privacyActiveChecksTitle,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(l10n.privacyActiveChecksSubtitle),
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
                              color: _activeProbing
                                  ? Colors.orange[700]
                                  : Colors.blue[700],
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _activeProbing
                                    ? l10n.privacyExplainerOn
                                    : l10n.privacyExplainerOff,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: _activeProbing
                                      ? Colors.orange[900]
                                      : Colors.blue[900],
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
            ),
    );
  }
}

class SafeBrowsingSettingsScreen extends StatefulWidget {
  const SafeBrowsingSettingsScreen({super.key});

  @override
  State<SafeBrowsingSettingsScreen> createState() =>
      _SafeBrowsingSettingsScreenState();
}

class _SafeBrowsingSettingsScreenState
    extends State<SafeBrowsingSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    // Redirects to the new unified screen.
    return const UrlSafetyProvidersScreen();
  }
}

// ============================================================================
// URL Safety Providers Screen
// ============================================================================

class UrlSafetyProvidersScreen extends StatefulWidget {
  const UrlSafetyProvidersScreen({super.key});

  @override
  State<UrlSafetyProvidersScreen> createState() =>
      _UrlSafetyProvidersScreenState();
}

class _UrlSafetyProvidersScreenState extends State<UrlSafetyProvidersScreen> {
  final _secureStorage = const FlutterSecureStorage();
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
    final gsbKey = await _secureStorage.read(
      key: 'google_safe_browsing_api_key',
    );
    final gsbLastReset = prefs.getString('safe_browsing_last_reset');
    final gsbCount = gsbLastReset == today
        ? prefs.getInt('safe_browsing_request_count') ?? 0
        : 0;

    // VirusTotal
    final vtKey = await _secureStorage.read(key: 'virustotal_api_key');
    final vtLastReset = prefs.getString(UrlSafetyService.vtLastResetKey);
    final vtCount = vtLastReset == today
        ? prefs.getInt(UrlSafetyService.vtRequestCountKey) ?? 0
        : 0;
    final vtEndpoint =
        prefs.getString(UrlSafetyService.vtEndpointPrefKey) ??
        UrlSafetyService.vtDefaultEndpoint;

    // URLhaus
    final uhKey = await _secureStorage.read(key: 'urlhaus_api_key');
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
        _hasGsbKey = gsbKey != null && gsbKey.isNotEmpty;
        _gsbRequestsToday = gsbCount;
        _loadingGsb = false;

        _hasVtKey = vtKey != null && vtKey.isNotEmpty;
        _vtRequestsToday = vtCount;
        _vtEndpointCtrl.text = vtEndpoint;
        _loadingVt = false;

        _hasUhKey = uhKey != null && uhKey.isNotEmpty;
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
    await _secureStorage.write(key: storageKey, value: key);
    ctrl.clear();
    onSaved();
  }

  Future<void> _deleteKey(String storageKey, void Function() onDeleted) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.apiKeyDeleteTitle),
        content: Text(l10n.apiKeyDeleteMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancelButton),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.deleteButton),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await _secureStorage.delete(key: storageKey);
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
              ? l10n.openPhishFeedRefreshed('$count')
              : l10n.openPhishFeedFailed,
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

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsUrlSafetyProvidersTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          // Help card
          Card(
            color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
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
                      l10n.urlSafetyProvidersHelpText,
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
            title: l10n.urlSafetyUserSuppliedHeader,
            note: l10n.urlSafetyUserSuppliedNote,
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
            onToggleObscure: () => setState(() => _gsbObscured = !_gsbObscured),
            usageText: _hasGsbKey
                ? l10n.providerDailyUsage(
                    '$_gsbRequestsToday',
                    '$_gsbMaxPerDay',
                  )
                : null,
            onSave: () => _saveKey(
              'google_safe_browsing_api_key',
              _gsbKeyCtrl,
              () => setState(() => _hasGsbKey = true),
            ),
            onDelete: () => _deleteKey(
              'google_safe_browsing_api_key',
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
            onToggleObscure: () => setState(() => _vtObscured = !_vtObscured),
            usageText: _hasVtKey
                ? l10n.providerDailyUsage('$_vtRequestsToday', '$_vtMaxPerDay')
                : null,
            onSave: () async {
              await _saveKey(
                'virustotal_api_key',
                _vtKeyCtrl,
                () => setState(() => _hasVtKey = true),
              );
              final ep = _vtEndpointCtrl.text.trim();
              if (ep.isNotEmpty) {
                await _savePrefString(UrlSafetyService.vtEndpointPrefKey, ep);
              }
            },
            onDelete: () => _deleteKey(
              'virustotal_api_key',
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
            onToggleObscure: () => setState(() => _uhObscured = !_uhObscured),
            onSave: () async {
              await _saveKey(
                'urlhaus_api_key',
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
              'urlhaus_api_key',
              () => setState(() => _hasUhKey = false),
            ),
          ),
          const SizedBox(height: 28),

          // ── BUILT-IN PROVIDERS ───────────────────────────────────────────
          _buildSectionHeader(
            context,
            icon: Icons.lock_open_outlined,
            title: l10n.urlSafetyBuiltInHeader,
            note: l10n.urlSafetyBuiltInNote,
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
                              l10n.phishTankToggleLabel,
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
                              l10n.openPhishToggleLabel,
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
                        l10n.openPhishLastUpdated(
                          _openPhishLastUpdated!.split('T').first,
                        ),
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      )
                    else
                      Text(
                        'Feed not yet downloaded',
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
                        label: Text(l10n.openPhishRefreshNow),
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
                              ? l10n.apiKeyConfigured
                              : l10n.apiKeyNotConfigured,
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
                        labelText: l10n.providerApiKeyHint,
                        border: const OutlineInputBorder(),
                        isDense: true,
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscured
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          tooltip: obscured
                              ? l10n.revealAction
                              : l10n.hideAction,
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
                        labelText: l10n.providerEndpointLabel,
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
                        child: Text(l10n.apiKeySaveButton),
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
                          l10n.deleteButton,
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
                        '${l10n.providerGetKeyAt} $regUrl',
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

class PermissionsSettingsScreen extends StatelessWidget {
  const PermissionsSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.permissionsScreenTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(
              context,
              title: l10n.permissionsExplicitHeading,
              icon: Icons.security_outlined,
            ),
            Card(
              margin: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.blue,
                    ),
                    title: Text(
                      l10n.permissionCameraTitle,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(l10n.permissionCameraDesc),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(
                      Icons.fingerprint,
                      color: Colors.purple,
                    ),
                    title: Text(
                      l10n.permissionBiometricTitle,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(l10n.permissionBiometricDesc),
                  ),
                ],
              ),
            ),
            _buildSectionHeader(
              context,
              title: l10n.permissionsImplicitHeading,
              icon: Icons.settings_suggest_outlined,
            ),
            Card(
              margin: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.wifi, color: Colors.teal),
                    title: Text(
                      l10n.permissionInternetTitle,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(l10n.permissionInternetDesc),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.vibration, color: Colors.orange),
                    title: Text(
                      l10n.permissionVibrateTitle,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(l10n.permissionVibrateDesc),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(
                      Icons.photo_library_outlined,
                      color: Colors.indigo,
                    ),
                    title: Text(
                      l10n.permissionPhotoPickerTitle,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(l10n.permissionPhotoPickerDesc),
                  ),
                ],
              ),
            ),
            _buildSectionHeader(
              context,
              title: l10n.permissionsSettingHeading,
              icon: Icons.toggle_on_outlined,
            ),
            Card(
              margin: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.travel_explore,
                      color: Colors.amber,
                    ),
                    title: Text(
                      l10n.permissionProbingTitle,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(l10n.permissionProbingDesc),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(
                      Icons.cloud_sync_outlined,
                      color: Colors.lightBlue,
                    ),
                    title: Text(
                      l10n.permissionSafeBrowsingTitle,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(l10n.permissionSafeBrowsingDesc),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(
                      Icons.touch_app_outlined,
                      color: Colors.deepOrange,
                    ),
                    title: Text(
                      l10n.permissionFeedbackTitle,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(l10n.permissionFeedbackDesc),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required String title,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
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

class HelpSettingsScreen extends StatelessWidget {
  const HelpSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsHelpTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildHelpCard(
              context: context,
              icon: Icons.view_in_ar,
              title: l10n.arScreenTitle,
              badgeText: l10n.helpArBadge,
              description: l10n.helpArDesc,
              details: [
                l10n.helpArPoint1,
                l10n.helpArPoint2,
                l10n.helpArPoint3,
                l10n.helpArPoint4,
              ],
            ),
            const SizedBox(height: 16),
            _buildHelpCard(
              context: context,
              icon: Icons.stream,
              title: l10n.airQrReceiverTitle,
              badgeText: l10n.helpAirQrBadge,
              description: l10n.helpAirQrDesc,
              details: [
                l10n.helpAirQrPoint1,
                l10n.helpAirQrPoint2,
                l10n.helpAirQrPoint3,
                l10n.helpAirQrPoint4,
              ],
            ),
            const SizedBox(height: 16),
            _buildHelpCard(
              context: context,
              icon: Icons.qr_code_scanner,
              title: l10n.helpQuishingTitle,
              badgeText: l10n.helpQuishingBadge,
              description: l10n.helpQuishingDesc,
              details: [
                l10n.helpQuishingPoint1,
                l10n.helpQuishingPoint2,
                l10n.helpQuishingPoint3,
                l10n.helpQuishingPoint4,
              ],
            ),
            const SizedBox(height: 16),
            _buildHelpCard(
              context: context,
              icon: Icons.verified_user_outlined,
              title: l10n.helpUrlTitle,
              badgeText: l10n.helpUrlBadge,
              description: l10n.helpUrlDesc,
              details: [
                l10n.helpUrlPoint1,
                l10n.helpUrlPoint2,
                l10n.helpUrlPoint3,
                l10n.helpUrlPoint4,
                l10n.helpUrlPoint5,
                l10n.helpUrlPoint6,
                l10n.helpUrlPoint7,
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String badgeText,
    required String description,
    required List<String> details,
  }) {
    final l10n = AppLocalizations.of(context);
    return Card(
      child: ExpansionTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Theme.of(context).primaryColor),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  badgeText,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        childrenPadding: const EdgeInsets.all(16),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(description, style: const TextStyle(fontSize: 14, height: 1.4)),
          const SizedBox(height: 12),
          Text(
            l10n.helpCapabilitiesHeading,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          const SizedBox(height: 8),
          ...details.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
