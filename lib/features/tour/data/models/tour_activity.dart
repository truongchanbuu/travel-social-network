import 'package:json_annotation/json_annotation.dart';

import '../../../../cores/enums/activity_type.dart';
import '../../../../cores/utils/enum_utils.dart';
import '../../domain/entities/tour_activity.dart';

part 'tour_activity.g.dart';

@JsonSerializable()
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
    return <String, dynamic>{
      "time": time,
      "location": location,
      "description": description,
      "transportation": transportation,
      "activityType": activityType.name,
    };
  }

  factory TourActivity.fromMap(Map<String, dynamic> map) {
    return TourActivity(
      time: map["time"],
      location: map["location"],
      description: map["description"],
      transportation: map["transportation"],
      activityType: stringToEnum(map['activityType'], ActivityType.values),
    );
  }

  factory TourActivity.fromJson(Map<String, dynamic> json) =>
      _$TourActivityFromJson(json);

  Map<String, dynamic> toJson() => _$TourActivityToJson(this);

  @override
  String toString() {
    return "TourActivity(time: $time, location: $location, description: $description, transportation: $transportation, activityType: $activityType)";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TourActivity &&
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
