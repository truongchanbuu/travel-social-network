import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_social_network/cores/utils/form_validator.dart';

import '../../../cores/constants/constants.dart';
import '../../../generated/l10n.dart';

class DurationPicker extends StatefulWidget {
  const DurationPicker({super.key});

  @override
  State<DurationPicker> createState() => _DurationPickerState();
}

class _DurationPickerState extends State<DurationPicker> {
  static String yearLabel = S.current.year.toUpperCase();
  static String monthLabel = S.current.month.toUpperCase();
  static String weekLabel = S.current.week.toUpperCase();
  static String dayLabel = S.current.day.toUpperCase();
  static String hourLabel = S.current.hour.toUpperCase();
  static String minLabel = S.current.minute.toUpperCase();

  final Map<String, int> _values = {
    yearLabel: 0,
    monthLabel: 0,
    weekLabel: 0,
    dayLabel: 0,
    hourLabel: 0,
    minLabel: 0,
  };

  void _updateValue(String unit, int value) {
    setState(() {
      _values[unit] = value;
    });
  }

  String _getDuration() {
    List<String> durationParts = [];

    _values.forEach((unit, value) {
      if (value > 0) {
        String formattedUnit;

        if (unit == yearLabel) {
          formattedUnit = S.current.yearFormatted(value);
        } else if (unit == monthLabel) {
          formattedUnit = S.current.monthFormatted(value);
        } else if (unit == weekLabel) {
          formattedUnit = S.current.weekFormatted(value);
        } else if (unit == dayLabel) {
          formattedUnit = S.current.dayFormatted(value);
        } else if (unit == hourLabel) {
          formattedUnit = S.current.hourFormatted(value);
        } else if (unit == minLabel) {
          formattedUnit = S.current.minuteFormatted(value);
        } else {
          formattedUnit = '';
        }

        if (formattedUnit.isNotEmpty) {
          durationParts.add(formattedUnit);
        }
      }
    });

    return durationParts.isNotEmpty
        ? durationParts.join(', ')
        : S.current.dayFormatted(0);
  }

  static const btnTxtStyle = TextStyle(
    color: primaryColor,
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.current.duration),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _values.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(child: Text(entry.key)),
                  SizedBox(
                    width: 100,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => _onValidate(entry.key, value),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(5)
                      ],
                      onChanged: (value) =>
                          _updateValue(entry.key, int.tryParse(value) ?? 0),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            S.current.cancel,
            style: btnTxtStyle,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(_getDuration());
          },
          child: const Text(
            'OK',
            style: btnTxtStyle,
          ),
        ),
      ],
    );
  }

  String? _onValidate(String key, String? value) {
    String? error = genericValidator(value: value, label: key, minLength: 0);
    if (error != null) {
      return error;
    }

    int numVal = int.parse(value!);
    if (numVal <= 0) {
      return S.current.invalidDurationError;
    }

    return null;
  }
}
