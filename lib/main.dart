import 'package:flutter/services.dart';
import 'package:tgh_mobile/providers/index.dart';

import 'imports.dart';
import 'package:flutter/foundation.dart';

import 'main/observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setSystemUIOverlayStyle(
  //   SystemUiOverlayStyle.light.copyWith(
  //     statusBarColor: Colors.black,
  //     statusBarBrightness: Brightness.light,
  //   ),
  // );
  runApp(ProviderScope(observers: [Observers()], child: Root()));
}

class Root extends ConsumerWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeNotifierProvider);
    return MaterialApp(
        title: 'The Golden House',
        debugShowCheckedModeBanner: false,
        theme: light,
        darkTheme: dark,
        themeMode: theme,
        home: HomeScreen());
  }
}
