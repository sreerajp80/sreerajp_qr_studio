import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';
import 'package:sreerajp_qr_studio/models/scan_record.dart';
import 'package:sreerajp_qr_studio/providers/history_provider.dart';
import 'package:sreerajp_qr_studio/screens/widgets/export_import_dialog.dart';
import 'package:sreerajp_qr_studio/screens/widgets/history_card.dart';
import 'package:sreerajp_qr_studio/screens/widgets/history_detail_sheet.dart';
import 'package:sreerajp_qr_studio/widgets/secure_screen.dart';

/// Screen displaying persistent scan history, search bar, category filters, and export/import actions.
class HistoryScreen extends StatefulWidget {
  final bool isEmbeddedTab;
  const HistoryScreen({super.key, this.isEmbeddedTab = false});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HistoryProvider>(context, listen: false).loadRecords();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showDetailSheet(BuildContext context, ScanRecord record) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => HistoryDetailSheet(
        record: record,
        onSave: (notes, locationTag) {
          final provider = Provider.of<HistoryProvider>(context, listen: false);
          provider.updateNotes(record.id, notes);
          provider.updateLocationTag(record.id, locationTag);
        },
      ),
    );
  }

  void _showExportImportDialog(BuildContext context) {
    showDialog(context: context, builder: (ctx) => const ExportImportDialog());
  }

  void _confirmClearAll(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.titleHistoryClear),
        content: Text(l10n.bodyHistoryClear),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(l10n.actionCancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Provider.of<HistoryProvider>(context, listen: false).clearAll();
              Navigator.of(ctx).pop();
            },
            child: Text(l10n.actionHistoryClearAll),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final historyProvider = Provider.of<HistoryProvider>(context);

    final categoryChips = [
      {'key': 'all', 'label': l10n.labelHistoryFilterAll, 'icon': Icons.apps},
      {
        'key': 'favorites',
        'label': l10n.labelHistoryFilterStarred,
        'icon': Icons.star,
      },
      {'key': 'url', 'label': l10n.labelHistoryFilterUrls, 'icon': Icons.link},
      {'key': 'wifi', 'label': l10n.labelHistoryFilterWifi, 'icon': Icons.wifi},
      {
        'key': 'contact',
        'label': l10n.labelHistoryFilterContacts,
        'icon': Icons.person,
      },
      {
        'key': 'email',
        'label': l10n.labelHistoryFilterEmail,
        'icon': Icons.email,
      },
      {
        'key': 'phone',
        'label': l10n.labelHistoryFilterPhone,
        'icon': Icons.phone,
      },
      {'key': 'sms', 'label': l10n.labelHistoryFilterSms, 'icon': Icons.sms},
      {
        'key': 'applink',
        'label': l10n.labelHistoryFilterAppLink,
        'icon': Icons.launch,
      },
      {
        'key': 'productbarcode',
        'label': l10n.labelHistoryFilterProductBarcode,
        'icon': Icons.qr_code_scanner,
      },
      {
        'key': 'isbn',
        'label': l10n.labelHistoryFilterIsbn,
        'icon': Icons.menu_book,
      },
      {
        'key': 'text',
        'label': l10n.labelHistoryFilterText,
        'icon': Icons.text_snippet,
      },
      {
        'key': 'barcode',
        'label': l10n.labelHistoryFilterBarcodes,
        'icon': Icons.qr_code_2,
      },
    ];

    return SecureScreen(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: !widget.isEmbeddedTab,
          title: Text(l10n.titleHistoryScreen),
          actions: [
            IconButton(
              icon: const Icon(Icons.ios_share),
              tooltip: l10n.tooltipHistoryExport,
              onPressed: () => _showExportImportDialog(context),
            ),
            IconButton(
              icon: const Icon(Icons.delete_sweep_outlined),
              tooltip: l10n.actionHistoryClearAll,
              onPressed: historyProvider.totalCount > 0
                  ? () => _confirmClearAll(context)
                  : null,
            ),
          ],
        ),
        body: SafeArea(
          top: false,
          child: Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: l10n.helpHistorySearch,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            tooltip: l10n.actionCancel,
                            onPressed: () {
                              _searchController.clear();
                              historyProvider.setSearchQuery('');
                            },
                          )
                        : null,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (query) => historyProvider.setSearchQuery(query),
                ),
              ),

              // Category Filter Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                child: Row(
                  children: categoryChips.map((chip) {
                    final isSelected =
                        historyProvider.selectedCategory == chip['key'];
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FilterChip(
                        avatar: Icon(
                          chip['icon'] as IconData,
                          size: 16,
                          color: isSelected
                              ? theme.colorScheme.onPrimary
                              : theme.colorScheme.primary,
                        ),
                        label: Text(chip['label'] as String),
                        selected: isSelected,
                        selectedColor: theme.colorScheme.primary,
                        labelStyle: TextStyle(
                          color: isSelected
                              ? theme.colorScheme.onPrimary
                              : theme.colorScheme.onSurface,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        onSelected: (selected) {
                          historyProvider.setCategory(chip['key'] as String);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 4),

              // Summary Stats Header
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 4,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.bodyHistoryRecordCount(historyProvider.totalCount),
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    if (historyProvider.favoritesCount > 0)
                      Text(
                        '⭐ ${historyProvider.favoritesCount} Starred',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: Colors.amber.shade800,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ),

              const Divider(height: 1),

              // Records List / Loading / Empty State
              Expanded(
                child: historyProvider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : historyProvider.hasLoadError
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: 72,
                                color: theme.colorScheme.error,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                l10n.errorHistoryLoadFailed,
                                style: theme.textTheme.titleMedium,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              FilledButton.icon(
                                onPressed: historyProvider.loadRecords,
                                icon: const Icon(Icons.refresh),
                                label: Text(l10n.actionTryAgain),
                              ),
                            ],
                          ),
                        ),
                      )
                    : historyProvider.records.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.history_toggle_off,
                              size: 72,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              l10n.emptyHistoryTitle,
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              historyProvider.searchQuery.isNotEmpty
                                  ? l10n.emptyHistoryNoMatches(
                                      historyProvider.searchQuery,
                                    )
                                  : l10n.emptyHistoryMessage,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.grey.shade500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () => historyProvider.loadRecords(),
                        child: ListView.builder(
                          itemCount: historyProvider.records.length,
                          itemBuilder: (context, index) {
                            final record = historyProvider.records[index];
                            return HistoryCard(
                              record: record,
                              onTap: () => _showDetailSheet(context, record),
                              onToggleFavorite: () =>
                                  historyProvider.toggleFavorite(record.id),
                              onEditNotes: () =>
                                  _showDetailSheet(context, record),
                              onDelete: () =>
                                  historyProvider.deleteRecord(record.id),
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
