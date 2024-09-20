import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../cores/shared/pages/full_screen_image_page.dart';
import '../../../../../cores/shared/widgets/app_progressing_indicator.dart';
import '../../../../../cores/shared/widgets/error_image.dart';

class TourReviewImageList extends StatelessWidget {
  final double? imageSize;
  final String reviewId;
  final List<String> imageUrls;
  const TourReviewImageList({
    super.key,
    required this.reviewId,
    required this.imageUrls,
    this.imageSize,
  });

  @override
  Widget build(BuildContext context) {
    double size = imageSize ?? 80;

    int itemQuantity =
        _determineQuantity(MediaQuery.of(context).size.width, size);

    return SizedBox(
      height: size,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  FullScreenImagePage(imageUrls: imageUrls, initialPage: index),
            ),
          ),
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                width: size,
                height: size,
                child: CachedNetworkImage(
                  imageUrl: imageUrls[index],
                  cacheKey: '$reviewId-img-$index',
                  errorWidget: (context, url, error) =>
                      const ErrorImage(size: 20),
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, progress) =>
                      const AppProgressingIndicator(),
                ),
              ),
              if (isOverflowed(index, itemQuantity))
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Center(
                      child: Text(
                        '+${imageUrls.length - itemQuantity}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        itemCount: min(itemQuantity, imageUrls.length),
        separatorBuilder: (context, index) => const SizedBox(width: 1),
      ),
    );
  }

  int _determineQuantity(double screenSize, double itemSize) {
    return screenSize ~/ itemSize;
  }

  bool isOverflowed(int index, int quantity) {
    return index == quantity - 1 && imageUrls.length - quantity > 0;
  }
}
