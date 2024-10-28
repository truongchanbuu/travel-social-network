import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';

class IconWithText extends StatelessWidget {
  final IconData iconData;
  final String text;
  final VoidCallback? onTap;

  const IconWithText({
    super.key,
    required this.iconData,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(iconData),
                const SizedBox(height: 8),
                Text(
                  text,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  textDirection: defaultTextDirection,
                  overflow: defaultTextOverflow,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
