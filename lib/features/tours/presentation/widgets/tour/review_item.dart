import 'package:flutter/material.dart';

import '../../../../../cores/constants/constants.dart';
import '../../../../../cores/utils/date_time_utils.dart';
import '../../../domain/entities/review.dart';
import 'tour_rating_widget.dart';
import 'tour_review_image_list.dart';

class ReviewItem extends StatelessWidget {
  final ReviewEntity review;
  final bool isLimited;
  final int contentMaxLines;
  const ReviewItem({
    super.key,
    required this.review,
    this.isLimited = true,
    this.contentMaxLines = 3,
  });

  String _getFormattedDateTime(DateTime date) => DateTimeUtils.isToday(date)
      ? DateTimeUtils.getTimeAgo(date)
      : DateTimeUtils.formatDate(date);

  @override
  Widget build(BuildContext context) {
    List<String> imageUrls =
        isLimited ? review.images.take(maxReviewItem).toList() : review.images;

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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          overflow: TextOverflow.ellipsis,
                        ),
                        TourRatingWidget(rating: review.rating),
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
                  maxLines: contentMaxLines,
                ),
                const SizedBox(height: 8),
                if (imageUrls.isNotEmpty) ...[
                  TourReviewImageList(
                    reviewId: review.reviewId,
                    imageUrls: imageUrls,
                  ),
                  const SizedBox(height: 10)
                ],
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Reviewed ${_getFormattedDateTime(review.updatedAt ?? review.createdAt)}',
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
}
