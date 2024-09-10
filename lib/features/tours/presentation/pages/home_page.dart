import 'package:flutter/material.dart';

import '../../../../cores/shared/widgets/search_box.dart';
import '../widgets/home_page_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double _appBarHeight = 180;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            expandedHeight: _appBarHeight,
            collapsedHeight: kToolbarHeight + 20,
            stretch: false,
            flexibleSpace: FlexibleSpaceBar(
              title: const SearchBox(),
              collapseMode: CollapseMode.pin,
              titlePadding: const EdgeInsets.all(10),
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
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: HomePageHeader(username: 'Buu Truong'),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Container(),
            ),
          ),
        ],
      ),
    );
  }
}
