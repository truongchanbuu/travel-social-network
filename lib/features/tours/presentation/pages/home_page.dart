import 'package:flutter/material.dart';

import '../../../../cores/shared/widgets/unsupported_screen.dart';
import '../widgets/destination_list.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/homepage_section_heading.dart';
import '../widgets/tours_grid_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ScrollController _scrollController;

  final double _appBarScrollLimit = 90;

  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.offset > _appBarScrollLimit) {
      setState(() {
        _isScrolled = true;
      });
    } else {
      setState(() {
        _isScrolled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const double padding = 20;
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 200) {
            return const UnsupportedScreen();
          }

          return CustomScrollView(
            controller: _scrollController,
            slivers: const [
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
