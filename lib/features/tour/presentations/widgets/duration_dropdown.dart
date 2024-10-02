import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_social_network/features/shared/widgets/custom_text_field.dart';

import '../../../../generated/l10n.dart';

class DurationTextField extends StatefulWidget {
  final void Function(String duration) onDurationChange;

  const DurationTextField({super.key, required this.onDurationChange});

  @override
  State<DurationTextField> createState() => _DurationTextFieldState();
}

class _DurationTextFieldState extends State<DurationTextField> {
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _customController = TextEditingController();
  String _unit = 'hours';

  @override
  void dispose() {
    _valueController.dispose();
    _customController.dispose();
    super.dispose();
  }

  void _updateDuration() {
    if (_valueController.text.isNotEmpty) {
      widget.onDurationChange('${_valueController.text} $_unit');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: CustomTextField(
                label: S.current.duration,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                onChanged: (_) => _updateDuration(),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: CustomTextField(
                label: 'Unit',
                replaceField: DropdownButtonFormField<String>(
                  value: _unit,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  items: ['minutes', 'hours', 'days', 'weeks', 'months']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _unit = newValue;
                        _updateDuration();
                      });
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        CustomTextField(
          label: 'Custom Format',
          textEditingController: _customController,
          hintTexts: const ['e.g., 1h30m, 3 days 2h'],
          onChanged: widget.onDurationChange,
        )
      ],
    );
  }
}
