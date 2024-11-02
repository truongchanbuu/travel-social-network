import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/themes/app_theme.dart';
import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/date_time_utils.dart';
import '../../../../generated/l10n.dart';
import '../../../auth/presentations/bloc/update_info/update_info_cubit.dart';
import '../../../auth/presentations/pages/info_template_page.dart';

class DateTimeTextField extends StatefulWidget {
  final InputFieldConfig config;
  const DateTimeTextField({super.key, required this.config});

  @override
  State<DateTimeTextField> createState() => _DateTimeTextFieldState();
}

class _DateTimeTextFieldState extends State<DateTimeTextField> {
  late final FocusNode _focusNode;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.config.controller ??
        TextEditingController(text: widget.config.initialVale);
    _focusNode = FocusNode()..requestFocus();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateAccountInfoCubit, UpdateAccountInfoState>(
      builder: (context, state) {
        final isValid = state.isValid;
        final isProgressing = state is BirthDateChanged;

        return TextField(
          focusNode: _focusNode,
          controller: _controller,
          onChanged: widget.config.onChanged,
          decoration: _buildInputDecoration(isValid, isProgressing),
          keyboardType: widget.config.keyboardType,
          textDirection: defaultTextDirection,
          cursorColor: AppTheme.primaryColor,
          inputFormatters: widget.config.formatters,
          textInputAction: TextInputAction.next,
        );
      },
    );
  }

  InputDecoration _buildInputDecoration(bool isValid, bool isProgressing) {
    final color = !isValid
        ? Colors.red
        : isProgressing
            ? AppTheme.primaryColor
            : null;

    return InputDecoration(
      prefixIcon: widget.config.icon != null
          ? Icon(widget.config.icon, color: color)
          : null,
      suffixIcon: IconButton(
        onPressed: () => _openDateTimeDialog(
            context, context.read<UpdateAccountInfoCubit>()),
        icon: Icon(
          widget.config.suffixIcon,
          color: color,
        ),
      ),
      border: const OutlineInputBorder(
        borderRadius: defaultFieldBorderRadius,
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppTheme.primaryColor),
      ),
      labelText: widget.config.labelText,
      hintText: widget.config.hintText,
      floatingLabelStyle: TextStyle(color: color),
      labelStyle: TextStyle(color: color),
      errorText: !isValid ? S.current.invalidInput : null,
      errorMaxLines: 2,
    );
  }

  void _openDateTimeDialog(
    BuildContext context,
    UpdateAccountInfoCubit cubit,
  ) async {
    DateTime? data = await showDatePicker(
      context: context,
      keyboardType: TextInputType.datetime,
      firstDate: DateTime(1924),
      lastDate: DateTime(2124),
      initialDate: DateTime.now(),
    );

    cubit.birthDateChanged(data);
    _controller.text = DateTimeUtils.dateTimeToString(data);
  }
}
