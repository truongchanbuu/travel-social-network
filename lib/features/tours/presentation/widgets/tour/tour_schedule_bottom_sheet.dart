import 'package:flutter/material.dart';

import '../../../domain/entities/tour_schedule.dart';
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
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.5, color: Colors.grey),
              ),
            ),
            alignment: Alignment.center,
            child: const Text(
              'Tour Itinerary',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
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
      ),
    );
  }
}
