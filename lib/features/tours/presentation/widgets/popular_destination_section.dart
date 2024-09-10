import 'package:flutter/material.dart';

import '../widgets/destination_list.dart';

class PopularDestinationSection extends StatelessWidget {
  const PopularDestinationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Popular Destinations',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          height: 200,
          child: DestinationList(),
        ),
      ],
    );
  }
}
