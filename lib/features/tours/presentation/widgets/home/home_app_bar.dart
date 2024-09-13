import 'package:flutter/material.dart';

import '../../../../../cores/constants/constants.dart';
import '../../pages/search_page.dart';
import '../search/search_box.dart';
import 'home_page_header.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverLayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.crossAxisExtent;

        double appBarHeight = 150;

        if (width <= 500 && width > 350) {
          appBarHeight = 170;
        } else if (width <= 350 && width >= 250) {
          appBarHeight = 180;
        } else if (width < 250 && width >= 210) {
          appBarHeight = 200;
        } else if (width < 210) {
          appBarHeight = 230;
        }

        return SliverAppBar(
          pinned: true,
          backgroundColor: Colors.white,
          expandedHeight: appBarHeight,
          collapsedHeight: kToolbarHeight + 40,
          flexibleSpace: FlexibleSpaceBar(
            title: Container(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              width: double.maxFinite,
              child: SearchBox(
                onTap: () => _navigateToSearchPage(context),
                elevation: 5,
                hintText: 'Search your wonderful trips!',
              ),
            ),
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
                padding: EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    HomePageHeader(username: 'Buu Truong'),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _navigateToSearchPage(BuildContext context) {
    Navigator.push(context, _createSearchPageRoute());
  }

  Route _createSearchPageRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const SearchPage(),
      transitionDuration:
          const Duration(milliseconds: pageChangeTransitionDuration),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const Offset begin = Offset(0.0, 1.0);
        const Offset end = Offset.zero;
        const Curve curve = Curves.fastOutSlowIn;

        Animatable<Offset> tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
