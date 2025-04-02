abstract class StorageService {
  Future<void> init();
  Future<Object?> get(String key);
  Future<bool> set(String key, dynamic data);
  Future<void> clear();
  Future<bool> has(String key);
  Future<bool> remove(String key);
}
