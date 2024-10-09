// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tour.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tour _$TourFromJson(Map<String, dynamic> json) => Tour(
      tourId: json['tourId'] as String,
      tourName: json['tourName'] as String,
      tourDescription: json['tourDescription'] as String,
      createdBy: json['createdBy'] as String,
      ticketIds:
          (json['ticketIds'] as List<dynamic>).map((e) => e as String).toList(),
      imageUrls:
          (json['imageUrls'] as List<dynamic>).map((e) => e as String).toList(),
      departure: json['departure'] as String,
      destination: json['destination'] as String,
      duration: json['duration'] as String,
      rating: (json['rating'] as num).toDouble(),
      tourSchedule: json['tourSchedule'] == null
          ? null
          : TourSchedule.fromJson(json['tourSchedule'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TourToJson(Tour instance) => <String, dynamic>{
      'tourId': instance.tourId,
      'tourName': instance.tourName,
      'tourDescription': instance.tourDescription,
      'createdBy': instance.createdBy,
      'ticketIds': instance.ticketIds,
      'imageUrls': instance.imageUrls,
      'departure': instance.departure,
      'destination': instance.destination,
      'duration': instance.duration,
      'rating': instance.rating,
      'tourSchedule': instance.tourSchedule,
    };
