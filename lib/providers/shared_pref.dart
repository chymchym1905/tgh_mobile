import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../imports.dart';
import '../shared/shared_pref.dart';

part 'shared_pref.g.dart';

@riverpod
SharedPreferences sharedPrefInstance(Ref ref) {
  throw UnimplementedError();
}

@riverpod
StorageService sharedPrefsService(Ref ref) {
  // Watch the future provider to rebuild when the instance is available
  final prefs = ref.watch(sharedPrefInstanceProvider);

  return SharedPrefsService(prefs);
}
