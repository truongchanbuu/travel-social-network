import 'package:flutter/material.dart';
import '../../../data/models/tour_schedule.dart';

class TourScheduleList extends StatefulWidget {
  final List<TourSchedule> tourSchedule;
  const TourScheduleList({super.key, required this.tourSchedule});

  @override
  State<TourScheduleList> createState() => _TourScheduleListState();
}

class _TourScheduleListState extends State<TourScheduleList> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
