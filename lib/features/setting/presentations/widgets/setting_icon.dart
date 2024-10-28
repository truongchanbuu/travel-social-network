import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../pages/settings_page.dart';

class SettingIcon extends StatelessWidget {
  const SettingIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _onSetting(context),
      icon: const Icon(Icons.settings_outlined),
    );
  }

  void _onSetting(BuildContext context) {
    Navigator.push(
      context,
      PageTransition(
        child: const SettingsPage(),
        type: PageTransitionType.bottomToTop,
      ),
    );
  }
}
