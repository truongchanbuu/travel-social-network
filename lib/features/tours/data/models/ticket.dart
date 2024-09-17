import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

import '../../../../cores/enums/ticket_type.dart';
import '../../domain/entities/ticket.dart';
import '../../../../cores/utils/enum_utils.dart';

part 'ticket_entity.g.dart';

@JsonSerializable()
class Ticket extends TicketEntity {
  const Ticket({
    required super.ticketId,
    required super.ticketName,
    required super.tourId,
    required super.bookingDate,
    required super.tourDate,
    required super.ticketPrice,
    required super.ticketDescription,
    required super.ticketType,
    required super.refundPolicy,
    required super.discount,
  });

  TicketEntity toEntity() {
    return TicketEntity(
      ticketId: ticketId,
      ticketName: ticketName,
      tourId: tourId,
      bookingDate: bookingDate,
      tourDate: tourDate,
      ticketPrice: ticketPrice,
      ticketDescription: ticketDescription,
      ticketType: ticketType,
      refundPolicy: refundPolicy,
      discount: discount,
    );
  }

  factory Ticket.fromEntity(TicketEntity entity) {
    return Ticket(
      ticketId: entity.ticketId,
      ticketName: entity.ticketName,
      tourId: entity.tourId,
      bookingDate: entity.bookingDate,
      tourDate: entity.tourDate,
      ticketPrice: entity.ticketPrice,
      ticketDescription: entity.ticketDescription,
      ticketType: entity.ticketType,
      refundPolicy: entity.refundPolicy,
      discount: entity.discount,
    );
  }

  @override
  Ticket copyWith({
    String? ticketId,
    String? ticketName,
    String? tourId,
    DateTime? bookingDate,
    String? tourDate,
    num? ticketPrice,
    String? ticketDescription,
    TicketType? ticketType,
    String? refundPolicy,
    num? discount,
  }) {
    return Ticket(
      ticketId: ticketId ?? this.ticketId,
      ticketName: ticketName ?? this.ticketName,
      tourId: tourId ?? this.tourId,
      bookingDate: bookingDate ?? this.bookingDate,
      tourDate: tourDate ?? this.tourDate,
      ticketPrice: ticketPrice ?? this.ticketPrice,
      ticketDescription: ticketDescription ?? this.ticketDescription,
      ticketType: ticketType ?? this.ticketType,
      refundPolicy: refundPolicy ?? this.refundPolicy,
      discount: discount ?? this.discount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "ticketId": ticketId,
      "ticketName": ticketName,
      "tourId": tourId,
      "bookingDate": bookingDate.toUtc().toIso8601String(),
      "tourDate": tourDate,
      "ticketPrice": ticketPrice,
      "ticketDescription": ticketDescription,
      "ticketType": enumToString(ticketType),
      "refundPolicy": refundPolicy,
      "discount": discount,
    };
  }

  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      ticketId: map["ticketId"],
      ticketName: map["ticketName"],
      tourId: map["tourId"],
      bookingDate: DateTime.parse(map["bookingDate"]).toLocal(),
      tourDate: map["tourDate"],
      ticketPrice: map["ticketPrice"],
      ticketDescription: map["ticketDescription"],
      ticketType: stringToEnum(map['ticketType'], TicketType.values),
      refundPolicy: map["refundPolicy"],
      discount: map["discount"],
    );
  }

  String toJson() => json.encode(toMap());

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

  Map<String, dynamic> toJson() => _$TicketToJson(this);
}
