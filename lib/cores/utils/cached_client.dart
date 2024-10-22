import 'package:shared_preferences/shared_preferences.dart';

class CacheClient {
  Future<String?> getString(String key) async {
    final prefs = await SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions());
    return prefs.getString(key);
  }

  Future<void> setString(String key, String value) async {
    final prefs = await SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions());
    await prefs.setString(key, value);
  }

  Future<int?> getInt(String key) async {
    final prefs = await SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions());
    return prefs.getInt(key);
  }

  Future<void> setInt(String key, int value) async {
    final prefs = await SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions());
    await prefs.setInt(key, value);
  }

  Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions());
    return prefs.getBool(key);
  }

  Future<void> setBool(String key, bool value) async {
    final prefs = await SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions());
    await prefs.setBool(key, value);
  }

  Future<void> remove(String key) async {
    final prefs = await SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions());
    await prefs.remove(key);
  }

  Future<void> clear() async {
    final prefs = await SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions());
    await prefs.clear();
  }

  Future<bool> containsKey(String key) async {
    final prefs = await SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions());
    return prefs.containsKey(key);
  }
}
