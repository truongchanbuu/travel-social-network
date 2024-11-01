import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/themes/app_theme.dart';
import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../bloc/login/login_cubit.dart';

class EmailInput extends StatefulWidget {
  final String? email;
  const EmailInput({super.key, this.email});

  @override
  State<EmailInput> createState() => _EmailInputState();
}

class _EmailInputState extends State<EmailInput> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayError = context
        .select((LoginCubit loginCubit) => loginCubit.state.email.displayError);

    return TextFormField(
      focusNode: _focusNode,
      initialValue: widget.email,
      onChanged: context.read<LoginCubit>().emailChanged,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person),
        border:
            const OutlineInputBorder(borderRadius: defaultFieldBorderRadius),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.primaryColor)),
        hintText: 'abc@example.com',
        labelText: 'Email',
        floatingLabelStyle: TextStyle(
            color: displayError != null ? Colors.red : AppTheme.primaryColor),
        labelStyle: TextStyle(color: displayError != null ? Colors.red : null),
        errorText: displayError != null ? S.current.invalidEmail : null,
      ),
      cursorColor: AppTheme.primaryColor,
      textDirection: defaultTextDirection,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
    );
  }
}
