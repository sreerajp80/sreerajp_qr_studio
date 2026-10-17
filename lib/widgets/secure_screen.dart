import 'package:flutter/widgets.dart';
import 'package:sreerajp_qr_studio/services/screen_security_service.dart';

/// Blocks screenshots and screen recording while [child] is on screen
/// (`FLAG_SECURE`, docs/security.md §10.1). Wrap screens and sheets that show
/// scanned content, history, secrets or API keys.
class SecureScreen extends StatefulWidget {
  const SecureScreen({super.key, required this.child, this.service});

  final Widget child;

  /// Defaults to [ScreenSecurityService.instance]; tests pass their own.
  final ScreenSecurityService? service;

  @override
  State<SecureScreen> createState() => _SecureScreenState();
}

class _SecureScreenState extends State<SecureScreen> {
  late final ScreenSecurityService _service =
      widget.service ?? ScreenSecurityService.instance;

  @override
  void initState() {
    super.initState();
    _service.acquire();
  }

  @override
  void dispose() {
    _service.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
