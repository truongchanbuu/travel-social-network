import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:travel_social_network/cores/constants/tours.dart';

import '../../../../../cores/constants/constants.dart';
import '../../../../../cores/shared/widgets/app_progressing_indicator.dart';
import '../../../data/models/tour.dart';

class ToursGridView extends StatefulWidget {
  const ToursGridView({super.key});

  @override
  State<ToursGridView> createState() => _ToursGridViewState();
}

class _ToursGridViewState extends State<ToursGridView> {
  late final List<Tour> recommendedTours;

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

  Widget _buildTourItem(
      {required Tour tour, required double height, required bool isNarrow}) {
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
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildImage(Tour tour, double height) {
    final size = height / 5;

    return CachedNetworkImage(
      cacheKey: tour.tourId,
      imageUrl: tour.imageUrls[Random().nextInt(tour.imageUrls.length)],
      fit: BoxFit.cover,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          AppProgressingIndicator(
        size: size,
        value: downloadProgress.progress,
      ),
      errorWidget: (context, url, error) => Container(
        color: Colors.black.withOpacity(0.2),
        child: Center(
          child: Icon(
            Icons.image,
            size: size,
            color: Colors.grey,
            semanticLabel: 'Placeholder Image',
          ),
        ),
      ),
    );
  }
}
