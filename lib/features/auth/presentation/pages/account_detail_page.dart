import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../widgets/account_detail_section.dart';
import '../widgets/account_section_item.dart';
import '../widgets/user_avatar.dart';

class AccountDetailPage extends StatelessWidget {
  const AccountDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: ListView(
        children: [
          _buildAvatarSection(),
          _buildSecuritySection(),
        ],
      ),
    );
  }

  Widget _buildAvatarSection() {
    return Container(
      color: Colors.red,
      child: const Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: UserAvatar(),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Icon(Icons.edit),
          ),
        ],
      ),
    );
  }

  Widget _buildSecuritySection() {
    const TextStyle valueTextStyle = TextStyle(
      fontSize: 13,
      color: Colors.grey,
    );

    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: AccountDetailSection(
        title: 'Account Security',
        items: [
          AccountSectionItem(
            leading: Icon(Icons.email),
            title: 'Link Email',
            value: Text(
              'a***le.com',
              style: valueTextStyle,
            ),
          ),
          AccountSectionItem(
            leading: Icon(Icons.phone),
            title: 'Phone number',
            value: Text(
              '09***699',
              style: valueTextStyle,
            ),
          ),
          AccountSectionItem(
            leading: Icon(Icons.password),
            title: 'Reset Password',
            value: Text(
              '***',
              style: valueTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
