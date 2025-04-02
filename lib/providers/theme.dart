import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../imports.dart';
import 'shared_pref.dart';

part 'theme.g.dart';

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  @override
  ThemeMode? build() {
    final storage = ref.watch(sharedPrefsServiceProvider);
    getCurrentTheme(storage);
    return ThemeMode.light;
  }

  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    ref.read(sharedPrefsServiceProvider).set(APP_THEME_STORAGE_KEY, state?.name);
  }

  Future<void> getCurrentTheme(StorageService storage) async {
    final theme = await storage.get(APP_THEME_STORAGE_KEY);
    final value = ThemeMode.values.byName('${theme ?? 'light'}');
    state = value;
  }
}
