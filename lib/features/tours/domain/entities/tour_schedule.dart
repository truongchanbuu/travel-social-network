import 'package:equatable/equatable.dart';

import 'tour_activity.dart';

class TourScheduleEntity extends Equatable {
  final String day;
  final DateTime date;
  final String briefDesc;
  final List<TourActivityEntity> activities;

  const TourScheduleEntity({
    required this.day,
    required this.date,
    required this.briefDesc,
    required this.activities,
  });

  @override
  List<Object> get props => [day, date, activities, briefDesc];
}
