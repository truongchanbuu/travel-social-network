import 'dart:convert';

import '../../../../cores/utils/enum_utils.dart';
import '../../../../cores/enums/activity_type.dart';
import '../../domain/entities/tour_activity.dart';

class TourActivity extends TourActivityEntity {
  const TourActivity({
    required super.time,
    required super.location,
    required super.description,
    required super.transportation,
    required super.activityType,
  });

  TourActivityEntity toEntity() {
    return TourActivityEntity(
      time: time,
      location: location,
      description: description,
      transportation: transportation,
      activityType: activityType,
    );
  }

  factory TourActivity.fromEntity(TourActivityEntity entity) {
    return TourActivity(
      time: entity.time,
      location: entity.location,
      description: entity.description,
      transportation: entity.transportation,
      activityType: entity.activityType,
    );
  }

  TourActivity copyWith({
    String? time,
    String? location,
    String? description,
    String? transportation,
    ActivityType? activityType,
  }) {
    return TourActivity(
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

  factory TourActivity.fromMap(Map<String, dynamic> map) {
    return TourActivity(
      time: map['time'] ?? '',
      location: map['location'] ?? '',
      description: map['description'] ?? '',
      transportation: map['transportation'] ?? '',
      activityType: stringToEnum(map['activityType'], ActivityType.values),
    );
  }

  String toJson() => json.encode(toMap());

  factory TourActivity.fromJson(String source) =>
      TourActivity.fromMap(json.decode(source));
}
