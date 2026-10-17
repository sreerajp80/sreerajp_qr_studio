import 'package:material_ui/material_ui.dart';

// Fixed neutral colors: this widget must not look up the theme (it may be the
// thing that failed), so it cannot use theme tokens.
const Color _fallbackBackground = Color(0x14808080);
const Color _fallbackIcon = Color(0xFF9E9E9E);

/// Shown in release builds in place of a widget that failed to build
/// (engineering standard §11.1).
///
/// It is deliberately minimal: no text, no controls and no lookups of
/// localizations or theme, so it cannot fail the same way.
class SafeErrorFallback extends StatelessWidget {
  const SafeErrorFallback({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExcludeSemantics(
      child: ColoredBox(
        color: _fallbackBackground,
        child: Center(
          child: Icon(Icons.error_outline, size: 32, color: _fallbackIcon),
        ),
      ),
    );
  }
}
