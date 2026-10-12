import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/l10n/sa_material_localizations.dart';

/// The three app languages, for tests that run a screen in each one.
const List<Locale> appTestLocales = [Locale('en'), Locale('ml'), Locale('sa')];

/// Wraps [home] in a [MaterialApp] set up like the real app: the same
/// localization delegates (including the Sanskrit fallbacks) and [locale].
Widget buildTestApp({
  required Widget home,
  Locale locale = const Locale('en'),
  List<SingleChildWidget> providers = const [],
}) {
  final app = MaterialApp(
    locale: locale,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      SaMaterialLocalizationsDelegate(),
      SaCupertinoLocalizationsDelegate(),
      SaWidgetsLocalizationsDelegate(),
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: home,
  );
  if (providers.isEmpty) return app;
  return MultiProvider(providers: providers, child: app);
}

/// The strings for [locale], to compare against what a screen shows.
AppLocalizations l10nFor(Locale locale) => lookupAppLocalizations(locale);

/// Platform channels the camera screens talk to at start-up.
const List<String> _quietChannels = [
  'receive_sharing_intent/messages',
  'receive_sharing_intent/events-media',
  'in.sreerajp.qr_studio/ghost_scan',
  'in.sreerajp.qr_studio/clipboard',
  'in.sreerajp.qr_studio/scan_bubble',
  'in.sreerajp.qr_studio/ambient_light',
];

/// Fakes the Android side for the camera screens: camera permission is
/// answered "denied" (or "granted" when [granted] is true) and the other
/// start-up channels answer nothing. There is still no real camera, so a
/// screen that starts the camera gets a camera error.
///
/// Returns how many times the camera permission was requested.
ValueNotifier<int> fakeCameraPlatform({bool granted = false}) {
  // PermissionStatus values used by permission_handler: 0 denied, 1 granted.
  final status = granted ? 1 : 0;
  final requests = ValueNotifier<int>(0);
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  const permissions = MethodChannel('flutter.baseflow.com/permissions/methods');
  messenger.setMockMethodCallHandler(permissions, (call) async {
    switch (call.method) {
      case 'requestPermissions':
        requests.value++;
        final asked = (call.arguments as List).cast<int>();
        return {for (final p in asked) p: status};
      case 'checkPermissionStatus':
        return status;
      case 'shouldShowRequestPermissionRationale':
        return false;
      default:
        return null;
    }
  });
  for (final name in _quietChannels) {
    messenger.setMockMethodCallHandler(MethodChannel(name), (_) async => null);
  }

  addTearDown(() {
    messenger.setMockMethodCallHandler(permissions, null);
    for (final name in _quietChannels) {
      messenger.setMockMethodCallHandler(MethodChannel(name), null);
    }
  });
  return requests;
}
