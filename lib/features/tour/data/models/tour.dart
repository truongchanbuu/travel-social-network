import 'package:json_annotation/json_annotation.dart';

import '../../../ticket/data/models/ticket_type.dart';
import '../../../ticket/domain/entities/ticket_type.dart';
import '../../domain/entities/tour.dart';
import '../../domain/entities/tour_schedule.dart';
import 'tour_schedule.dart';

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
    required super.rating,
    TourSchedule? tourSchedule,
  }) : super(
          tickets: tickets.map((ticket) => ticket.toEntity()).toList(),
          tourSchedule: tourSchedule?.toEntity(),
        );

  @override
  Tour copyWith({
    String? createdBy,
    String? departure,
    String? destination,
    String? duration,
    List<String>? imageUrls,
    double? rating,
    List<TicketTypeEntity>? tickets,
    String? tourDescription,
    String? tourId,
    String? tourName,
    TourScheduleEntity? tourSchedule,
  }) {
    return Tour(
      createdBy: createdBy ?? this.createdBy,
      departure: departure ?? this.departure,
      destination: destination ?? this.destination,
      duration: duration ?? this.duration,
      imageUrls: imageUrls ?? this.imageUrls,
      rating: rating ?? this.rating,
      tickets: (tickets ?? this.tickets).map(TicketType.fromEntity).toList(),
      tourDescription: tourDescription ?? this.tourDescription,
      tourId: tourId ?? this.tourId,
      tourName: tourName ?? this.tourName,
      tourSchedule: tourSchedule != null
          ? TourSchedule.fromEntity(tourSchedule)
          : (this.tourSchedule != null)
              ? TourSchedule.fromEntity(this.tourSchedule!)
              : null,
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
      rating: rating,
      tourSchedule: tourSchedule,
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
      rating: entity.rating,
      tourSchedule: entity.tourSchedule != null
          ? TourSchedule.fromEntity(entity.tourSchedule!)
          : null,
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
      "rating": rating,
      "tourSchedule": tourSchedule != null
          ? TourSchedule.fromEntity(tourSchedule!).toMap()
          : null,
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
      rating: map["rating"]?.toDouble(),
      tourSchedule: TourSchedule.fromMap(map['tourSchedule']),
    );
  }

  factory Tour.fromJson(Map<String, dynamic> json) => _$TourFromJson(json);

  Map<String, dynamic> toJson() => _$TourToJson(this);
}
