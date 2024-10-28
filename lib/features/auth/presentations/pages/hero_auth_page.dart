import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../../setting/presentation/widgets/setting_icon.dart';
import '../../../user/presentations/widgets/about_section.dart';
import '../../domain/entities/user.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/login/login_cubit.dart';
import '../bloc/signup/signup_cubit.dart';
import '../widgets/hero_image.dart';
import 'auth_method_page.dart';

class HeroAuthPage extends StatelessWidget {
  const HeroAuthPage({super.key});

  static const SizedBox spacing = SizedBox(height: 10);

  @override
  Widget build(BuildContext context) {
    final UserEntity user =
        context.select((AuthBloc authBloc) => authBloc.state.user);

    return SafeArea(
      child: Scaffold(
        backgroundColor: scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          actionsIconTheme: const IconThemeData(color: Colors.black),
          actions: const <Widget>[SettingIcon()],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildInfoSection(context, user.isLoggedIn),
                spacing,
                const AboutSection(),
                spacing,
                if (user.isLoggedIn) _LogOutButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  static const SizedBox infoSpacing = SizedBox(height: 15);
  Widget _buildInfoSection(BuildContext context, bool isLoggedIn) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const HeroImage(),
            infoSpacing,
            _buildPromotionText(),
            infoSpacing,
            if (!isLoggedIn) _buildAuthButton(context),
          ],
        ),
      ),
    );
  }

  Text _buildPromotionText() {
    return Text(
      S.current.exclusiveOffers,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      maxLines: 3,
      overflow: defaultTextOverflow,
      semanticsLabel: S.current.exclusiveOffers,
      textAlign: TextAlign.center,
      textDirection: defaultTextDirection,
    );
  }

  Widget _buildAuthButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _navToSignUpPage(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        child: Text(
          '${S.current.signIn} / ${S.current.signUp}',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  void _navToSignUpPage(BuildContext context) {
    Navigator.push(
      context,
      PageTransition(
        child: MultiBlocProvider(providers: [
          BlocProvider(create: (context) => getIt.get<LoginCubit>()),
          BlocProvider(create: (context) => getIt.get<SignUpCubit>()),
        ], child: const AuthMethodPage()),
        type: PageTransitionType.bottomToTop,
      ),
    );
  }
}

class _LogOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => context.read<AuthBloc>().add(LogoutRequest()),
        style: ElevatedButton.styleFrom(
          minimumSize: minBtnSize,
          backgroundColor: Colors.white,
        ),
        child: Text(
          S.current.logout,
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ));
  }
}
