import 'package:flutter/material.dart';
import 'package:travel_social_network/cores/constants/tickets.dart';

import '../../../../../cores/constants/constants.dart';
import '../../domain/entities/ticket_type.dart';
import '../pages/ticket_detail_page.dart';
import 'ticket_brief_info.dart';

class TicketItem extends StatefulWidget {
  final String ticketId;
  const TicketItem({super.key, required this.ticketId});

  @override
  State<TicketItem> createState() => _TicketItemState();
}

class _TicketItemState extends State<TicketItem> {
  late final TicketTypeEntity ticket;

  @override
  void initState() {
    super.initState();
    ticket = sampleTickets
        .where((ticket) => ticket.ticketTypeId == widget.ticketId)
        .first;
  }

  @override
  Widget build(BuildContext context) {
    bool isOverflowed = MediaQuery.of(context).size.width < 260;

    return GestureDetector(
      onTap: () => _showDetailTicketPage(context),
      child: Container(
        key: ValueKey('TICKET-${ticket.tourId}-${ticket.ticketTypeId}'),
        width: ticketItemWidth,
        margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
        decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: Colors.grey),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TicketBriefInfo(
              ticketName: ticket.ticketTypeName,
              ticketCategory: ticket.category.name.toUpperCase(),
              ticketDescription: ticket.ticketDescription,
            ),
            const SizedBox(height: 5),
            const Text(
              'See detail',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const Divider(color: Colors.grey, thickness: 0.5),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => debugPrint('PRICE DETAIL'),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'VND ${ticket.ticketPrice}',
                    style: const TextStyle(
                      color: currencyTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  if (!isOverflowed) _buildSelectButton(),
                ],
              ),
            ),
            if (isOverflowed) ...[
              const SizedBox(height: 10),
              _buildSelectButton(),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildSelectButton() {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
        elevation: 5,
        backgroundColor: primaryColor,
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 30,
        ),
      ),
      child: const Text(
        'Select',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  void _showDetailTicketPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TicketDetailPage(ticketId: widget.ticketId),
      ),
    );
  }
}
