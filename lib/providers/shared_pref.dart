import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../imports.dart';

part 'shared_pref.g.dart';

@riverpod
LocalStorage sharedPrefsService(Ref ref) {
  final sharedPrefsService = LocalStorage();
  sharedPrefsService.init();
  return sharedPrefsService;
}
