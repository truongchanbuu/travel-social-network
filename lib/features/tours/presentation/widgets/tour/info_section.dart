import 'package:flutter/material.dart';

import '../../../../../cores/constants/constants.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            spreadRadius: 5,
            color: Colors.grey.withOpacity(0.1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                'Underwater World Pattaya',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                semanticsLabel: 'Underwater World Pattaya',
                textDirection: defaultTextDirection,
                maxLines: 1,
              ),
            ),
          ),
          _buildReviewAndRating(),
          _buildBriefInfo(),
        ],
      ),
    );
  }

  Widget _buildReviewAndRating() {
    const double ratingBorderRadius = 20;
    const Color reviewNumberTextColor = Colors.grey;

    return GestureDetector(
      onTap: () => debugPrint('Reviews and Ratings'),
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
                color: Colors.indigo,
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

  Widget _buildBriefInfo() {
    const Icon trailing = Icon(
      Icons.chevron_right,
      color: primaryColor,
    );

    return Column(
      children: [
        ListTile(
          onTap: () {},
          leading: const Icon(
            Icons.access_time_outlined,
            color: primaryColor,
          ),
          contentPadding: EdgeInsets.zero,
          titleAlignment: ListTileTitleAlignment.center,
          title: RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Open',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: ' | '),
                TextSpan(text: 'Open at 8:00 - 22:00')
              ],
            ),
          ),
          subtitle: const Text(
            'Weekdays',
            semanticsLabel: 'Weekdays',
            overflow: TextOverflow.ellipsis,
            textDirection: defaultTextDirection,
          ),
          trailing: trailing,
        ),
        ListTile(
          onTap: () {},
          leading: const Icon(
            Icons.location_on,
            color: primaryColor,
          ),
          trailing: trailing,
          contentPadding: EdgeInsets.zero,
          titleAlignment: ListTileTitleAlignment.center,
          title: const Text(
            'Hoa Vang, Da Nang, Viet Nam',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
