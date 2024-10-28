import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:travel_social_network/features/user/presentations/widgets/user_avatar.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/date_time_utils.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../auth/presentations/bloc/auth_bloc.dart';
import '../../../shared/presentations/widgets/confirm_deletion_dialog.dart';
import '../../../shared/presentations/widgets/limit_image_list.dart';
import '../../../tour/presentations/bloc/tour_bloc.dart';
import '../../../user/presentations/bloc/user_cubit.dart';
import '../../domain/entities/review.dart';
import '../bloc/review_bloc.dart';
import '../pages/review_detail_page.dart';
import '../pages/save_review_page.dart';
import 'tour_rating_widget.dart';

class ReviewItem extends StatefulWidget {
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

  @override
  State<ReviewItem> createState() => _ReviewItemState();
}

class _ReviewItemState extends State<ReviewItem> {
  UserEntity? _cachedUser;

  String _getFormattedDateTime(DateTime date) => DateTimeUtils.isToday(date)
      ? DateTimeUtils.getTimeAgo(date)
      : DateTimeUtils.formatDayAndMonth(date);

  @override
  Widget build(BuildContext context) {
    final currentUser =
        context.select((AuthBloc authBloc) => authBloc.state.user);

    return BlocSelector<UserCubit, UserState, UserEntity>(
      selector: (state) {
        if (state.user.id == widget.review.userId) {
          _cachedUser = state.user;
          return state.user;
        }

        return _cachedUser ?? UserEntity.empty;
      },
      builder: (context, reviewUser) {
        final userToDisplay = _cachedUser ?? reviewUser;

        return GestureDetector(
          onTap: () => widget.clickable
              ? _showReviewItemDetail(context, userToDisplay)
              : null,
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
                            child: UserAvatar(user: userToDisplay),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: _showProfile,
                                child: Text(
                                  userToDisplay.username ??
                                      userToDisplay.email ??
                                      'Unknown',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textDirection: defaultTextDirection,
                                  overflow: defaultTextOverflow,
                                ),
                              ),
                              TourRatingWidget(rating: widget.review.rating),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.review.content,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        textDirection: defaultTextDirection,
                        overflow: defaultTextOverflow,
                        maxLines: widget.contentMaxLines,
                      ),
                      const SizedBox(height: 10),
                      if (_getImageUrls().isNotEmpty) ...[
                        Expanded(
                          child: LimitImageList(
                            id: widget.review.reviewId,
                            imageUrls: _getImageUrls(),
                            imageSize: widget.imageSize,
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
                      '${S.current.reviewed} ${_getFormattedDateTime(widget.review.updatedAt ?? widget.review.createdAt)}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    if (currentUser.id == widget.review.userId)
                      _buildActionButtons(context, currentUser.id),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButtons(BuildContext context, String userId) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
            onPressed: () => _editReview(context, userId),
            icon: const Icon(Icons.edit_note)),
        IconButton(
          onPressed: () => _deleteReview(context),
          icon: const Icon(Icons.delete),
        ),
      ],
    );
  }

  List<String> _getImageUrls() {
    return widget.isLimited
        ? widget.review.images.take(maxReviewItem).toList()
        : widget.review.images;
  }

  void _showReviewItemDetail(BuildContext context, UserEntity user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => getIt.get<ReviewBloc>(),
          child: ReviewDetailPage(
            reviewId: widget.review.reviewId,
            reviewUser: user,
          ),
        ),
      ),
    );
  }

  // TODO: SHOW PROFILE
  void _showProfile() {}

  void _deleteReview(BuildContext context) async {
    final reviewBloc = context.read<ReviewBloc>();
    bool confirmed = await confirmDeletion(context);

    if (confirmed) {
      reviewBloc.add(DeleteReviewEvent(widget.review.reviewId));
    }
  }

  void _editReview(BuildContext context, String userId) {
    Navigator.push(
      context,
      PageTransition(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt.get<ReviewBloc>()),
            BlocProvider(create: (context) => getIt.get<TourBloc>()),
          ],
          child: SaveReviewPage(
            postId: widget.review.tourId,
            reviewId: widget.review.reviewId,
            userId: userId,
          ),
        ),
        type: PageTransitionType.bottomToTop,
      ),
    );
  }
}
