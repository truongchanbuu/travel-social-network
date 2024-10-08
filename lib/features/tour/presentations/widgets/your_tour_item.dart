import 'package:flutter/material.dart';

import '../../domain/entities/tour.dart';

class YourTourItem extends StatelessWidget {
  final TourEntity tour;
  const YourTourItem({super.key, required this.tour});

  static const subColor = Colors.grey;
  static const TextStyle subTextStyle = TextStyle(
    color: subColor,
    fontSize: 16,
  );
  static const SizedBox spacing = SizedBox(height: 6);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _navigateToTourDetail,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              spreadRadius: 5,
              color: Colors.black12,
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                tour.tourName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              spacing,
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: subColor,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${tour.departure} - ${tour.destination}',
                    style: subTextStyle,
                  ),
                ],
              ),
              spacing,
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    color: subColor,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    tour.duration,
                    style: subTextStyle,
                  ),
                ],
              ),
            ],
          ),
          trailing: const Icon(Icons.chevron_right, color: subColor),
        ),
      ),
    );
  }

  void _navigateToTourDetail() {}
}
