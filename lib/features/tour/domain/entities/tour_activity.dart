import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../cores/enums/activity_type.dart';

@JsonSerializable()
class TourActivityEntity extends Equatable {
  final String time;
  final String location;
  final String description;
  final String transportation;
  final ActivityType activityType;

  const TourActivityEntity({
    required this.time,
    required this.location,
    required this.description,
    required this.transportation,
    required this.activityType,
  });

  @override
  List<Object> get props {
    return [
      time,
      location,
      description,
      transportation,
      activityType,
    ];
  }
}
