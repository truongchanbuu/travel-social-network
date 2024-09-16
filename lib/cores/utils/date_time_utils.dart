import 'dart:ui';

import 'package:intl/intl.dart';

class DateTimeUtils {
  static String getThePeriodOfTheDay() {
    final DateTime now = DateTime.now();
    final int hour = now.hour;

    if (hour >= 5 && hour < 12) {
      return 'morning';
    } else if (hour >= 12 && hour < 17) {
      return 'afternoon';
    } else if (hour >= 17 && hour < 21) {
      return 'evening';
    }

    return 'night';
  }

  static String formatDateTime(DateTime date, [languageCode = 'en']) {
    DateFormat vietnameseFormat = DateFormat('d \'thg\' M');
    DateFormat englishFormat = DateFormat('dd MMM');

    return languageCode == 'en'
        ? englishFormat.format(date)
        : vietnameseFormat.format(date);
  }

  static String getWeekdays(DateTime date, [languageCode = 'en']) {
    DateFormat formatter = DateFormat(DateFormat.ABBR_WEEKDAY);
    return formatter.format(date);
  }
}
