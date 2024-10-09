import 'package:flutter/material.dart';
import 'package:travel_social_network/cores/constants/reviews.dart';
import 'package:travel_social_network/cores/constants/tours.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/classification_utils.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/presentations/widgets/default_white_appbar.dart';
import '../../../tour/domain/entities/tour.dart';
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
  late final TourEntity tour;

  List<ReviewEntity> reviews = [];
  int totalReviews = 0;

  @override
  void initState() {
    super.initState();

    tour = generateSampleTours().where((t) => t.tourId == widget.tourId).first;
    reviews = sampleReviews
        .where((review) => review.tourId == widget.tourId)
        .toList();
    if (widget.reviewId != null) {
      reviews = reviews
          .where((review) => review.reviewId == widget.reviewId)
          .toList();
    }

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
                text:
                    '${tour.rating} ${ClassificationUtils.classificationRating(tour.rating)}',
                style: const TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const WidgetSpan(child: SizedBox(width: 5)),
              TextSpan(
                text: '$totalReviews ${S.current.reviews}',
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

  AppBar _buildAppBar() => defaultWhiteAppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tour.tourName,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              overflow: defaultTextOverflow,
              textDirection: defaultTextDirection,
            ),
            Text(
              S.current.reviews(totalReviews),
              style: const TextStyle(
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
}
