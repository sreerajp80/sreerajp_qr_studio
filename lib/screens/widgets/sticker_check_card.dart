import 'package:material_ui/material_ui.dart';
import 'package:sreerajp_qr_studio/l10n/gen/app_localizations.dart';

/// QuishingGuard card on the result screen: reminds the user to check a
/// printed QR code for a fake sticker glued over the real one.
///
/// The app does not look at the camera image for stickers, so the card
/// gives no score; it only lists the checks the user can do by hand.
/// It starts as one short row and opens when tapped.
class StickerCheckCard extends StatefulWidget {
  const StickerCheckCard({super.key});

  @override
  State<StickerCheckCard> createState() => _StickerCheckCardState();
}

class _StickerCheckCardState extends State<StickerCheckCard> {
  bool _isExpanded = false;

  void _toggle() => setState(() => _isExpanded = !_isExpanded);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final color = Colors.amber.shade800;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color.withValues(alpha: 0.4), width: 1.5),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: _toggle,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.back_hand_outlined, color: color, size: 22),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.titleQuishingGuard,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          l10n.titleStickerCheck,
                          style: TextStyle(fontSize: 12, color: color),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: _toggle,
                    tooltip: _isExpanded
                        ? l10n.tooltipStickerCheckCollapse
                        : l10n.tooltipStickerCheckExpand,
                    icon: Icon(
                      _isExpanded ? Icons.expand_less : Icons.expand_more,
                    ),
                  ),
                ],
              ),
              if (_isExpanded) ...[
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.bodyStickerCheckIntro,
                        style: const TextStyle(fontSize: 13),
                      ),
                      const SizedBox(height: 6),
                      _bullet(l10n.bodyStickerCheckEdges),
                      _bullet(l10n.bodyStickerCheckPayee),
                      _bullet(l10n.bodyStickerCheckAsk),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }
}
