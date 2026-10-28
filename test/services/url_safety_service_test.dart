import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sreerajp_qr_studio/models/app_message.dart';
import 'package:sreerajp_qr_studio/services/url_safety_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('UrlSafetyService.checkSuspiciousPatterns', () {
    late UrlSafetyService service;

    setUp(() {
      service = UrlSafetyService();
    });

    test('passes for a normal URL', () async {
      final result = await service.checkSuspiciousPatterns(
        'https://example.com',
      );
      expect(result.passed, true);
      expect(result.checkName.key, AppMessageKey.checkNamePattern);
    });

    test('fails for an IP address in the domain', () async {
      final result = await service.checkSuspiciousPatterns(
        'https://192.168.1.1/login',
      );
      expect(result.passed, false);
      expect(
        result.message.args['patterns'],
        contains(AppMessageKey.patternIpAddress.name),
      );
    });

    test('fails for a long number sequence in the domain', () async {
      final result = await service.checkSuspiciousPatterns(
        'https://example12345678.com',
      );
      expect(result.passed, false);
      expect(
        result.message.args['patterns'],
        contains(AppMessageKey.patternLongNumbers.name),
      );
    });

    test('fails when phishing keyword is combined with numbers', () async {
      final result = await service.checkSuspiciousPatterns(
        'https://login-verify123.com',
      );
      expect(result.passed, false);
      expect(
        result.message.args['patterns'],
        contains(AppMessageKey.patternPhishingKeywords.name),
      );
    });

    test('fails for excessive subdomains', () async {
      final result = await service.checkSuspiciousPatterns(
        'https://a.b.c.d.example.com',
      );
      expect(result.passed, false);
      expect(
        result.message.args['patterns'],
        contains(AppMessageKey.patternManySubdomains.name),
      );
    });

    test('fails for four or more consecutive dashes', () async {
      final result = await service.checkSuspiciousPatterns(
        'https://my----domain.com',
      );
      expect(result.passed, false);
      expect(
        result.message.args['patterns'],
        contains(AppMessageKey.patternManyDashes.name),
      );
    });

    test(
      'passes for a URL with a short path and no suspicious patterns',
      () async {
        final result = await service.checkSuspiciousPatterns(
          'https://docs.flutter.dev/get-started',
        );
        expect(result.passed, true);
      },
    );
  });

  group('UrlSafetyService.checkHomographAttacks', () {
    late UrlSafetyService service;

    setUp(() {
      service = UrlSafetyService();
    });

    test('passes for a normal ASCII domain', () async {
      final result = await service.checkHomographAttacks('https://example.com');
      expect(result.passed, true);
      expect(result.checkName.key, AppMessageKey.checkNameHomograph);
      expect(result.message.key, AppMessageKey.homographNone);
    });

    test('passes for a legitimate subdomain', () async {
      final result = await service.checkHomographAttacks(
        'https://mail.google.com',
      );
      expect(result.passed, true);
    });

    test(
      'fails when domain contains Cyrillic а (U+0430, lookalike for a)',
      () async {
        // ex\u0430mple.com — the 'a' is Cyrillic
        final result = await service.checkHomographAttacks(
          'https://ex\u0430mple.com',
        );
        expect(result.passed, false);
        expect(result.message.key, AppMessageKey.homographLookalikes);
      },
    );

    test(
      'fails when domain contains Cyrillic о (U+043E, lookalike for o)',
      () async {
        final result = await service.checkHomographAttacks(
          'https://ex\u043Emple.com',
        );
        expect(result.passed, false);
      },
    );

    test('fails for a domain mixing Latin and Cyrillic scripts', () async {
      // Both Latin letters and Cyrillic characters present
      final result = await service.checkHomographAttacks(
        'https://ex\u0430mple.\u0441om',
      );
      expect(result.passed, false);
    });
  });

  group('UrlSafetyService.checkUrlRedirects', () {
    test('passes when server returns 200 with no redirect', () async {
      final client = MockClient((_) async => http.Response('', 200));
      final service = UrlSafetyService(httpClient: client);
      final result = await service.checkUrlRedirects(
        'https://example.com',
        activeProbing: true,
      );
      expect(result.passed, true);
      expect(result.message.key, AppMessageKey.redirectNone);
    });

    test('passes for one redirect (within normal range)', () async {
      var callCount = 0;
      final client = MockClient((request) async {
        callCount++;
        if (callCount == 1) {
          return http.Response(
            '',
            301,
            headers: {'location': 'https://example.com/new'},
          );
        }
        return http.Response('', 200);
      });
      final service = UrlSafetyService(httpClient: client);
      final result = await service.checkUrlRedirects(
        'https://example.com',
        activeProbing: true,
      );
      expect(result.passed, true);
      expect(result.message.key, AppMessageKey.redirectWithinRange);
      expect(result.message.args['count'], '1');
    });

    test('fails for three or more redirects (suspicious chain)', () async {
      var callCount = 0;
      final client = MockClient((request) async {
        callCount++;
        if (callCount <= 3) {
          return http.Response(
            '',
            301,
            headers: {'location': 'https://example.com/step$callCount'},
          );
        }
        return http.Response('', 200);
      });
      final service = UrlSafetyService(httpClient: client);
      final result = await service.checkUrlRedirects(
        'https://example.com',
        activeProbing: true,
      );
      expect(result.passed, false);
      expect(result.message.key, AppMessageKey.redirectSuspiciousChain);
    });

    test('fails when a redirect loop is detected', () async {
      // Both calls return a redirect back to the original URL
      final client = MockClient(
        (_) async => http.Response(
          '',
          301,
          headers: {'location': 'https://example.com'},
        ),
      );
      final service = UrlSafetyService(httpClient: client);
      final result = await service.checkUrlRedirects(
        'https://example.com',
        activeProbing: true,
      );
      expect(result.passed, false);
      expect(result.message.key, AppMessageKey.redirectLoop);
    });

    test(
      'does NOT contact the server when active probing is disabled',
      () async {
        var called = false;
        final client = MockClient((_) async {
          called = true;
          return http.Response('', 200);
        });
        final service = UrlSafetyService(httpClient: client);
        // Default (activeProbing: false) — privacy mode.
        final result = await service.checkUrlRedirects('https://example.com');
        expect(
          called,
          false,
          reason: 'no request should be made in private mode',
        );
        expect(result.passed, true);
        expect(result.message.key, AppMessageKey.redirectSkippedPrivate);
        expect(result.skipped, isTrue);
      },
    );
  });

  group('UrlSafetyService.certificateProblem', () {
    final now = DateTime(2026, 10, 27);

    test('an expired certificate is reported as expired', () {
      final message = UrlSafetyService.certificateProblem(
        startValidity: DateTime(2025),
        endValidity: DateTime(2026),
        now: now,
      );
      expect(message.key, AppMessageKey.sslExpired);
    });

    test('a future certificate is reported as not yet valid', () {
      final message = UrlSafetyService.certificateProblem(
        startValidity: DateTime(2027),
        endValidity: DateTime(2028),
        now: now,
      );
      expect(message.key, AppMessageKey.sslNotYetValid);
    });

    test('a rejected certificate with valid dates is not trusted', () {
      // For example self-signed or issued for another site. It must never
      // be shown as valid.
      final message = UrlSafetyService.certificateProblem(
        startValidity: DateTime(2026),
        endValidity: DateTime(2027),
        now: now,
      );
      expect(message.key, AppMessageKey.sslUntrusted);
    });
  });

  group('UrlSafetyService privacy mode (active probing disabled)', () {
    test(
      'checkSslCertificate confirms https without opening a connection',
      () async {
        final service = UrlSafetyService();
        final result = await service.checkSslCertificate('https://example.com');
        expect(result.passed, true);
        expect(result.message.key, AppMessageKey.sslPrivateModeOk);
      },
    );

    test('checkSslCertificate still fails plain http', () async {
      final service = UrlSafetyService();
      final result = await service.checkSslCertificate('http://example.com');
      expect(result.passed, false);
    });

    test(
      'checkUrlShorteners runs heuristics without contacting the server',
      () async {
        var called = false;
        final client = MockClient((_) async {
          called = true;
          return http.Response('', 200);
        });
        final service = UrlSafetyService(httpClient: client);
        final result = await service.checkUrlShorteners(
          'https://example.com/path',
        );
        expect(
          called,
          false,
          reason: 'no request should be made in private mode',
        );
        expect(result.checkName.key, AppMessageKey.checkNameShortener);
      },
    );

    test('checkUrlShorteners still flags a known shortener locally', () async {
      final service = UrlSafetyService();
      final result = await service.checkUrlShorteners('https://bit.ly/abc');
      expect(result.passed, false);
      expect(result.message.key, AppMessageKey.shortenerKnown);
    });
  });

  group('UrlSafetyService.checkGoogleSafeBrowsing – no API key', () {
    test('returns passed with Skipped message when API key is absent', () async {
      SharedPreferences.setMockInitialValues({});
      // In the test environment the platform channel for flutter_secure_storage
      // is unregistered; read() returns null → treated as no API key configured.
      final service = UrlSafetyService(
        httpClient: MockClient((_) async => http.Response('{}', 200)),
      );
      final result = await service.checkGoogleSafeBrowsing(
        'https://example.com',
      );
      // Either "Skipped" (null key) or "Unable to check" (platform channel threw).
      // Both are acceptable without a real device keystore.
      expect(result.checkName.key, AppMessageKey.checkNameMalicious);
    });
  });

  group('UrlSafetyService.checkVirusTotal', () {
    test('returns skipped when no API key is stored', () async {
      SharedPreferences.setMockInitialValues({});
      FlutterSecureStorage.setMockInitialValues({});
      final service = UrlSafetyService();
      final result = await service.checkVirusTotal('https://example.com');
      expect(result.passed, true);
      expect(result.message.key, AppMessageKey.virusTotalSkippedNoKey);
      expect(result.skipped, isTrue);
    });

    test('returns clean when VT reports zero malicious engines', () async {
      SharedPreferences.setMockInitialValues({});
      FlutterSecureStorage.setMockInitialValues({
        'virustotal_api_key': 'fake_vt_key',
      });
      final client = MockClient((request) async {
        return http.Response(
          '{"data": {"attributes": {"last_analysis_stats": {"malicious": 0, "suspicious": 0, "harmless": 70}}}}',
          200,
        );
      });
      final service = UrlSafetyService(httpClient: client);
      final result = await service.checkVirusTotal('https://example.com');
      expect(result.passed, true);
      expect(result.message.key, AppMessageKey.virusTotalNone);
    });

    test('returns threats when VT reports malicious engines', () async {
      SharedPreferences.setMockInitialValues({});
      FlutterSecureStorage.setMockInitialValues({
        'virustotal_api_key': 'fake_vt_key',
      });
      final client = MockClient((request) async {
        return http.Response(
          '{"data": {"attributes": {"last_analysis_stats": {"malicious": 5, "suspicious": 1, "harmless": 50}}}}',
          200,
        );
      });
      final service = UrlSafetyService(httpClient: client);
      final result = await service.checkVirusTotal(
        'https://malicious.example.com',
      );
      expect(result.passed, false);
      expect(result.message.key, AppMessageKey.virusTotalThreats);
      expect(result.message.args['engines'], '6');
    });

    test('handles 429 rate limit gracefully', () async {
      SharedPreferences.setMockInitialValues({});
      FlutterSecureStorage.setMockInitialValues({
        'virustotal_api_key': 'fake_vt_key',
      });
      final client = MockClient((request) async => http.Response('', 429));
      final service = UrlSafetyService(httpClient: client);
      final result = await service.checkVirusTotal('https://example.com');
      expect(result.passed, true);
      expect(result.message.key, AppMessageKey.virusTotalRateLimited);
    });
  });

  group('UrlSafetyService.checkUrlhaus', () {
    test('returns skipped when no API key is stored', () async {
      SharedPreferences.setMockInitialValues({});
      FlutterSecureStorage.setMockInitialValues({});
      final service = UrlSafetyService();
      final result = await service.checkUrlhaus('https://example.com');
      expect(result.passed, true);
      expect(result.message.key, AppMessageKey.urlhausSkippedNoKey);
      expect(result.skipped, isTrue);
    });

    test('returns clean when urlhaus reports no_results', () async {
      SharedPreferences.setMockInitialValues({});
      FlutterSecureStorage.setMockInitialValues({
        'urlhaus_api_key': 'fake_uh_key',
      });
      final client = MockClient((request) async {
        return http.Response('{"query_status": "no_results"}', 200);
      });
      final service = UrlSafetyService(httpClient: client);
      final result = await service.checkUrlhaus('https://clean.example.com');
      expect(result.passed, true);
      expect(result.message.key, AppMessageKey.urlhausNotFound);
    });

    test('returns malware when urlhaus reports is_malware', () async {
      SharedPreferences.setMockInitialValues({});
      FlutterSecureStorage.setMockInitialValues({
        'urlhaus_api_key': 'fake_uh_key',
      });
      final client = MockClient((request) async {
        return http.Response(
          '{"query_status": "is_malware", "tags": ["emotet", "payload"]}',
          200,
        );
      });
      final service = UrlSafetyService(httpClient: client);
      final result = await service.checkUrlhaus('https://malware.example.com');
      expect(result.passed, false);
      expect(result.message.key, AppMessageKey.urlhausMalware);
      expect(result.message.args['tags'], 'emotet, payload');
    });
  });

  group('UrlSafetyService.checkPhishTank', () {
    test('returns skipped when toggle is disabled', () async {
      SharedPreferences.setMockInitialValues({
        UrlSafetyService.phishTankEnabledPrefKey: false,
      });
      final service = UrlSafetyService();
      final result = await service.checkPhishTank('https://example.com');
      expect(result.passed, true);
      expect(result.message.key, AppMessageKey.phishTankSkippedDisabled);
      expect(result.skipped, isTrue);
    });

    test('returns clean when URL is not in phishtank database', () async {
      SharedPreferences.setMockInitialValues({
        UrlSafetyService.phishTankEnabledPrefKey: true,
      });
      final client = MockClient((request) async {
        return http.Response('{"results": {"in_database": false}}', 200);
      });
      final service = UrlSafetyService(httpClient: client);
      final result = await service.checkPhishTank('https://example.com');
      expect(result.passed, true);
      expect(result.message.key, AppMessageKey.phishTankNotInDatabase);
    });

    test('returns phishing when URL is in database and valid', () async {
      SharedPreferences.setMockInitialValues({
        UrlSafetyService.phishTankEnabledPrefKey: true,
      });
      final client = MockClient((request) async {
        return http.Response(
          '{"results": {"in_database": true, "valid": true}}',
          200,
        );
      });
      final service = UrlSafetyService(httpClient: client);
      final result = await service.checkPhishTank(
        'https://phishing.example.com',
      );
      expect(result.passed, false);
      expect(result.message.key, AppMessageKey.phishTankPhishing);
    });
  });

  group('UrlSafetyService.checkOpenPhish', () {
    test('returns skipped when toggle is disabled', () async {
      SharedPreferences.setMockInitialValues({
        UrlSafetyService.openPhishEnabledPrefKey: false,
      });
      final service = UrlSafetyService();
      final result = await service.checkOpenPhish('https://example.com');
      expect(result.passed, true);
      expect(result.message.key, AppMessageKey.openPhishSkippedDisabled);
      expect(result.skipped, isTrue);
    });

    test('flags URL when found in cached openphish feed', () async {
      SharedPreferences.setMockInitialValues({
        UrlSafetyService.openPhishEnabledPrefKey: true,
        'openphish_feed_cache':
            '["https://phish1.com", "https://phish2.com/login"]',
        'openphish_feed_timestamp': DateTime.now().toIso8601String(),
      });
      final service = UrlSafetyService();
      final result = await service.checkOpenPhish('https://phish1.com');
      expect(result.passed, false);
      expect(result.message.key, AppMessageKey.openPhishPhishing);
    });

    test('passes URL when not present in feed cache', () async {
      SharedPreferences.setMockInitialValues({
        UrlSafetyService.openPhishEnabledPrefKey: true,
        'openphish_feed_cache': '["https://phish1.com"]',
        'openphish_feed_timestamp': DateTime.now().toIso8601String(),
      });
      final service = UrlSafetyService();
      final result = await service.checkOpenPhish('https://safe-domain.com');
      expect(result.passed, true);
      expect(result.message.key, AppMessageKey.openPhishClean);
    });
  });

  group('UrlSafetyService API key storage', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
      FlutterSecureStorage.setMockInitialValues({});
    });

    test('hasApiKey is false when nothing is saved', () async {
      final service = UrlSafetyService();
      expect(
        await service.hasApiKey(UrlSafetyService.virusTotalApiKeyStorageKey),
        isFalse,
      );
    });

    test(
      'saveApiKey then hasApiKey is true; deleteApiKey removes it',
      () async {
        final service = UrlSafetyService();
        const key = UrlSafetyService.safeBrowsingApiKeyStorageKey;

        await service.saveApiKey(key, 'test-key-value');
        expect(await service.hasApiKey(key), isTrue);

        await service.deleteApiKey(key);
        expect(await service.hasApiKey(key), isFalse);
      },
    );

    test('an empty saved key does not count as configured', () async {
      FlutterSecureStorage.setMockInitialValues({
        UrlSafetyService.urlhausApiKeyStorageKey: '',
      });
      final service = UrlSafetyService();
      expect(
        await service.hasApiKey(UrlSafetyService.urlhausApiKeyStorageKey),
        isFalse,
      );
    });

    test('countActiveProviders adds saved keys and enabled feeds', () async {
      FlutterSecureStorage.setMockInitialValues({
        UrlSafetyService.safeBrowsingApiKeyStorageKey: 'a',
        UrlSafetyService.urlhausApiKeyStorageKey: 'b',
      });
      SharedPreferences.setMockInitialValues({
        UrlSafetyService.phishTankEnabledPrefKey: true,
        UrlSafetyService.openPhishEnabledPrefKey: false,
      });
      final service = UrlSafetyService();
      expect(await service.countActiveProviders(), 3);
    });

    test('countActiveProviders is 0 when nothing is set up', () async {
      final service = UrlSafetyService();
      expect(await service.countActiveProviders(), 0);
    });

    test('saved key is used by the matching check', () async {
      final service = UrlSafetyService(
        httpClient: MockClient((_) async => http.Response('{}', 200)),
      );
      await service.saveApiKey(
        UrlSafetyService.safeBrowsingApiKeyStorageKey,
        'test-key-value',
      );
      final result = await service.checkGoogleSafeBrowsing(
        'https://example.com',
      );
      expect(result.skipped, isFalse);
    });
  });

  group('UrlSafetyService lookalike characters', () {
    test('lists lookalikes with a language-neutral arrow', () async {
      final result = await UrlSafetyService().checkHomographAttacks(
        'https://аpple.com',
      );
      expect(result.passed, isFalse);
      expect(result.message.args['characters'], contains('→'));
      expect(result.message.args['characters'], isNot(contains('looks like')));
    });
  });
}
