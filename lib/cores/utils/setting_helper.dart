import '../../injection_container.dart';
import '../constants/storage_keys.dart';
import 'cached_client.dart';

class SettingHelper {
  static final CacheClient cacheClient = getIt.get<CacheClient>();

  static bool get isDarkMode =>
      cacheClient.getBool(StorageKeys.appThemeCachedKey) ?? false;
}
