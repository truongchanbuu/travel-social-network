import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/shared/widgets/search_box.dart';
import 'home_page_header.dart';

class HomeAppBar extends StatelessWidget {
  final bool isTitleShowed;
  final PreferredSize? bottom;
  const HomeAppBar({
    super.key,
    this.isTitleShowed = false,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    const double appBarHeight = 180;
    return SliverAppBar(
      bottom: bottom,
      pinned: true,
      backgroundColor: Colors.white,
      expandedHeight: appBarHeight,
      collapsedHeight: kToolbarHeight + 40,
      flexibleSpace: FlexibleSpaceBar(
        title: isTitleShowed
            ? Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: homePagePadding, vertical: 10),
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.5,
                      color: Colors.grey,
                    ),
                  ),
                ),
                child: const SearchBox())
            : null,
        centerTitle: true,
        collapseMode: CollapseMode.pin,
        expandedTitleScale: 1,
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.lightBlue,
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          width: double.maxFinite,
          child: const Padding(
            padding: EdgeInsets.all(homePagePadding),
            child: Column(
              children: [
                HomePageHeader(username: 'Buu Truong'),
                SizedBox(height: 10),
                SearchBox(elevation: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
