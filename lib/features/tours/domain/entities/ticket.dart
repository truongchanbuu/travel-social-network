import 'package:equatable/equatable.dart';

import '../../../../cores/enums/ticket_type.dart';
import '../../../../cores/utils/enum_utils.dart';

class TicketEntity extends Equatable {
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

  const TicketEntity({
    required this.ticketId,
    required this.ticketName,
    required this.tourId,
    required this.bookingDate,
    required this.tourDate,
    required this.ticketPrice,
    required this.ticketDescription,
    required this.ticketType,
    required this.refundPolicy,
    required this.discount,
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

  @override
  String toString() {
    return 'TicketEntity(ticketId: $ticketId, ticketName: $ticketName, tourId: $tourId, bookingDate: $bookingDate, tourDate: $tourDate, ticketPrice: $ticketPrice, ticketDescription: $ticketDescription, ticketType: $ticketType, refundPolicy: $refundPolicy, discount: $discount)';
  }

  @override
  List<Object> get props {
    return [
      ticketId,
      ticketName,
      tourId,
      bookingDate,
      tourDate,
      ticketPrice,
      ticketDescription,
      ticketType,
      refundPolicy,
      discount,
    ];
  }
}
