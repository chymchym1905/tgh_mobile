import 'package:flutter/rendering.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'imports.dart';
import 'package:flutter/foundation.dart';

import 'utils/observer.dart';

void main() async {
  // debugRepaintRainbowEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint(defaultTargetPlatform.toString());
  if (kIsWeb) {
    usePathUrlStrategy();
    GoRouter.optionURLReflectsImperativeAPIs = true;
  }
  final prefs = await SharedPreferences.getInstance();
  runApp(ProviderScope(
      overrides: [sharedPrefInstanceProvider.overrideWithValue(prefs)], observers: [Observers()], child: const Root()));
}

class Root extends ConsumerWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeNotifierProvider);
    final router = ref.watch(routerProvider);
    ref.watch(dioNetworkServiceProvider);
    return ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp.router(
            restorationScopeId: 'app',
            routerConfig: router,
            title: 'The Golden House',
            debugShowCheckedModeBanner: false,
            theme: light,
            darkTheme: dark,
            themeMode: theme));
  }
}
