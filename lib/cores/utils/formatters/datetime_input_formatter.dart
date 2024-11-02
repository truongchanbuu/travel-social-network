import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../date_time_utils.dart';

class DateTimeInputFormatter extends TextInputFormatter {
  final DateFormat formatter = DateFormat('dd/MM/yyyy');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;

    if (text.length > 10) {
      return oldValue;
    }

    if (!RegExp(r'^[0-9/]*$').hasMatch(newValue.text)) {
      return oldValue;
    }

    if (text.length == 2 || text.length == 5) {
      if (text.length > oldValue.text.length) {
        return TextEditingValue(
          text: '$text/',
          selection: TextSelection.collapsed(offset: text.length + 1),
        );
      }
    }

    if (text.length == 10) {
      try {
        formatter.parse(text);

        final List<String> parts = text.split('/');
        int day = int.parse(parts[0]);
        int month = int.parse(parts[1]);
        int year = int.parse(parts[2]);

        final dayInMonth = DateTimeUtils.getDaysInMonth(year, month);
        if (day < 1 || day > dayInMonth) {
          return oldValue;
        }

        if (year < 1900 || year > DateTime.now().year) {
          return oldValue;
        }
      } catch (e) {
        return oldValue;
      }
    }

    return newValue;
  }
}
