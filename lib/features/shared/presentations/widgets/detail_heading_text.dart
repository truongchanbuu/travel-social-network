import 'package:flutter/material.dart';

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
                color: primaryColor,
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  overflow: defaultTextOverflow,
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
