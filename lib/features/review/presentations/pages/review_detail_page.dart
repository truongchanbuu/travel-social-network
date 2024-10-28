import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cores/constants/constants.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../shared/presentations/widgets/app_progressing_indicator.dart';
import '../../../shared/presentations/widgets/default_white_appbar.dart';
import '../../../user/presentations/bloc/user_cubit.dart';
import '../../../user/presentations/widgets/user_avatar.dart';
import '../../domain/entities/review.dart';
import '../bloc/review_bloc.dart';
import '../widgets/review_item.dart';

class ReviewDetailPage extends StatefulWidget {
  final String reviewId;
  final UserEntity reviewUser;

  const ReviewDetailPage({
    super.key,
    required this.reviewId,
    required this.reviewUser,
  });

  @override
  State<ReviewDetailPage> createState() => _ReviewDetailPageState();
}

class _ReviewDetailPageState extends State<ReviewDetailPage> {
  late ReviewEntity review;

  @override
  void initState() {
    super.initState();
    context.read<ReviewBloc>().add(GetReviewByIdEvent(widget.reviewId));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<ReviewBloc, ReviewState>(
        builder: (context, state) {
          if (state is ReviewActionLoading) {
            return const AppProgressingIndicator();
          } else if (state is ReviewLoaded) {
            review = state.review;
            return Scaffold(
              appBar: _buildAppBar(),
              body: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: SizedBox(
                  width: double.infinity,
                  height: reviewBoxHeight,
                  child: BlocProvider.value(
                    value: context.read<UserCubit>()..getUser(review.userId),
                    child: ReviewItem(
                      key: ValueKey(
                          'review_${review.userId}_${review.reviewId}'),
                      review: review,
                      isLimited: false,
                      imageSize: reviewItemDetailImageSize,
                      clickable: false,
                    ),
                  ),
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  AppBar _buildAppBar() => defaultWhiteAppBar(
        title: Row(
          children: [
            UserAvatar(user: widget.reviewUser),
            const SizedBox(width: 5),
            Text(
              widget.reviewUser.username ??
                  widget.reviewUser.email ??
                  'Unknown',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                overflow: defaultTextOverflow,
              ),
            ),
          ],
        ),
      );
}
