import 'dart:convert';
import 'dart:math';

import '../../features/ticket/domain/entities/ticket_type.dart';
import '../enums/ticket_category.dart';

final List<String> ticketNames = [
  'Standard Ticket',
  'VIP Ticket',
  'Child Ticket',
];

final String ticketInfo = jsonEncode([
  {
    "insert": "Ticket Information\n",
    "attributes": {"header": 1, "color": "red"}
  },
  {"insert": "Ticket Title: Grand Tour Ticket\n"},
  {"insert": "Ticket ID: TICKET-123456\n"},
  {"insert": "User ID: USER-78910\n"},
  {"insert": "Tour ID: TOUR-54321\n"},
  {"insert": "Purchase Date: 2024-09-20T15:30:00Z\n"},
  {"insert": "Price: 99.99\n"},
]);

final List<TicketTypeEntity> sampleTickets = List.generate(
  100,
  (i) => TicketTypeEntity(
    ticketTypeId: 'TYPE${i + 1}',
    ticketTypeName: ticketNames[i % ticketNames.length],
    tourId: 'TOUR-${(i % 10) + 1}', // Cycle through 10 tours
    ticketPrice: double.parse((20 + Random().nextDouble() * 80)
        .toStringAsFixed(2)), // Price between 20 and 100
    ticketDescription: 'Description for ticket type ${i + 1}',
    category: TicketCategory.values[i % TicketCategory.values.length],
    quantity: Random().nextInt(20) + 1, // Quantity between 1 and 10
    ticketInfo: ticketInfo,
  ),
);
