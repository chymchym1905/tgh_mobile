import 'dart:async';

import '../../imports.dart';

class LocalStorage {
  SharedPreferences? _prefs;
  final Completer<SharedPreferences> _initCompleter = Completer<SharedPreferences>();

  void init() {
    _initCompleter.complete(SharedPreferences.getInstance());
  }

  Future<SharedPreferences> get _instance async {
    return _prefs ?? await _initCompleter.future;
  }

  Future<Object?> get(String key) async {
    final prefs = await _instance;
    return prefs.get(key);
  }

  Future<bool> set(String key, data) async {
    final prefs = await _instance;
    return await prefs.setString(key, data.toString());
  }

  Future<void> clear() async {
    final prefs = await _instance;
    await prefs.clear();
  }

  Future<bool> has(String key) async {
    final prefs = await _instance;
    return prefs.containsKey(key);
  }

  Future<bool> remove(String key) async {
    final prefs = await _instance;
    return await prefs.remove(key);
  }
}
