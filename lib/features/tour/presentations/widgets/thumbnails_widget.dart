import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../config/themes/app_theme.dart';
import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/extensions/context_extension.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/presentations/pages/media_view_page.dart';
import '../../../shared/presentations/widgets/app_cached_image.dart';

class ThumbnailsWidget extends StatefulWidget {
  final List<String> imageUrls;
  final String collectionId;
  final void Function()? onImage;
  final int minShowedImages;

  const ThumbnailsWidget({
    super.key,
    required this.imageUrls,
    this.minShowedImages = minImageShowed,
    this.collectionId = '',
    this.onImage,
  });

  @override
  State<ThumbnailsWidget> createState() => _ThumbnailsWidgetState();
}

class _ThumbnailsWidgetState extends State<ThumbnailsWidget> {
  int _currentIndex = 0;
  List<String> imageUrls = [];

  late final CarouselSliderController _carouselSliderController;

  @override
  void initState() {
    super.initState();
    imageUrls = widget.imageUrls;
    _carouselSliderController = CarouselSliderController();
  }

  static Color textColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onImage ?? _showImage,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CarouselSlider.builder(
            carouselController: _carouselSliderController,
            itemCount: min(imageUrls.length, minImageShowed),
            itemBuilder: _buildImageItem,
            options: CarouselOptions(
              autoPlay: false,
              viewportFraction: 1,
              aspectRatio: 1,
              pageViewKey: widget.collectionId.isNotEmpty
                  ? PageStorageKey(widget.collectionId)
                  : null,
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
              children: imageUrls
                  .take(widget.minShowedImages)
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
                          color: (context.isDarkMode
                                  ? Colors.white
                                  : AppTheme.primaryColor)
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
        imageUrl: imageUrls[index],
        cacheKey: S.current.cacheKeyWithId(widget.collectionId, index),
        errorSemanticLabel: S.current.errorImage,
        loadingSemanticLabel: S.current.loadingImageText(index),
      );

  void _showImage() => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MediaViewPage(
          prefixValueKey: widget.collectionId,
          imageUrls: imageUrls,
        ),
      ));
}
