import 'package:tgh_mobile/imports.dart';

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
      body: SafeArea(
        child: ListView(children: [
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
      ),
    );
  }
}
