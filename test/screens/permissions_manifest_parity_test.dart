import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_qr_studio/screens/settings_screen.dart';

/// Permissions that plugins add to the merged manifest (so they are not in
/// the app's own manifest) but that the app really uses. Each one must still
/// be explained on the Permissions screen.
const Set<String> _pluginAddedPermissions = {
  'USE_FINGERPRINT', // local_auth, older-phone form of USE_BIOMETRIC
};

void main() {
  final manifest = File('android/app/src/main/AndroidManifest.xml')
      .readAsStringSync();
  final tag = RegExp(r'<uses-permission\b[^>]*>');
  final name = RegExp(r'android:name="android\.permission\.([A-Z_]+)"');

  final requested = <String>{};
  final removed = <String>{};
  for (final match in tag.allMatches(manifest)) {
    final element = match.group(0)!;
    final permission = name.firstMatch(element)?.group(1);
    if (permission == null) continue;
    if (element.contains('tools:node="remove"')) {
      removed.add(permission);
    } else {
      requested.add(permission);
    }
  }

  Set<String> screenPermissions({required bool requestedGroup}) => {
    for (final group in kPermissionGroups)
      if (group.requested == requestedGroup)
        for (final entry in group.entries) ...entry.androidPermissions,
  };

  test('the manifest was read', () {
    expect(requested, contains('CAMERA'));
  });

  test('every permission in the manifest is explained on the screen', () {
    final missing = requested.difference(
      screenPermissions(requestedGroup: true),
    );
    expect(missing, isEmpty, reason: 'Add these to kPermissionGroups');
  });

  test('the screen lists no permission the app does not have', () {
    final extra = screenPermissions(requestedGroup: true)
        .difference({...requested, ..._pluginAddedPermissions});
    expect(extra, isEmpty);
  });

  test('"not asked for" permissions are not requested', () {
    final notAsked = screenPermissions(requestedGroup: false);
    expect(notAsked.intersection(requested), isEmpty);
    expect(notAsked.intersection(_pluginAddedPermissions), isEmpty);
  });

  test('permissions removed from plugins are shown as not asked for', () {
    expect(
      removed.difference(screenPermissions(requestedGroup: false)),
      isEmpty,
    );
  });
}
