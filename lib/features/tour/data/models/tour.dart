import 'package:json_annotation/json_annotation.dart';

import '../../../ticket/data/models/ticket_type.dart';
import '../../domain/entities/tour.dart';

part 'tour.g.dart';

@JsonSerializable()
class Tour extends TourEntity {
  Tour({
    required super.tourId,
    required super.tourName,
    required super.tourDescription,
    required super.createdBy,
    required List<TicketType> tickets,
    required super.imageUrls,
    required super.departure,
    required super.destination,
    required super.duration,
    required super.startDates,
    required super.rating,
  }) : super(tickets: tickets.map((ticket) => ticket.toEntity()).toList());

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
    List<DateTime>? startDates,
    double? rating,
  }) {
    return Tour(
      tourId: tourId ?? this.tourId,
      tourName: tourName ?? this.tourName,
      tourDescription: tourDescription ?? this.tourDescription,
      createdBy: createdBy ?? this.createdBy,
      tickets: tickets ?? this.tickets.map(TicketType.fromEntity).toList(),
      imageUrls: imageUrls ?? this.imageUrls,
      departure: departure ?? this.departure,
      destination: destination ?? this.destination,
      duration: duration ?? this.duration,
      startDates: startDates ?? this.startDates,
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
      startDates: startDates,
      rating: rating,
    );
  }

  factory Tour.fromEntity(TourEntity entity) {
    return Tour(
      tourId: entity.tourId,
      tourName: entity.tourName,
      tourDescription: entity.tourDescription,
      createdBy: entity.createdBy,
      tickets: entity.tickets.map(TicketType.fromEntity).toList(),
      imageUrls: entity.imageUrls,
      departure: entity.departure,
      destination: entity.destination,
      duration: entity.duration,
      startDates: entity.startDates,
      rating: entity.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "tourId": tourId,
      "tourName": tourName,
      "tourDescription": tourDescription,
      "createdBy": createdBy,
      "tickets": tickets.map(TicketType.fromEntity).toList(),
      "imageUrls": imageUrls,
      "departure": departure,
      "destination": destination,
      "duration": duration,
      "startDates": startDates,
      "rating": rating,
    };
  }

  factory Tour.fromMap(Map<String, dynamic> map) {
    return Tour(
      tourId: map["tourId"],
      tourName: map["tourName"],
      tourDescription: map["tourDescription"],
      createdBy: map["createdBy"],
      tickets: List<TicketType>.from(map["tickets"].map(TicketType.fromMap)),
      imageUrls: List<String>.from(map["imageUrls"]),
      departure: map["departure"],
      destination: map["destination"],
      duration: map["duration"]?.toInt(),
      startDates: map["startDates"],
      rating: map["rating"]?.toDouble(),
    );
  }

  factory Tour.fromJson(Map<String, dynamic> json) => _$TourFromJson(json);

  Map<String, dynamic> toJson() => _$TourToJson(this);
}
