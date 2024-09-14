import 'package:flutter/material.dart';

import '../../../../../cores/constants/constants.dart';

class SearchTitle extends StatelessWidget {
  final String title;
  final Widget? suffix;
  const SearchTitle({
    super.key,
    required this.title,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 0.5, color: Colors.grey)),
      ),
      padding:
          const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            semanticsLabel: title,
            textDirection: defaultTextDirection,
            overflow: TextOverflow.ellipsis,
          ),
          if (suffix != null) suffix!,
        ],
      ),
    );
  }
}
