import 'package:intl/intl.dart';

enum SupportCurrencies {
  usd,
  jpy,
  eur,
  vnd,
  sgd,
  krw,
  cny,
}

class CurrencyHelper {
  static List<String> get supportedCurrencies =>
      SupportCurrencies.values.map((currency) => currency.name).toList();

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
