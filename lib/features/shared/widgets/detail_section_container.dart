import 'package:flutter/material.dart';

import '../../../cores/constants/constants.dart';

class DetailSectionContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final bool isPadding;
  const DetailSectionContainer({
    super.key,
    required this.child,
    this.height,
    this.isPadding = true,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: height,
        padding: isPadding
            ? const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: 5)
            : null,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [detailSectionBoxShadow],
        ),
        child: child,
      ),
    );
  }
}
