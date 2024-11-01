import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../config/themes/app_theme.dart';
import '../../../../cores/utils/date_time_utils.dart';
import '../../../../cores/utils/extensions/context_extension.dart%20';
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
  changePhoneNumber,
}

class AccountDetailPage extends StatelessWidget {
  final UserEntity user;
  const AccountDetailPage({super.key, required this.user});

  static const spacing = SizedBox(height: 20);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            S.current.userProfile,
            style: const TextStyle(color: AppTheme.secondaryColor),
          ),
          centerTitle: true,
        ),
        backgroundColor: context.isDarkMode
            ? AppTheme.primaryColorDark
            : AppTheme.scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: _buildAvatarSection(context)),
                _buildSecuritySection(context),
                spacing,
                _buildUserGeneralInfo(context),
                spacing,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarSection(BuildContext context) {
    return GestureDetector(
      onTap: context.read<UserCubit>().updatePhotoUrl,
      child: Stack(
        children: [
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              UserEntity currentUser = user;
              if (state is UserAvatarChanged && state.user.id == user.id) {
                currentUser = state.user;
              }

              return UserAvatar(user: currentUser, radius: 30);
            },
            buildWhen: (previous, current) {
              return current is UserAvatarChanged && current.user.id == user.id;
            },
          ),
          const Positioned(
            bottom: -3,
            right: -5,
            child: Icon(Icons.edit),
          ),
        ],
      ),
    );
  }

  static const TextStyle valueTextStyle = TextStyle(
    fontSize: 13,
    color: Colors.grey,
  );
  Widget _buildSecuritySection(BuildContext context) {
    return AccountDetailSection(
      title: S.current.securityAccount,
      items: [
        AccountSectionItem(
          onTap: () => _reAuthenticate(context, AccountAction.changeEmail),
          leading: const Icon(Icons.email),
          title: S.current.linkEmail,
          value: Text(
            user.email?.obscure ?? '',
            style: valueTextStyle,
          ),
        ),
        BlocProvider.value(
          value: context.read<UserCubit>()..getUser(user.id),
          child: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              UserEntity currentUser = user;
              if (state is UserLoaded && state.user.id == user.id) {
                currentUser = state.user;
              }

              return AccountSectionItem(
                onTap: () =>
                    _reAuthenticate(context, AccountAction.changePhoneNumber),
                leading: const Icon(Icons.phone),
                title: S.current.phoneNumber,
                value: Text(
                  currentUser.phoneNumber?.obscure ?? '',
                  style: valueTextStyle,
                ),
              );
            },
            buildWhen: (previous, current) {
              return current is UserLoaded &&
                  current.user.id == user.id &&
                  current.user.phoneNumber != user.phoneNumber;
            },
          ),
        ),
        AccountSectionItem(
          onTap: () => _reAuthenticate(context, AccountAction.changePassword),
          leading: const Icon(Icons.password),
          title: S.current.resetPassword,
          value: const Text(
            '***',
            style: valueTextStyle,
          ),
        ),
      ],
    );
  }

  Widget _buildUserGeneralInfo(BuildContext context) {
    return AccountDetailSection(
      title: S.current.generalInfoAccount,
      items: [
        BlocProvider.value(
          value: context.read<UserCubit>()..getUser(user.id),
          child: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              UserEntity currentUser = user;
              if (state is UserLoaded && state.user.id == user.id) {
                currentUser = state.user;
              }

              return AccountSectionItem(
                onTap: () =>
                    _reAuthenticate(context, AccountAction.changeDisplayName),
                leading: const Icon(Icons.person_2),
                title: S.current.displayName,
                value: Text(
                  currentUser.username ?? '',
                  style: valueTextStyle,
                ),
              );
            },
            buildWhen: (previous, current) {
              return current is UserLoaded &&
                  current.user.id == user.id &&
                  current.user.username != user.username;
            },
          ),
        ),
        BlocProvider.value(
          value: context.read<UserCubit>()..getUser(user.id),
          child: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              UserEntity currentUser = user;
              if (state is UserLoaded && state.user.id == user.id) {
                currentUser = state.user;
              }

              return AccountSectionItem(
                leading: const Icon(Icons.date_range),
                title: S.current.birthDate,
                value: Text(
                  user.dateOfBirth != null
                      ? DateTimeUtils.formatFullDate(user.dateOfBirth!)
                      : '',
                  style: valueTextStyle,
                ),
              );
            },
            buildWhen: (previous, current) {
              return current is UserLoaded &&
                  current.user.id == user.id &&
                  current.user.dateOfBirth != user.dateOfBirth;
            },
          ),
        ),
      ],
    );
  }

  void _reAuthenticate(BuildContext context, AccountAction action) async {
    final navigator = Navigator.of(context);

    bool? isReAuthenticated = await showDialog<bool>(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => getIt.get<LoginCubit>(),
        child: const Dialog(child: ReAuthForm()),
      ),
    );

    String title = '';
    if (isReAuthenticated ?? false) {
      switch (action) {
        case AccountAction.changeEmail:
          title = 'Email';
          break;
        case AccountAction.changePassword:
          title = S.current.password;
          break;
        case AccountAction.changeDisplayName:
          title = S.current.displayName;
          break;
        case AccountAction.changeBirthDate:
          // TODO: Handle this case.
          break;
        case AccountAction.changePhoneNumber:
          title = S.current.phoneNumber;
          break;
      }

      navigator.push(
        PageTransition(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt.get<LoginCubit>()),
              BlocProvider(
                  create: (context) => getIt.get<UpdateAccountInfoCubit>()),
            ],
            child: InfoTemplatePage(title: title, action: action),
          ),
          type: PageTransitionType.leftToRight,
        ),
      );
    }
  }
}
