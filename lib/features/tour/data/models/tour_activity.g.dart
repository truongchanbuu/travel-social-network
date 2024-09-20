// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tour_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TourActivity _$TourActivityFromJson(Map<String, dynamic> json) => TourActivity(
      time: json['time'] as String,
      location: json['location'] as String,
      description: json['description'] as String,
      transportation: json['transportation'] as String,
      activityType: $enumDecode(_$ActivityTypeEnumMap, json['activityType']),
    );

Map<String, dynamic> _$TourActivityToJson(TourActivity instance) =>
    <String, dynamic>{
      'time': instance.time,
      'location': instance.location,
      'description': instance.description,
      'transportation': instance.transportation,
      'activityType': _$ActivityTypeEnumMap[instance.activityType]!,
    };

const _$ActivityTypeEnumMap = {
  ActivityType.dining: 'dining',
  ActivityType.breakfast: 'breakfast',
  ActivityType.lunch: 'lunch',
  ActivityType.sightseeing: 'sightseeing',
  ActivityType.rest: 'rest',
  ActivityType.exploring: 'exploring',
  ActivityType.transportation: 'transportation',
};
