import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/presentations/widgets/app_cached_image.dart';
import '../../domain/entities/tour.dart';
import '../pages/tour_detail_page.dart';

class ToursGridView extends StatefulWidget {
  final List<TourEntity> tours;
  const ToursGridView({super.key, required this.tours});

  @override
  State<ToursGridView> createState() => _ToursGridViewState();
}

class _ToursGridViewState extends State<ToursGridView> {
  List<TourEntity> tours = [];

  @override
  void initState() {
    super.initState();
    tours = widget.tours;
  }

  static const double borderRadius = 10;
  static const double gridSpacing = 20;
  static const itemWidth = 200;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = min(screenWidth ~/ itemWidth, maxItemCount);

    return SliverMasonryGrid.count(
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: gridSpacing,
      crossAxisSpacing: gridSpacing,
      childCount: tours.length,
      itemBuilder: (context, index) => _buildTourItem(
        tour: tours[index],
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
        loadingSemanticLabel: S.current.loadingImageText(tours.indexOf(tour)),
        errorSemanticLabel: S.current.errorImage,
      );

  void _navigateToTourDetail(String tourId) => Navigator.push(context,
      MaterialPageRoute(builder: (context) => TourDetailPage(tourId: tourId)));
}
