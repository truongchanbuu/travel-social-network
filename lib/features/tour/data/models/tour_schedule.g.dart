// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tour_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TourSchedule _$TourScheduleFromJson(Map<String, dynamic> json) => TourSchedule(
      tourId: json['tourId'] as String,
      day: json['day'] as String,
      date: DateTime.parse(json['date'] as String),
      briefDesc: json['briefDesc'] as String,
      activities: (json['activities'] as List<dynamic>)
          .map((e) => TourActivity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TourScheduleToJson(TourSchedule instance) =>
    <String, dynamic>{
      'tourId': instance.tourId,
      'day': instance.day,
      'date': instance.date.toIso8601String(),
      'briefDesc': instance.briefDesc,
      'activities': instance.activities,
    };
