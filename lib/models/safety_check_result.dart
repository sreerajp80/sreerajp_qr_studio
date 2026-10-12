import 'package:sreerajp_qr_studio/models/app_message.dart';

/// Outcome of one link safety check.
///
/// [checkName] and [message] carry message keys, not English text, so the
/// service layer stays free of UI strings. The screen turns them into words
/// with `appMessageText`.
class SafetyCheckResult {
  final AppMessage checkName;
  final bool passed;
  final AppMessage message;

  /// True when the check did not run (no API key, service turned off, or
  /// skipped in private mode). A skipped check also has [passed] set, so it
  /// never counts as a failure.
  final bool skipped;

  const SafetyCheckResult({
    required this.checkName,
    required this.passed,
    required this.message,
    this.skipped = false,
  });
}
