import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'imports.dart';
import 'package:flutter/foundation.dart';

import 'main/observer.dart';

void main() async {
  debugRepaintRainbowEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.black,
        statusBarBrightness: Brightness.light,
      ),
    );
  }
  // SystemChrome.setSystemUIOverlayStyle(
  //   SystemUiOverlayStyle.light.copyWith(
  //     statusBarColor: Colors.black,
  //     statusBarBrightness: Brightness.light,
  //   ),
  // );
  final prefs = await SharedPreferences.getInstance();
  runApp(ProviderScope(
      overrides: [sharedPrefInstanceProvider.overrideWithValue(prefs)], observers: [Observers()], child: const Root()));
}

class Root extends ConsumerWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeNotifierProvider);
    ref.watch(dioNetworkServiceProvider);
    return ScreenUtilInit(
        designSize: const Size(344, 882),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
            title: 'The Golden House',
            debugShowCheckedModeBanner: false,
            theme: light,
            darkTheme: dark,
            themeMode: theme,
            home: const HomeScreen()));
  }
}
