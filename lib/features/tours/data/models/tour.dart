import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/tour.dart';
import 'ticket_type.dart';

part 'tour.g.dart';

@JsonSerializable()
class Tour extends TourEntity {
  const Tour({
    required super.tourId,
    required super.tourName,
    required super.tourDescription,
    required super.createdBy,
    required super.tickets,
    required super.imageUrls,
    required super.departure,
    required super.destination,
    required super.duration,
    required super.startedDate,
    required super.endDate,
    required super.rating,
  });

  Tour copyWith({
    String? tourId,
    String? tourName,
    String? tourDescription,
    String? createdBy,
    List<TicketType>? tickets,
    List<String>? imageUrls,
    String? departure,
    String? destination,
    int? duration,
    DateTime? startedDate,
    DateTime? endDate,
    double? rating,
  }) {
    return Tour(
      tourId: tourId ?? this.tourId,
      tourName: tourName ?? this.tourName,
      tourDescription: tourDescription ?? this.tourDescription,
      createdBy: createdBy ?? this.createdBy,
      tickets: tickets ?? this.tickets,
      imageUrls: imageUrls ?? this.imageUrls,
      departure: departure ?? this.departure,
      destination: destination ?? this.destination,
      duration: duration ?? this.duration,
      startedDate: startedDate ?? this.startedDate,
      endDate: endDate ?? this.endDate,
      rating: rating ?? this.rating,
    );
  }

  TourEntity toEntity() {
    return TourEntity(
      tourId: tourId,
      tourName: tourName,
      tourDescription: tourDescription,
      createdBy: createdBy,
      tickets: tickets,
      imageUrls: imageUrls,
      departure: departure,
      destination: destination,
      duration: duration,
      startedDate: startedDate,
      endDate: endDate,
      rating: rating,
    );
  }

  factory Tour.fromEntity(TourEntity entity) {
    return Tour(
      tourId: entity.tourId,
      tourName: entity.tourName,
      tourDescription: entity.tourDescription,
      createdBy: entity.createdBy,
      tickets: entity.tickets,
      imageUrls: entity.imageUrls,
      departure: entity.departure,
      destination: entity.destination,
      duration: entity.duration,
      startedDate: entity.startedDate,
      endDate: entity.endDate,
      rating: entity.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "tourId": tourId,
      "tourName": tourName,
      "tourDescription": tourDescription,
      "createdBy": createdBy,
      "tickets": tickets.map((x) => x.toMap()).toList(),
      "imageUrls": imageUrls,
      "departure": departure,
      "destination": destination,
      "duration": duration,
      "startedDate": startedDate.toUtc().toIso8601String(),
      "endDate": endDate.toUtc().toIso8601String(),
      "rating": rating,
    };
  }

  factory Tour.fromMap(Map<String, dynamic> map) {
    return Tour(
      tourId: map["tourId"],
      tourName: map["tourName"],
      tourDescription: map["tourDescription"],
      createdBy: map["createdBy"],
      tickets: List<TicketType>.from(
          map["tickets"].map((x) => TicketType.fromMap(x))),
      imageUrls: List<String>.from(map["imageUrls"]),
      departure: map["departure"],
      destination: map["destination"],
      duration: map["duration"]?.toInt(),
      startedDate: DateTime.parse(map["startedDate"]).toLocal(),
      endDate: DateTime.parse(map["endDate"]).toLocal(),
      rating: map["rating"]?.toDouble(),
    );
  }

  factory Tour.fromJson(Map<String, dynamic> json) => _$TourFromJson(json);

  Map<String, dynamic> toJson() => _$TourToJson(this);

  @override
  String toString() {
    return "Tour(tourId: $tourId, tourName: $tourName, tourDescription: $tourDescription, createdBy: $createdBy, tickets: $tickets, imageUrls: $imageUrls, departure: $departure, destination: $destination, duration: $duration, startedDate: $startedDate, endDate: $endDate, rating: $rating)";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Tour &&
        other.tourId == tourId &&
        other.tourName == tourName &&
        other.tourDescription == tourDescription &&
        other.createdBy == createdBy &&
        listEquals(other.tickets, tickets) &&
        listEquals(other.imageUrls, imageUrls) &&
        other.departure == departure &&
        other.destination == destination &&
        other.duration == duration &&
        other.startedDate == startedDate &&
        other.endDate == endDate &&
        other.rating == rating;
  }

  @override
  int get hashCode {
    return tourId.hashCode ^
        tourName.hashCode ^
        tourDescription.hashCode ^
        createdBy.hashCode ^
        tickets.hashCode ^
        imageUrls.hashCode ^
        departure.hashCode ^
        destination.hashCode ^
        duration.hashCode ^
        startedDate.hashCode ^
        endDate.hashCode ^
        rating.hashCode;
  }
}
