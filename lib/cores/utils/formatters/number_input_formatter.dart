import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NumberInputFormatter extends TextInputFormatter {
  final NumberFormat numberFormat;
  NumberInputFormatter({required this.numberFormat});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(RegExp(r'D'), '');

    if (newText.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final double value = double.parse(newText);
    String formatted = numberFormat.format(value);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
