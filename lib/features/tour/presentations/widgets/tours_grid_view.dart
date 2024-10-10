import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../../review/presentations/bloc/review_bloc.dart';
import '../../../shared/presentations/widgets/app_cached_image.dart';
import '../../../ticket/presentations/bloc/ticket_bloc.dart';
import '../../domain/entities/tour.dart';
import '../bloc/tour_bloc.dart';
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
    int crossAxisCount =
        tours.length == 1 ? 1 : min(screenWidth ~/ itemWidth, maxItemCount);

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

  void _navigateToTourDetail(String tourId) => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MultiBlocProvider(providers: [
                BlocProvider(create: (context) => getIt.get<TourBloc>()),
                BlocProvider(create: (context) => getIt.get<TicketBloc>()),
                BlocProvider(create: (context) => getIt.get<ReviewBloc>()),
              ], child: TourDetailPage(tourId: tourId))));
}
