import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../../../../cores/constants/constants.dart';
import '../widgets/setting_icon.dart';

class AccountBriefInfo extends StatelessWidget {
  const AccountBriefInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 25,
              child: Image(
                image: const Svg('assets/auth/images/female_avatars.svg'),
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.person,
                  size: 30,
                ),
              ),
            ),
            const SizedBox(width: 10),
            _buildInfoText(),
            const Spacer(),
            const SettingIcon(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoText() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hi $appName member',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Row(
          children: [
            Text(
              'Manage your account',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w100,
              ),
            ),
            Icon(Icons.chevron_right)
          ],
        )
      ],
    );
  }
}
