import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../config/themes/app_theme.dart';
import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/classification_utils.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../../auth/presentations/bloc/auth_bloc.dart';
import '../../../shared/presentations/widgets/app_progressing_indicator.dart';
import '../../../shared/presentations/widgets/default_white_appbar.dart';
import '../../../tour/domain/entities/tour.dart';
import '../../../tour/presentations/bloc/tour_bloc.dart';
import '../../domain/entities/review.dart';
import '../bloc/review_bloc.dart';
import '../widgets/review_list.dart';
import 'save_review_page.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthBloc authBloc) => authBloc.state.user);
    return SafeArea(
      child: BlocBuilder<ReviewBloc, ReviewState>(
        builder: (context, state) {
          if (state is ReviewActionLoading) {
            return const AppProgressingIndicator();
          } else if (state is ListOfReviewsLoaded) {
            reviews = state.reviews
              ..sort((prevReview, curReview) =>
                  curReview.createdAt.compareTo(prevReview.createdAt));
            totalReviews = reviews.length;

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
                  Expanded(child: ReviewList(reviews: reviews)),
                ],
              ),
              floatingActionButton: _reviewFAB(user.id),
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
          color: AppTheme.primaryColor.withOpacity(0.1),
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
                  color: AppTheme.primaryColor,
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

  AppBar _buildAppBar() => defaultWhiteAppBar(
        context: context,
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

  FloatingActionButton _reviewFAB(String userId) {
    return FloatingActionButton(
      onPressed: () => _reviewTour(userId),
      backgroundColor: AppTheme.primaryColor,
      shape: const CircleBorder(),
      child: const Icon(Icons.rate_review_sharp, color: Colors.white),
    );
  }

  void _reviewTour(String userId) {
    Navigator.push(
      context,
      PageTransition(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt.get<ReviewBloc>()),
            BlocProvider(create: (context) => getIt.get<TourBloc>()),
          ],
          child: SaveReviewPage(
            postId: tour.tourId,
            userId: userId,
          ),
        ),
        type: PageTransitionType.leftToRight,
      ),
    );
  }
}
