import 'package:flutter/material.dart';

import 'tour_bottom_sheet_template.dart';
import 'tour_desc.dart';

class AdditionalTourInfoBottomSheet extends StatelessWidget {
  final String additionalInfo;
  const AdditionalTourInfoBottomSheet(
      {super.key, required this.additionalInfo});

  @override
  Widget build(BuildContext context) {
    return TourBottomSheetTemplate(
      title: 'Additional Information',
      children: [
        Expanded(
          child: TourDesc(
            content: additionalInfo,
            isScrollable: true,
          ),
        ),
      ],
    );
  }
}
