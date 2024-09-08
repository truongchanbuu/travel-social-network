import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../widgets/account_brief_info.dart';
import '../widgets/about_section.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    const SizedBox spacing = SizedBox(height: 10);

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
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
    );
  }
}
