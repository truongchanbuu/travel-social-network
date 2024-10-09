import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/form_utils.dart';
import '../../../../generated/l10n.dart';

class DurationPicker extends StatefulWidget {
  final String? initialDuration;
  const DurationPicker({super.key, this.initialDuration});

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

  final Map<String, int> _durationValues = {
    yearLabel: 0,
    monthLabel: 0,
    weekLabel: 0,
    dayLabel: 0,
    hourLabel: 0,
    minLabel: 0,
  };

  final Map<String, TextEditingController> _controllers = {};
  void _initControllers() {
    _durationValues.forEach((key, value) {
      _controllers[key] = TextEditingController.fromValue(TextEditingValue(
        text: value.toString(),
        selection: TextSelection.collapsed(offset: value.toString().length),
      ));
    });
  }

  void _initializeFromString(String? durationString) {
    if (durationString == null || durationString.isEmpty) return;

    final parts = durationString.split(', ');
    for (final part in parts) {
      final match = RegExp(r'(\d+)\s+(\w+)').firstMatch(part);
      if (match != null) {
        final value = int.parse(match.group(1)!);
        final unit = match.group(2)!.toLowerCase();

        if (unit.startsWith('year')) {
          _durationValues[yearLabel] = value;
        } else if (unit.startsWith('month')) {
          _durationValues[monthLabel] = value;
        } else if (unit.startsWith('week')) {
          _durationValues[weekLabel] = value;
        } else if (unit.startsWith('day')) {
          _durationValues[dayLabel] = value;
        } else if (unit.startsWith('hour')) {
          _durationValues[hourLabel] = value;
        } else if (unit.startsWith('minute')) {
          _durationValues[minLabel] = value;
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeFromString(widget.initialDuration);
    _initControllers();
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _updateValue(String unit, String value) {
    int? parsedValue = int.tryParse(value) ?? 0;
    setState(() {
      _durationValues[unit] = parsedValue;
      _controllers[unit] = TextEditingController.fromValue(TextEditingValue(
        text: parsedValue.toString(),
        selection:
            TextSelection.collapsed(offset: parsedValue.toString().length),
      ));
    });
  }

  String _getDuration() {
    List<String> durationParts = [];

    _durationValues.forEach((unit, value) {
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
          children: _durationValues.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(child: Text('${entry.key}:')),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: _controllers[entry.key],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => genericValidator(
                        value: value,
                        label: entry.key,
                        minLength: 0,
                        checkEmpty: false,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(5)
                      ],
                      onChanged: (value) => _updateValue(entry.key, value),
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
}
