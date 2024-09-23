import 'dart:convert';
import 'dart:math';

import 'package:travel_social_network/features/ticket/domain/entities/ticket.dart';

import '../../features/ticket/data/models/ticket_type.dart';
import '../../features/ticket/domain/entities/ticket_type.dart';
import '../../features/tour/data/models/tour.dart';
import '../enums/ticket_category.dart';

final List<String> ticketNames = [
  'Standard Ticket',
  'VIP Ticket',
  'Child Ticket',
];

final String redemptionMethodDesc = jsonEncode([
  {
    "insert":
        "You can retrieve your ticket from the self-service kiosk by entering your booking reference number.\n"
  },
  {
    "insert":
        "You will receive an SMS with your ticket code. Present the code at the venue for entry.\n"
  },
  {
    "insert":
        "A QR code will be sent to your email or available in the mobile app. Present the QR code at the entrance for entry.\n"
  },
  {
    "insert":
        "You will receive your ticket via email. Please check your inbox for a PDF attachment or a QR code.\n"
  },
  {
    "insert":
        "You will receive an SMS with your ticket code. Present the code at the venue for entry.\n"
  }
]);

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

final now = DateTime.now();

final List<TicketTypeEntity> tour1Tickets = List.generate(
  ticketNames.length,
  (i) => TicketTypeEntity(
    ticketTypeId: 'TYPE-${i + 1}',
    ticketTypeName: ticketNames[i % ticketNames.length],
    tourId: 'TOUR-1', // Cycle through 10 tours
    ticketPrice: int.parse((5000000 + Random().nextInt(1000000))
        .toString()), // Price between 20 and 100
    ticketDescription: 'Description for ticket type ${i + 1}',
    category: TicketCategory.values[i % TicketCategory.values.length],
    quantity: Random().nextInt(20) + 1, // Quantity between 1 and 10
    ticketInfo: ticketInfo,
    refundPolicyId: 'RF-1',
    reschedulePolicyId: 'RS-1',
    redemptionMethodDesc: redemptionMethodDesc,
    createdAt: now,
    date: now.add(Duration(days: i)),
  ),
);
