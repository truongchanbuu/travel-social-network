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
      tickets: (json['tickets'] as List<dynamic>)
          .map((e) => TicketType.fromJson(e as Map<String, dynamic>))
          .toList(),
      imageUrls:
          (json['imageUrls'] as List<dynamic>).map((e) => e as String).toList(),
      departure: json['departure'] as String,
      destination: json['destination'] as String,
      duration: (json['duration'] as num).toInt(),
      startedDate: DateTime.parse(json['startedDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      rating: (json['rating'] as num).toDouble(),
    );

Map<String, dynamic> _$TourToJson(Tour instance) => <String, dynamic>{
      'tourId': instance.tourId,
      'tourName': instance.tourName,
      'tourDescription': instance.tourDescription,
      'createdBy': instance.createdBy,
      'tickets': instance.tickets,
      'imageUrls': instance.imageUrls,
      'departure': instance.departure,
      'destination': instance.destination,
      'duration': instance.duration,
      'startedDate': instance.startedDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'rating': instance.rating,
    };
