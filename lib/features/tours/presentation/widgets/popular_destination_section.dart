import 'package:flutter/material.dart';

import '../widgets/destination_list.dart';
import '../widgets/section_heading.dart';

class PopularDestinationSection extends StatelessWidget {
  const PopularDestinationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(title: 'Popular Destinations'),
        SizedBox(
          width: double.infinity,
          height: 200,
          child: DestinationList(),
        ),
      ],
    );
  }
}
