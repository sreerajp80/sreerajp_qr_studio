import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/models/air_qr_frame.dart';
import 'package:sreerajp_qr_studio/models/device_sync_data.dart';
import 'package:sreerajp_qr_studio/models/scan_record.dart';
import 'package:sreerajp_qr_studio/providers/history_provider.dart';
import 'package:sreerajp_qr_studio/services/air_qr_service.dart';
import 'package:sreerajp_qr_studio/services/device_sync_service.dart';

enum AirQrTransmitMode { customText, deviceSync }

class AirQrTransmitterScreen extends StatefulWidget {
  final String? initialPayload;
  final bool startInSyncMode;

  const AirQrTransmitterScreen({
    super.key,
    this.initialPayload,
    this.startInSyncMode = false,
  });

  @override
  State<AirQrTransmitterScreen> createState() => _AirQrTransmitterScreenState();
}

class _AirQrTransmitterScreenState extends State<AirQrTransmitterScreen> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _passphraseController = TextEditingController();
  final DeviceSyncService _deviceSyncService = DeviceSyncService();

  late AirQrTransmitMode _mode;
  bool _sampleTextApplied = false;
  bool _includeHistory = true;
  bool _includeSettings = true;
  bool _isPassphraseVisible = true;

  int _fps = 10;
  bool _isBroadcasting = false;
  List<AirQrFrame> _encodedFrames = [];
  int _currentFrameIndex = 0;
  Timer? _broadcastTimer;

  @override
  void initState() {
    super.initState();
    _mode = widget.startInSyncMode
        ? AirQrTransmitMode.deviceSync
        : AirQrTransmitMode.customText;
    _generateRandomPin();

    if (widget.initialPayload != null && widget.initialPayload!.isNotEmpty) {
      _textController.text = widget.initialPayload!;
      _sampleTextApplied = true;
      _prepareFrames();
    }
  }

  void _generateRandomPin() {
    final pin = (Random().nextInt(899999) + 100000).toString();
    _passphraseController.text = pin;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Check modal route arguments if passed via pushNamed
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map<String, dynamic>) {
      if (args['syncMode'] == true && _mode != AirQrTransmitMode.deviceSync) {
        setState(() {
          _mode = AirQrTransmitMode.deviceSync;
        });
      }
      if (args['payload'] is String && args['payload'].isNotEmpty) {
        _textController.text = args['payload'] as String;
        _sampleTextApplied = true;
        _prepareFrames();
      }
    }

    if (!_sampleTextApplied && _mode == AirQrTransmitMode.customText) {
      _sampleTextApplied = true;
      _textController.text = AppLocalizations.of(context).airQrSamplePayload;
      _prepareFrames();
    } else if (_mode == AirQrTransmitMode.deviceSync &&
        _encodedFrames.isEmpty) {
      _prepareSyncFrames();
    }
  }

  @override
  void dispose() {
    _broadcastTimer?.cancel();
    _textController.dispose();
    _passphraseController.dispose();
    super.dispose();
  }

  void _prepareFrames() {
    final text = _textController.text.trim();
    if (text.isEmpty) {
      setState(() {
        _encodedFrames = [];
        _currentFrameIndex = 0;
      });
      return;
    }

    final frames = AirQrService.encodePayload(text);

    setState(() {
      _encodedFrames = frames;
      _currentFrameIndex = 0;
    });
  }

  Future<void> _prepareSyncFrames() async {
    final l10n = AppLocalizations.of(context);
    if (!_includeHistory && !_includeSettings) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.airQrSyncNoDataWarning)));
      setState(() {
        _encodedFrames = [];
        _currentFrameIndex = 0;
      });
      return;
    }

    final passphrase = _passphraseController.text.trim();
    if (passphrase.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.exportPassphraseRequired)));
      return;
    }

    final historyProvider = Provider.of<HistoryProvider>(
      context,
      listen: false,
    );
    if (historyProvider.records.isEmpty) {
      await historyProvider.loadRecords();
    }

    final recordsToSync = _includeHistory
        ? historyProvider.records
        : <ScanRecord>[];

    final prefs = await SharedPreferences.getInstance();
    final settingsToSync = _includeSettings
        ? _deviceSyncService.collectSettings(prefs)
        : <String, dynamic>{};

    final syncData = DeviceSyncData(
      exportedAt: DateTime.now(),
      records: recordsToSync,
      settings: settingsToSync,
    );

    final encryptedPackage = _deviceSyncService.createEncryptedSyncPackage(
      syncData,
      passphrase,
    );

    final frames = AirQrService.encodePayload(encryptedPackage);

    if (mounted) {
      setState(() {
        _encodedFrames = frames;
        _currentFrameIndex = 0;
      });
    }
  }

  void _toggleBroadcasting() {
    if (_isBroadcasting) {
      _stopBroadcasting();
    } else {
      _startBroadcasting();
    }
  }

  void _startBroadcasting() {
    if (_encodedFrames.isEmpty) {
      if (_mode == AirQrTransmitMode.customText) {
        _prepareFrames();
      } else {
        _prepareSyncFrames();
      }
    }
    if (_encodedFrames.isEmpty) return;

    _broadcastTimer?.cancel();
    final intervalMs = (1000 / _fps).round();

    setState(() {
      _isBroadcasting = true;
    });

    _broadcastTimer = Timer.periodic(Duration(milliseconds: intervalMs), (_) {
      if (mounted) {
        setState(() {
          _currentFrameIndex = (_currentFrameIndex + 1) % _encodedFrames.length;
          if (_currentFrameIndex == 0) _refreshParityFrames();
        });
      }
    });
  }

  /// Swaps in a fresh set of fountain parity frames at the start of each loop,
  /// so every pass gives the receiver new repair data.
  void _refreshParityFrames() {
    final dataFrames = _encodedFrames.where((f) => !f.isParity).toList();
    final parityCount = _encodedFrames.length - dataFrames.length;
    if (parityCount <= 0) return;
    _encodedFrames = [
      ...dataFrames,
      ...AirQrService.generateParityFrames(dataFrames, count: parityCount),
    ];
  }

  void _stopBroadcasting() {
    _broadcastTimer?.cancel();
    if (mounted) {
      setState(() {
        _isBroadcasting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentFrame = _encodedFrames.isNotEmpty
        ? _encodedFrames[_currentFrameIndex]
        : null;

    final qrString = currentFrame?.toQrString() ?? '';
    final l10n = AppLocalizations.of(context);
    final historyProvider = Provider.of<HistoryProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.airQrTransmitterTitle), elevation: 2),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Mode Selector
              SegmentedButton<AirQrTransmitMode>(
                segments: [
                  ButtonSegment(
                    value: AirQrTransmitMode.customText,
                    label: Text(l10n.airQrModeText),
                    icon: const Icon(Icons.short_text),
                  ),
                  ButtonSegment(
                    value: AirQrTransmitMode.deviceSync,
                    label: Text(l10n.airQrModeSync),
                    icon: const Icon(Icons.sync_lock),
                  ),
                ],
                selected: {_mode},
                onSelectionChanged: (selected) {
                  _stopBroadcasting();
                  setState(() {
                    _mode = selected.first;
                  });
                  if (_mode == AirQrTransmitMode.customText) {
                    _prepareFrames();
                  } else {
                    _prepareSyncFrames();
                  }
                },
              ),
              const SizedBox(height: 16),

              // Mode-specific Configuration
              if (_mode == AirQrTransmitMode.customText) ...[
                TextField(
                  controller: _textController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: l10n.airQrPayloadLabel,
                    hintText: l10n.airQrPayloadHint,
                    border: const OutlineInputBorder(),
                  ),
                  onChanged: (_) {
                    if (_isBroadcasting) _stopBroadcasting();
                    _prepareFrames();
                  },
                ),
              ] else ...[
                Card(
                  elevation: 0,
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.lock,
                              size: 20,
                              color: Colors.cyan,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              l10n.airQrSyncPackageDetected,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        CheckboxListTile(
                          value: _includeHistory,
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            l10n.airQrSyncIncludeHistory(
                              historyProvider.totalCount,
                            ),
                          ),
                          onChanged: (val) {
                            if (_isBroadcasting) _stopBroadcasting();
                            setState(() => _includeHistory = val ?? true);
                            _prepareSyncFrames();
                          },
                        ),
                        CheckboxListTile(
                          value: _includeSettings,
                          contentPadding: EdgeInsets.zero,
                          title: Text(l10n.airQrSyncIncludeSettings),
                          onChanged: (val) {
                            if (_isBroadcasting) _stopBroadcasting();
                            setState(() => _includeSettings = val ?? true);
                            _prepareSyncFrames();
                          },
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _passphraseController,
                          obscureText: !_isPassphraseVisible,
                          decoration: InputDecoration(
                            labelText: l10n.airQrSyncPassphraseLabel,
                            hintText: l10n.airQrSyncPassphraseHint,
                            border: const OutlineInputBorder(),
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    _isPassphraseVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  tooltip: l10n.tooltipToggleSecretVisibility,
                                  onPressed: () {
                                    setState(() {
                                      _isPassphraseVisible =
                                          !_isPassphraseVisible;
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.refresh),
                                  tooltip: l10n.airQrSyncGeneratePin,
                                  onPressed: () {
                                    if (_isBroadcasting) _stopBroadcasting();
                                    _generateRandomPin();
                                    _prepareSyncFrames();
                                  },
                                ),
                              ],
                            ),
                          ),
                          onChanged: (_) {
                            if (_isBroadcasting) _stopBroadcasting();
                            _prepareSyncFrames();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    l10n.airQrStreamSpeed,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Slider(
                      value: _fps.toDouble(),
                      min: 5,
                      max: 25,
                      divisions: 20,
                      label: l10n.airQrFps(_fps),
                      onChanged: (val) {
                        setState(() {
                          _fps = val.toInt();
                        });
                        if (_isBroadcasting) {
                          _stopBroadcasting();
                          _startBroadcasting();
                        }
                      },
                    ),
                  ),
                  Text(
                    l10n.airQrFps(_fps),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: _encodedFrames.isEmpty ? null : _toggleBroadcasting,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: _isBroadcasting
                      ? Colors.redAccent
                      : Theme.of(context).colorScheme.primary,
                  foregroundColor: _isBroadcasting
                      ? Colors.white
                      : Theme.of(context).colorScheme.onPrimary,
                ),
                icon: Icon(_isBroadcasting ? Icons.stop : Icons.play_arrow),
                label: Text(
                  _isBroadcasting
                      ? l10n.airQrStopStream
                      : l10n.airQrStartStream,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Real High-Speed QR Visual Display Box
              Center(
                child: Container(
                  width: 290,
                  height: 290,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: qrString.isNotEmpty
                              ? QrImageView(
                                  data: qrString,
                                  size: 240,
                                  backgroundColor: Colors.white,
                                )
                              : const Center(
                                  child: Icon(
                                    Icons.qr_code,
                                    size: 100,
                                    color: Colors.grey,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      if (currentFrame != null)
                        Text(
                          currentFrame.isParity
                              ? l10n.airQrFrameParity(
                                  _currentFrameIndex + 1,
                                  _encodedFrames.length,
                                )
                              : l10n.airQrFrameBlock(
                                  _currentFrameIndex + 1,
                                  _encodedFrames.length,
                                  currentFrame.sequenceIndex,
                                ),
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (_encodedFrames.isNotEmpty)
                Text(
                  l10n.airQrTotalFrames(
                    _encodedFrames.length,
                    _encodedFrames.where((f) => !f.isParity).length,
                    _encodedFrames.where((f) => f.isParity).length,
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
