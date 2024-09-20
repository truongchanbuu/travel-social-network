import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:travel_social_network/cores/shared/widgets/app_name_logo.dart';

import '../../../../cores/constants/constants.dart';
import '../widgets/hero_image.dart';
import '../widgets/social_button.dart';
import '../widgets/social_icon.dart';

class AuthMethodPage extends StatelessWidget {
  const AuthMethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color descColor = Colors.grey;

    return Scaffold(
      appBar: _buildAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 200) {
            return const Center(
              child: Text(
                'No support for this viewport',
                textAlign: TextAlign.center,
                overflow: defaultTextOverflow,
                semanticsLabel: 'No support for this viewport',
              ),
            );
          }

          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: const HeroImage(),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Sign in/Sign up',
                    semanticsLabel: 'Sign in / Sign up',
                    overflow: defaultTextOverflow,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Icon(
                        Icons.discount_outlined,
                        color: descColor,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Enjoy the privilege of membership',
                        overflow: defaultTextOverflow,
                        style: TextStyle(color: descColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  _buildSocialList(),
                  const SizedBox(height: 30),
                  _buildConditionAndPolicyConfirmation(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: primaryColor,
      title: const AppName(),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.chevron_left),
        tooltip: 'Back to previous page',
      ),
    );
  }

  Widget _buildSocialList() {
    const spacing = SizedBox(height: 10);

    return const Column(
      children: [
        // Facebook
        SocialButton(
          title: 'Continue with Facebook',
          buttonColor: Colors.blue,
          leading: SocialIcon(
            label: 'Continue with Facebook',
            imageUrl: 'assets/auth/icons/facebook_icon.svg',
            size: 20,
            iconColor: Colors.white,
            iconData: Icons.facebook,
          ),
        ),
        spacing,
        // Google
        SocialButton(
          title: 'Continue with Google',
          textColor: Colors.black,
          leading: SocialIcon(
            label: 'Continue with Google',
            imageUrl: 'assets/auth/icons/google_icon.svg',
            size: 20,
            iconColor: Colors.white,
          ),
        ),
        spacing,
        // Email
        SocialButton(
          title: 'Continue with Email',
          buttonColor: Colors.black,
          leading: SocialIcon(
            label: 'Continue with Email',
            imageUrl: 'assets/auth/icons/email_icon.svg',
            size: 20,
            iconColor: Colors.white,
            iconData: Icons.email_outlined,
          ),
        ),
        spacing,
        // Phone
        SocialButton(
          title: 'Continue with Phone',
          buttonColor: Color.fromRGBO(5, 164, 5, 1),
          leading: SocialIcon(
            label: 'Continue with Phone',
            imageUrl: 'assets/auth/icons/phone_icon.svg',
            size: 20,
            iconColor: Colors.white,
            iconData: Icons.phone,
          ),
        ),
      ],
    );
  }

  Widget _buildConditionAndPolicyConfirmation() {
    const TextStyle emphasizedText = TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.bold,
    );

    return RichText(
      overflow: defaultTextOverflow,
      maxLines: 3,
      textAlign: TextAlign.center,
      text: TextSpan(children: <TextSpan>[
        const TextSpan(
          text: 'By continuing, you agree to our ',
          semanticsLabel: 'By continuing, you agree to our ',
        ),
        TextSpan(
          text: 'Terms of Service',
          style: emphasizedText,
          semanticsLabel: 'Terms of Service',
          recognizer: TapGestureRecognizer()
            ..onTap =
                () => debugPrint('Ready to navigate to Term of Service page'),
        ),
        const TextSpan(text: ' and ', semanticsLabel: 'and'),
        TextSpan(
          text: 'Privacy Policy',
          style: emphasizedText,
          semanticsLabel: 'Privacy Policy',
          recognizer: TapGestureRecognizer()
            ..onTap =
                () => debugPrint('Ready to navigate to Privacy Policy page'),
        ),
      ]),
    );
  }
}
