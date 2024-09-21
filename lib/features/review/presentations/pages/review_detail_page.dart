import 'package:flutter/material.dart';
import 'package:travel_social_network/cores/constants/reviews.dart';

import '../../../../cores/constants/constants.dart';
import '../../domain/entities/review.dart';
import '../widgets/review_item.dart';

class ReviewDetailPage extends StatefulWidget {
  final String tourId;
  final String? reviewId;
  const ReviewDetailPage({super.key, required this.tourId, this.reviewId});

  @override
  State<ReviewDetailPage> createState() => _ReviewDetailPageState();
}

class _ReviewDetailPageState extends State<ReviewDetailPage> {
  List<ReviewEntity> reviews = List.empty(growable: true);
  int totalReviews = 0;

  double tourRating = 0;
  String tourName = 'Tour Da Lat';

  @override
  void initState() {
    super.initState();

    reviews = sampleReviews
        .where((review) => review.tourId == widget.tourId)
        .toList();

    if (widget.reviewId != null) {
      reviews = reviews
          .where((review) => review.reviewId == widget.reviewId)
          .toList();
    }

    // Get tour info later
    tourRating = 4.3;
    tourName = 'Dalat';

    totalReviews = reviews.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          if (widget.reviewId == null) ...[
            _buildRating(),
          ],
          const Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          Expanded(child: _buildReviewList()),
        ],
      ),
    );
  }

  Widget _buildRating() => Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.1),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: 10,
        ),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '$tourRating ${classification(tourRating)}',
                style: const TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const WidgetSpan(child: SizedBox(width: 5)),
              TextSpan(
                text:
                    '($totalReviews ${totalReviews > 1 ? 'reviews' : 'review'})',
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildReviewList() => ListView.builder(
        itemBuilder: (context, index) => SizedBox(
          height: reviewItemDetailPageHeight,
          child: ReviewItem(
            review: reviews[index],
            isLimited: false,
            imageSize: reviewItemDetailImageSize,
            clickable: widget.reviewId == null,
          ),
        ),
        itemCount: reviews.length,
      );

  AppBar _buildAppBar() => AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tourName,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              overflow: defaultTextOverflow,
              textDirection: defaultTextDirection,
            ),
            const Text(
              'Reviews & Rating',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              overflow: defaultTextOverflow,
              textDirection: defaultTextDirection,
            ),
          ],
        ),
      );

  String classification(double rating) => switch (rating) {
        >= 4.9 => 'Outstanding',
        >= 4.5 && < 4.9 => 'Wonderful',
        >= 4.0 && < 4.5 => 'Good',
        >= 3.0 && < 4.0 => 'Pleasant',
        >= 2.0 && < 3.0 => 'No Very Good',
        >= 1.0 && < 2.0 => 'Disappointing',
        < 1.0 => 'Terrible',
        _ => throw Exception('Not available rating'),
      };
}