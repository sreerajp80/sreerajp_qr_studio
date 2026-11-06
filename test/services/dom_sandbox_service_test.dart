import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:sreerajp_qr_studio/services/dom_sandbox_service.dart';

void main() {
  group('DomSandboxService Tests', () {
    test(
      'Offline / Private mode generates sanitized local pre-render model',
      () async {
        final service = DomSandboxService();
        final result = await service.analyzeAndRender(
          'https://example.com/login',
        );

        expect(result.url, equals('https://example.com/login'));
        expect(result.isSanitized, isTrue);
        expect(result.sslValid, isTrue);
        expect(result.pageTitle, equals('example.com'));
        expect(result.headings, contains('example.com'));
      },
    );

    test('A failed page fetch is flagged without English text', () async {
      final service = DomSandboxService(
        httpClient: MockClient((_) async => throw Exception('offline')),
      );
      final result = await service.analyzeAndRender(
        'https://example.com/login',
        activeProbing: true,
      );

      expect(result.fetchFailed, isTrue);
      expect(result.pageTitle, equals('example.com'));
    });

    test('Private mode is not marked as a failed fetch', () async {
      final result = await DomSandboxService().analyzeAndRender(
        'https://example.com',
      );
      expect(result.fetchFailed, isFalse);
    });

    test(
      'Strips script tags, inline handlers, and tracking pixels from HTML',
      () async {
        const mockHtml = '''
        <!DOCTYPE html>
        <html>
        <head>
          <title>Test Security Portal</title>
          <meta name="description" content="A test security portal page">
          <meta name="theme-color" content="#008080">
          <script>console.log("malicious script");</script>
        </head>
        <body onload="alert('exploit')">
          <h1>Welcome to Security Portal</h1>
          <p>This is a safe text paragraph inside the DOM hierarchy.</p>
          <iframe src="https://exploit.com/frame"></iframe>
          <img src="https://tracker.com/pixel.gif" width="1" height="1">
          <a href="https://example.com/dashboard">Dashboard</a>
        </body>
        </html>
      ''';

        final mockClient = MockClient((request) async {
          return http.Response(
            mockHtml,
            200,
            headers: {'content-type': 'text/html; charset=utf-8'},
          );
        });

        final service = DomSandboxService(httpClient: mockClient);
        final result = await service.analyzeAndRender(
          'https://example.com',
          activeProbing: true,
        );

        expect(result.pageTitle, equals('Test Security Portal'));
        expect(result.metaDescription, equals('A test security portal page'));
        expect(result.headings, contains('Welcome to Security Portal'));
        expect(
          result.paragraphs,
          contains('This is a safe text paragraph inside the DOM hierarchy.'),
        );
        expect(result.links, contains('https://example.com/dashboard'));
        expect(result.blockedScriptsCount, equals(2)); // <script> + onload
        expect(result.blockedIframesCount, equals(1)); // <iframe>
        expect(result.blockedTrackersCount, equals(1)); // 1x1 image
        expect(result.isSanitized, isTrue);
      },
    );

    test('Detects open redirect traps in URL query parameters', () async {
      final service = DomSandboxService();
      final result = await service.analyzeAndRender(
        'https://login-portal.com/login?redirect=https://evil-phishing.com/steal',
      );

      expect(result.hasOpenRedirect, isTrue);
      expect(result.redirectTarget, equals('https://evil-phishing.com/steal'));
      expect(result.isSafe, isFalse);
    });
  });
  _bodyLimitTests();
}

/// Client that answers like the real `IOClient` after following a redirect:
/// status 200, with [finalUrl] as the response URL.
class _RedirectedClient extends http.BaseClient {
  final Uri finalUrl;
  _RedirectedClient(this.finalUrl);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async =>
      _UrlStreamedResponse(
        Stream.value(utf8.encode('<html><title>Final</title></html>')),
        200,
        finalUrl,
      );
}

class _UrlStreamedResponse extends http.StreamedResponse
    implements http.BaseResponseWithUrl {
  @override
  final Uri url;
  _UrlStreamedResponse(super.stream, super.statusCode, this.url);
}

void _bodyLimitTests() {
  group('DomSandboxService body limits', () {
    test('stops reading at the byte cap', () async {
      final chunk = List<int>.filled(1000, 0x61);
      final text = await DomSandboxService.readCappedBody(
        Stream.fromIterable(List.generate(20, (_) => chunk)),
        maxBytes: 2500,
      );
      expect(text.length, 2500);
    });

    test('a stalled stream fails instead of hanging', () async {
      final controller = StreamController<List<int>>();
      controller.add([0x61]);
      await expectLater(
        DomSandboxService.readCappedBody(
          controller.stream,
          stallTimeout: const Duration(milliseconds: 50),
        ),
        throwsA(isA<TimeoutException>()),
      );
      await controller.close();
    });

    test('stops at the total time limit and keeps what was read', () async {
      final stream = Stream<List<int>>.periodic(
        const Duration(milliseconds: 10),
        (_) => [0x61],
      );
      final text = await DomSandboxService.readCappedBody(
        stream,
        totalTimeout: const Duration(milliseconds: 60),
      );
      expect(text, isNotEmpty);
      expect(text.length, lessThan(50));
    });

    test('a page cut mid-character still decodes', () async {
      final bytes = utf8.encode('അ'); // 3 bytes
      final text = await DomSandboxService.readCappedBody(
        Stream.value(bytes),
        maxBytes: 2,
      );
      expect(text, isNotEmpty);
    });
  });

  group('DomSandboxService redirect detection', () {
    test('a followed redirect to another host is flagged', () async {
      final service = DomSandboxService(
        httpClient: _RedirectedClient(Uri.parse('https://evil.example/x')),
      );
      final result = await service.analyzeAndRender(
        'https://short.example/a',
        activeProbing: true,
      );
      expect(result.hasOpenRedirect, isTrue);
      expect(result.redirectTarget, 'https://evil.example/x');
    });

    test('a same-host redirect is not flagged', () async {
      final service = DomSandboxService(
        httpClient: _RedirectedClient(Uri.parse('https://short.example/b')),
      );
      final result = await service.analyzeAndRender(
        'http://short.example/a',
        activeProbing: true,
      );
      expect(result.hasOpenRedirect, isFalse);
    });
  });
}
