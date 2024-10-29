import 'package:flutter/material.dart';

import '../../../../config/themes/app_theme.dart';
import '../../../../cores/constants/constants.dart';

class DetailHeadingText extends StatelessWidget {
  final String title;
  final IconData? leadingIcon;
  final Widget? trailing;
  final void Function()? onTap;

  const DetailHeadingText({
    super.key,
    required this.title,
    this.leadingIcon,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (leadingIcon != null)
              Icon(
                leadingIcon,
                color: AppTheme.primaryColor,
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  overflow: defaultTextOverflow,
                  textDirection: defaultTextDirection,
                ),
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
