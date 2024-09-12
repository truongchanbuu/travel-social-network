import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:travel_social_network/cores/constants/tours.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/shared/widgets/app_progressing_indicator.dart';
import '../../data/models/tour.dart';

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
        int crossAxisCount = 2;
        if (constraints.crossAxisExtent <= 350) {
          crossAxisCount = 1;
        }

        return SliverMasonryGrid.count(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childCount: recommendedTours.length,
          itemBuilder: (context, index) {
            Tour tour = recommendedTours[index];

            double height = tourItemSizes[index % tourItemSizes.length];
            if (constraints.crossAxisExtent <= 350) {
              height = 300;
            }

            double size = height / 5;

            const double borderRadius = 10;

            return Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(borderRadius),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                height: height,
                child: GridTile(
                  footer: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(borderRadius),
                        bottomRight: Radius.circular(borderRadius),
                      ),
                    ),
                    child: Text(
                      tour.tourName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  child: CachedNetworkImage(
                    cacheKey: tour.tourId,
                    imageUrl: tour.imageUrls[Random().nextInt(3)],
                    fit: BoxFit.cover,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            AppProgressingIndicator(
                      size: size,
                      value: downloadProgress.progress,
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: Icon(
                        Icons.image,
                        size: size,
                        color: Colors.grey,
                        semanticLabel: 'Placeholder Image',
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
