import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../config/themes/app_theme.dart';
import '../../../../cores/utils/date_time_utils.dart';
import '../../../../cores/utils/extensions/context_extension.dart';
import '../../../../cores/utils/extensions/string_extension.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../auth/presentations/bloc/login/login_cubit.dart';
import '../../../auth/presentations/bloc/update_info/update_info_cubit.dart';
import '../../../auth/presentations/pages/info_template_page.dart';
import '../../../auth/presentations/widgets/account_detail_section.dart';
import '../../../auth/presentations/widgets/re_auth_form.dart';
import '../bloc/user_cubit.dart';
import '../widgets/account_section_item.dart';
import '../widgets/user_avatar.dart';

enum AccountAction {
  changeEmail,
  changePassword,
  changeDisplayName,
  changeBirthDate,
  changePhoneNumber;

  String get getTitle {
    switch (this) {
      case changeEmail:
        return 'Email';
      case changePassword:
        return S.current.password;
      case changeDisplayName:
        return S.current.displayName;
      case changeBirthDate:
        return S.current.birthDate;
      case changePhoneNumber:
        return S.current.phoneNumber;
    }
  }
}

class AccountDetailPage extends StatelessWidget {
  final UserEntity user;

  const AccountDetailPage({super.key, required this.user});

  static const double _padding = 10.0;
  static const double _spacing = 20.0;
  static const double _avatarRadius = 30.0;

  static const TextStyle _valueTextStyle = TextStyle(
    fontSize: 13,
    color: Colors.grey,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        backgroundColor: _getBackgroundColor(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(_padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: _buildAvatarSection(context)),
                _buildSecuritySection(context),
                const SizedBox(height: _spacing),
                _buildUserGeneralInfo(context),
                const SizedBox(height: _spacing),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        S.current.userProfile,
        style: const TextStyle(color: AppTheme.secondaryColor),
      ),
      centerTitle: true,
    );
  }

  Color _getBackgroundColor(BuildContext context) {
    return context.isDarkMode
        ? AppTheme.primaryColorDark
        : AppTheme.scaffoldBackgroundColor;
  }

  Widget _buildAvatarSection(BuildContext context) {
    return GestureDetector(
      onTap: context.read<UserCubit>().updatePhotoUrl,
      child: Stack(
        children: [
          _buildAvatarWithBloc(),
          const Positioned(
            bottom: -3,
            right: -5,
            child: Icon(Icons.edit),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarWithBloc() {
    return BlocBuilder<UserCubit, UserState>(
      buildWhen: (previous, current) =>
          current is UserAvatarChanged && current.user.id == user.id,
      builder: (context, state) {
        final currentUser =
            (state is UserAvatarChanged && state.user.id == user.id)
                ? state.user
                : user;
        return UserAvatar(user: currentUser, radius: _avatarRadius);
      },
    );
  }

  Widget _buildSecuritySection(BuildContext context) {
    return AccountDetailSection(
      title: S.current.securityAccount,
      items: [
        _buildEmailItem(context),
        _buildPhoneNumberItem(context),
        _buildPasswordItem(context),
      ],
    );
  }

  AccountSectionItem _buildEmailItem(BuildContext context) {
    return AccountSectionItem(
      onTap: () => _reAuthenticate(context, AccountAction.changeEmail),
      leading: const Icon(Icons.email),
      title: S.current.linkEmail,
      value: Text(
        user.email?.obscure ?? '',
        style: _valueTextStyle,
      ),
    );
  }

  Widget _buildPhoneNumberItem(BuildContext context) {
    return BlocProvider.value(
      value: context.read<UserCubit>()..getUser(user.id),
      child: BlocBuilder<UserCubit, UserState>(
        buildWhen: (previous, current) =>
            current is UserLoaded &&
            current.user.id == user.id &&
            current.user.phoneNumber != user.phoneNumber,
        builder: (context, state) {
          final currentUser = (state is UserLoaded && state.user.id == user.id)
              ? state.user
              : user;
          return AccountSectionItem(
            onTap: () =>
                _reAuthenticate(context, AccountAction.changePhoneNumber),
            leading: const Icon(Icons.phone),
            title: S.current.phoneNumber,
            value: Text(
              currentUser.phoneNumber?.obscure ?? '',
              style: _valueTextStyle,
            ),
          );
        },
      ),
    );
  }

  AccountSectionItem _buildPasswordItem(BuildContext context) {
    return AccountSectionItem(
      onTap: () => _reAuthenticate(context, AccountAction.changePassword),
      leading: const Icon(Icons.password),
      title: S.current.resetPassword,
      value: const Text('***', style: _valueTextStyle),
    );
  }

  Widget _buildUserGeneralInfo(BuildContext context) {
    return AccountDetailSection(
      title: S.current.generalInfoAccount,
      items: [
        _buildDisplayNameItem(context),
        _buildBirthDateItem(context),
      ],
    );
  }

  Widget _buildDisplayNameItem(BuildContext context) {
    return BlocProvider.value(
      value: context.read<UserCubit>()..getUser(user.id),
      child: BlocBuilder<UserCubit, UserState>(
        buildWhen: (previous, current) =>
            current is UserLoaded &&
            current.user.id == user.id &&
            current.user.username != user.username,
        builder: (context, state) {
          final currentUser = (state is UserLoaded && state.user.id == user.id)
              ? state.user
              : user;
          return AccountSectionItem(
            onTap: () =>
                _reAuthenticate(context, AccountAction.changeDisplayName),
            leading: const Icon(Icons.person_2),
            title: S.current.displayName,
            value: Text(
              currentUser.username ?? '',
              style: _valueTextStyle,
            ),
          );
        },
      ),
    );
  }

  Widget _buildBirthDateItem(BuildContext context) {
    return BlocProvider.value(
      value: context.read<UserCubit>()..getUser(user.id),
      child: BlocBuilder<UserCubit, UserState>(
        buildWhen: (previous, current) =>
            current is UserLoaded &&
            current.user.id == user.id &&
            current.user.dateOfBirth != user.dateOfBirth,
        builder: (context, state) {
          return AccountSectionItem(
            onTap: () =>
                _reAuthenticate(context, AccountAction.changeBirthDate),
            leading: const Icon(Icons.date_range),
            title: S.current.birthDate,
            value: Text(
              user.dateOfBirth != null
                  ? DateTimeUtils.formatFullDate(user.dateOfBirth!)
                  : '',
              style: _valueTextStyle,
            ),
          );
        },
      ),
    );
  }

  Future<void> _reAuthenticate(
      BuildContext context, AccountAction action) async {
    final navigator = Navigator.of(context);

    final isReAuthenticated = await showDialog<bool>(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => getIt.get<LoginCubit>(),
        child: const Dialog(child: ReAuthForm()),
      ),
    );

    if (isReAuthenticated ?? false) {
      navigator.push(
        PageTransition(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt.get<LoginCubit>()),
              BlocProvider(
                  create: (context) => getIt.get<UpdateAccountInfoCubit>()),
            ],
            child: InfoTemplatePage(
              title: action.getTitle,
              action: action,
            ),
          ),
          type: PageTransitionType.leftToRight,
        ),
      );
    }
  }
}
