import 'package:flutter/material.dart';

import '../../../../auth/presentations/pages/hero_auth_page.dart';
import '../../../../social/presentations/pages/social_network_page.dart';
import '../../widgets/app_bottom_navigation_bar.dart';
import 'home_page.dart';

class ContainerPageWithBottomNav extends StatefulWidget {
  const ContainerPageWithBottomNav({super.key});

  @override
  State<ContainerPageWithBottomNav> createState() =>
      _ContainerPageWithBottomNavState();
}

class _ContainerPageWithBottomNavState
    extends State<ContainerPageWithBottomNav> {
  int _currentIndex = 0;

  late final List<Widget> _pages = [
    const HomePage(),
    const SocialNetworkPage(),
    const HeroAuthPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: AppBottomNavigationBar(
          onTap: (int index) => setState(() => _currentIndex = index),
        ),
      ),
    );
  }
}
