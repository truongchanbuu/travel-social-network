import 'dart:convert';

import '../../domain/entities/tour_schedule.dart';
import 'tour_activity.dart';

class TourSchedule extends TourScheduleEntity {
  TourSchedule({
    required super.day,
    required super.date,
    required super.briefDesc,
    required List<TourActivity> activities,
  }) : super(activities: activities.map((a) => a.toEntity()).toList());

  TourScheduleEntity toEntity() {
    return TourScheduleEntity(
        day: day, date: date, activities: activities, briefDesc: briefDesc);
  }

  factory TourSchedule.fromEntity(TourScheduleEntity entity) {
    return TourSchedule(
      day: entity.day,
      date: entity.date,
      briefDesc: entity.briefDesc,
      activities: entity.activities.map(TourActivity.fromEntity).toList(),
    );
  }

  TourSchedule copyWith({
    String? day,
    DateTime? date,
    String? briefDesc,
    List<TourActivity>? activities,
  }) {
    return TourSchedule(
      day: day ?? this.day,
      date: date ?? this.date,
      briefDesc: briefDesc ?? this.briefDesc,
      activities:
          activities ?? this.activities.map(TourActivity.fromEntity).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'date': date.toIso8601String(),
      'briefDesc': briefDesc,
      'activities':
          activities.map((activity) => (activity as TourActivity).toMap()),
    };
  }

  factory TourSchedule.fromMap(Map<String, dynamic> map) {
    return TourSchedule(
      day: map['day'] ?? '',
      date: DateTime.parse(map['date']),
      briefDesc: map['briefDesc'],
      activities: (map['activities'] as List<Map<String, dynamic>>)
          .map(TourActivity.fromMap)
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory TourSchedule.fromJson(String source) =>
      TourSchedule.fromMap(json.decode(source));
}
