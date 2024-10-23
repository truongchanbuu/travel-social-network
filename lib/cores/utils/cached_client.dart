import 'package:shared_preferences/shared_preferences.dart';

class CacheClient {
  late SharedPreferencesWithCache _prefs;
  bool _initialized = false;

  Future<void> _ensureInitialized() async {
    if (!_initialized) {
      _prefs = await SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions(),
      );
      _initialized = true;
    }
  }

  Future<String?> getString(String key) async {
    await _ensureInitialized();
    return _prefs.getString(key);
  }

  Future<void> setString(String key, String value) async {
    await _ensureInitialized();
    await _prefs.setString(key, value);
  }

  Future<int?> getInt(String key) async {
    await _ensureInitialized();
    return _prefs.getInt(key);
  }

  Future<void> setInt(String key, int value) async {
    await _ensureInitialized();
    await _prefs.setInt(key, value);
  }

  Future<bool?> getBool(String key) async {
    await _ensureInitialized();
    return _prefs.getBool(key);
  }

  Future<void> setBool(String key, bool value) async {
    await _ensureInitialized();
    await _prefs.setBool(key, value);
  }

  Future<void> remove(String key) async {
    await _ensureInitialized();
    await _prefs.remove(key);
  }

  Future<void> clear() async {
    await _ensureInitialized();
    await _prefs.clear();
  }

  Future<bool> containsKey(String key) async {
    await _ensureInitialized();
    return _prefs.containsKey(key);
  }
}
