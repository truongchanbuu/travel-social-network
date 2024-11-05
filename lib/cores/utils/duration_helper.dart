import '../../generated/l10n.dart';

class DurationHelper {
  static String get yearLabel => S.current.year;
  static String get monthLabel => S.current.month;
  static String get weekLabel => S.current.week;
  static String get dayLabel => S.current.day;
  static String get hourLabel => S.current.hour;
  static String get minLabel => S.current.minute;

  static Map<String, int> get _durationValues => {
        yearLabel: 0,
        monthLabel: 0,
        weekLabel: 0,
        dayLabel: 0,
        hourLabel: 0,
        minLabel: 0,
      };

  static Duration getDurationFromString(
    String? durationString, [
    String separator = ',',
    String conjunction = 'and',
    String unitPattern = r'[a-zA-ZÀ-ỹ]+',
    String numberPattern = r'\d+',
    Map<String, int>? durationValues,
  ]) {
    _durationValues.clear();
    if (durationString?.isEmpty ?? true) return const Duration();

    final parts =
        durationString!.split(RegExp('$separator\\s*|\\s+$conjunction\\s+'));
    for (final part in parts) {
      final pattern = RegExp('($numberPattern)\\s*($unitPattern)');
      final match = pattern.firstMatch(part.trim());

      if (match != null) {
        final value = int.parse(match.group(1)!);
        final unit = match.group(2)!;

        durationValues ??= Map<String, int>.from(_durationValues);

        if (unit.startsWith(yearLabel)) {
          durationValues[yearLabel] = value;
        } else if (unit.startsWith(monthLabel)) {
          durationValues[monthLabel] = value;
        } else if (unit.startsWith(weekLabel)) {
          durationValues[weekLabel] = value;
        } else if (unit.startsWith(dayLabel)) {
          durationValues[dayLabel] = value;
        } else if (unit.startsWith(hourLabel)) {
          durationValues[hourLabel] = value;
        } else if (unit.startsWith(minLabel)) {
          durationValues[minLabel] = value;
        }

        return Duration(
          days: durationValues[dayLabel]! +
              durationValues[weekLabel]! * 7 +
              durationValues[monthLabel]! * 30 +
              durationValues[yearLabel]! * 365,
          hours: durationValues[hourLabel]!,
          minutes: durationValues[minLabel]!,
        );
      }
    }

    return const Duration();
  }
}
