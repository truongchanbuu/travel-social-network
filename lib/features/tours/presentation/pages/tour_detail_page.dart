import 'package:flutter/material.dart';

import '../widgets/tour/tour_detail_app_bar.dart';

class TourDetailPage extends StatefulWidget {
  // final Tour tour;
  const TourDetailPage({
    super.key,
    // required this.tour,
  });

  @override
  State<TourDetailPage> createState() => _TourDetailPageState();
}

class _TourDetailPageState extends State<TourDetailPage> {
  Color titleColor = Colors.white;
  final double expandedHeight = 250;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final double maxOffset = expandedHeight - kToolbarHeight;
    final double scrollOffset = _scrollController.offset;

    if (_scrollController.hasClients && scrollOffset > maxOffset) {
      setState(() {
        titleColor = Colors.black;
      });
    } else {
      titleColor = Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          TourDetailAppBar(
            expandedHeight: expandedHeight,
            titleColor: titleColor,
          ),
          ...List.generate(
            100,
            (index) => SliverToBoxAdapter(
              child: Text('$index'),
            ),
          )
        ],
      ),
    );
  }
}
