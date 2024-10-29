import 'package:flutter/material.dart';

import '../../../../config/themes/app_theme.dart';
import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';

class AppBottomNavigationBar extends StatefulWidget {
  final void Function(int index)? onTap;
  const AppBottomNavigationBar({super.key, this.onTap});

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  int _currentTabIndex = 0;
  List<BottomNavigationBarItem> icons = [];

  @override
  void initState() {
    super.initState();
    icons = [
      BottomNavigationBarItem(
        icon: const Icon(Icons.home_filled),
        label: S.current.home,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.travel_explore),
        label: S.current.social,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.person),
        label: S.current.account,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: AppTheme.primaryColor,
      elevation: 20,
      currentIndex: _currentTabIndex,
      items: icons,
      onTap: (index) {
        setState(() => _currentTabIndex = index);
        widget.onTap?.call(index);
      },
    );
  }
}
