import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/models/app_message.dart';

/// Turns an [AppMessage] produced by a service into text the user can read.
///
/// This is the only place that joins message keys to words. Services return
/// keys; screens call this with the [AppLocalizations] from their context.
String appMessageText(AppLocalizations l10n, AppMessage message) {
  final args = message.args;

  switch (message.key) {
    // names of the link safety checks
    case AppMessageKey.checkNameHttps:
      return l10n.labelCheckNameHttps;
    case AppMessageKey.checkNameSsl:
      return l10n.labelCheckNameSsl;
    case AppMessageKey.checkNameRedirect:
      return l10n.labelCheckNameRedirect;
    case AppMessageKey.checkNamePattern:
      return l10n.labelCheckNamePattern;
    case AppMessageKey.checkNameShortener:
      return l10n.labelCheckNameShortener;
    case AppMessageKey.checkNameHomograph:
      return l10n.labelCheckNameHomograph;
    case AppMessageKey.checkNameMalicious:
      return l10n.labelCheckNameMalicious;

    // HTTPS and certificate
    case AppMessageKey.httpsNotUsed:
      return l10n.bodyHttpsNotUsed;
    case AppMessageKey.sslPrivateModeOk:
      return l10n.bodySslPrivateModeOk;
    case AppMessageKey.sslValid:
      return l10n.bodySslValid;
    case AppMessageKey.sslExpired:
      return l10n.bodySslExpired;
    case AppMessageKey.sslNotYetValid:
      return l10n.bodySslNotYetValid;
    case AppMessageKey.sslUntrusted:
      return l10n.bodySslUntrusted;
    case AppMessageKey.sslUnverifiable:
      return l10n.bodySslUnverifiable;
    case AppMessageKey.sslCheckFailed:
      return l10n.bodySslCheckFailed;

    // redirects
    case AppMessageKey.redirectSkippedPrivate:
      return l10n.bodyRedirectSkippedPrivate;
    case AppMessageKey.redirectLoop:
      return l10n.bodyRedirectLoop;
    case AppMessageKey.redirectNone:
      return l10n.bodyRedirectNone;
    case AppMessageKey.redirectSuspiciousChain:
      return l10n.bodyRedirectSuspiciousChain(args['count'] ?? '');
    case AppMessageKey.redirectWithinRange:
      return l10n.bodyRedirectWithinRange(args['count'] ?? '');
    case AppMessageKey.redirectUnavailable:
      return l10n.bodyRedirectUnavailable;

    // suspicious patterns
    case AppMessageKey.patternNone:
      return l10n.bodyPatternNone;
    case AppMessageKey.patternDetected:
      return l10n.bodyPatternDetected(
        _patternList(l10n, args['patterns'] ?? ''),
      );
    case AppMessageKey.patternIpAddress:
      return l10n.labelPatternIpAddress;
    case AppMessageKey.patternLongNumbers:
      return l10n.labelPatternLongNumbers;
    case AppMessageKey.patternManyDashes:
      return l10n.labelPatternManyDashes;
    case AppMessageKey.patternPhishingKeywords:
      return l10n.labelPatternPhishingKeywords;
    case AppMessageKey.patternDataUri:
      return l10n.labelPatternDataUri;
    case AppMessageKey.patternManySubdomains:
      return l10n.labelPatternManySubdomains;
    case AppMessageKey.patternUnavailable:
      return l10n.bodyPatternUnavailable;

    // URL shorteners
    case AppMessageKey.shortenerKnown:
      return l10n.bodyShortenerKnown(args['shortener'] ?? '');
    case AppMessageKey.shortenerRedirect:
      return l10n.bodyShortenerRedirect(args['host'] ?? '');
    case AppMessageKey.shortenerPossibleShortDomain:
      return l10n.bodyShortenerPossibleShortDomain;
    case AppMessageKey.shortenerPossibleTld:
      return l10n.bodyShortenerPossibleTld(args['tld'] ?? '');
    case AppMessageKey.shortenerPossibleRandomPath:
      return l10n.bodyShortenerPossibleRandomPath;
    case AppMessageKey.shortenerOfflineHeuristics:
      return l10n.bodyShortenerOfflineHeuristics;
    case AppMessageKey.shortenerNone:
      return l10n.bodyShortenerNone;
    case AppMessageKey.shortenerUnavailable:
      return l10n.bodyShortenerUnavailable;

    // lookalike characters
    case AppMessageKey.homographLookalikes:
      return l10n.bodyHomographLookalikes(args['characters'] ?? '');
    case AppMessageKey.homographMixedScripts:
      return l10n.bodyHomographMixedScripts;
    case AppMessageKey.homographNone:
      return l10n.bodyHomographNone;
    case AppMessageKey.homographUnavailable:
      return l10n.bodyHomographUnavailable;

    // Google Safe Browsing
    case AppMessageKey.maliciousSkippedNoKey:
      return l10n.bodyMaliciousSkippedNoKey;
    case AppMessageKey.maliciousDailyLimit:
      return l10n.bodyMaliciousDailyLimit;
    case AppMessageKey.maliciousThreats:
      return l10n.bodyMaliciousThreats(args['threats'] ?? '');
    case AppMessageKey.maliciousNone:
      return l10n.bodyMaliciousNone;
    case AppMessageKey.maliciousInvalidKey:
      return l10n.bodyMaliciousInvalidKey;
    case AppMessageKey.maliciousRateLimited:
      return l10n.bodyMaliciousRateLimited;
    case AppMessageKey.maliciousApiError:
      return l10n.bodyMaliciousApiError(args['status'] ?? '');
    case AppMessageKey.maliciousUnavailable:
      return l10n.bodyMaliciousUnavailable;

    // VirusTotal
    case AppMessageKey.checkNameVirusTotal:
      return l10n.labelCheckNameVirusTotal;
    case AppMessageKey.virusTotalSkippedNoKey:
      return l10n.bodyVirusTotalSkippedNoKey;
    case AppMessageKey.virusTotalDailyLimit:
      return l10n.bodyVirusTotalDailyLimit;
    case AppMessageKey.virusTotalThreats:
      return l10n.bodyVirusTotalThreats(args['engines'] ?? '');
    case AppMessageKey.virusTotalNone:
      return l10n.bodyVirusTotalNone;
    case AppMessageKey.virusTotalInvalidKey:
      return l10n.bodyVirusTotalInvalidKey;
    case AppMessageKey.virusTotalRateLimited:
      return l10n.bodyVirusTotalRateLimited;
    case AppMessageKey.virusTotalApiError:
      return l10n.bodyVirusTotalApiError(args['status'] ?? '');
    case AppMessageKey.virusTotalUnavailable:
      return l10n.bodyVirusTotalUnavailable;

    // URLhaus
    case AppMessageKey.checkNameUrlhaus:
      return l10n.labelCheckNameUrlhaus;
    case AppMessageKey.urlhausSkippedNoKey:
      return l10n.bodyUrlhausSkippedNoKey;
    case AppMessageKey.urlhausMalware:
      return l10n.bodyUrlhausMalware(args['tags'] ?? '');
    case AppMessageKey.urlhausClean:
      return l10n.bodyUrlhausClean;
    case AppMessageKey.urlhausNotFound:
      return l10n.bodyUrlhausNotFound;
    case AppMessageKey.urlhausInvalidKey:
      return l10n.bodyUrlhausInvalidKey;
    case AppMessageKey.urlhausApiError:
      return l10n.bodyUrlhausApiError(args['status'] ?? '');
    case AppMessageKey.urlhausUnavailable:
      return l10n.bodyUrlhausUnavailable;

    // PhishTank
    case AppMessageKey.checkNamePhishTank:
      return l10n.labelCheckNamePhishTank;
    case AppMessageKey.phishTankSkippedDisabled:
      return l10n.bodyPhishTankSkippedDisabled;
    case AppMessageKey.phishTankPhishing:
      return l10n.bodyPhishTankPhishing;
    case AppMessageKey.phishTankClean:
      return l10n.bodyPhishTankClean;
    case AppMessageKey.phishTankNotInDatabase:
      return l10n.bodyPhishTankNotInDatabase;
    case AppMessageKey.phishTankApiError:
      return l10n.bodyPhishTankApiError(args['status'] ?? '');
    case AppMessageKey.phishTankUnavailable:
      return l10n.bodyPhishTankUnavailable;

    // OpenPhish
    case AppMessageKey.checkNameOpenPhish:
      return l10n.labelCheckNameOpenPhish;
    case AppMessageKey.openPhishSkippedDisabled:
      return l10n.bodyOpenPhishSkippedDisabled;
    case AppMessageKey.openPhishPhishing:
      return l10n.bodyOpenPhishPhishing;
    case AppMessageKey.openPhishClean:
      return l10n.bodyOpenPhishClean;
    case AppMessageKey.openPhishFeedStale:
      return l10n.bodyOpenPhishFeedStale;
    case AppMessageKey.openPhishUnavailable:
      return l10n.bodyOpenPhishUnavailable;

    // sandboxed page preview
    case AppMessageKey.domSslInvalidScheme:
      return l10n.bodyDomSslInvalidScheme;
    case AppMessageKey.domSslHttps:
      return l10n.bodyDomSslHttps;
    case AppMessageKey.domSslHttp:
      return l10n.bodyDomSslHttp;
    case AppMessageKey.domStatusInvalidUrl:
      return l10n.bodyDomStatusInvalidUrl;
    case AppMessageKey.domStatusOpenRedirect:
      return l10n.bodyDomStatusOpenRedirect(args['target'] ?? '');
    case AppMessageKey.domStatusHttpCaution:
      return l10n.bodyDomStatusHttpCaution;
    case AppMessageKey.domStatusNewDomain:
      return l10n.bodyDomStatusNewDomain(args['days'] ?? '');
    case AppMessageKey.domStatusSafe:
      return l10n.bodyDomStatusSafe;

    // hidden encrypted payload
    case AppMessageKey.stegoPassphraseEmpty:
      return l10n.errorStegoPassphraseEmpty;
    case AppMessageKey.stegoWrongPassphrase:
      return l10n.errorStegoWrongPassphrase;
    case AppMessageKey.stegoBiometricCanceled:
      return l10n.errorStegoBiometricCanceled;

    // optical stream transfer
    case AppMessageKey.airQrChecksumFailed:
      return l10n.errorAirQrChecksumFailed;

    // encrypted backup files
    case AppMessageKey.backupInvalidFormat:
      return l10n.errorBackupInvalidFormat;
    case AppMessageKey.backupBadHeader:
      return l10n.errorBackupBadHeader;
    case AppMessageKey.backupWrongPassphrase:
      return l10n.errorBackupWrongPassphrase;

    // names for the kind of code seen in the AR view
    case AppMessageKey.formatQrUrl:
      return l10n.labelFormatQrUrl;
    case AppMessageKey.formatQrEmail:
      return l10n.labelFormatQrEmail;
    case AppMessageKey.formatQrPhone:
      return l10n.labelFormatQrPhone;
    case AppMessageKey.formatQrSms:
      return l10n.labelFormatQrSms;
    case AppMessageKey.formatQrWifi:
      return l10n.labelFormatQrWifi;
    case AppMessageKey.formatQrLocation:
      return l10n.labelFormatQrLocation;
    case AppMessageKey.formatQrContact:
      return l10n.labelFormatQrContact;
    case AppMessageKey.formatIsbn:
      return l10n.labelFormatIsbn;
    case AppMessageKey.formatEanUpc:
      return l10n.labelFormatEanUpc;
    case AppMessageKey.formatQrCode:
      return l10n.labelFormatQrCode;
    case AppMessageKey.formatEanUpcProduct:
      return l10n.labelFormatEanUpcProduct;
    case AppMessageKey.formatBarcode:
      return l10n.labelFormatBarcode;

    // reading codes from pictures and PDFs
    case AppMessageKey.mediaImagePickFailed:
      return l10n.errorMediaImagePickFailed(args['error'] ?? '');
    case AppMessageKey.mediaNoCodeInImage:
      return l10n.errorMediaNoCodeInImage;
    case AppMessageKey.mediaImageAnalyzeFailed:
      return l10n.errorMediaImageAnalyzeFailed(args['error'] ?? '');
    case AppMessageKey.mediaPdfPickFailed:
      return l10n.errorMediaPdfPickFailed(args['error'] ?? '');
    case AppMessageKey.mediaNoCodeInPdf:
      return l10n.errorMediaNoCodeInPdf;
    case AppMessageKey.mediaPdfScanFailed:
      return l10n.errorMediaPdfScanFailed(args['error'] ?? '');
    case AppMessageKey.mediaImageTooLarge:
      return l10n.errorMediaImageTooLarge(args['maxMb'] ?? '');
    case AppMessageKey.mediaPdfTooLarge:
      return l10n.errorMediaPdfTooLarge(args['maxMb'] ?? '');

    // CodeForge file reading
    case AppMessageKey.codeForgeFileEmpty:
      return l10n.errorCodeForgeFileEmpty;
    case AppMessageKey.codeForgeFileTruncated:
      return l10n.bodyCodeForgeFileTruncated;
    case AppMessageKey.codeForgeFileLoaded:
      return l10n.bodyCodeForgeFileLoaded;
    case AppMessageKey.codeForgeFileReadError:
      return l10n.errorCodeForgeFileReadError;

    // CodeForge input checks
    case AppMessageKey.codeForgeContentEmpty:
      return l10n.errorCodeForgeContentEmpty;
    case AppMessageKey.codeForgeTextTooLong:
      return l10n.errorCodeForgeTextTooLong(args['max'] ?? '');
    case AppMessageKey.codeForgeWifiSsidRequired:
      return l10n.errorCodeForgeWifiSsidRequired;
    case AppMessageKey.codeForgeUpiVpaRequired:
      return l10n.errorCodeForgeUpiVpaRequired;
    case AppMessageKey.codeForgeBarcodeInvalid:
      return l10n.errorCodeForgeBarcodeInvalid(args['detail'] ?? '');
  }
}

/// Turns the comma-separated enum names carried by
/// [AppMessageKey.patternDetected] into a readable list, for example
/// "IP Address, Data URI".
String _patternList(AppLocalizations l10n, String names) {
  if (names.isEmpty) return '';
  return names
      .split(',')
      .map((name) {
        final key = AppMessageKey.values.firstWhere(
          (candidate) => candidate.name == name,
          orElse: () => AppMessageKey.patternDetected,
        );
        return appMessageText(l10n, AppMessage(key));
      })
      .join(', ');
}
