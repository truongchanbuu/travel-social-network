import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../../domain/entities/tour.dart';
import '../../../review/presentations/pages/review_detail_page.dart';
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
                  fontSize: 17,
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

  Widget _buildReviewAndRating(context) {
    const double ratingBorderRadius = 20;
    const Color reviewNumberTextColor = Colors.grey;

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
              padding: const EdgeInsetsDirectional.all(5),
              child: const Text(
                '4.9/5.0',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              '2.1k reviews',
              style: TextStyle(
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

  Widget _buildBriefInfo(BuildContext context) {
    const Icon trailing = Icon(
      Icons.chevron_right,
      color: primaryColor,
    );

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
                const TextSpan(
                  text: 'Duration',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(text: ' | '),
                TextSpan(text: '${tour.duration} day(s)')
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
          title: Text(tour.destination, style: const TextStyle(fontSize: 14)),
        ),
      ],
    );
  }

  void _showReviewDetailPage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReviewDetailPage(tourId: tour.tourId),
        ));
  }

  void _showTourDetailLocation(BuildContext context) => showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (context) => Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: TourDetailLocation(location: tour.destination),
        ),
      );
}
