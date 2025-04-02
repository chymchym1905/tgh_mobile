import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../imports.dart';

part 'shared_pref.g.dart';

@riverpod
StorageService sharedPrefsService(Ref ref) {
  final sharedPrefsService = SharedPrefsService();
  sharedPrefsService.init();
  return sharedPrefsService;
}
