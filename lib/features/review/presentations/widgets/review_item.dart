import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/date_time_utils.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../../shared/presentations/widgets/confirm_deletion_dialog.dart';
import '../../../shared/presentations/widgets/limit_image_list.dart';
import '../../../tour/presentations/bloc/tour_bloc.dart';
import '../../domain/entities/review.dart';
import '../bloc/review_bloc.dart';
import '../pages/review_detail_page.dart';
import '../pages/save_review_page.dart';
import 'tour_rating_widget.dart';

class ReviewItem extends StatelessWidget {
  final ReviewEntity review;
  final bool isLimited;
  final int contentMaxLines;
  final double? imageSize;
  final bool clickable;

  const ReviewItem({
    super.key,
    required this.review,
    this.isLimited = true,
    this.contentMaxLines = 3,
    this.imageSize,
    this.clickable = true,
  });

  String _getFormattedDateTime(DateTime date) => DateTimeUtils.isToday(date)
      ? DateTimeUtils.getTimeAgo(date)
      : DateTimeUtils.formatDayAndMonth(date);

  @override
  Widget build(BuildContext context) {
    List<String> imageUrls =
        isLimited ? review.images.take(maxReviewItem).toList() : review.images;

    return GestureDetector(
      onTap: () => clickable ? _showReviewItemDetail(context) : null,
      child: Container(
        width: reviewBoxSize,
        padding: const EdgeInsets.all(defaultPadding),
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
                      GestureDetector(
                        onTap: _showProfile,
                        child: const CircleAvatar(radius: circleAvatarRadius),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: _showProfile,
                            child: const Text(
                              'Truong Chan Buu',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              textDirection: defaultTextDirection,
                              overflow: defaultTextOverflow,
                            ),
                          ),
                          TourRatingWidget(rating: review.rating),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    review.content,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    textDirection: defaultTextDirection,
                    overflow: defaultTextOverflow,
                    maxLines: contentMaxLines,
                  ),
                  const SizedBox(height: 10),
                  if (imageUrls.isNotEmpty) ...[
                    Expanded(
                      child: LimitImageList(
                        id: review.reviewId,
                        imageUrls: imageUrls,
                        imageSize: imageSize,
                      ),
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
                  '${S.current.reviewed} ${_getFormattedDateTime(review.updatedAt ?? review.createdAt)}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                if (currentUserId == review.userId)
                  _buildActionButtons(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
            onPressed: () => _editReview(context),
            icon: const Icon(Icons.edit_note)),
        IconButton(
          onPressed: () => _deleteReview(context),
          icon: const Icon(Icons.delete),
        ),
      ],
    );
  }

  void _showReviewItemDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) => getIt.get<ReviewBloc>(),
                child: ReviewDetailPage(reviewId: review.reviewId),
              )),
    );
  }

  // TODO: SHOW PROFILE
  void _showProfile() {}

  void _deleteReview(BuildContext context) async {
    final reviewBloc = context.read<ReviewBloc>();
    bool confirmed = await confirmDeletion(context);

    if (confirmed) {
      reviewBloc.add(DeleteReviewEvent(review.reviewId));
    }
  }

  void _editReview(BuildContext context) {
    Navigator.push(
        context,
        PageTransition(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt.get<ReviewBloc>()),
              BlocProvider(create: (context) => getIt.get<TourBloc>()),
            ],
            child: SaveReviewPage(
              postId: review.tourId,
              reviewId: review.reviewId,
            ),
          ),
          type: PageTransitionType.bottomToTop,
        ));
  }
}
