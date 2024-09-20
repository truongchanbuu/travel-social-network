import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/constants/reviews.dart';
import '../../domain/entities/review.dart';
import 'review_item.dart';

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
                    fontSize: 16,
                  ),
                ),
                Text(
                  '2.1k Reviews',
                  style: TextStyle(
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
