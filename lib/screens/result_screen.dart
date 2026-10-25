import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sreerajp_qr_studio/models/encrypted_payload_data.dart';
import 'package:sreerajp_qr_studio/models/safety_check_result.dart';
import 'package:sreerajp_qr_studio/l10n/app_message_text.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/models/parsed_payload.dart';
import 'package:sreerajp_qr_studio/providers/scan_provider.dart';
import 'package:sreerajp_qr_studio/screens/widgets/wifi_action_card.dart';
import 'package:sreerajp_qr_studio/screens/widgets/contact_action_card.dart';
import 'package:sreerajp_qr_studio/screens/widgets/geo_action_card.dart';
import 'package:sreerajp_qr_studio/screens/widgets/calendar_action_card.dart';
import 'package:sreerajp_qr_studio/screens/widgets/payment_action_card.dart';
import 'package:sreerajp_qr_studio/screens/widgets/totp_action_card.dart';
import 'package:sreerajp_qr_studio/screens/widgets/email_action_card.dart';
import 'package:sreerajp_qr_studio/screens/widgets/phone_action_card.dart';
import 'package:sreerajp_qr_studio/screens/widgets/sms_action_card.dart';
import 'package:sreerajp_qr_studio/screens/widgets/app_link_action_card.dart';
import 'package:sreerajp_qr_studio/screens/widgets/product_barcode_action_card.dart';
import 'package:sreerajp_qr_studio/screens/widgets/id_card_action_card.dart';
import 'package:sreerajp_qr_studio/screens/widgets/isbn_action_card.dart';
import 'package:sreerajp_qr_studio/screens/widgets/sticker_check_card.dart';
import 'package:sreerajp_qr_studio/screens/widgets/dom_sandbox_preview_card.dart';
import 'package:sreerajp_qr_studio/screens/widgets/url_verdict_card.dart';
import 'package:sreerajp_qr_studio/models/code_content_type.dart';
import 'package:sreerajp_qr_studio/widgets/secure_screen.dart';

