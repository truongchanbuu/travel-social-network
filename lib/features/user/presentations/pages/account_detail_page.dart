import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../auth/presentations/widgets/account_detail_section.dart';
import '../../../setting/presentation/widgets/user_avatar.dart';
import '../widgets/account_section_item.dart';

class AccountDetailPage extends StatelessWidget {
  const AccountDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.white,
              ),
              title: Text(S.current.userProfile),
              centerTitle: true,
              collapseMode: CollapseMode.pin,
              titlePadding:
                  const EdgeInsets.only(bottom: 16), // Adjust as needed
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed([
              _buildAvatarSection(),
              _buildSecuritySection(),
              _buildAvatarSection(),
              _buildSecuritySection(),
              _buildAvatarSection(),
              _buildSecuritySection(),
              _buildAvatarSection(),
              _buildSecuritySection(),
              _buildAvatarSection(),
              _buildSecuritySection(),
              _buildAvatarSection(),
              _buildSecuritySection(),
            ]),
          ),
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

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: AccountDetailSection(
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
      ),
    );
  }
}
