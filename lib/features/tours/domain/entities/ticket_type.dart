import 'package:equatable/equatable.dart';

import '../../../../cores/enums/ticket_category.dart';

class TicketTypeEntity extends Equatable {
  final String ticketTypeId;
  final String ticketTypeName;
  final String tourId;
  final num ticketPrice;
  final String ticketDescription;
  final TicketCategory category;
  final int quantity;

  const TicketTypeEntity({
    required this.ticketTypeId,
    required this.ticketTypeName,
    required this.tourId,
    required this.ticketPrice,
    required this.ticketDescription,
    required this.category,
    required this.quantity,
  });

  @override
  List<Object> get props {
    return [
      ticketTypeId,
      ticketTypeName,
      tourId,
      ticketPrice,
      ticketDescription,
      category,
      quantity,
    ];
  }
}
