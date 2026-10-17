import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/providers/app_lock_provider.dart';

/// Covers the whole app with a lock screen while [AppLockProvider.locked]
/// (docs/security.md §7). Used in `MaterialApp.builder`, so it sits above
/// every route, dialog and sheet. While locked, nothing behind it can be
/// seen, read by a screen reader, or touched.
class AppLockGate extends StatefulWidget {
  const AppLockGate({super.key, required this.child});

  final Widget child;

  @override
  State<AppLockGate> createState() => _AppLockGateState();
}

class _AppLockGateState extends State<AppLockGate> with WidgetsBindingObserver {
  bool _promptedForThisLock = false;
  bool _lastAttemptFailed = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final lock = context.read<AppLockProvider>();
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
        lock.onBackground();
      case AppLifecycleState.resumed:
        lock.onForeground();
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        break;
    }
  }

  Future<void> _unlock() async {
    final l10n = AppLocalizations.of(context);
    final ok = await context.read<AppLockProvider>().unlock(
      l10n.bodyAppLockReason,
    );
    if (mounted) setState(() => _lastAttemptFailed = !ok);
  }

  @override
  Widget build(BuildContext context) {
    final lock = context.watch<AppLockProvider>();
    if (!lock.locked) {
      _promptedForThisLock = false;
      _lastAttemptFailed = false;
      return widget.child;
    }
    if (!_promptedForThisLock) {
      // Open the system prompt once for each new lock.
      _promptedForThisLock = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && context.read<AppLockProvider>().locked) _unlock();
      });
    }
    return Stack(
      children: [
        Offstage(child: ExcludeSemantics(child: widget.child)),
        _LockScreen(
          onUnlock: lock.authInProgress ? null : _unlock,
          showError: _lastAttemptFailed,
        ),
      ],
    );
  }
}

class _LockScreen extends StatelessWidget {
  const _LockScreen({required this.onUnlock, required this.showError});

  final VoidCallback? onUnlock;
  final bool showError;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Material(
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.asset(
                      'assets/app_icon.png',
                      width: 96,
                      height: 96,
                      excludeFromSemantics: true,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Icon(Icons.lock_outline, color: theme.colorScheme.primary),
                  const SizedBox(height: 8),
                  Text(
                    l10n.titleAppLocked,
                    style: theme.textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.bodyAppLocked,
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  if (showError) ...[
                    const SizedBox(height: 16),
                    Text(
                      l10n.errorAppLockFailed,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.error,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: onUnlock,
                    icon: const Icon(Icons.fingerprint),
                    label: Text(l10n.actionUnlock),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
