import 'package:flutter/services.dart';

import '../../../generated/l10n.dart';

class DurationInputFormatter extends TextInputFormatter {
  final String locale;
  const DurationInputFormatter({this.locale = 'en'});

  static const List<String> _unitOrder = [
    'year',
    'month',
    'week',
    'day',
    'hour',
    'minute'
  ];

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final String normalizedText = _normalizeInput(newValue.text);
    if (_isValidInput(normalizedText)) {
      return TextEditingValue(
        text: _formatOutput(normalizedText),
        selection: TextSelection.collapsed(
          offset: _formatOutput(normalizedText).length,
        ),
      );
    }

    return oldValue;
  }

  String _normalizeInput(String input) =>
      input.toLowerCase().replaceAll(RegExp(r'\s+'), ' ');

  bool _isValidInput(String input) {
    final String pattern = _buildRegPattern();
    return RegExp(pattern).hasMatch(input);
  }

  String _buildRegPattern() {
    final String patterns = _unitOrder
        .map((unit) => getDurationUnit(unit))
        .expand((list) => list.split('|'))
        .join('|');
    return r'^\d+\s*(' + patterns + r')(\s+\d+\s*(' + patterns + r'))*$';
  }

  String _formatOutput(String input) {
    final parts = input.split(RegExp(r'\s+'));
    final Map<String, int> durationParts = {};

    for (int i = 0; i < parts.length; i += 2) {
      if (i + 1 < parts.length) {
        final number = int.parse(parts[i]);
        final unit = _normalizeUnit(parts[i + 1]);
        durationParts[unit] = (durationParts[unit] ?? 0) + number;
      }
    }

    final formattedParts = _unitOrder
        .map((unit) {
          final value = durationParts[unit];
          if (value != null && value > 0) {
            return getDurationFormatted(unit, value);
          }
          return null;
        })
        .where((part) => part != null)
        .join(' ');

    return formattedParts;
  }

  String _normalizeUnit(String unit) {
    for (final baseUnit in _unitOrder) {
      if (getDurationUnit(baseUnit).split('|').contains(unit)) {
        return baseUnit;
      }
    }

    return unit;
  }

  String getDurationUnit(String unit) {
    switch (unit) {
      case 'year':
        return S.current.yearUnit;
      case 'month':
        return S.current.monthUnit;
      case 'week':
        return S.current.weekUnit;
      case 'day':
        return S.current.dayUnit;
      case 'hour':
        return S.current.hourUnit;
      case 'minute':
        return S.current.minuteUnit;
      default:
        return '';
    }
  }

  String getDurationFormatted(String unit, int count) {
    switch (unit) {
      case 'year':
        return S.current.yearFormatted(count);
      case 'month':
        return S.current.monthFormatted(count);
      case 'week':
        return S.current.weekFormatted(count);
      case 'day':
        return S.current.dayFormatted(count);
      case 'hour':
        return S.current.hourFormatted(count);
      case 'minute':
        return S.current.minuteFormatted(count);
      default:
        return '';
    }
  }
}
