import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../review/presentations/pages/reviews_page.dart';
import '../../domain/entities/tour.dart';
import 'tour_detail_location.dart';

class InfoSection extends StatelessWidget {
  final TourEntity tour;
  const InfoSection({super.key, required this.tour});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
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
                tour.tourName,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                overflow: defaultTextOverflow,
                semanticsLabel: tour.tourName,
                textDirection: defaultTextDirection,
                maxLines: 1,
              ),
            ),
          ),
          _buildReviewAndRating(context),
          _buildBriefInfo(context),
        ],
      ),
    );
  }

  static const double ratingBorderRadius = 20;
  static const Color reviewNumberTextColor = Colors.grey;

  Widget _buildReviewAndRating(context) {
    return GestureDetector(
      onTap: () => _showReviewDetailPage(context),
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
                color: primaryColor,
              ),
              padding: const EdgeInsetsDirectional.all(6),
              child: Text(
                '${tour.rating.toStringAsFixed(1)} / $maxRatingPoint',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              // TODO: Change the total review later
              '${S.current.totalReviews(21243)} ${S.current.reviews(20000)}',
              style: const TextStyle(
                color: reviewNumberTextColor,
                fontSize: 12,
              ),
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
    color: primaryColor,
  );

  Widget _buildBriefInfo(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(
            Icons.access_time_outlined,
            color: primaryColor,
          ),
          contentPadding: EdgeInsets.zero,
          titleAlignment: ListTileTitleAlignment.center,
          title: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: S.current.duration,
                  style: const TextStyle(
                    color: primaryColor,
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
          onTap: () => _showTourDetailLocation(context),
          leading: const Icon(
            Icons.location_on,
            color: primaryColor,
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

  void _showReviewDetailPage(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ReviewsPage(tour: tour)));
  }

  void _showTourDetailLocation(BuildContext context) => showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        shape: bottomSheetShape,
        builder: (context) => Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: TourDetailLocation(location: tour.destination),
        ),
      );
}
