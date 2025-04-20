import 'package:go_router/go_router.dart';
import 'package:tgh_mobile/imports.dart';
import 'package:tgh_mobile/widgets/overlays/theme_setting_overlay.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          forceMaterialTransparency: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ),
        body: ListView(children: [
          const ThemeSettingsTile(),
          ListTile(
            leading: const Icon(Icons.cached),
            title: Text('Clear preferences', style: Theme.of(context).textTheme.titleMedium),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(Routes.clearCache),
          )
        ]));
  }
}

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

class ClearCacheScreen extends ConsumerWidget {
  const ClearCacheScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text('Clear preferences'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(children: [
        ListTile(
            title: const Text('Clear recent searches'),
            subtitle: const Text('Clear recent results from search page'),
            onTap: () {
              ref.read(sharedPrefsServiceProvider).set(APP_RECENT_USER_SEARCH_STORAGE_KEY, []);
              // Fluttertoast.showToast(
              //     msg: 'Cleared',
              //     toastLength: Toast.LENGTH_SHORT,
              //     gravity: ToastGravity.CENTER,
              //     timeInSecForIosWeb: 1,
              //     backgroundColor: Colors.grey[800]!.withOpacity(0.8),
              //     textColor: Colors.white,
              //     fontSize: 16.0);
            }),
        ListTile(
            title: const Text('Clear theme preference'),
            subtitle: const Text('App will start in light theme next time'),
            onTap: () {
              ref.read(sharedPrefsServiceProvider).set(APP_THEME_STORAGE_KEY, 'light');
              // Fluttertoast.showToast(
              //     msg: 'Done',
              //     toastLength: Toast.LENGTH_SHORT,
              //     gravity: ToastGravity.CENTER,
              //     timeInSecForIosWeb: 1,
              //     backgroundColor: Colors.grey[800]!.withOpacity(0.8),
              //     textColor: Colors.white,
              //     fontSize: 16.0);
            }),
      ]),
    );
  }
}
