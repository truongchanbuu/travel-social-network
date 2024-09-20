import 'package:flutter/material.dart';

import '../../widgets/unsupported_screen.dart';
import '../../widgets/home/destination_list.dart';
import '../../widgets/home/home_app_bar.dart';
import '../../widgets/home/homepage_fab.dart';
import '../../widgets/home/homepage_section_heading.dart';
import '../../widgets/home/tours_grid_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    const double padding = 20;
    return Scaffold(
      floatingActionButton: const HomePageFloatingActionButton(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 200) {
            return const UnsupportedScreen();
          }

          return const CustomScrollView(
            slivers: [
              HomeAppBar(),
              HomepageSectionHeading(
                title: 'Popular Destinations',
                padding: padding,
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: padding),
                sliver: SliverToBoxAdapter(
                  child: SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: DestinationList(),
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 20)),
              HomepageSectionHeading(
                title: 'Recommended Tours',
                padding: padding,
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: padding),
                sliver: ToursGridView(),
              ),
            ],
          );
        },
      ),
    );
  }
}
