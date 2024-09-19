import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../cores/shared/pages/full_screen_image_page.dart';
import '../../../../../cores/shared/widgets/app_progressing_indicator.dart';
import '../../../../../cores/shared/widgets/error_image.dart';

class TourReviewImageList extends StatelessWidget {
  final double imageSize;
  final String reviewId;
  final List<String> imageUrls;
  const TourReviewImageList({
    super.key,
    required this.reviewId,
    required this.imageUrls,
    this.imageSize = 50,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: imageSize,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FullScreenImagePage(imageUrls: imageUrls),
            ),
          ),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            width: imageSize,
            height: imageSize,
            child: CachedNetworkImage(
              imageUrl: imageUrls[index],
              cacheKey: '$reviewId-img-$index',
              errorWidget: (context, url, error) => const ErrorImage(size: 20),
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, progress) =>
                  const AppProgressingIndicator(),
            ),
          ),
        ),
        itemCount: imageUrls.length,
        separatorBuilder: (context, index) => const SizedBox(width: 1),
      ),
    );
  }
}
