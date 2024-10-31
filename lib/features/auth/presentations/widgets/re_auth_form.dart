import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../../../../generated/l10n.dart';
import '../bloc/login/login_cubit.dart';
import 'continue_button.dart';
import 'email_input.dart';
import 'password_input_field.dart';

class ReAuthForm extends StatelessWidget {
  const ReAuthForm({super.key});

  static const spacing = SizedBox(height: 10);
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSucceed) {
          showToast(S.current.success, context: context);
          Navigator.pop(context, true);
        } else if (state is LoginFailed) {
          showToast(state.errorMessage, context: context);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.current.reAuthDialog,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            spacing,
            const EmailInput(),
            spacing,
            const PasswordInputField(),
            spacing,
            ContinueButton(
              onTap: context.select(
                      (LoginCubit loginCubit) => loginCubit.state.isValid)
                  ? context.read<LoginCubit>().reAuthenticate
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
