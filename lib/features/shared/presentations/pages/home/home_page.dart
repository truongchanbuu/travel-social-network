import 'package:flutter/material.dart';

import '../../../../../cores/constants/constants.dart';
import '../../../../../generated/l10n.dart';
import '../../../../tour/presentations/widgets/tours_grid_view.dart';
import '../../widgets/home/destination_list.dart';
import '../../widgets/home/home_app_bar.dart';
import '../../widgets/home/homepage_fab.dart';
import '../../widgets/home/homepage_section_heading.dart';
import '../unsupported_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const HomePageFloatingActionButton(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 200) {
            return const UnsupportedScreen();
          }

          return CustomScrollView(
            slivers: [
              const HomeAppBar(),
              HomepageSectionHeading(
                title: S.current.popularDest,
                padding: defaultPadding,
              ),
              const SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                sliver: SliverToBoxAdapter(
                  child: SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: DestinationList(),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
              HomepageSectionHeading(
                title: S.current.recommendTours,
                padding: defaultPadding,
              ),
              const SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                sliver: ToursGridView(),
              ),
            ],
          );
        },
      ),
    );
  }
}
