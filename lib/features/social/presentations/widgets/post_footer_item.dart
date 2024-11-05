import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';

class PostFooterItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color? iconColor;

  const PostFooterItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20, color: iconColor),
              const SizedBox(width: 3),
              Text(
                title,
                style: const TextStyle(fontSize: 14),
                overflow: defaultTextOverflow,
                textDirection: defaultTextDirection,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
