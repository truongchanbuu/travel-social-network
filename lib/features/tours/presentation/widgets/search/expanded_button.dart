import 'package:flutter/material.dart';

import '../../../../../cores/constants/constants.dart';

class ExpandedButton extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onPressed;
  const ExpandedButton({
    super.key,
    required this.isExpanded,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    const Color iconColor = Colors.white;

    return IconButton(
      onPressed: onPressed,
      tooltip: isExpanded ? 'Show less' : 'Show more',
      style: const ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(primaryColor),
      ),
      icon: isExpanded
          ? const Icon(
              Icons.arrow_upward,
              color: iconColor,
            )
          : const Icon(
              Icons.arrow_downward,
              color: iconColor,
            ),
    );
  }
}