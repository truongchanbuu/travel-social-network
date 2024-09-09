import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';

class CategoryTabBar extends StatefulWidget {
  const CategoryTabBar({super.key});

  @override
  State<CategoryTabBar> createState() => _CategoryTabBarState();
}

class _CategoryTabBarState extends State<CategoryTabBar>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  List<String> tabBarItems = [];

  @override
  void initState() {
    super.initState();
    tabBarItems = ['Popular Destinations', 'Recommended Tours'];
    _tabController = TabController(length: tabBarItems.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.circular(50);

    return TabBar(
      controller: _tabController,
      isScrollable: true,
      dividerHeight: 0,
      indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
      labelColor: Colors.white,
      splashBorderRadius: borderRadius,
      unselectedLabelColor: Colors.black,
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: BoxDecoration(
        color: primaryColor,
        borderRadius: borderRadius,
      ),
      tabs: tabBarItems
          .map(
            (itemText) => Tab(text: itemText),
          )
          .toList(),
    );
  }
}
