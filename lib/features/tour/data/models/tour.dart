import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/tour.dart';

part 'tour.g.dart';

@JsonSerializable()
class Tour extends TourEntity {
  const Tour(
      {required super.tourId,
      required super.tourName,
      required super.tourDescription,
      required super.createdBy,
      required super.ticketIds,
      required super.imageUrls,
      required super.departure,
      required super.destination,
      required super.duration,
      required super.rating,
      super.tourSchedule,
      super.additionalInfo});

  @override
  Tour copyWith({
    String? createdBy,
    String? departure,
    String? destination,
    String? duration,
    List<String>? imageUrls,
    double? rating,
    List<String>? ticketIds,
    String? tourDescription,
    String? tourId,
    String? tourName,
    String? tourSchedule,
    String? additionalInfo,
  }) {
    return Tour(
      createdBy: createdBy ?? this.createdBy,
      departure: departure ?? this.departure,
      destination: destination ?? this.destination,
      duration: duration ?? this.duration,
      imageUrls: imageUrls ?? this.imageUrls,
      rating: rating ?? this.rating,
      ticketIds: ticketIds ?? this.ticketIds,
      tourDescription: tourDescription ?? this.tourDescription,
      tourId: tourId ?? this.tourId,
      tourName: tourName ?? this.tourName,
      tourSchedule: tourSchedule ?? this.tourSchedule,
      additionalInfo: additionalInfo ?? this.additionalInfo,
    );
  }

  TourEntity toEntity() {
    return TourEntity(
      tourId: tourId,
      tourName: tourName,
      tourDescription: tourDescription,
      createdBy: createdBy,
      ticketIds: ticketIds,
      imageUrls: imageUrls,
      departure: departure,
      destination: destination,
      duration: duration,
      rating: rating,
      tourSchedule: tourSchedule,
      additionalInfo: additionalInfo,
    );
  }

  factory Tour.fromEntity(TourEntity entity) {
    return Tour(
      tourId: entity.tourId,
      tourName: entity.tourName,
      tourDescription: entity.tourDescription,
      createdBy: entity.createdBy,
      ticketIds: entity.ticketIds,
      imageUrls: entity.imageUrls,
      departure: entity.departure,
      destination: entity.destination,
      duration: entity.duration,
      rating: entity.rating,
      tourSchedule: entity.tourSchedule,
      additionalInfo: entity.additionalInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "tourId": tourId,
      "tourName": tourName,
      "tourDescription": tourDescription,
      "createdBy": createdBy,
      "ticketIds": ticketIds,
      "imageUrls": imageUrls,
      "departure": departure,
      "destination": destination,
      "duration": duration,
      "rating": rating,
      "tourSchedule": tourSchedule,
      "additionalInfo": additionalInfo,
    };
  }

  factory Tour.fromMap(Map<String, dynamic> map) {
    return Tour(
      tourId: map["tourId"],
      tourName: map["tourName"],
      tourDescription: map["tourDescription"],
      createdBy: map["createdBy"],
      ticketIds: map["ticketIds"],
      imageUrls: List<String>.from(map["imageUrls"]),
      departure: map["departure"],
      destination: map["destination"],
      duration: map["duration"]?.toInt(),
      rating: map["rating"]?.toDouble(),
      tourSchedule: map["tourSchedule"],
      additionalInfo: map["additionalInfo"],
    );
  }

  factory Tour.fromJson(Map<String, dynamic> json) => _$TourFromJson(json);

  Map<String, dynamic> toJson() => _$TourToJson(this);
}
