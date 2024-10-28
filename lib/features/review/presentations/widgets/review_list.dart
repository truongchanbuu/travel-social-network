import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_social_network/features/review/presentations/widgets/review_item.dart';

import '../../../../cores/constants/constants.dart';
import '../../../user/presentations/bloc/user_cubit.dart';
import '../../domain/entities/review.dart';

class ReviewList extends StatelessWidget {
  final List<ReviewEntity> reviews;
  const ReviewList({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => SizedBox(
        height: reviewItemDetailPageHeight,
        child: BlocProvider.value(
          value: context.read<UserCubit>()..getUser(reviews[index].userId),
          child: ReviewItem(
            key: ValueKey(
                'review_${reviews[index].userId}_${reviews[index].reviewId}'),
            review: reviews[index],
            isLimited: false,
            imageSize: reviewItemDetailImageSize,
          ),
        ),
      ),
      itemCount: reviews.length,
    );
  }
}
