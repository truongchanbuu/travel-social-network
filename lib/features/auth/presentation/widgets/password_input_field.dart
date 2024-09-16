import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';

class PasswordInputField extends StatefulWidget {
  const PasswordInputField({super.key});

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _isHidden = true;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusNode.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          color: focusNode.hasFocus ? primaryColor : null,
        ),
        suffixIcon: IconButton(
          onPressed: () => setState(() => _isHidden = !_isHidden),
          icon: Icon(
            _isHidden ? Icons.visibility : Icons.visibility_off,
            color: focusNode.hasFocus ? primaryColor : null,
          ),
        ),
        labelText: 'Password',
        semanticCounterText: 'Password should be at least 8 characters',
        border: const OutlineInputBorder(
          borderRadius: inputFieldBorderRadius,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
        ),
        floatingLabelStyle: const TextStyle(color: primaryColor),
        counterText: '',
      ),
      obscureText: _isHidden,
      textDirection: defaultTextDirection,
      cursorColor: primaryColor,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.send,
      validator: _validatePassword,
      onChanged: (String? value) {},
    );
  }

  String? _validatePassword(String? password) {
    if (password?.isEmpty ?? true) {
      return 'Please enter your password';
    }

    RegExp passwordRegExp =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

    if (!passwordRegExp.hasMatch(password!)) {
      return 'Password must have at least 8 characters, 1 uppercase, 1 lowercase, 1 number and 1 special character';
    }

    return null;
  }
}
