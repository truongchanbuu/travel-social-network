import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../widgets/search/recent_search.dart';
import '../widgets/search/search_box.dart';
import '../widgets/search/search_recommendation.dart';
import '../widgets/search/search_title.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> recentSearches = [];

  @override
  void initState() {
    super.initState();
    recentSearches = ['Singapore', 'ThaiLand'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      shape: const Border(
        bottom: BorderSide(width: 0.5, color: Colors.grey),
      ),
      elevation: 20,
      surfaceTintColor: Colors.white,
      toolbarHeight: kToolbarHeight + 20,
      centerTitle: true,
      titleSpacing: 0,
      title: const SearchBox(
        autofocus: true,
        enabled: true,
        radius: 5,
        fillColor: Colors.white,
        searchIcon: false,
        hintText: 'Searching...',
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.close),
        color: primaryColor,
        tooltip: 'Close',
      ),
      automaticallyImplyLeading: true,
      actions: [
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.all(15),
          ),
          child: const Text(
            'Search',
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    const SizedBox spacing = SizedBox(height: 10);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (recentSearches.isNotEmpty) ...[
            SearchTitle(
              title: 'Recent Search',
              suffix: GestureDetector(
                onTap: () {},
                child: const Text(
                  'Clear',
                  style: TextStyle(color: primaryColor),
                ),
              ),
            ),
            spacing,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: RecentSearch(recentSearches: recentSearches),
            ),
            spacing,
          ],
          const SearchTitle(title: 'Recommendations'),
          spacing,
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            child: SearchRecommendations(),
          ),
        ],
      ),
    );
  }
}
