import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';

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
        labelText: S.current.password,
        semanticCounterText: S.current.passwordRequirement,
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
