import 'package:flutter/material.dart';

import '../widgets/search/search_box.dart';
import '../../../../cores/constants/constants.dart';
import '../widgets/search/search_recommendation.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        onPressed: () {},
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
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recommendations',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              semanticsLabel: 'Recommendations',
            ),
            SizedBox(height: 10),
            SearchRecommendations(),
          ],
        ),
      ),
    );
  }
}
