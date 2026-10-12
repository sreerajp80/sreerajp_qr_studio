import 'package:flutter/material.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/screens/code_forge_screen.dart';
import 'package:sreerajp_qr_studio/screens/history_screen.dart';
import 'package:sreerajp_qr_studio/screens/scanner_screen.dart';

/// Root shell widget hosting the bottom NavigationBar tabs:
/// - Tab 0: Scanner (Live Camera)
/// - Tab 1: CodeForge (QR & Barcode Generator Suite)
/// - Tab 2: History (Encrypted Scan Log)
class MainShellScreen extends StatefulWidget {
  final int initialTabIndex;

  const MainShellScreen({super.key, this.initialTabIndex = 0});

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialTabIndex;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map<String, dynamic> && args['tabIndex'] is int) {
      final tabIndex = args['tabIndex'] as int;
      if (tabIndex >= 0 && tabIndex <= 2 && tabIndex != _selectedIndex) {
        setState(() {
          _selectedIndex = tabIndex;
        });
      }
    }
  }

  void _onDestinationSelected(int index) {
    if (_selectedIndex == index) return;
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          ScannerScreen(isActive: _selectedIndex == 0),
          const CodeForgeScreen(isEmbeddedTab: true),
          const HistoryScreen(isEmbeddedTab: true),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.qr_code_scanner_outlined),
            selectedIcon: const Icon(Icons.qr_code_scanner),
            label: l10n.tabScan,
          ),
          NavigationDestination(
            icon: const Icon(Icons.qr_code_2_outlined),
            selectedIcon: const Icon(Icons.qr_code_2),
            label: l10n.tabCodeForge,
          ),
          NavigationDestination(
            icon: const Icon(Icons.history_outlined),
            selectedIcon: const Icon(Icons.history),
            label: l10n.tabHistory,
          ),
        ],
      ),
    );
  }
}
