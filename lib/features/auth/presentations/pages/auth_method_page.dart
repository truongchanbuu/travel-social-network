import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../config/themes/app_theme.dart';
import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../../shared/presentations/widgets/app_name_logo.dart';
import '../bloc/login/login_cubit.dart';
import '../bloc/signup/signup_cubit.dart';
import '../widgets/hero_image.dart';
import '../widgets/social_button.dart';
import '../widgets/social_icon.dart';
import 'continue_with_email_page.dart';
import 'continue_with_phone_page.dart';

class AuthMethodPage extends StatelessWidget {
  const AuthMethodPage({super.key});

  static const String googleProviderName = "google";
  static const String facebookProviderName = "facebook";
  static const String emailProviderName = "email";
  static const String phoneProviderName = "phone";

  static const Color descColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSucceed) {
          Navigator.popUntil(context, ModalRoute.withName('/'));
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: _buildAppBar(context),
          body: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 200) {
                return Center(
                  child: Text(
                    S.current.unsupportedText,
                    textAlign: TextAlign.left,
                    overflow: defaultTextOverflow,
                    semanticsLabel: S.current.unsupportedText,
                  ),
                );
              }

              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: const HeroImage(),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${S.current.signIn} / ${S.current.signUp}',
                        semanticsLabel:
                            '${S.current.signIn} / ${S.current.signUp}',
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
                      _buildSocialList(context),
                      const SizedBox(height: 30),
                      _buildConditionAndPolicyConfirmation(context),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.primaryColor,
      title: const AppName(),
      centerTitle: true,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.chevron_left),
        tooltip: S.current.backToPreviousPage,
      ),
    );
  }

  static const spacing = SizedBox(height: 10);
  Widget _buildSocialList(BuildContext context) {
    return Column(
      children: [
        // Facebook
        // SocialButton(
        //   title: '${S.current.continueWith} Facebook',
        //   buttonColor: Colors.blue,
        //   leading: SocialIcon(
        //     label: '${S.current.continueWith} Facebook',
        //     imageUrl: 'assets/auth/icons/facebook_icon.svg',
        //     size: 20,
        //     iconColor: Colors.white,
        //     iconData: Icons.facebook,
        //   ),
        // ),
        // spacing,
        // Google
        SocialButton(
          onTap: () => _continueWithAccount(context, googleProviderName),
          title: '${S.current.continueWith} Google',
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
          onTap: () => _continueWithAccount(context, emailProviderName),
          title: '${S.current.continueWith} Email',
          textColor: Colors.white,
          buttonColor: Colors.black,
          leading: SocialIcon(
            label: '${S.current.continueWith} Email',
            imageUrl: 'assets/auth/icons/email_icon.svg',
            size: 20,
            iconColor: Colors.white,
            iconData: Icons.email_outlined,
          ),
        ),
        // spacing,
        // Phone
        // SocialButton(
        //   onTap: () => _continueWithAccount(context, phoneProviderName),
        //   title: '${S.current.continueWith} Phone',
        //   buttonColor: const Color.fromRGBO(5, 164, 5, 1),
        //   leading: SocialIcon(
        //     label: '${S.current.continueWith} Phone',
        //     imageUrl: 'assets/auth/icons/phone_icon.svg',
        //     size: 20,
        //     iconColor: Colors.white,
        //     iconData: Icons.phone,
        //   ),
        // ),
      ],
    );
  }

  static const TextStyle emphasizedTextStyle = TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.bold,
  );
  Widget _buildConditionAndPolicyConfirmation(BuildContext context) {
    final defaultTextStyle = DefaultTextStyle.of(context).style;

    return RichText(
      overflow: defaultTextOverflow,
      maxLines: 3,
      textAlign: TextAlign.center,
      text: TextSpan(children: <TextSpan>[
        TextSpan(
          text: S.current.agreementText,
          semanticsLabel: S.current.agreementText,
          style: defaultTextStyle,
        ),
        TextSpan(
          text: S.current.termsOfService,
          style: emphasizedTextStyle,
          semanticsLabel: S.current.termsOfService,
          recognizer: TapGestureRecognizer()
            ..onTap =
                () => debugPrint('Ready to navigate to Term of Service page'),
        ),
        TextSpan(
          text: ' ${S.current.and} ',
          style: defaultTextStyle,
          semanticsLabel: S.current.and,
        ),
        TextSpan(
          text: S.current.privacyPolicy,
          style: emphasizedTextStyle,
          semanticsLabel: S.current.privacyPolicy,
          recognizer: TapGestureRecognizer()
            ..onTap =
                () => debugPrint('Ready to navigate to Privacy Policy page'),
        ),
      ]),
    );
  }

  void _continueWithAccount(BuildContext context, String providerName) {
    switch (providerName) {
      case googleProviderName:
        context.read<LoginCubit>().logInWithGoogle();
        break;
      case emailProviderName:
        Navigator.push(
          context,
          PageTransition(
            child: BlocProvider(
              create: (context) => getIt.get<LoginCubit>(),
              child: BlocProvider.value(
                value: context.read<SignUpCubit>(),
                child: const ContinueWithEmailPage(),
              ),
            ),
            type: PageTransitionType.leftToRight,
          ),
        );
        break;
      case phoneProviderName:
        Navigator.push(
          context,
          PageTransition(
            child: BlocProvider.value(
              value: context.read<SignUpCubit>(),
              child: const ContinueWithPhonePage(),
            ),
            type: PageTransitionType.leftToRight,
          ),
        );
        break;
    }
  }
}
