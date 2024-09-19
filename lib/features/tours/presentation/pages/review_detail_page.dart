import 'package:flutter/material.dart';
import 'package:travel_social_network/cores/constants/reviews.dart';

import '../../domain/entities/review.dart';

class ReviewDetailPage extends StatefulWidget {
  final String tourId;
  const ReviewDetailPage({
    super.key,
    required this.tourId,
  });

  @override
  State<ReviewDetailPage> createState() => _ReviewDetailPageState();
}

class _ReviewDetailPageState extends State<ReviewDetailPage> {
  List<ReviewEntity> reviews = List.empty(growable: true);

  @override
  void initState() {
    super.initState();

    reviews = sampleReviews
        .where((review) => review.tourId == widget.tourId)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
