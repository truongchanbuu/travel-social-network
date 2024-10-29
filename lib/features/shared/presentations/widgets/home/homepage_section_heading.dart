import 'package:flutter/material.dart';

import '../../../../../config/themes/app_theme.dart';
import '../../../../../cores/constants/constants.dart';

class HomepageSectionHeading extends StatelessWidget {
  final String title;
  final double padding;

  const HomepageSectionHeading({
    super.key,
    required this.title,
    required this.padding,
  });

  static const double underlineOffset = 2;
  static const double underlineThickness = 5;
  static const double borderRadius = 10;
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: underlineOffset + underlineThickness,
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
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
                        color: AppTheme.primaryColor,
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
