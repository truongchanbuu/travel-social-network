import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:travel_social_network/cores/constants/tours.dart';

import '../../../../cores/constants/constants.dart';
import '../../../tour/domain/entities/tour.dart';
import '../../../tour/presentations/pages/tour_detail_page.dart';
import '../app_cached_image.dart';

class ToursGridView extends StatefulWidget {
  const ToursGridView({super.key});

  @override
  State<ToursGridView> createState() => _ToursGridViewState();
}

class _ToursGridViewState extends State<ToursGridView> {
  List<TourEntity> recommendedTours = [];

  @override
  void initState() {
    super.initState();
    recommendedTours = generateSampleTours();
  }

  static const double borderRadius = 10;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = min(screenWidth ~/ 200, maxItemCount);

    return SliverMasonryGrid.count(
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      childCount: recommendedTours.length,
      itemBuilder: (context, index) => _buildTourItem(
        tour: recommendedTours[index],
        height: crossAxisCount == 1
            ? recommendedTourItemSize
            : tourItemSizes[index % tourItemSizes.length],
      ),
    );
  }

  Widget _buildTourItem({required TourEntity tour, required double height}) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(borderRadius),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: GestureDetector(
        onTap: () => _navigateToTourDetail(tour.tourId),
        child: Container(
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: GridTile(
            footer: _buildFooter(tour.tourName),
            child: _buildImage(tour),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(String tourName) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: const BorderRadius.only(
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

  Widget _buildImage(TourEntity tour) => AppCachedImage(
        imageUrl: tour.imageUrls[Random().nextInt(tour.imageUrls.length)],
        cacheKey: tour.tourId,
        loadingSemanticLabel:
            'Loading thumb for tour with name ${tour.tourName}',
        errorSemanticLabel: 'Thumb of ${tour.tourName} tour',
      );

  void _navigateToTourDetail(String tourId) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TourDetailPage(tourId: tourId),
        ),
      );
}
