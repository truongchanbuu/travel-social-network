import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../cores/constants/constants.dart';
import '../../../../../cores/shared/pages/full_screen_image_page.dart';
import '../../../../../cores/shared/widgets/app_progressing_indicator.dart';
import '../../../../../cores/shared/widgets/error_image.dart';
import '../../../../../cores/utils/date_time_utils.dart';
import '../../../domain/entities/review.dart';
import '../../../../../cores/constants/reviews.dart';

class TourReviewsAndRating extends StatefulWidget {
  final List<ReviewEntity> reviews;
  const TourReviewsAndRating({super.key, required this.reviews});

  @override
  State<TourReviewsAndRating> createState() => _TourReviewsAndRatingState();
}

class _TourReviewsAndRatingState extends State<TourReviewsAndRating> {
  List<ReviewEntity> reviews = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    reviews = sampleReviews.take(5).toList();
  }

  String _getFormattedDate(DateTime date) {
    return DateTimeUtils.formatDateTime(date);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: primaryColor,
              ),
              padding: const EdgeInsets.all(8),
              child: const Text(
                '4.9',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Excellent',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '2.1k Reviews',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
        _buildReviews(),
      ],
    );
  }

  Widget _buildReviews() {
    return Container(
      height: reviewBoxHeight,
      padding: const EdgeInsets.all(10),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => _buildReviewItem(reviews[index]),
        itemCount: reviews.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
      ),
    );
  }

  Widget _buildReviewItem(ReviewEntity review) {
    List<String> imageUrls = review.images.take(5).toList();

    return Container(
      width: reviewBoxSize,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(width: 0.5, color: Colors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 3,
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(radius: 25),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Truong Chan Buu',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: review.rating.toString(),
                                style: const TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const TextSpan(
                                text: ' / 5.0',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  review.content,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  textDirection: defaultTextDirection,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                const SizedBox(height: 8),
                if (imageUrls.isNotEmpty) ...[
                  _buildImageList(review.reviewId, imageUrls),
                  const SizedBox(height: 10)
                ],
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Review at ${_getFormattedDate(review.updatedAt ?? review.createdAt)}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageList(String reviewId, List<String> imageUrls) {
    const double imageSize = 50;

    return SizedBox(
      height: imageSize,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => _showFullScreenImage(imageUrls),
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

  void _showFullScreenImage(List<String> imageUrls) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImagePage(imageUrls: imageUrls),
      ),
    );
  }
}
