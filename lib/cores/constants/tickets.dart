import 'dart:math';

import 'package:travel_social_network/features/tours/data/models/ticket_type.dart';

import '../enums/ticket_category.dart';

final List<String> ticketNames = [
  'Standard Ticket',
  'VIP Ticket',
  'Child Ticket',
];

final List<TicketType> sampleTickets = List.generate(
  100,
  (i) => TicketType(
    ticketTypeId: 'TYPE${i + 1}',
    ticketTypeName: ticketNames[i % ticketNames.length],
    tourId: 'TOUR${(i % 10) + 1}', // Cycle through 10 tours
    ticketPrice: double.parse((20 + Random().nextDouble() * 80)
        .toStringAsFixed(2)), // Price between 20 and 100
    ticketDescription: 'Description for ticket type ${i + 1}',
    category: TicketCategory.values[i % TicketCategory.values.length],
    quantity: Random().nextInt(10) + 1, // Quantity between 1 and 10
  ),
);
