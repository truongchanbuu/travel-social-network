import 'package:flutter/material.dart';

import '../../../cores/constants/constants.dart';

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar({super.key});

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
      const BottomNavigationBarItem(
          icon: Icon(Icons.home_filled), label: 'Home'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.travel_explore), label: 'Social'),
      const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: primaryColor,
      elevation: 20,
      currentIndex: _currentTabIndex,
      items: icons,
      onTap: (index) => setState(() => _currentTabIndex = index),
    );
  }
}