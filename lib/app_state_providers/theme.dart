import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../imports.dart';
import '../shared/shared_pref.dart';

part 'theme.g.dart';

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  @override
  ThemeMode build() {
    final storage = ref.watch(sharedPrefsServiceProvider);
    return getCurrentTheme(storage);
  }

  void toggleTheme(ThemeMode mode) {
    state = mode;
    ref.read(sharedPrefsServiceProvider).set(APP_THEME_STORAGE_KEY, mode.toString());
    _updateSystemUIOverlay(mode);
  }

  ThemeMode getCurrentTheme(StorageService storage) {
    final theme = storage.get(APP_THEME_STORAGE_KEY) as String?;
    final value = theme != null ? ThemeMode.values.byName(theme) : ThemeMode.system;
    _updateSystemUIOverlay(value);
    return value;
  }

  void _updateSystemUIOverlay(ThemeMode mode) {
    bool isDark;
    if (mode == ThemeMode.system) {
      isDark = WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
    } else {
      isDark = mode == ThemeMode.dark;
    }

    SystemChrome.setSystemUIOverlayStyle(
      isDark
          ? SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarColor: dark.colorScheme.surface,
              systemNavigationBarIconBrightness: Brightness.light,
            )
          : SystemUiOverlayStyle.light.copyWith(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarColor: light.colorScheme.surface,
              systemNavigationBarIconBrightness: Brightness.dark,
            ),
    );
  }
}
