import 'package:shared_preferences/shared_preferences.dart';

class CacheClient {
  final SharedPreferencesWithCache prefs;
  const CacheClient(this.prefs);

  String? getString(String key) {
    return prefs.getString(key);
  }

  Future<void> setString(String key, String value) async {
    await prefs.setString(key, value);
  }

  int? getInt(String key) {
    return prefs.getInt(key);
  }

  Future<void> setInt(String key, int value) async {
    await prefs.setInt(key, value);
  }

  bool? getBool(String key) {
    return prefs.getBool(key);
  }

  Future<void> setBool(String key, bool value) async {
    await prefs.setBool(key, value);
  }

  Future<void> remove(String key) async {
    await prefs.remove(key);
  }

  Future<void> clear() async {
    await prefs.clear();
  }

  Future<bool> containsKey(String key) async {
    return prefs.containsKey(key);
  }
}
