import 'package:flutter/material.dart';

import '../../../../config/themes/app_theme.dart';
import '../../../../cores/constants/constants.dart';

class TourScheduleIconText extends StatelessWidget {
  final String title;
  final double textFontSize;
  final double? iconSize;
  final IconData iconData;
  final Color iconColor;
  final Color textColor;
  const TourScheduleIconText({
    super.key,
    required this.title,
    this.textFontSize = 14,
    this.iconSize,
    required this.iconData,
    this.iconColor = AppTheme.primaryColor,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(child: Icon(iconData, color: iconColor)),
        const SizedBox(width: 5),
        Text(
          title,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: textFontSize,
          ),
          textDirection: defaultTextDirection,
          overflow: defaultTextOverflow,
        )
      ],
    );
  }
}
