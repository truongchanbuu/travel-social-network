import 'package:equatable/equatable.dart';

class TicketEntity extends Equatable {
  final String ticketId;
  final String tourId;
  final String ticketTypeId;
  final String customerId;
  final DateTime purchasedDate;
  final num ticketPrice;
  final double discount;

  const TicketEntity({
    required this.ticketId,
    required this.tourId,
    required this.ticketTypeId,
    required this.customerId,
    required this.purchasedDate,
    required this.ticketPrice,
    required this.discount,
  });

  @override
  List<Object> get props {
    return [
      ticketId,
      tourId,
      ticketTypeId,
      customerId,
      purchasedDate,
      ticketPrice,
      discount,
    ];
  }
}
