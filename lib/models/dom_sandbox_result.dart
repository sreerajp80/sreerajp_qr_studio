import 'package:sreerajp_qr_studio/models/app_message.dart';
import 'package:material_ui/material_ui.dart';

/// Model representing the results of the Zero-Trust Sandboxed HTML Pre-Render Previewer.
class DomSandboxResult {
  final String url;
  final String? pageTitle;
  final String? metaDescription;
  final String? faviconUrl;
  final List<String> headings;
  final List<String> paragraphs;
  final List<String> links;
  final int blockedScriptsCount;
  final int blockedTrackersCount;
  final int blockedIframesCount;
  final bool hasOpenRedirect;
  final String? redirectTarget;
  final DateTime? domainCreationDate;
  final int? domainAgeDays;
  final bool sslValid;
  final AppMessage sslDetails;
  final bool isSanitized;
  final String? sanitizedBodyHtml;
  final Color? pageThemeColor;
  final AppMessage statusMessage;

  /// True when the live page could not be fetched (offline, timeout or
  /// network error). [pageTitle] then holds only the host name.
  final bool fetchFailed;

  const DomSandboxResult({
    required this.url,
    this.pageTitle,
    this.metaDescription,
    this.faviconUrl,
    this.headings = const [],
    this.paragraphs = const [],
    this.links = const [],
    required this.blockedScriptsCount,
    required this.blockedTrackersCount,
    required this.blockedIframesCount,
    required this.hasOpenRedirect,
    this.redirectTarget,
    this.domainCreationDate,
    this.domainAgeDays,
    required this.sslValid,
    required this.sslDetails,
    required this.isSanitized,
    this.sanitizedBodyHtml,
    this.pageThemeColor,
    required this.statusMessage,
    this.fetchFailed = false,
  });

  /// True if domain age is considered newly registered (< 30 days old).
  bool get isNewlyRegisteredDomain =>
      domainAgeDays != null && domainAgeDays! < 30;

  /// Overall risk score derived from sandbox security heuristics.
  bool get isSafe =>
      sslValid &&
      !hasOpenRedirect &&
      !isNewlyRegisteredDomain &&
      blockedTrackersCount < 10;
}
