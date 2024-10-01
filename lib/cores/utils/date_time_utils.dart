import 'package:get_time_ago/get_time_ago.dart';
import 'package:intl/intl.dart';

class DateTimeUtils {
  static DateTime now = DateTime.now();

  static bool isToday(DateTime date) =>
      now.day == date.day && now.month == date.month && now.year == date.year;

  static bool isSameDate(DateTime d1, DateTime d2) =>
      d1.day == d2.day && d1.month == d2.month && d1.year == d2.year;

  static String getThePeriodOfTheDay() {
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

  static String getTimeAgo(DateTime date, [String languageCode = 'en']) {
    switch (languageCode) {
      case 'en':
        return GetTimeAgo.parse(date);
      case 'vi':
        GetTimeAgo.setCustomLocaleMessages('vi', VietnameseMessages());
        return GetTimeAgo.parse(date, locale: 'vi');
      default:
        return formatDayAndMonth(date);
    }
  }

  static String formatFullDate(DateTime date, [String languageCode = 'en']) =>
      DateFormat(DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY).format(date);

  static String formatDayAndMonth(DateTime date, [String languageCode = 'en']) {
    DateFormat vietnameseFormat = DateFormat('d \'thg\' M');
    DateFormat englishFormat = DateFormat('dd MMM');

    return languageCode == 'en'
        ? englishFormat.format(date)
        : vietnameseFormat.format(date);
  }

  static String getWeekdays(DateTime date, [String languageCode = 'en']) {
    DateFormat formatter = DateFormat(DateFormat.ABBR_WEEKDAY);
    return formatter.format(date);
  }

  static List<DateTime> parseDateTimeRange(String dateTimeRange) {
    final List<String> parts = dateTimeRange.split(' - ');
    final DateFormat format = DateFormat('HH:mm dd/MM/yyyy');

    final DateTime startDateTime = format.parse(parts[0]);
    final DateTime endDateTime = format.parse(parts[1]);

    return [startDateTime, endDateTime];
  }
}
