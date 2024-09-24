import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../domain/entities/tour_schedule.dart';
import 'tour_bottom_sheet_template.dart';
import 'tour_schedule_list.dart';

class TourScheduleBottomSheet extends StatefulWidget {
  final List<TourScheduleEntity> schedules;
  const TourScheduleBottomSheet({super.key, required this.schedules});

  @override
  State<TourScheduleBottomSheet> createState() =>
      _TourScheduleBottomSheetState();
}

class _TourScheduleBottomSheetState extends State<TourScheduleBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return TourBottomSheetTemplate(
      title: S.current.tourItinerary,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TourScheduleList(
              tourSchedule: widget.schedules,
              isScrollable: true,
            ),
          ),
        ),
      ],
    );
  }
}
