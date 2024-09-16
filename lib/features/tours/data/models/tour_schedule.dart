import 'dart:convert';
import 'package:travel_social_network/cores/utils/enum_utils.dart';

import '../../../../cores/enums/activity_type.dart';

class TourSchedule {
  final String time;
  final String location;
  final String description;
  final String transportation;
  final ActivityType activityType;
  TourSchedule({
    required this.time,
    required this.location,
    required this.description,
    required this.transportation,
    required this.activityType,
  });

  TourSchedule copyWith({
    String? time,
    String? location,
    String? description,
    String? transportation,
    ActivityType? activityType,
  }) {
    return TourSchedule(
      time: time ?? this.time,
      location: location ?? this.location,
      description: description ?? this.description,
      transportation: transportation ?? this.transportation,
      activityType: activityType ?? this.activityType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'time': time,
      'location': location,
      'description': description,
      'transportation': transportation,
      'activityType': enumToString(activityType),
    };
  }

  factory TourSchedule.fromMap(Map<String, dynamic> map) {
    return TourSchedule(
      time: map['time'] ?? '',
      location: map['location'] ?? '',
      description: map['description'] ?? '',
      transportation: map['transportation'] ?? '',
      activityType: stringToEnum(map['activityType'], ActivityType.values),
    );
  }

  String toJson() => json.encode(toMap());

  factory TourSchedule.fromJson(String source) =>
      TourSchedule.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TourSchedule(time: $time, location: $location, description: $description, transportation: $transportation, activityType: $activityType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TourSchedule &&
        other.time == time &&
        other.location == location &&
        other.description == description &&
        other.transportation == transportation &&
        other.activityType == activityType;
  }

  @override
  int get hashCode {
    return time.hashCode ^
        location.hashCode ^
        description.hashCode ^
        transportation.hashCode ^
        activityType.hashCode;
  }
}
