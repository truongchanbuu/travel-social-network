import 'package:animated_hint_textfield/animated_hint_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../cores/constants/constants.dart';

class CustomTextField extends StatefulWidget {
  final Widget? replaceField;
  final String label;
  final bool enable;
  final bool readOnly;
  final List<String> hintTexts;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final AutovalidateMode autovalidateMode;
  final Animationtype animationtype;
  final int? maxLines;
  final void Function()? onTap;
  final void Function(String value)? onChanged;
  final String? Function(String? value)? validator;
  final void Function(String? value)? onSaved;
  final void Function(String? value)? onSubmitted;
  final VoidCallback? onEditingCompleted;
  final List<TextInputFormatter> inputFormatters;
  final TextEditingController? textEditingController;
  final FocusNode? focusNode;

  const CustomTextField({
    super.key,
    this.replaceField,
    required this.label,
    this.enable = true,
    this.readOnly = false,
    this.hintTexts = const [],
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.autovalidateMode = AutovalidateMode.onUnfocus,
    this.animationtype = Animationtype.typer,
    this.onTap,
    this.onChanged,
    this.validator,
    this.onSaved,
    this.onSubmitted,
    this.onEditingCompleted,
    this.maxLines,
    this.textEditingController,
    this.focusNode,
    this.inputFormatters = const [],
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final FocusNode _focusNode;

  String? _errorMessage;
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
    widget.textEditingController?.dispose();
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
              color: _errorMessage != null
                  ? Colors.red
                  : _isFocusing
                      ? primaryColor
                      : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
            textDirection: defaultTextDirection,
            overflow: defaultTextOverflow,
          ),
        ),
        widget.replaceField == null
            ? AnimatedTextField(
                autovalidateMode: widget.autovalidateMode,
                controller: widget.textEditingController,
                focusNode: _focusNode,
                onTap: widget.onTap,
                onChanged: widget.onChanged,
                onSaved: widget.onSaved,
                onEditingComplete: widget.onEditingCompleted,
                onSubmitted: widget.onSubmitted,
                validator: (value) {
                  _errorMessage = widget.validator?.call(value);
                  return _errorMessage;
                },
                maxLines: widget.maxLines,
                cursorColor: primaryColor,
                animationType: widget.animationtype,
                hintTextStyle: const TextStyle(overflow: TextOverflow.ellipsis),
                inputFormatters: widget.inputFormatters,
                hintTexts: widget.hintTexts,
                enabled: widget.enable,
                readOnly: widget.readOnly,
                decoration: const InputDecoration(
                  errorMaxLines: 2,
                  border: OutlineInputBorder(
                    borderRadius: defaultFieldBorderRadius,
                    borderSide:
                        BorderSide(width: 1, color: defaultFieldBorderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: defaultFieldBorderRadius,
                    borderSide:
                        BorderSide(width: 1, color: defaultFieldBorderColor),
                  ),
                  hintMaxLines: 1,
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
