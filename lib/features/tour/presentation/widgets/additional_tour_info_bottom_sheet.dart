import 'package:flutter/material.dart';

import '../../../shared/widgets/quill_content.dart';
import 'tour_bottom_sheet_template.dart';

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
          child: QuillContent(content: additionalInfo, isScrollable: true),
        ),
      ],
    );
  }
}