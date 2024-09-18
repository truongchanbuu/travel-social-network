import 'package:flutter/material.dart';

import '../../../../../cores/constants/constants.dart';

class TourDetailHeadingText extends StatelessWidget {
  final String title;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  const TourDetailHeadingText({
    super.key,
    required this.title,
    this.leadingIcon,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      leading: leadingIcon != null
          ? Icon(
              leadingIcon,
              color: primaryColor,
            )
          : null,
      trailing: trailingIcon != null
          ? Icon(
              trailingIcon,
              color: primaryColor,
            )
          : null,
    );
  }
}
