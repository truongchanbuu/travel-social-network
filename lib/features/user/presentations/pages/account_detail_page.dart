import 'package:flutter/material.dart';

import '../../../../config/themes/app_theme.dart';
import '../../../../cores/utils/date_time_utils.dart';
import '../../../../cores/utils/extensions/context_extension.dart';
import '../../../../generated/l10n.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../auth/presentations/widgets/account_detail_section.dart';
import '../widgets/account_section_item.dart';
import '../widgets/user_avatar.dart';

class AccountDetailPage extends StatelessWidget {
  final UserEntity user;
  const AccountDetailPage({super.key, required this.user});

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
                Center(child: _buildAvatarSection()),
                _buildSecuritySection(),
                _buildUserGeneralInfo(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarSection() {
    return Stack(
      children: [
        UserAvatar(user: user, radius: 30),
        Positioned(
          bottom: -3,
          right: -3,
          child: GestureDetector(
            onTap: () {},
            child: const Icon(Icons.edit),
          ),
        ),
      ],
    );
  }

  static const TextStyle valueTextStyle = TextStyle(
    fontSize: 13,
    color: Colors.grey,
  );
  Widget _buildSecuritySection() {
    return AccountDetailSection(
      title: S.current.securityAccount,
      items: [
        AccountSectionItem(
          leading: const Icon(Icons.email),
          title: S.current.linkEmail,
          value: const Text(
            'a***le.com',
            style: valueTextStyle,
          ),
        ),
        AccountSectionItem(
          leading: const Icon(Icons.phone),
          title: S.current.phoneNumber,
          value: const Text(
            '09***699',
            style: valueTextStyle,
          ),
        ),
        AccountSectionItem(
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

  Widget _buildUserGeneralInfo() {
    return AccountDetailSection(
      title: S.current.generalInfoAccount,
      items: [
        AccountSectionItem(
          leading: const Icon(Icons.person_2),
          title: S.current.displayName,
          value: Text(
            user.username ?? '',
            style: valueTextStyle,
          ),
        ),
        AccountSectionItem(
          leading: const Icon(Icons.date_range),
          title: S.current.birthDate,
          value: Text(
            user.dateOfBirth != null
                ? DateTimeUtils.formatFullDate(user.dateOfBirth!)
                : '',
            style: valueTextStyle,
          ),
        ),
      ],
    );
  }
}
