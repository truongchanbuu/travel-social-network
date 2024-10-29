import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/themes/app_theme.dart';
import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/presentations/widgets/app_progressing_indicator.dart';
import '../bloc/login/login_cubit.dart';
import '../bloc/signup/signup_cubit.dart';
import '../widgets/auth_app_bar.dart';
import '../widgets/continue_button.dart';
import '../widgets/password_input_field.dart';

class ContinueWithEmailPage extends StatelessWidget {
  const ContinueWithEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AuthAppBar(),
        body: MultiBlocListener(
          listeners: [
            BlocListener<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginSucceed) {
                  Navigator.of(context).popUntil(ModalRoute.withName('/'));
                } else if (state is LoginEmailNotFound) {
                  context.read<SignUpCubit>()
                    ..emailChanged(state.email.value)
                    ..passwordChanged(state.password.value)
                    ..signUpFormSubmitted();
                } else if (state is LoginFailed) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage ?? 'Login Failed'),
                      ),
                    );
                }
              },
            ),
            BlocListener<SignUpCubit, SignUpState>(
              listener: (context, state) {
                if (state is SignUpSucceed) {
                  Navigator.of(context).popUntil(ModalRoute.withName('/'));
                } else if (state is SignUpFailed) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(content: Text(S.current.authenticateFailed)),
                    );
                }
              },
            ),
          ],
          child: BlocBuilder<LoginCubit, LoginState>(
            builder: (context, loginState) {
              if (loginState is LoginInProgressing) {
                return const AppProgressingIndicator();
              }

              return Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  left: 20.0,
                  right: 20.0,
                  bottom: 10.0,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.current.emailAnnouncement,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              overflow: defaultTextOverflow,
                            ),
                            overflow: defaultTextOverflow,
                            maxLines: 3,
                          ),
                          const SizedBox(height: 15),
                          _EmailInput(loginState.email.value),
                          verticalInputSpacing,
                          PasswordInputField(
                            password: loginState.password.value,
                          ),
                        ],
                      ),
                    ),
                    ContinueButton(
                      onTap: context
                              .select((LoginCubit cubit) => cubit.state.isValid)
                          ? () =>
                              context.read<LoginCubit>().logInWithCredentials()
                          : null,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  final String? email;
  const _EmailInput(this.email);

  @override
  Widget build(BuildContext context) {
    final displayError = context
        .select((LoginCubit loginCubit) => loginCubit.state.email.displayError);

    return TextFormField(
      initialValue: email,
      onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
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
