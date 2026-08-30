import 'package:flutter_test/flutter_test.dart';
import 'package:sreeraj_qr_reader/core/constants/app_version.g.dart';
import 'package:sreeraj_qr_reader/core/constants/build_date.g.dart';

void main() {
  group('Build Metadata Constants', () {
    test('kAppVersion is non-empty and formatted correctly', () {
      expect(kAppVersion, isNotEmpty);
      expect(kAppVersion.contains('+'), isTrue);
    });

    test('kBuildDate is formatted as YYYY-MM-DD', () {
      expect(kBuildDate, isNotEmpty);
      final dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
      expect(dateRegex.hasMatch(kBuildDate), isTrue);
    });
  });
}
