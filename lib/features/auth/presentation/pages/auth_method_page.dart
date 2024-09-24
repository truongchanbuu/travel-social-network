import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:travel_social_network/features/shared/widgets/app_name_logo.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
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
            return Center(
              child: Text(
                S.current.unsupportedText,
                textAlign: TextAlign.center,
                overflow: defaultTextOverflow,
                semanticsLabel: S.current.unsupportedText,
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
                  Text(
                    '${S.current.signIn} / ${S.current.signUp}',
                    semanticsLabel: '${S.current.signIn} / ${S.current.signUp}',
                    overflow: defaultTextOverflow,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      const Icon(
                        Icons.discount_outlined,
                        color: descColor,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        S.current.promotionText,
                        overflow: defaultTextOverflow,
                        style: const TextStyle(color: descColor),
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
        tooltip: S.current.backToPreviousPage,
      ),
    );
  }

  Widget _buildSocialList() {
    const spacing = SizedBox(height: 10);

    return Column(
      children: [
        // Facebook
        SocialButton(
          title: '${S.current.continueWith} Facebook',
          buttonColor: Colors.blue,
          leading: SocialIcon(
            label: '${S.current.continueWith} Facebook',
            imageUrl: 'assets/auth/icons/facebook_icon.svg',
            size: 20,
            iconColor: Colors.white,
            iconData: Icons.facebook,
          ),
        ),
        spacing,
        // Google
        SocialButton(
          title: '${S.current.continueWith} Google',
          textColor: Colors.black,
          leading: SocialIcon(
            label: '${S.current.continueWith} Google',
            imageUrl: 'assets/auth/icons/google_icon.svg',
            size: 20,
            iconColor: Colors.white,
          ),
        ),
        spacing,
        // Email
        SocialButton(
          title: '${S.current.continueWith} Email',
          buttonColor: Colors.black,
          leading: SocialIcon(
            label: '${S.current.continueWith} Email',
            imageUrl: 'assets/auth/icons/email_icon.svg',
            size: 20,
            iconColor: Colors.white,
            iconData: Icons.email_outlined,
          ),
        ),
        spacing,
        // Phone
        SocialButton(
          title: '${S.current.continueWith} Phone',
          buttonColor: const Color.fromRGBO(5, 164, 5, 1),
          leading: SocialIcon(
            label: '${S.current.continueWith} Phone',
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
        TextSpan(
          text: S.current.agreementText,
          semanticsLabel: S.current.agreementText,
        ),
        TextSpan(
          text: S.current.termsOfService,
          style: emphasizedText,
          semanticsLabel: S.current.termsOfService,
          recognizer: TapGestureRecognizer()
            ..onTap =
                () => debugPrint('Ready to navigate to Term of Service page'),
        ),
        TextSpan(text: ' ${S.current.and} ', semanticsLabel: S.current.and),
        TextSpan(
          text: S.current.privacyPolicy,
          style: emphasizedText,
          semanticsLabel: S.current.privacyPolicy,
          recognizer: TapGestureRecognizer()
            ..onTap =
                () => debugPrint('Ready to navigate to Privacy Policy page'),
        ),
      ]),
    );
  }
}
