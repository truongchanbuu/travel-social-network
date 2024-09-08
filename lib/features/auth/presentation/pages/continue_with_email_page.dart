import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../widgets/auth_app_bar.dart';
import '../widgets/continue_button.dart';
import '../widgets/password_input_field.dart';

class ContinueWithEmailPage extends StatelessWidget {
  const ContinueWithEmailPage({super.key});

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'We are going to sign in with your email or create a new account if you don\'t have one',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: inputFieldBorderRadius,
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                      ),
                      hintText: 'abc@example.com',
                      labelText: 'Email',
                      floatingLabelStyle: const TextStyle(color: primaryColor),
                    ),
                    cursorColor: primaryColor,
                    textDirection: TextDirection.ltr,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.send,
                  ),
                  verticalInputSpacing,
                  const PasswordInputField(),
                ],
              ),
            ),
            const ContinueButton(),
          ],
        ),
      ),
    );
  }
}
