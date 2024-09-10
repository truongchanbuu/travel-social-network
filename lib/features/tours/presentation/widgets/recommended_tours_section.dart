import 'package:flutter/material.dart';
import 'package:travel_social_network/cores/constants/tours.dart';

import '../../data/models/tour.dart';

class RecommendedToursSection extends StatefulWidget {
  const RecommendedToursSection({super.key});

  @override
  State<RecommendedToursSection> createState() =>
      _RecommendedToursSectionState();
}

class _RecommendedToursSectionState extends State<RecommendedToursSection> {
  late final List<Tour> recommendedTours;

  @override
  void initState() {
    super.initState();
    recommendedTours = generateSampleTours();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
