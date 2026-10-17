import 'package:flutter/widgets.dart';

/// Rebuilds everything below it from scratch, including every provider.
///
/// Used after "Delete all data", so no screen or provider keeps old data in
/// memory and the app starts like a fresh install.
class AppRestartScope extends StatefulWidget {
  const AppRestartScope({super.key, required this.builder});

  /// Builds the app. Called again, with fresh state, on every restart.
  final WidgetBuilder builder;

  /// Restarts the app tree that contains [context].
  static void restart(BuildContext context) {
    context.findAncestorStateOfType<_AppRestartScopeState>()?._restart();
  }

  @override
  State<AppRestartScope> createState() => _AppRestartScopeState();
}

class _AppRestartScopeState extends State<AppRestartScope> {
  Key _key = UniqueKey();

  void _restart() => setState(() => _key = UniqueKey());

  @override
  Widget build(BuildContext context) => KeyedSubtree(
    key: _key,
    child: Builder(builder: widget.builder),
  );
}
