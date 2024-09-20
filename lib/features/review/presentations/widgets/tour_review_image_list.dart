import 'dart:math';

import 'package:flutter/material.dart';

import '../../../shared/pages/full_screen_image_page.dart';
import '../../../shared/widgets/app_cached_image.dart';

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
                child: AppCachedImage(
                  imageUrl: imageUrls[index],
                  cacheKey: '$reviewId-img-$index',
                  errorImageSize: 20,
                  errorSemanticLabel: 'Image at index $index',
                  loadingSemanticLabel: 'Loading image at index $index',
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
