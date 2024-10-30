import 'package:intl/intl.dart';

import '../../injection_container.dart';
import '../constants/storage_keys.dart';
import 'cached_client.dart';
import 'locale_helper.dart';

enum SupportCurrencies {
  usd,
  jpy,
  eur,
  vnd,
  sgd,
  krw,
  cny,
  gbp,
}

class CurrencyHelper {
  static final _cachedClient = getIt.get<CacheClient>();

  static final Map<String, String> currencyToLocale = {
    SupportCurrencies.usd.name: 'en',
    SupportCurrencies.jpy.name: 'ja',
    SupportCurrencies.eur.name: 'de',
    SupportCurrencies.vnd.name: 'vi',
    SupportCurrencies.sgd.name: 'en',
    SupportCurrencies.krw.name: 'ko',
    SupportCurrencies.cny.name: 'zh',
  };

  static String getLocaleFromCurrency(String currency) {
    return currencyToLocale[currency.toLowerCase()] ?? 'en';
  }

  static List<String> get supportedCurrencies => SupportCurrencies.values
      .map((currency) => currency.name.toUpperCase())
      .toList();

  static String get currentCurrencyUnit =>
      _cachedClient.getString(StorageKeys.appCurrencyCachedKey) ??
      getCurrencyBaseOnLocale();

  static String getCurrencyBaseOnLocale([String? locale]) {
    String currentLocale = LocaleHelper.getRegion;
    NumberFormat currencyFormatter =
        NumberFormat.simpleCurrency(locale: currentLocale);
    return currencyFormatter.currencyName ??
        SupportCurrencies.usd.name.toUpperCase();
  }

  static String formatCurrency(
    num amount, {
    String? locale,
    String? currencyCode,
    bool spaceBetweenSymbolAndAmount = true,
    bool removeTrailingZeros = true,
  }) {
    final String effectiveLocale = locale ?? Intl.getCurrentLocale();

    final NumberFormat formatter = NumberFormat.currency(
      locale: effectiveLocale,
      name: currencyCode,
      symbol: currencyCode,
    );

    String formatted = formatter.format(amount);

    if (removeTrailingZeros) {
      List<String> parts = formatted.split(formatter.symbols.DECIMAL_SEP);
      if (parts.length > 1) {
        if (int.parse(parts[1]) == 0) {
          formatted = parts[0];
        } else {
          parts[1] = parts[1].replaceAll(RegExp(r'0+$'), '');
          formatted = parts.join(formatter.symbols.DECIMAL_SEP);
        }
      }
    }

    if (spaceBetweenSymbolAndAmount || effectiveLocale.startsWith('en')) {
      final currencySymbol = formatter.currencySymbol;
      if (formatted.startsWith(currencySymbol)) {
        formatted = formatted.replaceFirst(currencySymbol, '$currencySymbol ');
      } else if (formatted.endsWith(currencySymbol)) {
        formatted = formatted.replaceFirst(
            RegExp('$currencySymbol\$'), ' $currencySymbol');
      }
    }

    return formatted;
  }
}
