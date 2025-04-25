import 'package:tgh_mobile/imports.dart';

class ThemeSettingsTile extends ConsumerStatefulWidget {
  const ThemeSettingsTile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ThemeSettingsTileState();
}

class _ThemeSettingsTileState extends ConsumerState<ThemeSettingsTile> {
  OverlayEntry? _overlayEntry;
  void _showOverlay() {
    if (_overlayEntry?.mounted ?? false) {
      _overlayEntry?.remove();
      return;
    }
    _overlayEntry = OverlayEntry(
        builder: (context) => Stack(
              children: [
                // Background overlay
                GestureDetector(
                    onTap: () {
                      _showOverlay();
                    },
                    child: Opacity(
                      opacity: 0.5,
                      child: Container(
                        color: Theme.of(context).colorScheme.surfaceContainerLowest,
                      ),
                    )),
                // Centered overlay
                const Center(child: ThemeSettingOverlay()),
              ],
            ));
    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: const Icon(Icons.dark_mode),
        title: Text('App Theme', style: Theme.of(context).textTheme.titleMedium),
        trailing: const Icon(Icons.chevron_right),
        onTap: _showOverlay);
  }
}
