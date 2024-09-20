import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';

class HomepageSectionHeading extends StatelessWidget {
  final String title;
  final double padding;

  const HomepageSectionHeading({
    super.key,
    required this.title,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    const double underlineOffset = 2;
    const double underlineThickness = 5;
    const double borderRadius = 10;

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(
                  bottom: underlineOffset + underlineThickness),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: -underlineOffset,
                    child: Container(
                      height: underlineThickness,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
