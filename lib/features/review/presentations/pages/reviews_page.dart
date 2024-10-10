import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/classification_utils.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/presentations/widgets/app_progressing_indicator.dart';
import '../../../shared/presentations/widgets/default_white_appbar.dart';
import '../../../tour/domain/entities/tour.dart';
import '../../domain/entities/review.dart';
import '../bloc/review_bloc.dart';
import '../widgets/review_item.dart';

class ReviewsPage extends StatefulWidget {
  final TourEntity tour;
  const ReviewsPage({super.key, required this.tour});

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  late final TourEntity tour;

  List<ReviewEntity> reviews = [];
  int totalReviews = 0;

  @override
  void initState() {
    super.initState();
    tour = widget.tour;
    context.read<ReviewBloc>().add(GetAllTourReviewsEvent(widget.tour.tourId));

    // totalReviews = reviews.length;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<ReviewBloc, ReviewState>(
        builder: (context, state) {
          if (state is ReviewActionLoading) {
            return const AppProgressingIndicator();
          } else if (state is ListOfReviewLoaded) {
            reviews = state.reviews;
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: _buildAppBar(),
              body: Column(
                children: [
                  _buildRating(),
                  const Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Expanded(child: _buildReviewList()),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
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
                text: '$totalReviews ${S.current.reviews(totalReviews)}',
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
