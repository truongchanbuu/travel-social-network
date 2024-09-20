import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../../pages/search/search_page.dart';
import '../search/search_box.dart';
import 'home_page_header.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverLayoutBuilder(
      builder: (context, constraints) {
        final appBarHeight =
            _calculateAppBarHeight(constraints.crossAxisExtent);
        return SliverAppBar(
          pinned: true,
          backgroundColor: Colors.white,
          expandedHeight: appBarHeight,
          collapsedHeight: kToolbarHeight + 40,
          flexibleSpace: FlexibleSpaceBar(
            title: _buildSearchBox(context),
            centerTitle: true,
            collapseMode: CollapseMode.pin,
            expandedTitleScale: 1,
            background: _buildBackground(),
          ),
        );
      },
    );
  }

  double _calculateAppBarHeight(double width) {
    switch (width) {
      case double w when w > 500:
        return 150;
      case double w when w > 350:
        return 170;
      case double w when w >= 250:
        return 180;
      case double w when w >= 225:
        return 200;
      default:
        return 230;
    }
  }

  Widget _buildSearchBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      width: double.infinity,
      child: SearchBox(
        onTap: () => _navigateToSearchPage(context),
        elevation: 5,
        hintText: 'Search your wonderful trips!',
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.lightBlue, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      width: double.infinity,
      child: const Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            HomePageHeader(username: 'Buu Truong'),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void _navigateToSearchPage(BuildContext context) {
    Navigator.push(context, _createSearchPageRoute());
  }

  Route _createSearchPageRoute() {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => const SearchPage(),
      transitionDuration:
          const Duration(milliseconds: pageChangeTransitionDuration),
      transitionsBuilder: (_, animation, __, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.fastOutSlowIn)).animate(animation),
          child: child,
        );
      },
    );
  }
}
