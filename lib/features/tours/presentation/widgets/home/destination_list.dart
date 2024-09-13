import 'package:flutter/material.dart';

import '../../../../../cores/constants/popular_destination.dart';
import '../../../../../cores/constants/types.dart';
import 'destination_item.dart';

class DestinationList extends StatelessWidget {
  final List<PopularDestination> destinations;
  const DestinationList({
    super.key,
    this.destinations = popularDestinations,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.horizontal,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 20,
        mainAxisExtent: 200,
      ),
      itemCount: destinations.length,
      itemBuilder: (context, index) => DestinationItem(
        imageUrl: destinations[index]['imageUrl'],
        name: destinations[index]['name'],
      ),
    );
  }
}
