import 'package:dynamic_color/dynamic_color.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/l10n/fallback_localizations.dart';
import 'package:sreerajp_qr_studio/providers/air_qr_provider.dart';
import 'package:sreerajp_qr_studio/providers/app_lock_provider.dart';
import 'package:sreerajp_qr_studio/providers/ar_codevision_provider.dart';
import 'package:sreerajp_qr_studio/providers/batch_scan_provider.dart';
import 'package:sreerajp_qr_studio/providers/camera_settings_provider.dart';
import 'package:sreerajp_qr_studio/providers/code_forge_provider.dart';
import 'package:sreerajp_qr_studio/providers/history_provider.dart';
import 'package:sreerajp_qr_studio/providers/locale_provider.dart';
import 'package:sreerajp_qr_studio/providers/multi_code_selection_provider.dart';
import 'package:sreerajp_qr_studio/providers/onboarding_provider.dart';
import 'package:sreerajp_qr_studio/providers/scan_bubble_provider.dart';
import 'package:sreerajp_qr_studio/providers/scan_provider.dart';
import 'package:sreerajp_qr_studio/providers/theme_provider.dart';
import 'package:sreerajp_qr_studio/screens/about_screen.dart';
import 'package:sreerajp_qr_studio/screens/air_qr_screen.dart';
import 'package:sreerajp_qr_studio/screens/air_qr_transmitter_screen.dart';
import 'package:sreerajp_qr_studio/screens/ar_codevision_screen.dart';
import 'package:sreerajp_qr_studio/screens/code_forge_screen.dart';
import 'package:sreerajp_qr_studio/screens/history_screen.dart';
import 'package:sreerajp_qr_studio/screens/main_shell_screen.dart';
import 'package:sreerajp_qr_studio/screens/onboarding_screen.dart';
import 'package:sreerajp_qr_studio/screens/result_screen.dart';
import 'package:sreerajp_qr_studio/screens/scan_bubble_settings_screen.dart';
import 'package:sreerajp_qr_studio/screens/scanner_screen.dart';
import 'package:sreerajp_qr_studio/screens/settings_screen.dart';
import 'package:sreerajp_qr_studio/services/app_startup_service.dart';
import 'package:sreerajp_qr_studio/widgets/app_lock_gate.dart';
import 'package:sreerajp_qr_studio/widgets/app_restart_scope.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

Future<void> main() async {
  final startup = await AppStartupService.run();
  runApp(
    AppRestartScope(builder: (_) => SreerajQRReaderApp(prefs: startup.prefs)),
  );
}

class SreerajQRReaderApp extends StatelessWidget {
  const SreerajQRReaderApp({super.key, this.prefs});

  /// Preferences loaded before the first frame (saved language, onboarding).
  final SharedPreferences? prefs;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AppLockProvider(prefs: prefs)),
        ChangeNotifierProvider(create: (_) => LocaleProvider(prefs: prefs)),
        ChangeNotifierProvider(create: (_) => ScanProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
        ChangeNotifierProvider(create: (_) => AirQrProvider()),
        ChangeNotifierProvider(create: (_) => ArCodevisionProvider()),
        ChangeNotifierProvider(create: (_) => CameraSettingsProvider()),
        ChangeNotifierProvider(create: (_) => CodeForgeProvider()),
        ChangeNotifierProvider(create: (_) => OnboardingProvider(prefs: prefs)),
        ChangeNotifierProvider(create: (_) => BatchScanProvider()),
        ChangeNotifierProvider(create: (_) => MultiCodeSelectionProvider()),
        ChangeNotifierProvider(create: (_) => ScanBubbleProvider()),
      ],
      child: Consumer3<ThemeProvider, LocaleProvider, OnboardingProvider>(
        builder:
            (
              context,
              themeProvider,
              localeProvider,
              onboardingProvider,
              child,
            ) {
              return DynamicColorBuilder(
                builder: (lightDynamic, darkDynamic) {
                  final lightTheme = themeProvider.buildLightTheme(
                    dynamicColorScheme: lightDynamic,
                  );

                  final darkTheme = themeProvider.themeMode == AppThemeMode.oled
                      ? themeProvider.buildOledTheme(
                          dynamicColorScheme: darkDynamic,
                        )
                      : themeProvider.buildDarkTheme(
                          dynamicColorScheme: darkDynamic,
                        );

                  final themeMode = switch (themeProvider.themeMode) {
                    AppThemeMode.system => ThemeMode.system,
                    AppThemeMode.light => ThemeMode.light,
                    AppThemeMode.dark => ThemeMode.dark,
                    AppThemeMode.oled => ThemeMode.dark,
                  };

                  return MaterialApp(
                    onGenerateTitle: (context) =>
                        AppLocalizations.of(context).titleApp,
                    locale: localeProvider.locale,
                    localizationsDelegates: const [
                      AppLocalizations.delegate,
                      FallbackMaterialLocalizationsDelegate(),
                      FallbackCupertinoLocalizationsDelegate(),
                      FallbackWidgetsLocalizationsDelegate(),
                      ...GlobalMaterialLocalizations.delegates,
                    ],
                    supportedLocales: AppLocalizations.supportedLocales,
                    localeResolutionCallback: (deviceLocale, supportedLocales) {
                      if (deviceLocale != null) {
                        for (final locale in supportedLocales) {
                          if (locale.languageCode ==
                              deviceLocale.languageCode) {
                            return locale;
                          }
                        }
                      }
                      return supportedLocales.first; // the template language
                    },
                    theme: lightTheme,
                    darkTheme: darkTheme,
                    themeMode: themeMode,
                    home: !onboardingProvider.isInitialized
                        ? Scaffold(
                            backgroundColor: themeMode == ThemeMode.dark
                                ? darkTheme.scaffoldBackgroundColor
                                : lightTheme.scaffoldBackgroundColor,
                          )
                        : onboardingProvider.hasSeenOnboarding
                        ? const MainShellScreen()
                        : const OnboardingScreen(),
                    navigatorObservers: [routeObserver],
                    routes: {
                      '/scanner': (context) => const ScannerScreen(),
                      '/result': (context) => const ResultScreen(),
                      '/about': (context) => const AboutScreen(),
                      '/settings': (context) => const SettingsScreen(),
                      '/history': (context) => const HistoryScreen(),
                      '/code_forge': (context) => const CodeForgeScreen(),
                      '/air_qr': (context) => const AirQrScreen(),
                      '/air_qr_transmitter': (context) =>
                          const AirQrTransmitterScreen(),
                      '/ar_codevision': (context) => const ArCodevisionScreen(),
                      ScanBubbleSettingsScreen.routeName: (context) =>
                          const ScanBubbleSettingsScreen(),
                      '/onboarding': (context) =>
                          const OnboardingScreen(isReplay: true),
                    },
                    debugShowCheckedModeBanner: false,
                    builder: (context, child) =>
                        AppLockGate(child: child ?? const SizedBox.shrink()),
                  );
                },
              );
            },
      ),
    );
  }
}
