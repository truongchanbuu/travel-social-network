import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/tour_schedule.dart';
import '../pages/tour_schedule_detail_page.dart';
import 'tour_schedule_icon_text.dart';

class TourScheduleList extends StatefulWidget {
  final List<TourScheduleEntity> tourSchedule;
  final bool isScrollable;
  const TourScheduleList({
    super.key,
    required this.tourSchedule,
    this.isScrollable = false,
  });

  @override
  State<TourScheduleList> createState() => _TourScheduleListState();
}

class _TourScheduleListState extends State<TourScheduleList> {
  List<TourScheduleEntity> schedules = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics:
          widget.isScrollable ? null : const NeverScrollableScrollPhysics(),
      itemBuilder: _buildScheduleItem,
      itemCount: schedules.length,
      separatorBuilder: (context, index) => const SizedBox(height: 20),
    );
  }

  Widget _buildScheduleItem(BuildContext context, int index) {
    TourScheduleEntity schedule = schedules[index];

    return InkWell(
      onTap: widget.isScrollable
          ? () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      TourScheduleDetailPage(tourSchedule: schedule),
                ),
              )
          : null,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TourScheduleIconText(
              title: S.current.scheduleDay(schedule.day),
              iconData: Icons.calendar_month,
              iconColor: Colors.black,
            ),
            const SizedBox(height: 5),
            TourScheduleIconText(
              title: schedule.activities.first.time,
              iconData: Icons.location_on,
              textColor: primaryColor,
            ),
            const SizedBox(height: 5),
            Text(
              schedule.briefDesc,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
              overflow: TextOverflow.fade,
            )
          ],
        ),
      ),
    );
  }
}
