import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/popular_destination_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ScrollController _scrollController;

  final double _appBarScrollLimit = 90;

  bool _isTitleShowed = false;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.offset > _appBarScrollLimit) {
      setState(() {
        _isTitleShowed = true;
      });
    } else {
      setState(() {
        _isTitleShowed = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          HomeAppBar(isTitleShowed: _isTitleShowed),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(homePagePadding),
              child: PopularDestinationSection(),
            ),
          ),
        ],
      ),
    );
  }
}
