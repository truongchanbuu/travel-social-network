import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/classification_utils.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/review.dart';
import 'no_reviews_widget.dart';
import 'review_item.dart';

class TourReviewsAndRating extends StatefulWidget {
  final double rating;
  final List<ReviewEntity> reviews;
  const TourReviewsAndRating({
    super.key,
    required this.reviews,
    required this.rating,
  });

  @override
  State<TourReviewsAndRating> createState() => _TourReviewsAndRatingState();
}

class _TourReviewsAndRatingState extends State<TourReviewsAndRating> {
  List<ReviewEntity> reviews = [];

  @override
  void initState() {
    super.initState();
    reviews = widget.reviews.take(min(5, reviews.length)).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) {
      return const NoReviewsWidget();
    }

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
              child: Text(
                widget.rating.toStringAsFixed(1),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ClassificationUtils.classificationRating(widget.rating),
                  style: const TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  S.current.totalReviews(reviews.length),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        _buildReviews(),
      ],
    );
  }

  Widget _buildReviews() {
    return SizedBox(
      height: reviewBoxHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => ReviewItem(review: reviews[index]),
        itemCount: reviews.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
      ),
    );
  }
}
