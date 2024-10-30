import 'package:flutter/material.dart';

import '../../../../config/themes/app_theme.dart';
import '../../../../cores/utils/extensions/context_extension.dart';
import '../../../../generated/l10n.dart';

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
    tabBarItems = [S.current.popularDest, S.current.recommendTours];
    _tabController = TabController(length: tabBarItems.length, vsync: this);
  }

  BorderRadius borderRadius = BorderRadius.circular(50);
  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      dividerHeight: 0,
      indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
      labelColor: context.isDarkMode ? Colors.white : Colors.black,
      splashBorderRadius: borderRadius,
      unselectedLabelColor: Colors.black,
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: BoxDecoration(
        color: AppTheme.primaryColor,
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
