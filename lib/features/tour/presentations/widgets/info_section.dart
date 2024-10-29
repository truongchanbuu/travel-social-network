import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../config/themes/app_theme.dart';
import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../review/presentations/bloc/review_bloc.dart';
import '../../../review/presentations/pages/reviews_page.dart';
import '../../../shared/presentations/widgets/app_progressing_indicator.dart';
import '../../domain/entities/tour.dart';
import '../bloc/tour_bloc.dart';
import 'tour_detail_location.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TourBloc, TourState>(
      builder: (context, state) {
        if (state is! TourLoaded) {
          return const AppProgressingIndicator();
        }

        return Container(
          padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding, vertical: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : AppTheme.secondaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [detailSectionBoxShadow],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    state.tour.tourName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: defaultTextOverflow,
                    semanticsLabel: state.tour.tourName,
                    textDirection: defaultTextDirection,
                    maxLines: 1,
                  ),
                ),
              ),
              _buildReviewAndRating(context, state.tour),
              _buildBriefInfo(context, state.tour),
            ],
          ),
        );
      },
    );
  }

  static const double ratingBorderRadius = 20;
  static const Color reviewNumberTextColor = Colors.grey;

  Widget _buildReviewAndRating(context, TourEntity tour) {
    return GestureDetector(
      onTap: () => _showReviewDetailPage(context, tour),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.5, color: Colors.grey),
          ),
        ),
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(ratingBorderRadius),
                  bottomLeft: Radius.circular(ratingBorderRadius),
                  bottomRight: Radius.circular(ratingBorderRadius),
                ),
                color: AppTheme.primaryColor,
              ),
              padding: const EdgeInsetsDirectional.all(6),
              child: Text(
                '${tour.rating.toStringAsFixed(2)} / $maxRatingPoint',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(width: 10),
            BlocBuilder<ReviewBloc, ReviewState>(
              builder: (context, reviewState) {
                int numOfReviews = reviewState is ListOfReviewsLoaded
                    ? reviewState.reviews.length
                    : 0;

                return Text(
                  S.current.totalReviews(
                    numOfReviews,
                    NumberFormat.compact().format(numOfReviews),
                  ),
                  style: const TextStyle(
                    color: reviewNumberTextColor,
                    fontSize: 12,
                  ),
                );
              },
            ),
            const Icon(
              Icons.arrow_right,
              color: reviewNumberTextColor,
            ),
          ],
        ),
      ),
    );
  }

  static const Icon trailing = Icon(
    Icons.chevron_right,
    color: AppTheme.primaryColor,
  );

  Widget _buildBriefInfo(BuildContext context, TourEntity tour) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(
            Icons.access_time_outlined,
            color: AppTheme.primaryColor,
          ),
          contentPadding: EdgeInsets.zero,
          titleAlignment: ListTileTitleAlignment.center,
          title: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: S.current.duration,
                  style: const TextStyle(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(text: ' | '),
                TextSpan(text: tour.duration)
              ],
            ),
          ),
        ),
        ListTile(
          onTap: () => _showTourDetailLocation(context, tour.destination),
          leading: const Icon(
            Icons.location_on,
            color: AppTheme.primaryColor,
          ),
          trailing: trailing,
          contentPadding: EdgeInsets.zero,
          titleAlignment: ListTileTitleAlignment.center,
          title: Text('${tour.departure} - ${tour.destination}',
              style: const TextStyle(fontSize: 14)),
        ),
      ],
    );
  }

  void _showReviewDetailPage(BuildContext context, TourEntity tour) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ReviewsPage(tour: tour)));
  }

  void _showTourDetailLocation(BuildContext context, String destination) =>
      showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        shape: bottomSheetShape,
        builder: (context) => Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: TourDetailLocation(location: destination),
        ),
      );
}
