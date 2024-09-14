import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import 'icon_with_text.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconWithText(iconData: Icons.info_outline, text: 'About $appName'),
            IconWithText(
                iconData: Icons.star_border, text: 'Rate for $appName'),
            IconWithText(
                iconData: Icons.book_outlined, text: 'Terms & Conditions'),
          ],
        ),
      ),
    );
  }
}
