import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../imports.dart';
import '../shared/shared_pref.dart';

part 'theme.g.dart';

const map = {
  'ThemeMode.system': ThemeMode.system,
  'ThemeMode.light': ThemeMode.light,
  'ThemeMode.dark': ThemeMode.dark,
};

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  final _lightSystemNavigationBarColor = light.colorScheme.surface;
  final _darkSystemNavigationBarColor = dark.colorScheme.surface;
  @override
  ThemeMode build() {
    final storage = ref.watch(sharedPrefsServiceProvider);
    return getCurrentTheme(storage);
  }

  void toggleTheme(ThemeMode mode) {
    state = mode;
    ref.read(sharedPrefsServiceProvider).set(APP_THEME_STORAGE_KEY, mode.toString());
    updateSystemUIOverlay(mode);
  }

  ThemeMode getCurrentTheme(StorageService storage) {
    final theme = storage.get(APP_THEME_STORAGE_KEY) as String?;
    final value = theme != null ? map[theme] : ThemeMode.system;
    if (value == null) {
      updateSystemUIOverlay(ThemeMode.system);
      return ThemeMode.system;
    }
    updateSystemUIOverlay(value);
    return value;
  }

  void updateSystemUIOverlay(ThemeMode mode) {
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
              systemNavigationBarColor: _darkSystemNavigationBarColor,
              systemNavigationBarIconBrightness: Brightness.light,
            )
          : SystemUiOverlayStyle.light.copyWith(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarColor: _lightSystemNavigationBarColor,
              systemNavigationBarIconBrightness: Brightness.dark,
            ),
    );
  }
}
