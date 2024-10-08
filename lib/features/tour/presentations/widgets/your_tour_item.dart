import 'package:flutter/material.dart';

import '../../domain/entities/tour.dart';

class YourTourItem extends StatelessWidget {
  final TourEntity tour;
  const YourTourItem({super.key, required this.tour});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(tour.tourName),
          Text('${tour.departure} - ${tour.destination}'),
          Text(tour.duration),
          // Images?
        ],
      ),
    );
  }
}
