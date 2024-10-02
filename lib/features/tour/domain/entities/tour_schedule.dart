import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'tour_activity.dart';

@JsonSerializable()
class TourScheduleEntity extends Equatable {
  final String tourId;
  final int day;
  final DateTime date;
  final String briefDesc;
  final List<TourActivityEntity> activities;

  const TourScheduleEntity({
    required this.tourId,
    required this.day,
    required this.date,
    required this.briefDesc,
    required this.activities,
  });

  @override
  List<Object> get props => [tourId, day, date, activities, briefDesc];
}
