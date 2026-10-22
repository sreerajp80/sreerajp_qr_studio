import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sreerajp_qr_studio/core/constants/app_constants.dart';
import 'package:sreerajp_qr_studio/l10n/app_message_text.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/models/code_forge_config.dart';
import 'package:sreerajp_qr_studio/models/location_result.dart';
import 'package:sreerajp_qr_studio/providers/code_forge_provider.dart';
import 'package:sreerajp_qr_studio/services/code_forge_service.dart';
import 'package:sreerajp_qr_studio/widgets/code_forge_barcode_widget.dart';
import 'package:sreerajp_qr_studio/widgets/code_forge_qr_painter.dart';

/// Full-featured barcode generation suite screen: CodeForge.
class CodeForgeScreen extends StatefulWidget {
  final bool isEmbeddedTab;

  const CodeForgeScreen({super.key, this.isEmbeddedTab = false});

  @override
  State<CodeForgeScreen> createState() => _CodeForgeScreenState();
}

class _CodeForgeScreenState extends State<CodeForgeScreen> {
  late final TextEditingController _rawContentController;
  late final TextEditingController _wifiSsidController;
  late final TextEditingController _wifiPassController;
  late final TextEditingController _contactNameController;
  late final TextEditingController _contactPhoneController;
  late final TextEditingController _contactEmailController;
  late final TextEditingController _contactOrgController;
  late final TextEditingController _contactTitleController;
  late final TextEditingController _contactUrlController;
  late final TextEditingController _upiVpaController;
  late final TextEditingController _upiNameController;
  late final TextEditingController _upiAmountController;
  late final TextEditingController _upiNoteController;
  late final TextEditingController _smsPhoneController;
  late final TextEditingController _smsMsgController;
  late final TextEditingController _emailToController;
  late final TextEditingController _emailSubController;
  late final TextEditingController _emailBodyController;
  late final TextEditingController _geoLatController;
  late final TextEditingController _geoLngController;

  bool _obscureWifiPassword = true;
  final CodeForgeService _service = CodeForgeService();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<CodeForgeProvider>(context, listen: false);
    final cfg = provider.config;

