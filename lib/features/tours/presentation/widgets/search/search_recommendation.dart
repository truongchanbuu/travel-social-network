import 'package:flutter/material.dart';

import '../../../../../cores/constants/constants.dart';

class SearchRecommendations extends StatefulWidget {
  const SearchRecommendations({super.key});

  @override
  State<SearchRecommendations> createState() => _SearchRecommendationsState();
}

class _SearchRecommendationsState extends State<SearchRecommendations> {
  List<String> recommendations = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    recommendations = [
      'Ha Noi Trip for 3 day 2 night',
      'Ho Chi Minh City Around Trip',
      'Bangkok - ThaiLand for 3 days',
      'Around Singapore',
      'Meeting the kangaroo at Australia',
      'Dynamic Life at New York City',
      'Around Singapore',
      'Meeting the kangaroo at Australia',
      'Dynamic Life at New York City',
    ];
  }

  @override
  Widget build(BuildContext context) {
    const double spacing = 10;

    return Wrap(
      textDirection: TextDirection.ltr,
      direction: Axis.horizontal,
      runSpacing: spacing,
      spacing: spacing,
      children: recommendations.map(_buildRecommendationItem).toList(),
    );
  }

  Widget _buildRecommendationItem(String recommendation) {
    const BorderRadius borderRadius = BorderRadius.all(Radius.circular(10));

    return InkWell(
      onTap: () {},
      borderRadius: borderRadius,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: Border.all(color: primaryColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            recommendation,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
