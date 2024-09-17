import 'dart:convert';

import 'package:travel_social_network/cores/utils/enum_utils.dart';

import '../../../../cores/enums/ticket_type.dart';

class TicketEntity {
  final String ticketId;
  final String ticketName;
  final String tourId;
  final DateTime bookingDate;
  final String tourDate;
  final num ticketPrice;
  final String ticketDescription;
  final TicketType ticketType;
  final String refundPolicy;
  final num discount;

  TicketEntity({
    required this.ticketId,
    required this.ticketName,
    required this.tourId,
    required this.bookingDate,
    required this.tourDate,
    required this.ticketPrice,
    required this.ticketDescription,
    required this.ticketType,
    required this.refundPolicy,
    this.discount = 0,
  });

  TicketEntity copyWith({
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
    return TicketEntity(
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
    return {
      'ticketId': ticketId,
      'ticketName': ticketName,
      'tourId': tourId,
      'bookingDate': bookingDate.millisecondsSinceEpoch,
      'tourDate': tourDate,
      'ticketPrice': ticketPrice,
      'ticketDescription': ticketDescription,
      'ticketType': enumToString(ticketType),
      'refundPolicy': refundPolicy,
      'discount': discount,
    };
  }

  factory TicketEntity.fromMap(Map<String, dynamic> map) {
    return TicketEntity(
      ticketId: map['ticketId'] ?? '',
      ticketName: map['ticketName'] ?? '',
      tourId: map['tourId'] ?? '',
      bookingDate: DateTime.fromMillisecondsSinceEpoch(map['bookingDate']),
      tourDate: map['tourDate'] ?? '',
      ticketPrice: map['ticketPrice'] ?? 0,
      ticketDescription: map['ticketDescription'] ?? '',
      ticketType: stringToEnum(map['ticketType'], TicketType.values),
      refundPolicy: map['refundPolicy'] ?? '',
      discount: map['discount'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TicketEntity.fromJson(String source) =>
      TicketEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TicketEntity(ticketId: $ticketId, ticketName: $ticketName, tourId: $tourId, bookingDate: $bookingDate, tourDate: $tourDate, ticketPrice: $ticketPrice, ticketDescription: $ticketDescription, ticketType: $ticketType, refundPolicy: $refundPolicy, discount: $discount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TicketEntity &&
        other.ticketId == ticketId &&
        other.ticketName == ticketName &&
        other.tourId == tourId &&
        other.bookingDate == bookingDate &&
        other.tourDate == tourDate &&
        other.ticketPrice == ticketPrice &&
        other.ticketDescription == ticketDescription &&
        other.ticketType == ticketType &&
        other.refundPolicy == refundPolicy &&
        other.discount == discount;
  }

  @override
  int get hashCode {
    return ticketId.hashCode ^
        ticketName.hashCode ^
        tourId.hashCode ^
        bookingDate.hashCode ^
        tourDate.hashCode ^
        ticketPrice.hashCode ^
        ticketDescription.hashCode ^
        ticketType.hashCode ^
        refundPolicy.hashCode ^
        discount.hashCode;
  }
}
