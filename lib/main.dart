import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sreeraj_qr_reader/l10n/gen/app_localizations.dart';
import 'package:sreeraj_qr_reader/l10n/sa_material_localizations.dart';
import 'package:sreeraj_qr_reader/providers/air_qr_provider.dart';
import 'package:sreeraj_qr_reader/providers/ar_codevision_provider.dart';
import 'package:sreeraj_qr_reader/providers/batch_scan_provider.dart';
import 'package:sreeraj_qr_reader/providers/camera_settings_provider.dart';
import 'package:sreeraj_qr_reader/providers/code_forge_provider.dart';
import 'package:sreeraj_qr_reader/providers/history_provider.dart';
import 'package:sreeraj_qr_reader/providers/locale_provider.dart';
import 'package:sreeraj_qr_reader/providers/onboarding_provider.dart';
import 'package:sreeraj_qr_reader/providers/scan_provider.dart';
import 'package:sreeraj_qr_reader/providers/theme_provider.dart';
import 'package:sreeraj_qr_reader/screens/about_screen.dart';
import 'package:sreeraj_qr_reader/screens/air_qr_screen.dart';
import 'package:sreeraj_qr_reader/screens/air_qr_transmitter_screen.dart';
import 'package:sreeraj_qr_reader/screens/ar_codevision_screen.dart';
import 'package:sreeraj_qr_reader/screens/code_forge_screen.dart';
import 'package:sreeraj_qr_reader/screens/history_screen.dart';
import 'package:sreeraj_qr_reader/screens/main_shell_screen.dart';
import 'package:sreeraj_qr_reader/screens/onboarding_screen.dart';
import 'package:sreeraj_qr_reader/screens/result_screen.dart';
import 'package:sreeraj_qr_reader/screens/scanner_screen.dart';
import 'package:sreeraj_qr_reader/screens/settings_screen.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

void main() {
  runApp(const SreerajQRReaderApp());
}

class SreerajQRReaderApp extends StatelessWidget {
  const SreerajQRReaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => ScanProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
        ChangeNotifierProvider(create: (_) => AirQrProvider()),
        ChangeNotifierProvider(create: (_) => ArCodevisionProvider()),
        ChangeNotifierProvider(create: (_) => CameraSettingsProvider()),
        ChangeNotifierProvider(create: (_) => CodeForgeProvider()),
        ChangeNotifierProvider(create: (_) => OnboardingProvider()),
        ChangeNotifierProvider(create: (_) => BatchScanProvider()),
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
                        AppLocalizations.of(context).appTitle,
                    locale: localeProvider.locale,
                    localizationsDelegates: const [
                      AppLocalizations.delegate,
                      SaMaterialLocalizationsDelegate(),
                      SaCupertinoLocalizationsDelegate(),
                      SaWidgetsLocalizationsDelegate(),
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: const [
                      Locale('en'),
                      Locale('ml'),
                      Locale('sa'),
                    ],
                    localeResolutionCallback: (deviceLocale, supportedLocales) {
                      if (deviceLocale != null) {
                        for (final locale in supportedLocales) {
                          if (locale.languageCode ==
                              deviceLocale.languageCode) {
                            return locale;
                          }
                        }
                      }
                      return const Locale('en');
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
                      '/onboarding': (context) =>
                          const OnboardingScreen(isReplay: true),
                    },
                    debugShowCheckedModeBanner: false,
                  );
                },
              );
            },
      ),
    );
  }
}
