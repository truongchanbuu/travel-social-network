import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:travel_social_network/cores/constants/tours.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/widgets/app_cached_image.dart';
import '../../domain/entities/tour.dart';
import '../pages/media_view_page.dart';

class TourDetailThumb extends StatefulWidget {
  final String tourId;
  const TourDetailThumb({super.key, required this.tourId});

  @override
  State<TourDetailThumb> createState() => _TourDetailThumbState();
}

class _TourDetailThumbState extends State<TourDetailThumb> {
  int _currentIndex = 0;
  late final TourEntity tour;

  late final CarouselSliderController _carouselSliderController;

  @override
  void initState() {
    super.initState();
    tour = generateSampleTours()
        .where((tour) => tour.tourId == widget.tourId)
        .first;
    _carouselSliderController = CarouselSliderController();
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.white;

    return GestureDetector(
      onTap: () => _showImages(context),
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CarouselSlider.builder(
            carouselController: _carouselSliderController,
            itemCount: min(tour.imageUrls.length, minimumImageShowed),
            itemBuilder: _buildImageItem,
            options: CarouselOptions(
              autoPlay: false,
              viewportFraction: 1,
              aspectRatio: 1,
              pageViewKey: PageStorageKey(tour.tourId),
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) =>
                  setState(() => _currentIndex = index),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 8, top: 5, bottom: 5),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: const BorderRadius.all(Radius.circular(999)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    S.current.allPhotos,
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: textColor,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: tour.imageUrls
                  .take(minimumImageShowed)
                  .toList()
                  .asMap()
                  .entries
                  .map(
                    (entry) => GestureDetector(
                      onTap: () =>
                          _carouselSliderController.animateToPage(entry.key),
                      child: Container(
                        width: 12,
                        height: 12,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              (Theme.of(context).brightness == Brightness.dark
                                      ? Colors.white
                                      : primaryColor)
                                  .withOpacity(
                                      _currentIndex == entry.key ? 1 : 0.4),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageItem(BuildContext context, int index, int pageViewIndex) =>
      AppCachedImage(
        imageUrl: tour.imageUrls[index],
        cacheKey: S.current.cacheKeyWithId(tour.tourId, index),
        errorSemanticLabel: S.current.imageCollectionText(tour.tourName),
        loadingSemanticLabel: S.current.loadingImageText(index),
      );

  void _showImages(BuildContext context) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MediaViewPage(
          prefixValueKey: tour.tourId,
          nameOfCollection: tour.tourName,
          imageUrls: tour.imageUrls,
        ),
      ));
}
