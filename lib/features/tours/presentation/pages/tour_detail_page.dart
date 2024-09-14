import 'package:flutter/material.dart';

import '../../data/models/tour.dart';
import '../widgets/tour/info_section.dart';
import '../widgets/tour/tour_detail_app_bar.dart';

class TourDetailPage extends StatefulWidget {
  final Tour tour;
  const TourDetailPage({
    super.key,
    required this.tour,
  });

  @override
  State<TourDetailPage> createState() => _TourDetailPageState();
}

class _TourDetailPageState extends State<TourDetailPage> {
  late final Tour tour;
  Color titleColor = Colors.white;
  final double expandedHeight = 250;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    tour = widget.tour;
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
      setState(() => titleColor = Colors.black);
    } else {
      setState(() => titleColor = Colors.white);
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
            tour: tour,
          ),
          const SliverToBoxAdapter(child: InfoSection()),
        ],
      ),
    );
  }
}
