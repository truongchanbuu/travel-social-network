import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../widgets/auth_app_bar.dart';
import '../widgets/continue_button.dart';
import '../widgets/password_input_field.dart';
import '../widgets/phone_input_field.dart';

class ContinueWithPhonePage extends StatelessWidget {
  const ContinueWithPhonePage({super.key});

  get scrollController => ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AuthAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20.0,
          left: 20.0,
          right: 20.0,
          bottom: 10.0,
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const PhoneInputField(),
                    verticalInputSpacing,
                    const PasswordInputField(),
                    verticalInputSpacing,
                    _buildForgotPasswordText(),
                  ],
                ),
              ),
            ),
            const ContinueButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildForgotPasswordText() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            S.current.forgotPassword,
            style: const TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
