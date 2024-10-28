import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../bloc/login/login_cubit.dart';

class PasswordInputField extends StatefulWidget {
  final String? password;
  const PasswordInputField({super.key, this.password});

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  late final TextEditingController textEditingController;

  bool _isHidden = true;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(text: widget.password);
  }

  @override
  Widget build(BuildContext context) {
    final displayError =
        context.select((LoginCubit cubit) => cubit.state.password.displayError);

    final isProgressing =
        context.select((LoginCubit cubit) => cubit.state is PasswordChanged);

    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          color: displayError != null
              ? Colors.red
              : isProgressing
                  ? primaryColor
                  : null,
        ),
        suffixIcon: IconButton(
          onPressed: () => setState(() => _isHidden = !_isHidden),
          icon: Icon(
            _isHidden ? Icons.visibility : Icons.visibility_off,
            color: displayError != null
                ? Colors.red
                : isProgressing
                    ? primaryColor
                    : null,
          ),
        ),
        labelText: S.current.password,
        semanticCounterText: S.current.passwordRequirement,
        border: const OutlineInputBorder(
          borderRadius: defaultFieldBorderRadius,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
        ),
        floatingLabelStyle:
            TextStyle(color: displayError != null ? Colors.red : primaryColor),
        labelStyle: TextStyle(color: displayError != null ? Colors.red : null),
        counterText: '',
        errorMaxLines: 2,
        errorText: displayError != null ? S.current.passwordRequirement : null,
      ),
      obscureText: _isHidden,
      textDirection: defaultTextDirection,
      cursorColor: primaryColor,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.send,
      validator: _validatePassword,
      onChanged: (value) => context.read<LoginCubit>().passwordChanged(value),
    );
  }

  String? _validatePassword(String? password) {
    if (password?.isEmpty ?? true) {
      return S.current.enterPasswordRequirement;
    }

    RegExp passwordRegExp =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

    if (!passwordRegExp.hasMatch(password!)) {
      return S.current.passwordRequirement;
    }

    return null;
  }
}
