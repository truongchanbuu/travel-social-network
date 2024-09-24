import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../setting/presentation/widgets/setting_icon.dart';

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
          children: [
            CircleAvatar(
              radius: circleAvatarRadius,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.greetingAppMember(appName),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Row(
          children: [
            Text(
              S.current.manageYourAccount,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w100,
              ),
            ),
            const Icon(Icons.chevron_right)
          ],
        )
      ],
    );
  }
}
