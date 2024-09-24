import 'package:animated_hint_textfield/animated_hint_textfield.dart';
import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';

class CreateTourField extends StatefulWidget {
  final String label;
  final bool enable;
  final List<String> hintTexts;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final void Function()? onTap;

  const CreateTourField({
    super.key,
    required this.label,
    this.enable = true,
    this.hintTexts = const [],
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.onTap,
  });

  @override
  State<CreateTourField> createState() => _CreateTourFieldState();
}

class _CreateTourFieldState extends State<CreateTourField> {
  late final FocusNode _focusNode;
  bool _isFocusing = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode()..addListener(_changeTheTextColor);
  }

  void _changeTheTextColor() =>
      setState(() => _isFocusing = _focusNode.hasFocus);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, bottom: 5),
          child: Text(
            widget.label,
            style: TextStyle(
              color: _isFocusing ? primaryColor : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
        AnimatedTextField(
          onTap: widget.onTap,
          focusNode: _focusNode,
          animationType: Animationtype.typer,
          hintTextStyle: const TextStyle(overflow: TextOverflow.ellipsis),
          hintTexts: widget.hintTexts,
          enabled: widget.enable,
          decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(width: 1, color: Colors.black54),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(width: 1, color: Colors.black54),
              )),
          textInputAction: widget.textInputAction,
          keyboardType: widget.keyboardType,
          textDirection: defaultTextDirection,
        ),
      ],
    );
  }
}
