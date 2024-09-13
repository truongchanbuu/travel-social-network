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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const TourDetailAppBar(),
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
