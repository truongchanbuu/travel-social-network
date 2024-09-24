import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/tour_schedule.dart';
import 'tour_activity.dart';

part 'tour_schedule.g.dart';

@JsonSerializable()
class TourSchedule extends TourScheduleEntity {
  TourSchedule({
    required super.tourId,
    required super.day,
    required super.date,
    required super.briefDesc,
    required List<TourActivity> activities,
  }) : super(activities: activities.map((a) => a.toEntity()).toList());

  TourScheduleEntity toEntity() {
    return TourScheduleEntity(
      tourId: tourId,
      day: day,
      date: date,
      activities: activities,
      briefDesc: briefDesc,
    );
  }

  factory TourSchedule.fromEntity(TourScheduleEntity entity) {
    return TourSchedule(
      tourId: entity.tourId,
      day: entity.day,
      date: entity.date,
      briefDesc: entity.briefDesc,
      activities: entity.activities.map(TourActivity.fromEntity).toList(),
    );
  }

  TourSchedule copyWith({
    String? tourId,
    int? day,
    DateTime? date,
    String? briefDesc,
    List<TourActivity>? activities,
  }) {
    return TourSchedule(
      tourId: tourId ?? this.tourId,
      day: day ?? this.day,
      date: date ?? this.date,
      briefDesc: briefDesc ?? this.briefDesc,
      activities:
          activities ?? this.activities.map(TourActivity.fromEntity).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tourId': tourId,
      'day': day,
      'date': date.toIso8601String(),
      'briefDesc': briefDesc,
      'activities':
          activities.map((activity) => (activity as TourActivity).toMap()),
    };
  }

  factory TourSchedule.fromMap(Map<String, dynamic> map) {
    return TourSchedule(
      tourId: map['tourId'],
      day: map['day'] ?? '',
      date: DateTime.parse(map['date']),
      briefDesc: map['briefDesc'],
      activities: (map['activities'] as List<Map<String, dynamic>>)
          .map(TourActivity.fromMap)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => _$TourScheduleToJson(this);

  factory TourSchedule.fromJson(Map<String, dynamic> json) =>
      _$TourScheduleFromJson(json);
}
