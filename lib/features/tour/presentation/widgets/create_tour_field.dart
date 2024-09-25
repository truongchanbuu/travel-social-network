import 'package:animated_hint_textfield/animated_hint_textfield.dart';
import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';

class CreateTourField extends StatefulWidget {
  final Widget? replaceField;
  final String label;
  final bool enable;
  final bool readOnly;
  final List<String> hintTexts;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final void Function()? onTap;
  final int? maxLines;
  final TextEditingController? textEditingController;
  final FocusNode? focusNode;

  const CreateTourField({
    super.key,
    this.replaceField,
    required this.label,
    this.enable = true,
    this.readOnly = false,
    this.hintTexts = const [],
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.onTap,
    this.maxLines,
    this.textEditingController,
    this.focusNode,
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
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_changeTheTextColor);
  }

  void _changeTheTextColor() =>
      setState(() => _isFocusing = _focusNode.hasFocus);

  @override
  void dispose() {
    _focusNode.removeListener(_changeTheTextColor);
    _focusNode.dispose();
    super.dispose();
  }

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
            textDirection: defaultTextDirection,
            overflow: defaultTextOverflow,
          ),
        ),
        widget.replaceField == null
            ? AnimatedTextField(
                controller: widget.textEditingController,
                onTap: widget.onTap,
                focusNode: _focusNode,
                maxLines: widget.maxLines,
                cursorColor: primaryColor,
                animationType: Animationtype.typer,
                hintTextStyle: const TextStyle(overflow: TextOverflow.ellipsis),
                hintTexts: widget.hintTexts,
                enabled: widget.enable,
                readOnly: widget.readOnly,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: defaultFieldBorderRadius,
                    borderSide:
                        BorderSide(width: 1, color: createTourFieldBorder),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: defaultFieldBorderRadius,
                    borderSide:
                        BorderSide(width: 1, color: createTourFieldBorder),
                  ),
                ),
                textInputAction: widget.textInputAction,
                keyboardType: widget.keyboardType,
                textDirection: defaultTextDirection,
              )
            : GestureDetector(
                onTap: widget.onTap,
                child: widget.replaceField!,
              ),
      ],
    );
  }
}
