import 'package:equatable/equatable.dart';

import '../../../../cores/enums/ticket_category.dart';

class TicketEntity extends Equatable {
  final String ticketId;
  final TicketCategory category;
  final String tourId;
  final String ticketTypeId;
  final String customerId;
  final DateTime purchasedDate;
  final num ticketPrice;
  final int quantity;
  final double discount;

  const TicketEntity({
    required this.ticketId,
    required this.category,
    required this.tourId,
    required this.quantity,
    required this.ticketTypeId,
    required this.customerId,
    required this.purchasedDate,
    required this.ticketPrice,
    required this.discount,
  });

  TicketEntity copyWith({
    String? ticketId,
    TicketCategory? category,
    String? tourId,
    String? ticketTypeId,
    String? customerId,
    DateTime? purchasedDate,
    num? ticketPrice,
    int? quantity,
    double? discount,
  }) {
    return TicketEntity(
      ticketId: ticketId ?? this.ticketId,
      category: category ?? this.category,
      tourId: tourId ?? this.tourId,
      ticketTypeId: ticketTypeId ?? this.ticketTypeId,
      customerId: customerId ?? this.customerId,
      purchasedDate: purchasedDate ?? this.purchasedDate,
      ticketPrice: ticketPrice ?? this.ticketPrice,
      quantity: quantity ?? this.quantity,
      discount: discount ?? this.discount,
    );
  }

  @override
  List<Object> get props {
    return [
      ticketId,
      tourId,
      ticketTypeId,
      customerId,
      purchasedDate,
      ticketPrice,
      category,
      discount,
      quantity,
    ];
  }
}