    _rawContentController = TextEditingController(text: cfg.rawContent);
    _wifiSsidController = TextEditingController(text: cfg.wifiSsid);
    _wifiPassController = TextEditingController(text: cfg.wifiPassword);
    _contactNameController = TextEditingController(text: cfg.contactName);
    _contactPhoneController = TextEditingController(text: cfg.contactPhone);
    _contactEmailController = TextEditingController(text: cfg.contactEmail);
    _contactOrgController = TextEditingController(text: cfg.contactOrg);
    _contactTitleController = TextEditingController(text: cfg.contactTitle);
    _contactUrlController = TextEditingController(text: cfg.contactUrl);
    _upiVpaController = TextEditingController(text: cfg.upiVpa);
    _upiNameController = TextEditingController(text: cfg.upiName);
    _upiAmountController = TextEditingController(text: cfg.upiAmount);
    _upiNoteController = TextEditingController(text: cfg.upiNote);
    _smsPhoneController = TextEditingController(text: cfg.smsPhone);
    _smsMsgController = TextEditingController(text: cfg.smsMessage);
    _emailToController = TextEditingController(text: cfg.emailTo);
    _emailSubController = TextEditingController(text: cfg.emailSubject);
    _emailBodyController = TextEditingController(text: cfg.emailBody);
    _geoLatController = TextEditingController(text: cfg.geoLat);
    _geoLngController = TextEditingController(text: cfg.geoLng);
  }

  @override
  void dispose() {
    _rawContentController.dispose();
    _wifiSsidController.dispose();
    _wifiPassController.dispose();
    _contactNameController.dispose();
    _contactPhoneController.dispose();
    _contactEmailController.dispose();
    _contactOrgController.dispose();
    _contactTitleController.dispose();
    _contactUrlController.dispose();
    _upiVpaController.dispose();
    _upiNameController.dispose();
    _upiAmountController.dispose();
    _upiNoteController.dispose();
    _smsPhoneController.dispose();
    _smsMsgController.dispose();
    _emailToController.dispose();
    _emailSubController.dispose();
    _emailBodyController.dispose();
    _geoLatController.dispose();
    _geoLngController.dispose();
    super.dispose();
  }

  void _showCopiedSnackBar(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.bodyCodeForgeCopied),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _handleLoadFromFile(CodeForgeProvider provider) async {
    final result = await _service.pickAndReadTextFile();

    if (!mounted) return;
    final l10n = AppLocalizations.of(context);

    if (result.isSuccess && result.content != null) {
      _rawContentController.text = result.content!;
      provider.updateRawContent(result.content!);
    }

    if (result.message != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(appMessageText(l10n, result.message!)),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: result.wasTruncated ? 4 : 2),
        ),
      );
    }
  }

  Future<void> _fetchCurrentLocation(CodeForgeProvider provider) async {
    final l10n = AppLocalizations.of(context);
    final result = await provider.fetchCurrentLocation();
    if (result == null || !mounted) return;

    if (result.isSuccess) {
      _geoLatController.text = provider.config.geoLat;
      _geoLngController.text = provider.config.geoLng;
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          result.status == LocationStatus.permissionDenied
              ? l10n.errorCodeForgeGeoPermissionDenied
              : l10n.errorCodeForgeGeoFailed,
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final provider = Provider.of<CodeForgeProvider>(context);
    final config = provider.config;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !widget.isEmbeddedTab,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.titleCodeForge),
            Text(
              l10n.labelCodeForgeSubtitle,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: l10n.tooltipCodeForgeResetStyle,
            onPressed: () => provider.resetStylingToDefault(),
          ),
          IconButton(
            icon: const Icon(Icons.copy),
            tooltip: l10n.tooltipCodeForgeCopyPayload,
            onPressed: () {
              provider.copyPayloadToClipboard();
              _showCopiedSnackBar(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: l10n.actionMenuSettings,
            onPressed: () => Navigator.of(context).pushNamed('/settings'),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Barcode Format Selector (QR, 1D, 2D)
              _buildFormatSelector(context, provider, config),
              const SizedBox(height: 16),

              // 2. Live Interactive Code Preview Card
              _buildPreviewCard(context, provider, config),
              const SizedBox(height: 16),

              // 3. Pre-flight URL Safety Check Banner (if URL detected)
              if (config.barcodeType == CodeForgeBarcodeType.qrCode &&
                  (config.payloadType == CodeForgePayloadType.url ||
                      provider.payloadString.startsWith('http://') ||
                      provider.payloadString.startsWith('https://')))
                _buildSafetyBanner(context, provider),

              // 4. Payload Content Presets and Forms
              _buildPayloadForm(context, provider, config),
              const SizedBox(height: 16),

              // 5. QR Code Structure & Visual Design Studio (QR only)
              if (config.barcodeType == CodeForgeBarcodeType.qrCode)
                _buildDesignStudio(context, provider, config),

              const SizedBox(height: 24),

              // 6. Action Bar: Share PNG / Share SVG
              _buildActionButtons(context, provider),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormatSelector(
    BuildContext context,
    CodeForgeProvider provider,
    CodeForgeConfig config,
  ) {
    final l10n = AppLocalizations.of(context);
    final formats = [
      {'type': CodeForgeBarcodeType.qrCode, 'label': l10n.labelFormatQrCode},
      {'type': CodeForgeBarcodeType.code128, 'label': 'Code 128'},
      {'type': CodeForgeBarcodeType.ean13, 'label': 'EAN-13'},
      {'type': CodeForgeBarcodeType.ean8, 'label': 'EAN-8'},
      {'type': CodeForgeBarcodeType.upcA, 'label': 'UPC-A'},
      {'type': CodeForgeBarcodeType.code39, 'label': 'Code 39'},
      {'type': CodeForgeBarcodeType.pdf417, 'label': 'PDF417'},
      {'type': CodeForgeBarcodeType.dataMatrix, 'label': 'Data Matrix'},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: formats.map((item) {
          final type = item['type'] as CodeForgeBarcodeType;
          final label = item['label'] as String;
          final isSelected = config.barcodeType == type;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(label),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  provider.setBarcodeType(type);
                  _rawContentController.text = provider.config.rawContent;
                }
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPreviewCard(
    BuildContext context,
    CodeForgeProvider provider,
    CodeForgeConfig config,
  ) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest.withValues(
            alpha: 0.35,
          ),
        ),
        child: Column(
          children: [
            // Code Display Viewport
            Center(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 320,
                  maxHeight: 320,
                  minWidth: 260,
                  minHeight: 200,
                ),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: config.backgroundColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: _buildBarcodeCanvas(provider, config),
              ),
            ),
            const SizedBox(height: 12),

            // Error or Validation Message
            if (provider.validationError != null)
              Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 16,
                      color: Colors.red,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        appMessageText(l10n, provider.validationError!),
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            else
              Text(
                l10n.titleCodeForgePreview,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarcodeCanvas(
    CodeForgeProvider provider,
    CodeForgeConfig config,
  ) {
    if (config.barcodeType == CodeForgeBarcodeType.qrCode) {
      if (provider.qrImage != null) {
        return AspectRatio(
          aspectRatio: 1.0,
          child: CustomPaint(
            painter: CodeForgeQrPainter(
              config: config,
              qrImage: provider.qrImage!,
            ),
          ),
        );
      }
      return const Center(child: CircularProgressIndicator());
    } else {
      final barcode = _service.getBarcodeInstance(config.barcodeType);
      final payload = provider.payloadString;

      if (payload.isNotEmpty && provider.isValid) {
        return AspectRatio(
          aspectRatio: 1.8,
          child: CustomPaint(
            painter: CodeForgeBarcodePainter(
              config: config,
              barcode: barcode,
              data: payload,
            ),
          ),
        );
      }

      return Center(
        child: Icon(
          Icons.barcode_reader,
          size: 72,
          color: Colors.grey.withValues(alpha: 0.5),
        ),
      );
    }
  }

  Widget _buildSafetyBanner(BuildContext context, CodeForgeProvider provider) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final hasChecked = provider.safetyResults != null;
    final isSafe = hasChecked && provider.isUrlSafe;
    final hasProblems = hasChecked && !provider.isUrlSafe;

    // Four states: not checked, checking, safe, problems found.
    final Color accent;
    final IconData icon;
    final String message;
    if (isSafe) {
      accent = Colors.green;
      icon = Icons.verified;
      message = l10n.bodyCodeForgeSafeVerified;
    } else if (hasProblems) {
      accent = Colors.orange.shade800;
      icon = Icons.warning_amber_rounded;
      message = l10n.bodyCodeForgeSafetyProblems(provider.safetyIssueCount);
    } else {
      accent = colorScheme.primary;
      icon = Icons.shield_outlined;
      message = l10n.bodyCodeForgeSafetyPrompt;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSafe || hasProblems
            ? accent.withValues(alpha: 0.12)
            : colorScheme.primaryContainer.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: accent),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: isSafe
                    ? Colors.green.shade800
                    : (hasProblems ? accent : null),
              ),
            ),
          ),
          if (provider.isCheckingSafety)
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          else if (!isSafe)
            // A width cap so a long label wraps instead of pushing the row
            // past the screen edge; the text keeps the rest of the row.
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 120),
              child: TextButton(
                onPressed: () => provider.runUrlSafetyCheck(),
                child: Text(
                  hasProblems
                      ? l10n.actionCodeForgeSafetyCheckAgain
                      : l10n.actionCodeForgeSafetyCheck,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPayloadForm(
    BuildContext context,
    CodeForgeProvider provider,
    CodeForgeConfig config,
  ) {
    final l10n = AppLocalizations.of(context);

    if (config.barcodeType != CodeForgeBarcodeType.qrCode) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.labelCodeForgeBarcodeContent,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _rawContentController,
                decoration: InputDecoration(
                  hintText: l10n.helpCodeForgeBarcodeContent,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.qr_code_scanner),
                ),
                onChanged: (val) => provider.updateRawContent(val),
              ),
              const SizedBox(height: 8),
              SwitchListTile(
                title: Text(l10n.labelCodeForgeIncludeText),
                value: config.includeTextLabel,
                onChanged: (val) => provider.setIncludeTextLabel(val),
                contentPadding: EdgeInsets.zero,
              ),
            ],
          ),
        ),
      );
    }

    // QR Code Presets Bar
    final presets = [
      {
        'type': CodeForgePayloadType.text,
        'label': l10n.labelCodeForgePresetText,
        'icon': Icons.text_fields,
      },
      {
        'type': CodeForgePayloadType.url,
        'label': l10n.labelCodeForgePresetUrl,
        'icon': Icons.link,
      },
      {
        'type': CodeForgePayloadType.wifi,
        'label': l10n.labelCodeForgePresetWifi,
        'icon': Icons.wifi,
      },
      {
        'type': CodeForgePayloadType.contactVCard,
        'label': l10n.labelCodeForgePresetContact,
        'icon': Icons.person,
      },
      {
        'type': CodeForgePayloadType.upiPayment,
        'label': l10n.labelCodeForgePresetUpi,
        'icon': Icons.currency_rupee,
      },
      {
        'type': CodeForgePayloadType.sms,
        'label': l10n.labelCodeForgePresetSms,
        'icon': Icons.sms,
      },
      {
        'type': CodeForgePayloadType.email,
        'label': l10n.labelCodeForgePresetEmail,
        'icon': Icons.email,
      },
      {
        'type': CodeForgePayloadType.geo,
        'label': l10n.labelCodeForgePresetGeo,
        'icon': Icons.location_on,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: presets.map((item) {
              final type = item['type'] as CodeForgePayloadType;
              final label = item['label'] as String;
              final icon = item['icon'] as IconData;
              final isSelected = config.payloadType == type;

              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  avatar: Icon(icon, size: 16),
                  label: Text(label),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) provider.setPayloadType(type);
                  },
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: _buildFormFieldsForPreset(context, provider, config),
          ),
        ),
      ],
    );
  }

  Widget _buildFormFieldsForPreset(
    BuildContext context,
    CodeForgeProvider provider,
    CodeForgeConfig config,
  ) {
    final l10n = AppLocalizations.of(context);

    switch (config.payloadType) {
      case CodeForgePayloadType.text:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _rawContentController,
              maxLines: 4,
              maxLength: AppConstants.maxCodeForgeTextLength,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                labelText: l10n.labelCodeForgePresetText,
                helperText: l10n.helpCodeForgeText,
                helperMaxLines: 2,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.text_fields),
              ),
              onChanged: (val) => provider.updateRawContent(val),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Tooltip(
                message: l10n.tooltipCodeForgeLoadFromFile,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.file_open_outlined, size: 18),
                  label: Text(l10n.actionCodeForgeLoadFromFile),
                  style: OutlinedButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => _handleLoadFromFile(provider),
                ),
              ),
            ),
          ],
        );

      case CodeForgePayloadType.url:
        return TextField(
          controller: _rawContentController,
          decoration: InputDecoration(
            labelText: l10n.labelCodeForgePresetUrl,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            prefixIcon: const Icon(Icons.link),
          ),
          onChanged: (val) => provider.updateRawContent(val),
        );

      case CodeForgePayloadType.wifi:
        return Column(
          children: [
            TextField(
              controller: _wifiSsidController,
              decoration: InputDecoration(
                labelText: l10n.labelCodeForgeWifiSsid,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.wifi),
              ),
              onChanged: (val) => provider.updateWifi(ssid: val),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _wifiPassController,
              obscureText: _obscureWifiPassword,
              decoration: InputDecoration(
                labelText: l10n.labelCodeForgeWifiPassword,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  tooltip: _obscureWifiPassword
                      ? l10n.tooltipWifiShowPassword
                      : l10n.tooltipWifiHidePassword,
                  icon: Icon(
                    _obscureWifiPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureWifiPassword = !_obscureWifiPassword;
                    });
                  },
                ),
              ),
              onChanged: (val) => provider.updateWifi(password: val),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: config.wifiSecurity,
                    decoration: InputDecoration(
                      labelText: l10n.labelCodeForgeWifiSecurity,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: [
                      const DropdownMenuItem(
                        value: 'WPA',
                        child: Text('WPA / WPA2'),
                      ),
                      const DropdownMenuItem(value: 'WEP', child: Text('WEP')),
                      DropdownMenuItem(
                        value: 'nopass',
                        child: Text(l10n.labelCodeForgeWifiSecurityNone),
                      ),
                    ],
                    onChanged: (val) {
                      if (val != null) provider.updateWifi(security: val);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            CheckboxListTile(
              title: Text(l10n.labelCodeForgeWifiHidden),
              value: config.wifiHidden,
              onChanged: (val) => provider.updateWifi(hidden: val ?? false),
              contentPadding: EdgeInsets.zero,
            ),
          ],
        );

      case CodeForgePayloadType.contactVCard:
        return Column(
          children: [
            TextField(
              controller: _contactNameController,
              decoration: InputDecoration(
                labelText: l10n.labelCodeForgeContactName,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.person),
              ),
              onChanged: (val) => provider.updateContact(name: val),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _contactPhoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: l10n.labelCodeForgeContactPhone,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.phone),
              ),
              onChanged: (val) => provider.updateContact(phone: val),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _contactEmailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: l10n.labelCodeForgeContactEmail,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.email),
              ),
              onChanged: (val) => provider.updateContact(email: val),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _contactOrgController,
              decoration: InputDecoration(
                labelText: l10n.labelCodeForgeContactOrg,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.business),
              ),
              onChanged: (val) => provider.updateContact(org: val),
            ),
          ],
        );

      case CodeForgePayloadType.upiPayment:
        return Column(
          children: [
            TextField(
              controller: _upiVpaController,
              decoration: InputDecoration(
                labelText: l10n.labelCodeForgeUpiVpa,
                hintText: l10n.helpCodeForgeUpiVpa,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.alternate_email),
              ),
              onChanged: (val) => provider.updateUpi(vpa: val),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _upiNameController,
              decoration: InputDecoration(
                labelText: l10n.labelCodeForgeUpiName,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.person),
              ),
              onChanged: (val) => provider.updateUpi(name: val),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _upiAmountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: l10n.labelCodeForgeUpiAmount,
                hintText: l10n.labelOptionalField,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.currency_rupee),
              ),
              onChanged: (val) => provider.updateUpi(amount: val),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _upiNoteController,
              decoration: InputDecoration(
                labelText: l10n.labelCodeForgeUpiNote,
                hintText: l10n.labelOptionalField,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.note_alt_outlined),
              ),
              onChanged: (val) => provider.updateUpi(note: val),
            ),
          ],
        );

      case CodeForgePayloadType.sms:
        return Column(
          children: [
            TextField(
              controller: _smsPhoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: l10n.labelCodeForgeSmsPhone,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.phone),
              ),
              onChanged: (val) => provider.updateSms(phone: val),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _smsMsgController,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: l10n.labelCodeForgeSmsMessage,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.sms),
              ),
              onChanged: (val) => provider.updateSms(message: val),
            ),
          ],
        );

      case CodeForgePayloadType.email:
        return Column(
          children: [
            TextField(
              controller: _emailToController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: l10n.labelCodeForgeEmailTo,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.email),
              ),
              onChanged: (val) => provider.updateEmail(to: val),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _emailSubController,
              decoration: InputDecoration(
                labelText: l10n.labelCodeForgeEmailSubject,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.subject),
              ),
              onChanged: (val) => provider.updateEmail(subject: val),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _emailBodyController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: l10n.labelCodeForgeEmailBody,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.message),
              ),
              onChanged: (val) => provider.updateEmail(body: val),
            ),
          ],
        );

      case CodeForgePayloadType.geo:
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _geoLatController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                      signed: true,
                    ),
                    decoration: InputDecoration(
                      labelText: l10n.labelCodeForgeGeoLat,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (val) => provider.updateGeo(lat: val),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _geoLngController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                      signed: true,
                    ),
                    decoration: InputDecoration(
                      labelText: l10n.labelCodeForgeGeoLng,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (val) => provider.updateGeo(lng: val),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: provider.isFetchingLocation
                    ? null
                    : () => _fetchCurrentLocation(provider),
                icon: provider.isFetchingLocation
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.my_location),
                label: Text(
                  provider.isFetchingLocation
                      ? l10n.labelCodeForgeGeoFetching
                      : l10n.actionCodeForgeGeoUseMyLocation,
                ),
              ),
            ),
          ],
        );
    }
  }

  Widget _buildDesignStudio(
    BuildContext context,
    CodeForgeProvider provider,
    CodeForgeConfig config,
  ) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ExpansionTile(
        initiallyExpanded: true,
        leading: Icon(Icons.palette_outlined, color: theme.colorScheme.primary),
        title: Text(
          l10n.titleCodeForgeDesignStudio,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [
          // A. Eye Outer Design
          _buildSectionHeader(l10n.titleCodeForgeEyeShape),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              _buildChoiceChip(
                label: l10n.labelCodeForgeShapeSquare,
                selected: config.eyeShape == QrEyeShape.square,
                onSelect: () => provider.setEyeShape(QrEyeShape.square),
              ),
              _buildChoiceChip(
                label: l10n.labelCodeForgeShapeRounded,
                selected: config.eyeShape == QrEyeShape.rounded,
                onSelect: () => provider.setEyeShape(QrEyeShape.rounded),
              ),
              _buildChoiceChip(
                label: l10n.labelCodeForgeShapeCircle,
                selected: config.eyeShape == QrEyeShape.circle,
                onSelect: () => provider.setEyeShape(QrEyeShape.circle),
              ),
              _buildChoiceChip(
                label: l10n.labelCodeForgeShapeLeaf,
                selected: config.eyeShape == QrEyeShape.leaf,
                onSelect: () => provider.setEyeShape(QrEyeShape.leaf),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // B. Eye Inner Ball (Pupil) Design
          _buildSectionHeader(l10n.titleCodeForgeEyeBallShape),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              _buildChoiceChip(
                label: l10n.labelCodeForgeShapeSquare,
                selected: config.eyeBallShape == QrEyeBallShape.square,
                onSelect: () => provider.setEyeBallShape(QrEyeBallShape.square),
              ),
              _buildChoiceChip(
                label: l10n.labelCodeForgeShapeRounded,
                selected: config.eyeBallShape == QrEyeBallShape.rounded,
                onSelect: () =>
                    provider.setEyeBallShape(QrEyeBallShape.rounded),
              ),
              _buildChoiceChip(
                label: l10n.labelCodeForgeShapeCircle,
                selected: config.eyeBallShape == QrEyeBallShape.circle,
                onSelect: () => provider.setEyeBallShape(QrEyeBallShape.circle),
              ),
              _buildChoiceChip(
                label: l10n.labelCodeForgeShapeDiamond,
                selected: config.eyeBallShape == QrEyeBallShape.diamond,
                onSelect: () =>
                    provider.setEyeBallShape(QrEyeBallShape.diamond),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // C. Data Pattern Shapes
          _buildSectionHeader(l10n.titleCodeForgePatternShape),
          const SizedBox(height: 6),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildChoiceChip(
                  label: l10n.labelCodeForgeShapeSquare,
                  selected: config.patternShape == QrPatternShape.square,
                  onSelect: () =>
                      provider.setPatternShape(QrPatternShape.square),
                ),
                const SizedBox(width: 6),
                _buildChoiceChip(
                  label: l10n.labelCodeForgeShapeDots,
                  selected: config.patternShape == QrPatternShape.dots,
                  onSelect: () => provider.setPatternShape(QrPatternShape.dots),
                ),
                const SizedBox(width: 6),
                _buildChoiceChip(
                  label: l10n.labelCodeForgeShapeRounded,
                  selected: config.patternShape == QrPatternShape.rounded,
                  onSelect: () =>
                      provider.setPatternShape(QrPatternShape.rounded),
                ),
                const SizedBox(width: 6),
                _buildChoiceChip(
                  label: l10n.labelCodeForgeShapeClassy,
                  selected: config.patternShape == QrPatternShape.classy,
                  onSelect: () =>
                      provider.setPatternShape(QrPatternShape.classy),
                ),
                const SizedBox(width: 6),
                _buildChoiceChip(
                  label: l10n.labelCodeForgeShapeDiamond,
                  selected: config.patternShape == QrPatternShape.diamond,
                  onSelect: () =>
                      provider.setPatternShape(QrPatternShape.diamond),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // D. Foreground Color Palette
          _buildSectionHeader(l10n.titleCodeForgeFgColor),
          const SizedBox(height: 6),
          _buildColorPalette(
            selectedColor: config.foregroundColorValue,
            colors: const [
              0xFF000000, // Black
              0xFF1A237E, // Deep Navy
              0xFF0D47A1, // Cobalt Blue
              0xFF004D40, // Emerald Teal
              0xFF1B5E20, // Forest Green
              0xFF4A148C, // Royal Purple
              0xFFB71C1C, // Deep Crimson
              0xFFE65100, // Rich Amber
            ],
            onSelect: (val) => provider.setForegroundColor(val),
          ),
          const SizedBox(height: 14),

          // E. Background Color Palette
          _buildSectionHeader(l10n.titleCodeForgeBgColor),
          const SizedBox(height: 6),
          _buildColorPalette(
            selectedColor: config.backgroundColorValue,
            colors: const [
              0xFFFFFFFF, // Pure White
              0xFF000000, // OLED Pitch Black
              0xFFF5F5F5, // Light Grey
              0xFFFFF8E1, // Warm Cream
              0xFFE0F7FA, // Ice Cyan
              0xFFECEFF1, // Soft Slate
            ],
            onSelect: (val) => provider.setBackgroundColor(val),
          ),
          const SizedBox(height: 14),

          // F. Linear Gradient Themes
          _buildSectionHeader(l10n.titleCodeForgeColorStudio),
          const SizedBox(height: 6),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildChoiceChip(
                  label: l10n.labelCodeForgeGradientNone,
                  selected: config.gradientTheme == QrGradientTheme.none,
                  onSelect: () =>
                      provider.setGradientTheme(QrGradientTheme.none),
                ),
                const SizedBox(width: 6),
                _buildChoiceChip(
                  label: l10n.labelCodeForgeGradientSunset,
                  selected: config.gradientTheme == QrGradientTheme.sunset,
                  onSelect: () =>
                      provider.setGradientTheme(QrGradientTheme.sunset),
                ),
                const SizedBox(width: 6),
                _buildChoiceChip(
                  label: l10n.labelCodeForgeGradientOcean,
                  selected: config.gradientTheme == QrGradientTheme.ocean,
                  onSelect: () =>
                      provider.setGradientTheme(QrGradientTheme.ocean),
                ),
                const SizedBox(width: 6),
                _buildChoiceChip(
                  label: l10n.labelCodeForgeGradientNeon,
                  selected: config.gradientTheme == QrGradientTheme.neon,
                  onSelect: () =>
                      provider.setGradientTheme(QrGradientTheme.neon),
                ),
                const SizedBox(width: 6),
                _buildChoiceChip(
                  label: l10n.labelCodeForgeGradientGold,
                  selected: config.gradientTheme == QrGradientTheme.royalGold,
                  onSelect: () =>
                      provider.setGradientTheme(QrGradientTheme.royalGold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // G. Error Correction
          _buildSectionHeader(l10n.titleCodeForgeErrorCorrection),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              _buildChoiceChip(
                label: 'L (7%)',
                selected: config.errorCorrectionLevel == 1,
                onSelect: () => provider.setErrorCorrectionLevel(1),
              ),
              _buildChoiceChip(
                label: 'M (15%)',
                selected: config.errorCorrectionLevel == 0,
                onSelect: () => provider.setErrorCorrectionLevel(0),
              ),
              _buildChoiceChip(
                label: 'Q (25%)',
                selected: config.errorCorrectionLevel == 3,
                onSelect: () => provider.setErrorCorrectionLevel(3),
              ),
              _buildChoiceChip(
                label: 'H (30%)',
                selected: config.errorCorrectionLevel == 2,
                onSelect: () => provider.setErrorCorrectionLevel(2),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // H. Center Badge
          _buildSectionHeader(l10n.titleCodeForgeCenterBadge),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              _buildChoiceChip(
                label: l10n.labelCodeForgeBadgeNone,
                selected: config.centerBadge == QrCenterBadge.none,
                onSelect: () => provider.setCenterBadge(QrCenterBadge.none),
              ),
              _buildChoiceChip(
                label: l10n.labelCodeForgeBadgeIcon,
                selected: config.centerBadge == QrCenterBadge.payloadIcon,
                onSelect: () =>
                    provider.setCenterBadge(QrCenterBadge.payloadIcon),
              ),
              _buildChoiceChip(
                label: l10n.labelCodeForgeBadgeShield,
                selected: config.centerBadge == QrCenterBadge.shieldVerified,
                onSelect: () =>
                    provider.setCenterBadge(QrCenterBadge.shieldVerified),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildChoiceChip({
    required String label,
    required bool selected,
    required VoidCallback onSelect,
  }) {
    return ChoiceChip(
      label: Text(label, style: const TextStyle(fontSize: 12)),
      selected: selected,
      onSelected: (_) => onSelect(),
    );
  }

  Widget _buildColorPalette({
    required int selectedColor,
    required List<int> colors,
    required ValueChanged<int> onSelect,
  }) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: colors.map((colorVal) {
          final isSelected = selectedColor == colorVal;
          final color = Color(colorVal);

          return GestureDetector(
            onTap: () => onSelect(colorVal),
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.blueAccent : Colors.grey.shade400,
                  width: isSelected ? 3 : 1,
                ),
                boxShadow: isSelected
                    ? const [
                        BoxShadow(
                          color: Colors.blueAccent,
                          blurRadius: 6,
                          spreadRadius: 1,
                        ),
                      ]
                    : null,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, CodeForgeProvider provider) {
    final l10n = AppLocalizations.of(context);
    final isBusy = provider.isExporting;

    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: !provider.isValid || isBusy
                ? null
                : () => provider.exportPngAndShare(
                    paintQr: (canvas, size, qrImage) => CodeForgeQrPainter(
                      config: provider.config,
                      qrImage: qrImage,
                    ).paint(canvas, size),
                  ),
            icon: isBusy
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.image),
            label: Text(l10n.actionCodeForgeExportPng),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: !provider.isValid || isBusy
                ? null
                : () => provider.exportSvgAndShare(),
            icon: const Icon(Icons.code),
            label: Text(l10n.actionCodeForgeExportSvg),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
