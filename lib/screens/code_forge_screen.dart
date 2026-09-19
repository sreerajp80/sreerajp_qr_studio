import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sreeraj_qr_reader/core/constants/app_constants.dart';
import 'package:sreeraj_qr_reader/l10n/app_message_text.dart';
import 'package:sreeraj_qr_reader/l10n/gen/app_localizations.dart';
import 'package:sreeraj_qr_reader/models/code_forge_config.dart';
import 'package:sreeraj_qr_reader/providers/code_forge_provider.dart';
import 'package:sreeraj_qr_reader/services/code_forge_service.dart';
import 'package:sreeraj_qr_reader/widgets/code_forge_barcode_widget.dart';
import 'package:sreeraj_qr_reader/widgets/code_forge_qr_painter.dart';

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
  bool _isFetchingLocation = false;
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
        content: Text(l10n.codeForgeCopied),
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

    setState(() => _isFetchingLocation = true);

    try {
      // Request location permission at point of use
      final status = await Permission.location.request();
      if (!status.isGranted) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.codeForgeGeoPermissionDenied),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
        return;
      }

      // Fetch the current GPS position
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 15),
        ),
      );

      final lat = position.latitude.toStringAsFixed(6);
      final lng = position.longitude.toStringAsFixed(6);

      _geoLatController.text = lat;
      _geoLngController.text = lng;
      provider.updateGeo(lat: lat, lng: lng);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.codeForgeGeoFailed),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isFetchingLocation = false);
    }
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
            Text(l10n.codeForgeTitle),
            Text(
              l10n.codeForgeSubtitle,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: l10n.codeForgeResetStyle,
            onPressed: () => provider.resetStylingToDefault(),
          ),
          IconButton(
            icon: const Icon(Icons.copy),
            tooltip: l10n.codeForgeCopyPayload,
            onPressed: () {
              provider.copyPayloadToClipboard();
              _showCopiedSnackBar(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
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
    );
  }

  Widget _buildFormatSelector(
    BuildContext context,
    CodeForgeProvider provider,
    CodeForgeConfig config,
  ) {
    final formats = [
      {'type': CodeForgeBarcodeType.qrCode, 'label': 'QR Code'},
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
                        provider.validationError!,
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
                l10n.codeForgePreview,
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
    final hasChecked = provider.safetyResults != null;
    final isSafe = provider.isUrlSafe;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: hasChecked && isSafe
            ? Colors.green.withValues(alpha: 0.12)
            : Theme.of(
                context,
              ).colorScheme.primaryContainer.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: hasChecked && isSafe
              ? Colors.green.withValues(alpha: 0.3)
              : Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            hasChecked && isSafe ? Icons.verified : Icons.shield_outlined,
            color: hasChecked && isSafe
                ? Colors.green
                : Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              hasChecked && isSafe
                  ? l10n.codeForgeSafeVerified
                  : l10n.codeForgeVerifySafety,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: hasChecked && isSafe ? Colors.green.shade800 : null,
              ),
            ),
          ),
          if (provider.isCheckingSafety)
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          else if (!hasChecked || !isSafe)
            TextButton(
              onPressed: () => provider.runUrlSafetyCheck(),
              child: Text(l10n.codeForgeVerifySafety),
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
                'Barcode Content',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _rawContentController,
                decoration: InputDecoration(
                  hintText: 'Enter barcode number or code',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.qr_code_scanner),
                ),
                onChanged: (val) => provider.updateRawContent(val),
              ),
              const SizedBox(height: 8),
              SwitchListTile(
                title: Text(l10n.codeForgeIncludeText),
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
        'label': l10n.codeForgePresetText,
        'icon': Icons.text_fields,
      },
      {
        'type': CodeForgePayloadType.url,
        'label': l10n.codeForgePresetUrl,
        'icon': Icons.link,
      },
      {
        'type': CodeForgePayloadType.wifi,
        'label': l10n.codeForgePresetWifi,
        'icon': Icons.wifi,
      },
      {
        'type': CodeForgePayloadType.contactVCard,
        'label': l10n.codeForgePresetContact,
        'icon': Icons.person,
      },
      {
        'type': CodeForgePayloadType.upiPayment,
        'label': l10n.codeForgePresetUpi,
        'icon': Icons.currency_rupee,
      },
      {
        'type': CodeForgePayloadType.sms,
        'label': l10n.codeForgePresetSms,
        'icon': Icons.sms,
      },
      {
        'type': CodeForgePayloadType.email,
        'label': l10n.codeForgePresetEmail,
        'icon': Icons.email,
      },
      {
        'type': CodeForgePayloadType.geo,
        'label': l10n.codeForgePresetGeo,
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
                labelText: l10n.codeForgePresetText,
                helperText: l10n.codeForgeTextHint,
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
                message: l10n.codeForgeLoadFromFileTooltip,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.file_open_outlined, size: 18),
                  label: Text(l10n.codeForgeLoadFromFile),
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
            labelText: l10n.codeForgePresetUrl,
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
                labelText: l10n.codeForgeWifiSsid,
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
                labelText: l10n.codeForgeWifiPassword,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
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
                      labelText: l10n.codeForgeWifiSecurity,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'WPA', child: Text('WPA / WPA2')),
                      DropdownMenuItem(value: 'WEP', child: Text('WEP')),
                      DropdownMenuItem(
                        value: 'nopass',
                        child: Text('None (Open)'),
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
              title: Text(l10n.codeForgeWifiHidden),
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
                labelText: l10n.codeForgeContactName,
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
                labelText: l10n.codeForgeContactPhone,
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
                labelText: l10n.codeForgeContactEmail,
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
                labelText: l10n.codeForgeContactOrg,
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
                labelText: l10n.codeForgeUpiVpa,
                hintText: 'e.g. merchant@upi',
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
                labelText: l10n.codeForgeUpiName,
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
                labelText: l10n.codeForgeUpiAmount,
                hintText: 'Optional',
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
                labelText: l10n.codeForgeUpiNote,
                hintText: 'Optional',
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
                labelText: l10n.codeForgeSmsPhone,
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
                labelText: l10n.codeForgeSmsMessage,
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
                labelText: l10n.codeForgeEmailTo,
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
                labelText: l10n.codeForgeEmailSubject,
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
                labelText: l10n.codeForgeEmailBody,
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
                      labelText: l10n.codeForgeGeoLat,
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
                      labelText: l10n.codeForgeGeoLng,
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
                onPressed: _isFetchingLocation
                    ? null
                    : () => _fetchCurrentLocation(provider),
                icon: _isFetchingLocation
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.my_location),
                label: Text(
                  _isFetchingLocation
                      ? l10n.codeForgeGeoFetching
                      : l10n.codeForgeGeoUseMyLocation,
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
          l10n.codeForgeDesignStudio,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [
          // A. Eye Outer Design
          _buildSectionHeader(l10n.codeForgeEyeShape),
          const SizedBox(height: 6),
          Row(
            children: [
              _buildChoiceChip(
                label: l10n.codeForgeShapeSquare,
                selected: config.eyeShape == QrEyeShape.square,
                onSelect: () => provider.setEyeShape(QrEyeShape.square),
              ),
              const SizedBox(width: 6),
              _buildChoiceChip(
                label: l10n.codeForgeShapeRounded,
                selected: config.eyeShape == QrEyeShape.rounded,
                onSelect: () => provider.setEyeShape(QrEyeShape.rounded),
              ),
              const SizedBox(width: 6),
              _buildChoiceChip(
                label: l10n.codeForgeShapeCircle,
                selected: config.eyeShape == QrEyeShape.circle,
                onSelect: () => provider.setEyeShape(QrEyeShape.circle),
              ),
              const SizedBox(width: 6),
              _buildChoiceChip(
                label: l10n.codeForgeShapeLeaf,
                selected: config.eyeShape == QrEyeShape.leaf,
                onSelect: () => provider.setEyeShape(QrEyeShape.leaf),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // B. Eye Inner Ball (Pupil) Design
          _buildSectionHeader(l10n.codeForgeEyeBallShape),
          const SizedBox(height: 6),
          Row(
            children: [
              _buildChoiceChip(
                label: l10n.codeForgeShapeSquare,
                selected: config.eyeBallShape == QrEyeBallShape.square,
                onSelect: () => provider.setEyeBallShape(QrEyeBallShape.square),
              ),
              const SizedBox(width: 6),
              _buildChoiceChip(
                label: l10n.codeForgeShapeRounded,
                selected: config.eyeBallShape == QrEyeBallShape.rounded,
                onSelect: () =>
                    provider.setEyeBallShape(QrEyeBallShape.rounded),
              ),
              const SizedBox(width: 6),
              _buildChoiceChip(
                label: l10n.codeForgeShapeCircle,
                selected: config.eyeBallShape == QrEyeBallShape.circle,
                onSelect: () => provider.setEyeBallShape(QrEyeBallShape.circle),
              ),
              const SizedBox(width: 6),
              _buildChoiceChip(
                label: l10n.codeForgeShapeDiamond,
                selected: config.eyeBallShape == QrEyeBallShape.diamond,
                onSelect: () =>
                    provider.setEyeBallShape(QrEyeBallShape.diamond),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // C. Data Pattern Shapes
          _buildSectionHeader(l10n.codeForgePatternShape),
          const SizedBox(height: 6),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildChoiceChip(
                  label: l10n.codeForgeShapeSquare,
                  selected: config.patternShape == QrPatternShape.square,
                  onSelect: () =>
                      provider.setPatternShape(QrPatternShape.square),
                ),
                const SizedBox(width: 6),
                _buildChoiceChip(
                  label: l10n.codeForgeShapeDots,
                  selected: config.patternShape == QrPatternShape.dots,
                  onSelect: () => provider.setPatternShape(QrPatternShape.dots),
                ),
                const SizedBox(width: 6),
                _buildChoiceChip(
                  label: l10n.codeForgeShapeRounded,
                  selected: config.patternShape == QrPatternShape.rounded,
                  onSelect: () =>
                      provider.setPatternShape(QrPatternShape.rounded),
                ),
                const SizedBox(width: 6),
                _buildChoiceChip(
                  label: l10n.codeForgeShapeClassy,
                  selected: config.patternShape == QrPatternShape.classy,
                  onSelect: () =>
                      provider.setPatternShape(QrPatternShape.classy),
                ),
                const SizedBox(width: 6),
                _buildChoiceChip(
                  label: l10n.codeForgeShapeDiamond,
                  selected: config.patternShape == QrPatternShape.diamond,
                  onSelect: () =>
                      provider.setPatternShape(QrPatternShape.diamond),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // D. Foreground Color Palette
          _buildSectionHeader(l10n.codeForgeFgColor),
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
          _buildSectionHeader(l10n.codeForgeBgColor),
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
          _buildSectionHeader(l10n.codeForgeColorStudio),
          const SizedBox(height: 6),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildChoiceChip(
                  label: l10n.codeForgeGradientNone,
                  selected: config.gradientTheme == QrGradientTheme.none,
                  onSelect: () =>
                      provider.setGradientTheme(QrGradientTheme.none),
                ),
                const SizedBox(width: 6),
                _buildChoiceChip(
                  label: l10n.codeForgeGradientSunset,
                  selected: config.gradientTheme == QrGradientTheme.sunset,
                  onSelect: () =>
                      provider.setGradientTheme(QrGradientTheme.sunset),
                ),
                const SizedBox(width: 6),
                _buildChoiceChip(
                  label: l10n.codeForgeGradientOcean,
                  selected: config.gradientTheme == QrGradientTheme.ocean,
                  onSelect: () =>
                      provider.setGradientTheme(QrGradientTheme.ocean),
                ),
                const SizedBox(width: 6),
                _buildChoiceChip(
                  label: l10n.codeForgeGradientNeon,
                  selected: config.gradientTheme == QrGradientTheme.neon,
                  onSelect: () =>
                      provider.setGradientTheme(QrGradientTheme.neon),
                ),
                const SizedBox(width: 6),
                _buildChoiceChip(
                  label: l10n.codeForgeGradientGold,
                  selected: config.gradientTheme == QrGradientTheme.royalGold,
                  onSelect: () =>
                      provider.setGradientTheme(QrGradientTheme.royalGold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // G. Error Correction
          _buildSectionHeader(l10n.codeForgeErrorCorrection),
          const SizedBox(height: 6),
          Row(
            children: [
              _buildChoiceChip(
                label: 'L (7%)',
                selected: config.errorCorrectionLevel == 1,
                onSelect: () => provider.setErrorCorrectionLevel(1),
              ),
              const SizedBox(width: 6),
              _buildChoiceChip(
                label: 'M (15%)',
                selected: config.errorCorrectionLevel == 0,
                onSelect: () => provider.setErrorCorrectionLevel(0),
              ),
              const SizedBox(width: 6),
              _buildChoiceChip(
                label: 'Q (25%)',
                selected: config.errorCorrectionLevel == 3,
                onSelect: () => provider.setErrorCorrectionLevel(3),
              ),
              const SizedBox(width: 6),
              _buildChoiceChip(
                label: 'H (30%)',
                selected: config.errorCorrectionLevel == 2,
                onSelect: () => provider.setErrorCorrectionLevel(2),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // H. Center Badge
          _buildSectionHeader(l10n.codeForgeCenterBadge),
          const SizedBox(height: 6),
          Row(
            children: [
              _buildChoiceChip(
                label: l10n.codeForgeBadgeNone,
                selected: config.centerBadge == QrCenterBadge.none,
                onSelect: () => provider.setCenterBadge(QrCenterBadge.none),
              ),
              const SizedBox(width: 6),
              _buildChoiceChip(
                label: l10n.codeForgeBadgeIcon,
                selected: config.centerBadge == QrCenterBadge.payloadIcon,
                onSelect: () =>
                    provider.setCenterBadge(QrCenterBadge.payloadIcon),
              ),
              const SizedBox(width: 6),
              _buildChoiceChip(
                label: l10n.codeForgeBadgeShield,
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
                : () => provider.exportPngAndShare(),
            icon: isBusy
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.image),
            label: Text(l10n.codeForgeExportPng),
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
            label: Text(l10n.codeForgeExportSvg),
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
