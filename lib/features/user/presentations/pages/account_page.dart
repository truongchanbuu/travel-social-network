import 'package:flutter/material.dart';

import '../../../../config/themes/app_theme.dart';
import '../widgets/account_brief_info.dart';
import '../widgets/about_section.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  static const SizedBox spacing = SizedBox(height: 10);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.scaffoldBackgroundColor,
        body: ListView(
          children: const [
            AccountBriefInfo(),
            spacing,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: AboutSection(),
            ),
          ],
        ),
      ),
    );
  }
}