/// How risky it looks to open the scanned link. Drives the look of the
/// Open button and the confirm dialog.
enum _OpenRisk { safe, warning, danger }

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool _isCopied = false;
  bool _isSecretCopied = false;
  bool _showSecretText = true;
  bool _showPassedChecks = false;
  bool _showSkippedChecks = false;
  final GlobalKey _safetyCardKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scanProvider = Provider.of<ScanProvider>(context);
    final isUrl = scanProvider.isUrl;
    final isStego = scanProvider.isStegoQr;

    final displayedContent = isStego
        ? (scanProvider.stegoQrData?.decoyText ?? scanProvider.scanResult ?? '')
        : (scanProvider.scanResult ?? l10n.bodyResultNoResult);

    return SecureScreen(
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.titleResultScreen),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: l10n.tooltipBack,
            onPressed: () {
              scanProvider.clearScan();
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.history),
              onPressed: () => Navigator.pushNamed(context, '/history'),
              tooltip: l10n.titleHistoryScreen,
            ),
          ],
        ),
        bottomNavigationBar: _buildBottomBar(
          context,
          scanProvider,
          displayedContent,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Result type indicator
              _buildResultTypeCard(scanProvider),
              const SizedBox(height: 16),

              // Content display (Decoy or plain text)
              _buildContentCard(
                displayedContent,
                title: isStego
                    ? l10n.labelResultDecoyContent
                    : l10n.labelResultContent,
              ),
              const SizedBox(height: 16),

              // Short safety verdict, close to the actions
              if (isUrl) ...[
                _buildVerdictCard(scanProvider),
                const SizedBox(height: 16),
              ],

              // QuishingGuard fake-sticker reminder
              if (scanProvider.showStickerReminder) ...[
                const StickerCheckCard(),
                const SizedBox(height: 16),
              ],

              // StegoQR Card if detected
              if (isStego) ...[
                _buildStegoCard(scanProvider),
                const SizedBox(height: 16),
              ],

              // Smart Action Card if parsed
              if (scanProvider.parsedPayload != null &&
                  scanProvider.parsedPayload is! GenericPayload) ...[
                _buildSmartPayloadCard(scanProvider),
                const SizedBox(height: 16),
              ],

              // Zero-Trust Sandboxed HTML Pre-Render Preview Card if URL
              if (isUrl && scanProvider.domSandboxResult != null) ...[
                DomSandboxPreviewCard(result: scanProvider.domSandboxResult!),
                const SizedBox(height: 16),
              ],

              // Full URL safety details (if URL)
              if (isUrl)
                KeyedSubtree(
                  key: _safetyCardKey,
                  child: _buildSafetyCard(scanProvider),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVerdictCard(ScanProvider provider) {
    final l10n = AppLocalizations.of(context);
    final ran = provider.safetyChecks.where((c) => !c.skipped).toList();
    final failed = ran.where((c) => !c.passed).toList();
    return UrlVerdictCard(
      isLoading: provider.isLoading,
      failedCount: failed.length,
      passedCount: ran.length - failed.length,
      ranCount: ran.length,
      firstFailedName: failed.isEmpty
          ? null
          : appMessageText(l10n, failed.first.checkName),
      activeProbing: provider.activeProbingEnabled,
      onSeeDetails: provider.safetyChecks.isEmpty ? null : _scrollToSafetyCard,
    );
  }

  void _scrollToSafetyCard() {
    final target = _safetyCardKey.currentContext;
    if (target == null) return;
    Scrollable.ensureVisible(
      target,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Widget _buildSmartPayloadCard(ScanProvider provider) {
    final payload = provider.parsedPayload;
    if (payload == null || payload is GenericPayload) return const SizedBox();

    if (payload is WifiPayload) {
      return WifiActionCard(payload: payload);
    } else if (payload is ContactPayload) {
      return ContactActionCard(payload: payload);
    } else if (payload is GeoPayload) {
      return GeoActionCard(payload: payload);
    } else if (payload is CalendarPayload) {
      return CalendarActionCard(payload: payload);
    } else if (payload is PaymentPayload) {
      return PaymentActionCard(payload: payload);
    } else if (payload is TotpPayload) {
      return TotpActionCard(payload: payload);
    } else if (payload is EmailPayload) {
      return EmailActionCard(payload: payload);
    } else if (payload is PhonePayload) {
      return PhoneActionCard(payload: payload);
    } else if (payload is SmsPayload) {
      return SmsActionCard(payload: payload);
    } else if (payload is AppLinkPayload) {
      return AppLinkActionCard(payload: payload);
    } else if (payload is ProductBarcodePayload) {
      return ProductBarcodeActionCard(payload: payload);
    } else if (payload is IsbnPayload) {
      return IsbnActionCard(payload: payload);
    } else if (payload is IdCardPayload) {
      return IdCardActionCard(payload: payload);
    }
    return const SizedBox();
  }

  Widget _buildResultTypeCard(ScanProvider provider) {
    final l10n = AppLocalizations.of(context);
    final isStego = provider.isStegoQr;
    final payload = provider.parsedPayload;

    final typeLabel = isStego
        ? l10n.labelResultTypeStego
        : (payload != null && payload is! GenericPayload)
        ? payload.type.name.toUpperCase()
        : provider.scanType?.name.toUpperCase() ??
              l10n.labelResultTypeTextFallback;

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              isStego
                  ? Icons.lock_person
                  : payload is WifiPayload
                  ? Icons.wifi
                  : payload is ContactPayload
                  ? Icons.contact_page
                  : payload is GeoPayload
                  ? Icons.map
                  : payload is CalendarPayload
                  ? Icons.event
                  : payload is PaymentPayload
                  ? Icons.payment
                  : payload is TotpPayload
                  ? Icons.shield
                  : payload is EmailPayload
                  ? Icons.email
                  : payload is PhonePayload
                  ? Icons.phone
                  : payload is SmsPayload
                  ? Icons.sms
                  : payload is AppLinkPayload
                  ? Icons.launch
                  : payload is ProductBarcodePayload
                  ? Icons.qr_code_scanner
                  : payload is IsbnPayload
                  ? Icons.menu_book
                  : payload is IdCardPayload
                  ? Icons.badge
                  : provider.scanType == CodeContentType.url
                  ? Icons.link
                  : Icons.qr_code,
              size: 32,
              color: isStego
                  ? Colors.deepPurple
                  : Theme.of(context).primaryColor,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.labelResultDetectedType,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    typeLabel,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isStego ? Colors.deepPurple : null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStegoCard(ScanProvider provider) {
    final l10n = AppLocalizations.of(context);
    final encryptedData = provider.encryptedPayloadData;
    final stegoData = provider.stegoQrData;
    if (encryptedData == null && stegoData == null) return const SizedBox();

    final isUnlocked =
        encryptedData?.isUnlocked ?? stegoData?.isUnlocked ?? false;
    final decryptedPayload =
        encryptedData?.decryptedPayload ?? stegoData?.decryptedPayload ?? '';
    final error = encryptedData?.error ?? stegoData?.error;

    String cardTitle;
    String cardSubtitle;

    if (encryptedData?.containerType == EncryptedContainerType.airQr) {
      cardTitle = isUnlocked
          ? '🔓 ${l10n.titleAirQrUnlocked}'
          : '🔒 ${l10n.titleAirQrDetected}';
      cardSubtitle = isUnlocked
          ? l10n.bodyStegoUnlocked
          : l10n.bodyAirQrDetected;
    } else if (encryptedData?.containerType ==
        EncryptedContainerType.jsonEnvelope) {
      cardTitle = isUnlocked
          ? '🔓 ${l10n.titleJsonEnvelopeUnlocked}'
          : '🔒 ${l10n.titleJsonEnvelopeDetected}';
      cardSubtitle = isUnlocked
          ? l10n.bodyStegoUnlocked
          : l10n.bodyJsonEnvelopeDetected;
    } else {
      cardTitle = isUnlocked
          ? '🔓 ${l10n.titleStegoUnlocked}'
          : '🔒 ${l10n.titleStegoDetected}';
      cardSubtitle = isUnlocked ? l10n.bodyStegoUnlocked : l10n.bodyStegoLocked;
    }

    return Card(
      elevation: 4,
      color: isUnlocked ? Colors.purple[50] : Colors.deepPurple[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isUnlocked ? Colors.purple : Colors.deepPurple,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isUnlocked ? Icons.lock_open : Icons.lock_outline,
                  color: isUnlocked
                      ? Colors.purple[700]
                      : Colors.deepPurple[700],
                  size: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    cardTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isUnlocked
                          ? Colors.purple[900]
                          : Colors.deepPurple[900],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              cardSubtitle,
              style: TextStyle(
                fontSize: 13,
                color: isUnlocked ? Colors.purple[900] : Colors.deepPurple[900],
              ),
            ),
            if (encryptedData?.fileName != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[100],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.description,
                      size: 14,
                      color: Colors.deepPurple,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${encryptedData!.fileName} (${encryptedData.mimeType ?? 'text/plain'})',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (error != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red[300]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, color: Colors.red[700], size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        appMessageText(l10n, error),
                        style: TextStyle(fontSize: 12, color: Colors.red[800]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 16),
            if (!isUnlocked) ...[
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.fingerprint),
                      label: Text(l10n.actionStegoBiometricUnlock),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () => _promptForPassphraseAndUnlock(
                        context,
                        provider,
                        useBiometrics: true,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.key),
                      label: Text(
                        encryptedData?.containerType ==
                                EncryptedContainerType.airQr
                            ? l10n.labelAirQrCode
                            : l10n.labelStegoPassphrase,
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.deepPurple[900],
                        side: const BorderSide(color: Colors.deepPurple),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () => _promptForPassphraseAndUnlock(
                        context,
                        provider,
                        useBiometrics: false,
                      ),
                    ),
                  ),
                ],
              ),
            ] else ...[
              // Display decrypted payload safely
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).colorScheme.surfaceContainerHighest
                      : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.purple[300]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.labelStegoSecretPayload,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.purple,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            _showSecretText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            size: 20,
                            color: Colors.purple,
                          ),
                          onPressed: () {
                            setState(() {
                              _showSecretText = !_showSecretText;
                            });
                          },
                          tooltip: _showSecretText
                              ? l10n.actionHide
                              : l10n.actionReveal,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    SelectableText(
                      _showSecretText
                          ? decryptedPayload
                          : '••••••••••••••••••••••••••••',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: Icon(
                        _isSecretCopied ? Icons.check : Icons.content_copy,
                      ),
                      label: Text(
                        _isSecretCopied
                            ? l10n.labelCopied
                            : l10n.actionStegoCopySecret,
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.purple[900],
                        side: BorderSide(color: Colors.purple[300]!),
                      ),
                      onPressed: () => _copySecretToClipboard(decryptedPayload),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.share),
                      label: Text(l10n.actionStegoShareSecret),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.purple[900],
                        side: BorderSide(color: Colors.purple[300]!),
                      ),
                      onPressed: () => _shareContent(decryptedPayload),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _promptForPassphraseAndUnlock(
    BuildContext context,
    ScanProvider provider, {
    required bool useBiometrics,
  }) async {
    final l10n = AppLocalizations.of(context);
    final controller = TextEditingController();
    bool obscure = true;
    final isAirQr =
        provider.encryptedPayloadData?.containerType ==
        EncryptedContainerType.airQr;

    final passphrase = await showDialog<String>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.key, color: Colors.deepPurple),
              const SizedBox(width: 8),
              Text(
                useBiometrics
                    ? l10n.titleStegoDialogBiometric
                    : (isAirQr
                          ? l10n.labelAirQrCode
                          : l10n.titleStegoDialogPassphrase),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                useBiometrics
                    ? l10n.bodyStegoDialogBiometric
                    : (isAirQr
                          ? l10n.bodyAirQrDetected
                          : l10n.bodyStegoDialogPassphrase),
                style: const TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                obscureText: obscure,
                autofocus: true,
                textCapitalization: isAirQr
                    ? TextCapitalization.characters
                    : TextCapitalization.none,
                decoration: InputDecoration(
                  labelText: isAirQr
                      ? l10n.labelAirQrCode
                      : l10n.labelStegoPassphrase,
                  hintText: isAirQr ? l10n.helpAirQrCode : null,
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    tooltip: obscure ? l10n.actionReveal : l10n.actionHide,
                    onPressed: () {
                      setDialogState(() {
                        obscure = !obscure;
                      });
                    },
                  ),
                ),
                onSubmitted: (val) => Navigator.pop(context, val),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.actionCancel),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.pop(context, controller.text),
              child: Text(l10n.actionStegoUnlock),
            ),
          ],
        ),
      ),
    );

    if (passphrase != null && passphrase.isNotEmpty && mounted) {
      if (useBiometrics) {
        await provider.unlockStegoWithBiometrics(
          passphrase: passphrase,
          biometricReason: l10n.bodyStegoBiometricReason,
        );
      } else {
        provider.unlockStegoWithPassphrase(passphrase);
      }
    }
  }

  Widget _buildContentCard(String content, {String? title}) {
    final l10n = AppLocalizations.of(context);
    final cardTitle = title ?? l10n.labelResultContent;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cardTitle,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark
                    ? theme.colorScheme.surfaceContainerHighest
                    : Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isDark
                      ? theme.colorScheme.outline.withValues(alpha: 0.4)
                      : Colors.grey[300]!,
                ),
              ),
              child: SelectableText(
                content,
                style: TextStyle(
                  fontSize: 16,
                  color: isDark ? theme.colorScheme.onSurface : Colors.black87,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSafetyCard(ScanProvider provider) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final hasIssues = provider.safetyChecks.any((check) => !check.passed);
    final failedChecks = provider.safetyChecks
        .where((check) => !check.passed)
        .toList();
    final passedChecks = provider.safetyChecks
        .where((check) => check.passed && !check.skipped)
        .toList();
    final skippedChecks = provider.safetyChecks
        .where((check) => check.skipped)
        .toList();

    return Card(
      elevation: 4,
      color: isDark
          ? (provider.isLoading
                ? const Color(0xFF0D253F)
                : hasIssues
                ? const Color(0xFF3F0D0D)
                : const Color(0xFF3F2B0D))
          : (provider.isLoading
                ? Colors.blue[50]
                : hasIssues
                ? Colors.red[50]
                : Colors.orange[50]),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                if (provider.isLoading)
                  const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                else
                  Icon(
                    hasIssues ? Icons.warning : Icons.info_outline,
                    color: hasIssues ? Colors.red : Colors.orange,
                    size: 32,
                  ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        provider.isLoading
                            ? l10n.titleSafetyCheckInProgress
                            : l10n.titleSafetyAnalysis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: isDark
                              ? (provider.isLoading
                                    ? Colors.blue[200]
                                    : hasIssues
                                    ? Colors.red[200]
                                    : Colors.orange[200])
                              : (provider.isLoading
                                    ? Colors.blue[700]
                                    : hasIssues
                                    ? Colors.red[700]
                                    : Colors.orange[700]),
                        ),
                      ),
                      if (!provider.isLoading) const SizedBox(height: 4),
                      if (!provider.isLoading)
                        Text(
                          hasIssues
                              ? l10n.bodySafetyIssuesDetected(
                                  failedChecks.length,
                                )
                              : l10n.bodySafetyNoIssues,
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark
                                ? (hasIssues
                                      ? Colors.red[300]
                                      : Colors.orange[300])
                                : (hasIssues
                                      ? Colors.red[600]
                                      : Colors.orange[600]),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),

            // One compact info row: trust hint + privacy mode
            if (!provider.isLoading) ...[
              const SizedBox(height: 12),
              _buildProbingModeBanner(provider.activeProbingEnabled),
            ],

            // Check results: failed always shown, passed and skipped folded
            if (!provider.isLoading && provider.safetyChecks.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                l10n.titleSafetyResults,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.grey[200] : Colors.grey[800],
                ),
              ),
              const SizedBox(height: 12),
              ...failedChecks.map((check) => _buildDetailedCheckItem(check)),
              if (passedChecks.isNotEmpty) ...[
                _buildFoldToggle(
                  label: _showPassedChecks
                      ? l10n.actionSafetyHidePassed
                      : l10n.actionSafetyShowPassed(passedChecks.length),
                  expanded: _showPassedChecks,
                  onTap: () =>
                      setState(() => _showPassedChecks = !_showPassedChecks),
                ),
                if (_showPassedChecks)
                  ...passedChecks.map(
                    (check) => _buildDetailedCheckItem(check),
                  ),
              ],
              if (skippedChecks.isNotEmpty) ...[
                _buildFoldToggle(
                  label: l10n.actionSafetySkippedGroup(skippedChecks.length),
                  expanded: _showSkippedChecks,
                  onTap: () =>
                      setState(() => _showSkippedChecks = !_showSkippedChecks),
                ),
                if (_showSkippedChecks) ...[
                  ...skippedChecks.map(
                    (check) => _buildDetailedCheckItem(check),
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: TextButton.icon(
                      icon: const Icon(Icons.settings_outlined, size: 18),
                      label: Text(l10n.actionSafetySkippedSetup),
                      onPressed: () =>
                          Navigator.pushNamed(context, '/settings'),
                    ),
                  ),
                ],
              ],
            ],

            // Loading indicator message
            if (provider.isLoading) ...[
              const SizedBox(height: 12),
              Text(
                l10n.bodySafetyAnalyzing,
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.blue[300] : Colors.blue[600],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProbingModeBanner(bool activeProbing) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = activeProbing ? Colors.amber : Colors.blue;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark
            ? (activeProbing
                  ? const Color(0xFF3F2E0D)
                  : const Color(0xFF0D253F))
            : color[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark
              ? (activeProbing ? Colors.amber[700]! : Colors.blue[700]!)
              : color[200]!,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            activeProbing ? Icons.public : Icons.lock_outline,
            color: isDark
                ? (activeProbing ? Colors.amber[300] : Colors.blue[300])
                : color[700],
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '${l10n.helpSafetyTrustSource}\n'
              '${activeProbing ? l10n.bodyProbingBannerActive : l10n.bodyProbingBannerPrivate}',
              style: TextStyle(
                fontSize: 13,
                color: isDark
                    ? (activeProbing ? Colors.amber[100] : Colors.blue[100])
                    : color[900],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoldToggle({
    required String label,
    required bool expanded,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isDark ? Colors.grey[300] : Colors.grey[800];
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        child: Row(
          children: [
            Icon(
              expanded ? Icons.expand_less : Icons.expand_more,
              size: 20,
              color: color,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedCheckItem(SafetyCheckResult check) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark
            ? (check.passed ? const Color(0xFF0D3F1B) : const Color(0xFF3F0D0D))
            : (check.passed ? Colors.green[50] : Colors.red[50]),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark
              ? (check.passed ? Colors.green[800]! : Colors.red[800]!)
              : (check.passed ? Colors.green[200]! : Colors.red[200]!),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            check.passed ? Icons.check_circle : Icons.error,
            size: 20,
            color: isDark
                ? (check.passed ? Colors.green[300] : Colors.red[300])
                : (check.passed ? Colors.green[700] : Colors.red[700]),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appMessageText(l10n, check.checkName),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? (check.passed ? Colors.green[200] : Colors.red[200])
                        : (check.passed ? Colors.green[900] : Colors.red[900]),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  appMessageText(l10n, check.message),
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark
                        ? (check.passed ? Colors.green[300] : Colors.red[300])
                        : (check.passed ? Colors.green[800] : Colors.red[800]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Works out how risky opening the link looks, from results the provider
  /// already holds.
  _OpenRisk _openRiskFor(ScanProvider p) {
    final failed = p.safetyChecks.where((c) => !c.passed).length;
    final sandboxUnsafe = p.domSandboxResult?.isSafe == false;
    if (sandboxUnsafe || failed >= 2) {
      return _OpenRisk.danger;
    }
    if (failed > 0 || !p.isSafeUrl) {
      return _OpenRisk.warning;
    }
    return _OpenRisk.safe;
  }

  bool _canDecrypt(ScanProvider p) =>
      !p.isStegoQr ||
      !(p.encryptedPayloadData?.isUnlocked ??
          p.stegoQrData?.isUnlocked ??
          false);

  Widget _buildBottomBar(
    BuildContext context,
    ScanProvider provider,
    String displayedContent,
  ) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surfaceContainer,
      elevation: 8,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (provider.isUrl) ...[
                _buildOpenButton(context, provider, displayedContent),
                const SizedBox(height: 10),
              ],
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: Icon(_isCopied ? Icons.check : Icons.content_copy),
                      label: Text(
                        _isCopied
                            ? l10n.labelCopied
                            : (provider.isStegoQr
                                  ? l10n.actionResultCopyDecoyText
                                  : l10n.actionResultCopyText),
                        overflow: TextOverflow.ellipsis,
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () => _copyToClipboard(displayedContent),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.share),
                      label: Text(
                        provider.isStegoQr
                            ? l10n.actionResultShareDecoyText
                            : l10n.actionResultShareText,
                        overflow: TextOverflow.ellipsis,
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () => _shareContent(displayedContent),
                    ),
                  ),
                  const SizedBox(width: 6),
                  IconButton.outlined(
                    icon: const Icon(Icons.more_vert),
                    tooltip: l10n.tooltipResultMoreActions,
                    onPressed: () => _showMoreSheet(context, provider),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOpenButton(
    BuildContext context,
    ScanProvider provider,
    String displayedContent,
  ) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onPressed = provider.isLoading
        ? null
        : () => _showWarningDialog(context, displayedContent);
    const padding = EdgeInsets.symmetric(vertical: 16);
    final label = Text(l10n.actionResultOpenInBrowser);

    final Widget button;
    switch (_openRiskFor(provider)) {
      case _OpenRisk.safe:
        button = ElevatedButton.icon(
          icon: const Icon(Icons.open_in_browser),
          label: label,
          style: ElevatedButton.styleFrom(
            padding: padding,
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
          ),
          onPressed: onPressed,
        );
      case _OpenRisk.warning:
        button = ElevatedButton.icon(
          icon: const Icon(Icons.warning_amber_rounded),
          label: label,
          style: ElevatedButton.styleFrom(
            padding: padding,
            backgroundColor: Colors.amber[800],
            foregroundColor: Colors.white,
          ),
          onPressed: onPressed,
        );
      case _OpenRisk.danger:
        final red = isDark ? Colors.red[300]! : Colors.red[700]!;
        button = OutlinedButton.icon(
          icon: const Icon(Icons.warning_amber_rounded),
          label: label,
          style: OutlinedButton.styleFrom(
            padding: padding,
            foregroundColor: red,
            side: BorderSide(color: red, width: 1.5),
          ),
          onPressed: onPressed,
        );
    }
    return SizedBox(width: double.infinity, child: button);
  }

  Future<void> _showMoreSheet(
    BuildContext context,
    ScanProvider provider,
  ) async {
    final l10n = AppLocalizations.of(context);
    final showRecheck =
        provider.isUrl && !provider.isLoading && provider.hasNetworkError;
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  l10n.tooltipResultMoreActions,
                  style: Theme.of(sheetContext).textTheme.titleMedium,
                ),
              ),
            ),
            if (_canDecrypt(provider))
              ListTile(
                leading: const Icon(Icons.vpn_key_outlined),
                title: Text(l10n.actionDecryptPayload),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _showManualDecryptionDialog(context, provider);
                },
              ),
            if (showRecheck)
              ListTile(
                leading: const Icon(Icons.refresh),
                title: Text(l10n.actionResultRecheck),
                onTap: () {
                  Navigator.pop(sheetContext);
                  provider.checkUrlSafety(
                    provider.stegoQrData?.decoyText ?? provider.scanResult!,
                  );
                },
              ),
            ListTile(
              leading: const Icon(Icons.qr_code_scanner),
              title: Text(l10n.actionResultScanAnother),
              onTap: () {
                Navigator.pop(sheetContext);
                provider.clearScan();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showManualDecryptionDialog(
    BuildContext context,
    ScanProvider provider,
  ) async {
    final l10n = AppLocalizations.of(context);
    final keyController = TextEditingController();
    final saltController = TextEditingController();
    final ivController = TextEditingController();
    String selectedMode = 'auto';
    bool showAdvanced = false;
    String? decryptedResult;
    String? errorText;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) {
          return Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.lock_open, color: Colors.deepPurple),
                      const SizedBox(width: 8),
                      Text(
                        l10n.titleDecryptPayload,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.descDecryptPayload,
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Mode selector
                  DropdownButtonFormField<String>(
                    initialValue: selectedMode,
                    decoration: InputDecoration(
                      labelText: l10n.labelCipherMode,
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: 'auto',
                        child: Text(l10n.labelCipherModeAuto),
                      ),
                      DropdownMenuItem(
                        value: 'gcm',
                        child: Text(l10n.labelCipherModeAesGcm),
                      ),
                      DropdownMenuItem(
                        value: 'cbc',
                        child: Text(l10n.labelCipherModeAesCbc),
                      ),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        setSheetState(() => selectedMode = val);
                      }
                    },
                  ),
                  const SizedBox(height: 12),

                  // Passphrase field
                  TextField(
                    controller: keyController,
                    decoration: InputDecoration(
                      labelText: l10n.labelStegoPassphrase,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Advanced toggle
                  TextButton.icon(
                    icon: Icon(
                      showAdvanced
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down,
                    ),
                    label: Text(
                      showAdvanced
                          ? l10n.actionDecryptHideAdvanced
                          : l10n.actionDecryptShowAdvanced,
                    ),
                    onPressed: () {
                      setSheetState(() => showAdvanced = !showAdvanced);
                    },
                  ),

                  if (showAdvanced) ...[
                    TextField(
                      controller: saltController,
                      decoration: InputDecoration(
                        labelText: l10n.labelDecryptSalt,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: ivController,
                      decoration: InputDecoration(
                        labelText: l10n.labelDecryptIv,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],

                  if (errorText != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      errorText!,
                      style: const TextStyle(color: Colors.red, fontSize: 13),
                    ),
                  ],

                  if (decryptedResult != null) ...[
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.green[300]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.labelDecryptedContent,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green[900],
                            ),
                          ),
                          const SizedBox(height: 4),
                          SelectableText(
                            decryptedResult!,
                            style: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        final key = keyController.text.trim();
                        if (key.isEmpty) return;

                        final salt = saltController.text.trim().isNotEmpty
                            ? saltController.text.trim()
                            : null;
                        final iv = ivController.text.trim().isNotEmpty
                            ? ivController.text.trim()
                            : null;

                        final res = provider.decryptManualCipher(
                          passphrase: key,
                          mode: selectedMode == 'auto' ? null : selectedMode,
                          salt: salt,
                          iv: iv,
                        );

                        setSheetState(() {
                          if (res != null) {
                            decryptedResult = res;
                            errorText = null;
                          } else {
                            decryptedResult = null;
                            errorText = l10n.errorManualDecryptionFailed;
                          }
                        });
                      },
                      child: Text(l10n.actionStegoUnlock),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _showWarningDialog(BuildContext context, String url) async {
    final l10n = AppLocalizations.of(context);
    final scanProvider = Provider.of<ScanProvider>(context, listen: false);
    final failedCount = scanProvider.safetyChecks
        .where((check) => !check.passed)
        .length;
    final risk = _openRiskFor(scanProvider);
    final hasIssues = risk != _OpenRisk.safe;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              hasIssues ? Icons.warning : Icons.info_outline,
              color: hasIssues ? Colors.red : Colors.orange,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                hasIssues ? l10n.titleWarningDialog : l10n.titleCautionDialog,
              ),
            ),
          ],
        ),
        content: Text(
          failedCount > 0
              ? l10n.bodyOpenRiskDialogIssues(failedCount)
              : hasIssues
              ? l10n.bodyWarningDialog
              : l10n.bodyCautionDialog,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.actionCancel),
          ),
          // For danger, keep "Open anyway" plain so Cancel is the easy choice.
          if (risk == _OpenRisk.danger)
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text(l10n.actionOpenAnyway),
            )
          else
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: hasIssues ? Colors.amber[800] : Colors.orange,
                foregroundColor: Colors.white,
              ),
              child: Text(l10n.actionOpenAnyway),
            ),
        ],
      ),
    );

    if (result == true && mounted) {
      _openUrl(url);
    }
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).errorResultLaunchFailed),
        ),
      );
    }
  }

  Future<void> _copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (!mounted) return;

    setState(() {
      _isCopied = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context).bodyCopiedToClipboard),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isCopied = false;
        });
      }
    });
  }

  Future<void> _copySecretToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (!mounted) return;

    setState(() {
      _isSecretCopied = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context).bodyStegoSecretCopied),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isSecretCopied = false;
        });
      }
    });
  }

  Future<void> _shareContent(String content) async {
    await SharePlus.instance.share(ShareParams(text: content));
  }
}
