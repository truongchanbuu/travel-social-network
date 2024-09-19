import 'package:flutter/material.dart';

import '../../../../../cores/constants/constants.dart';
import '../../../domain/entities/review.dart';
import 'tour_rating_widget.dart';

class ReviewDetailItem extends StatelessWidget {
  final ReviewEntity review;
  const ReviewDetailItem({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(radius: 20),
              const SizedBox(width: 5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Text(
                          'This is for name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          'Reviewed 4 hours ago',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        TourRatingWidget(rating: review.rating),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
