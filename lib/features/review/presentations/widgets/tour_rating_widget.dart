import 'package:flutter/material.dart';

import '../../../../config/themes/app_theme.dart';
import '../../../../cores/constants/constants.dart';

class TourRatingWidget extends StatelessWidget {
  final double rating;
  const TourRatingWidget({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = DefaultTextStyle.of(context).style;

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.2),
        borderRadius: const BorderRadius.all(Radius.circular(999)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: RichText(
        overflow: defaultTextOverflow,
        text: TextSpan(children: [
          TextSpan(
            text: rating.toStringAsFixed(fixStringFloatingPointNumber),
            style: const TextStyle(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          TextSpan(
            text: ' / 5.0',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: defaultTextStyle.color,
            ),
          ),
        ]),
      ),
    );
  }
}
