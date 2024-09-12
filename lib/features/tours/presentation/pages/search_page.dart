import 'package:flutter/material.dart';

import '../widgets/search_box.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      shape: const Border(
        bottom: BorderSide(width: 1, color: Colors.black),
      ),
      title: const SearchBox(
        enabled: true,
        elevation: 5,
        radius: 5,
        fillColor: Colors.white,
      ),
    );
  }
}
