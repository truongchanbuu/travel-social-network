import '../../generated/l10n.dart';

class DurationHelper {
  static String get yearLabel => S.current.year;
  static String get monthLabel => S.current.month;
  static String get weekLabel => S.current.week;
  static String get dayLabel => S.current.day;
  static String get hourLabel => S.current.hour;
  static String get minLabel => S.current.minute;

  static final Map<String, int> _durationValues = {
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

        if (unit.startsWith(yearLabel)) {
          _durationValues[yearLabel] = value;
        } else if (unit.startsWith(monthLabel)) {
          _durationValues[monthLabel] = value;
        } else if (unit.startsWith(weekLabel)) {
          _durationValues[weekLabel] = value;
        } else if (unit.startsWith(dayLabel)) {
          print("HERE");
          _durationValues[dayLabel] = value;
        } else if (unit.startsWith(hourLabel)) {
          _durationValues[hourLabel] = value;
        } else if (unit.startsWith(minLabel)) {
          _durationValues[minLabel] = value;
        }
        print('V: $value + U: $unit - $dayLabel ${_durationValues[dayLabel]}');

        return Duration(
          days: _durationValues[dayLabel]! +
              _durationValues[weekLabel]! * 7 +
              _durationValues[monthLabel]! * 30 +
              _durationValues[yearLabel]! * 365,
          hours: _durationValues[hourLabel]!,
          minutes: _durationValues[minLabel]!,
        );
      }
    }

    return const Duration();
  }
}
