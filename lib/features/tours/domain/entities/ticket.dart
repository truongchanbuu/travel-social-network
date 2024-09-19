import 'package:equatable/equatable.dart';

import '../../../../cores/enums/ticket_type.dart';

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
