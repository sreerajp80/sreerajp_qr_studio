import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

/// Fails when an icon-only control on screen has no tooltip
/// (engineering standard §7.8).
void expectAllIconButtonsHaveTooltips(WidgetTester tester) {
  bool hasText(String? tooltip) => tooltip != null && tooltip.trim().isNotEmpty;

  for (final button in tester.widgetList<IconButton>(find.byType(IconButton))) {
    expect(
      hasText(button.tooltip),
      isTrue,
      reason: 'IconButton with icon ${button.icon} has no tooltip',
    );
  }
  for (final fab in tester.widgetList<FloatingActionButton>(
    find.byType(FloatingActionButton),
  )) {
    expect(
      hasText(fab.tooltip),
      isTrue,
      reason: 'FloatingActionButton has no tooltip',
    );
  }
  for (final menu in tester.widgetList<PopupMenuButton<dynamic>>(
    find.byWidgetPredicate((w) => w is PopupMenuButton),
  )) {
    expect(
      hasText(menu.tooltip),
      isTrue,
      reason: 'PopupMenuButton has no tooltip',
    );
  }
}
