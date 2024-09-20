import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:travel_social_network/cores/constants/tours.dart';

import '../../../../cores/constants/constants.dart';
import '../../../tour/domain/entities/tour.dart';
import '../app_cached_image.dart';

class ToursGridView extends StatefulWidget {
  const ToursGridView({super.key});

  @override
  State<ToursGridView> createState() => _ToursGridViewState();
}

class _ToursGridViewState extends State<ToursGridView> {
  late final List<TourEntity> recommendedTours;

  @override
  void initState() {
    super.initState();
    recommendedTours = generateSampleTours();
  }

  @override
  Widget build(BuildContext context) {
    return SliverLayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.crossAxisExtent <= 350;
        final crossAxisCount = isNarrow ? 1 : 2;

        return SliverMasonryGrid.count(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childCount: recommendedTours.length,
          itemBuilder: (context, index) => _buildTourItem(
            tour: recommendedTours[index],
            height:
                isNarrow ? 300 : tourItemSizes[index % tourItemSizes.length],
            isNarrow: isNarrow,
          ),
        );
      },
    );
  }

  Widget _buildTourItem({
    required TourEntity tour,
    required double height,
    required bool isNarrow,
  }) {
    const double borderRadius = 10;

    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(borderRadius),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: GridTile(
          footer: _buildFooter(tour.tourName, borderRadius),
          child: _buildImage(tour, height),
        ),
      ),
    );
  }

  Widget _buildFooter(String tourName, double borderRadius) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
        ),
      ),
      child: Text(
        tourName,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          overflow: defaultTextOverflow,
        ),
      ),
    );
  }

  Widget _buildImage(TourEntity tour, double height) => AppCachedImage(
        imageUrl: tour.imageUrls[Random().nextInt(tour.imageUrls.length)],
        cacheKey: tour.tourId,
        loadingSemanticLabel:
            'Loading thumb for tour with name ${tour.tourName}',
        errorSemanticLabel: 'Thumb of ${tour.tourName} tour',
      );
}
