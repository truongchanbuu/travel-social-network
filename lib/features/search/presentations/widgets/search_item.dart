import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';

class SearchItem extends StatelessWidget {
  final String title;
  const SearchItem({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    const BorderRadius borderRadius = BorderRadius.all(Radius.circular(10));

    return InkWell(
      onTap: () {},
      borderRadius: borderRadius,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: Border.all(color: primaryColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
