import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/widgets/custom_text_field.dart';

class DurationDropdown extends StatefulWidget {
  final void Function(String?) onSaved;
  final String? Function(String?) validator;
  final String timeUnit;

  const DurationDropdown({
    super.key,
    required this.onSaved,
    required this.validator,
    required this.timeUnit,
  });

  @override
  State<DurationDropdown> createState() => _DurationDropdownState();
}

class _DurationDropdownState extends State<DurationDropdown> {
  List<DropdownMenuItem> _dropDownItems = List.empty(growable: true);
  String? _currentDropdownTimeUnit;

  @override
  void initState() {
    super.initState();
    _dropDownItems = [
      DropdownMenuItem(
        value: S.current.hour,
        child: Text(
          S.current.hour,
          overflow: defaultTextOverflow,
          textDirection: defaultTextDirection,
        ),
      ),
      DropdownMenuItem(
        value: S.current.day,
        child: Text(
          S.current.day,
          overflow: defaultTextOverflow,
          textDirection: defaultTextDirection,
        ),
      ),
      DropdownMenuItem(
        value: S.current.week,
        child: Text(
          S.current.week,
          overflow: defaultTextOverflow,
          textDirection: defaultTextDirection,
        ),
      ),
      DropdownMenuItem(
        value: S.current.month,
        child: Text(
          S.current.month,
          overflow: defaultTextOverflow,
          textDirection: defaultTextDirection,
        ),
      ),
      DropdownMenuItem(
        value: S.current.year,
        child: Text(
          S.current.year,
          overflow: defaultTextOverflow,
          textDirection: defaultTextDirection,
        ),
      ),
    ];
    _currentDropdownTimeUnit = widget.timeUnit;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          flex: 2,
          child: CustomTextField(
            onSaved: widget.onSaved,
            validator: widget.validator,
            textEditingController: TextEditingController(text: '1'),
            label: S.current.duration,
            singleHintText: S.current.durationHintText,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.go,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        ),
        const SizedBox(width: 5),
        Flexible(
          flex: 1,
          child: DropdownButtonFormField(
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(left: 10),
              border: OutlineInputBorder(),
            ),
            icon: const SizedBox.shrink(),
            alignment: Alignment.center,
            padding: EdgeInsets.zero,
            style: const TextStyle(overflow: defaultTextOverflow),
            iconSize: 0,
            value: _currentDropdownTimeUnit,
            items: _dropDownItems,
            onChanged: (value) => _currentDropdownTimeUnit = value,
          ),
        )
      ],
    );
  }
}
