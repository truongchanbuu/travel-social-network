import 'package:flutter/material.dart';
import 'package:travel_social_network/cores/utils/enum_utils.dart';

import '../../../../generated/l10n.dart';
import '../../domain/entities/tour_activity.dart';
import '../../domain/entities/tour_schedule.dart';

class TourScheduleDetailPage extends StatefulWidget {
  final TourScheduleEntity tourSchedule;
  const TourScheduleDetailPage({super.key, required this.tourSchedule});

  @override
  State<TourScheduleDetailPage> createState() => _TourScheduleDetailPageState();
}

class _TourScheduleDetailPageState extends State<TourScheduleDetailPage> {
  List<TourActivityEntity> activities = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    activities = widget.tourSchedule.activities;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemBuilder: _buildActivityItem,
        itemCount: activities.length,
      ),
    );
  }

  Widget _buildActivityItem(BuildContext context, int index) {
    final TourActivityEntity activity = activities[index];

    return ListTile(
      leading: Icon(getActivityIcon(activity.activityType)),
      title: Text('${activity.time} --- ${activity.location}'),
      subtitle: Text(
          '${activity.description} --- ${S.current.transportation}: ${activity.transportation}'),
      titleAlignment: ListTileTitleAlignment.center,
    );
  }
}
