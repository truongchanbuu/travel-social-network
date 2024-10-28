import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:travel_social_network/features/auth/presentations/bloc/auth_bloc.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/classification_utils.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../../tour/presentations/bloc/tour_bloc.dart';
import '../../../user/presentations/bloc/user_cubit.dart';
import '../../domain/entities/review.dart';
import '../bloc/review_bloc.dart';
import '../pages/save_review_page.dart';
import 'no_reviews_widget.dart';
import 'review_item.dart';

class TourReviewsAndRating extends StatefulWidget {
  final String tourId;
  final double rating;
  final List<ReviewEntity> reviews;

  const TourReviewsAndRating({
    super.key,
    required this.tourId,
    required this.reviews,
    required this.rating,
  });

  @override
  State<TourReviewsAndRating> createState() => _TourReviewsAndRatingState();
}

class _TourReviewsAndRatingState extends State<TourReviewsAndRating> {
  List<ReviewEntity> reviews = [];

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthBloc authBloc) => authBloc.state.user);

    reviews = widget.reviews
      ..take(min(5, reviews.length)).toList()
      ..sort((prevReview, curReview) =>
          curReview.createdAt.compareTo(prevReview.createdAt));

    if (reviews.isEmpty) {
      return NoReviewsWidget(postId: widget.tourId);
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
                widget.rating.toStringAsFixed(fixStringFloatingPointNumber),
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
                  S.current.totalReviews(reviews.length,
                      NumberFormat.compact().format(reviews.length)),
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
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: user.isLoggedIn ? () => _createReview(user.id) : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            minimumSize: minBtnSize,
            shape: bottomSheetShape,
          ),
          child: Text(
            user.isLoggedIn ? S.current.reviews(1) : S.current.loginToReview,
            style: TextStyle(
              color: user.isLoggedIn ? Colors.white : primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReviews() {
    return SizedBox(
      height: reviewBoxHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => BlocProvider.value(
          value: context.read<UserCubit>()..getUser(reviews[index].userId),
          child: ReviewItem(
            key: ValueKey(
                'review_${reviews[index].userId}_${reviews[index].reviewId}'),
            review: reviews[index],
          ),
        ),
        itemCount: reviews.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
      ),
    );
  }

  void _createReview(String userId) {
    Navigator.push(
      context,
      PageTransition(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt.get<ReviewBloc>()),
            BlocProvider(create: (context) => getIt.get<TourBloc>()),
          ],
          child: SaveReviewPage(
            postId: widget.tourId,
            userId: userId,
          ),
        ),
        type: PageTransitionType.leftToRight,
      ),
    );
  }
}
