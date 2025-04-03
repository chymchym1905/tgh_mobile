import 'dart:async';

import '../../imports.dart';

abstract class StorageService {
  Future<void> init();
  Future<Object?> get(String key);
  Future<bool> set(String key, dynamic data);
  Future<void> clear();
  Future<bool> has(String key);
  Future<bool> remove(String key);
}

class SharedPrefsService implements StorageService {
  SharedPreferences? _prefs;
  final Completer<SharedPreferences> _initCompleter = Completer<SharedPreferences>();

  @override
  Future<void> init() async {
    if (!_initCompleter.isCompleted) {
      _prefs = await SharedPreferences.getInstance();
      _initCompleter.complete(_prefs);
    }
  }

  Future<SharedPreferences> get _instance async {
    return _prefs ?? await _initCompleter.future;
  }

  @override
  Future<Object?> get(String key) async {
    final prefs = await _instance;
    return prefs.get(key);
  }

  @override
  Future<bool> set(String key, dynamic data) async {
    final prefs = await _instance;
    return await prefs.setString(key, data.toString());
  }

  @override
  Future<void> clear() async {
    final prefs = await _instance;
    await prefs.clear();
  }

  @override
  Future<bool> has(String key) async {
    final prefs = await _instance;
    return prefs.containsKey(key);
  }

  @override
  Future<bool> remove(String key) async {
    final prefs = await _instance;
    return await prefs.remove(key);
  }
}
