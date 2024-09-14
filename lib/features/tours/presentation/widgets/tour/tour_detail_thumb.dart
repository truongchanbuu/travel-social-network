import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../../cores/constants/constants.dart';
import '../../../../../cores/shared/widgets/app_progressing_indicator.dart';
import '../../../data/models/tour.dart';

class TourDetailThumb extends StatefulWidget {
  final Tour tour;
  const TourDetailThumb({super.key, required this.tour});

  @override
  State<TourDetailThumb> createState() => _TourDetailThumbState();
}

class _TourDetailThumbState extends State<TourDetailThumb> {
  int _currentIndex = 0;
  late final Tour tour;

  late final CarouselSliderController _carouselSliderController;

  @override
  void initState() {
    super.initState();
    tour = widget.tour;
    _carouselSliderController = CarouselSliderController();
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.white;

    return GestureDetector(
      onTap: () => debugPrint('All Photos'),
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CarouselSlider.builder(
            carouselController: _carouselSliderController,
            itemCount: widget.tour.imageUrls.length,
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
              padding: const EdgeInsets.only(left: 9, top: 5, bottom: 5),
              margin: const EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: const BorderRadius.all(Radius.circular(999)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'All Photos',
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
                  .asMap()
                  .entries
                  .map(
                    (url) => GestureDetector(
                      onTap: () =>
                          _carouselSliderController.animateToPage(url.key),
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
                                      _currentIndex == url.key ? 0.9 : 0.4),
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

  Widget _buildImageItem(BuildContext context, int index, int pageViewIndex) {
    return CachedNetworkImage(
      imageUrl: tour.imageUrls[index],
      fit: BoxFit.cover,
      alignment: Alignment.center,
      cacheKey: tour.tourId,
      errorWidget: (context, error, stackTrace) => Container(
        color: Colors.black.withOpacity(0.2),
        child: Center(
          child: Icon(
            Icons.image,
            size: 50,
            color: Colors.grey,
            semanticLabel: 'Image of ${tour.tourName}',
          ),
        ),
      ),
      progressIndicatorBuilder: (context, child, loadingProgress) =>
          AppProgressingIndicator(
        size: 50,
        semanticLabel: 'Loading ${tour.tourName}',
        value: loadingProgress.progress,
      ),
    );
  }
}
