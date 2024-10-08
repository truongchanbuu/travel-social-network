import 'package:flutter/material.dart';
import 'package:travel_social_network/features/shared/presentations/widgets/default_white_appabar.dart';

import '../../../../generated/l10n.dart';
import '../../domain/entities/tour.dart';

class YourTourDetailPage extends StatefulWidget {
  final TourEntity tour;
  const YourTourDetailPage({super.key, required this.tour});

  @override
  State<YourTourDetailPage> createState() => _YourTourDetailPageState();
}

class _YourTourDetailPageState extends State<YourTourDetailPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: defaultWhiteAppBar(titleText: S.current.tourDetails),
        body: Column(),
      ),
    );
  }
}
