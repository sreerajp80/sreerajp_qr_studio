import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Adds the licences of native code built into the app (not covered by
/// pub packages) to Flutter's licence page.
///
/// zxing-cpp is Apache-2.0; its bundled libzueci is BSD-3-Clause. Both
/// licences require their text to ship with the app.
abstract final class OpenSourceLicenses {
  static const String zxingCppAsset = 'assets/licenses/zxing-cpp.txt';
  static const String libzueciAsset = 'assets/licenses/libzueci.txt';

  static bool _registered = false;

  /// Registers the licences once. Safe to call more than once.
  static void register() {
    if (_registered) return;
    _registered = true;
    LicenseRegistry.addLicense(() async* {
      yield LicenseEntryWithLineBreaks(const [
        'zxing-cpp',
      ], await rootBundle.loadString(zxingCppAsset));
      yield LicenseEntryWithLineBreaks(const [
        'libzueci (part of zxing-cpp)',
      ], await rootBundle.loadString(libzueciAsset));
    });
  }
}
