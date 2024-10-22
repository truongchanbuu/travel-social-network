import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import 'icon_with_text.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconWithText(
              iconData: Icons.info_outline,
              text: S.current.aboutUs,
            ),
            IconWithText(
              iconData: Icons.star_border,
              text: S.current.rateForUs,
            ),
            IconWithText(
              iconData: Icons.book_outlined,
              text: S.current.termAndCondition,
            ),
          ],
        ),
      ),
    );
  }
}
