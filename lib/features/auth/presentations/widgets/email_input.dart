import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/themes/app_theme.dart';
import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../bloc/login/login_cubit.dart';

class EmailInput extends StatelessWidget {
  final String? email;
  const EmailInput({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    final displayError = context
        .select((LoginCubit loginCubit) => loginCubit.state.email.displayError);

    return TextFormField(
      initialValue: email,
      onChanged: context.read<LoginCubit>().emailChanged,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person),
        border: const OutlineInputBorder(
          borderRadius: defaultFieldBorderRadius,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.primaryColor),
        ),
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
