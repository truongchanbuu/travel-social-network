import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';

class TourRatingWidget extends StatelessWidget {
  final double rating;
  const TourRatingWidget({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.2),
        borderRadius: const BorderRadius.all(Radius.circular(999)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: RichText(
        overflow: defaultTextOverflow,
        text: TextSpan(children: [
          TextSpan(
            text: rating.toStringAsFixed(fixStringFloatingPointNumber),
            style: const TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const TextSpan(
            text: ' / 5.0',
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ]),
      ),
    );
  }
}
