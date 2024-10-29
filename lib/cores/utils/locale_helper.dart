import 'package:intl/intl.dart';

import '../../generated/l10n.dart';
import '../../injection_container.dart';
import '../constants/storage_key.dart';
import 'cached_client.dart';

enum LanguageCode { en, vi }

enum TemperatureUnit { celsius, fahrenheit }

enum MeasurementSystem { metric, imperial }

class LocaleHelper {
  static final CacheClient cacheClient = getIt.get<CacheClient>();

  static List<String> get supportedLanguages => S.delegate.supportedLocales
      .map((locale) => langCodeToFullName(locale.toString()))
      .toList();

  static Map<String, String> get _langMap => {
        'vi': S.current.vietnameseLangChoice,
        'en': S.current.englishLangChoice,
        'unknown': 'Unknown'
      };

  static String langCodeToFullName(String langCode) {
    return _langMap[langCode] ?? 'Unknown Language';
  }

  static String langFullNameToCode(String fullName) {
    return _langMap.entries
        .firstWhere(
          (entry) => entry.value.toLowerCase() == fullName.toLowerCase(),
          orElse: () => _langMap.entries.last,
        )
        .key;
  }

  static String get getRegion {
    final language = cacheClient.getString(StorageKeys.appLanguageCachedKey);
    return language ?? Intl.getCurrentLocale().split('_').last;
  }

  static String getDefaultTemperature([String? region]) {
    switch (region ?? getRegion) {
      case 'US':
      case 'BS':
      case 'BZ':
      case 'KY':
      case 'PW':
        return TemperatureUnit.fahrenheit.name;
      default:
        return TemperatureUnit.celsius.name;
    }
  }

  static String getDefaultMeasurementSystem([String? region]) {
    switch (region ?? getRegion) {
      case 'US':
      case 'BS':
      case 'BZ':
      case 'KY':
      case 'PW':
        return MeasurementSystem.imperial.name;
      default:
        return MeasurementSystem.metric.name;
    }
  }

  static String getDefaultLanguage() {
    return getRegion != LanguageCode.vi.name
        ? LanguageCode.en.name
        : LanguageCode.vi.name;
  }

  static String getCurrency([String? locale]) {
    final format = NumberFormat.simpleCurrency(locale: locale);
    return format.currencySymbol;
  }
}
