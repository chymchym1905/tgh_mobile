import 'dart:async';

import '../../imports.dart';

abstract class StorageService {
  Object? get(String key);
  Future<bool> set(String key, dynamic data);
  Future<void> clear();
  bool has(String key);
  Future<bool> remove(String key);
}

class SharedPrefsService implements StorageService {
  final SharedPreferences _prefs;
  SharedPrefsService(this._prefs);

  SharedPreferences get _instance => _prefs;

  @override
  Object? get(String key) {
    return _instance.get(key);
  }

  @override
  Future<bool> set(String key, dynamic data) async {
    final prefs = _instance;
    return await prefs.setString(key, data.toString());
  }

  @override
  Future<void> clear() async {
    final prefs = _instance;
    await prefs.clear();
  }

  @override
  bool has(String key) {
    final prefs = _instance;
    return prefs.containsKey(key);
  }

  @override
  Future<bool> remove(String key) async {
    final prefs = _instance;
    return await prefs.remove(key);
  }
}
