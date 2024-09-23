import 'package:flutter/material.dart';

import '../../../../../cores/constants/constants.dart';
import '../../../../cores/utils/currency_util.dart';
import '../../domain/entities/ticket_type.dart';
import '../pages/add_number_visitor_page.dart';
import '../pages/ticket_detail_page.dart';
import 'ticket_brief_info.dart';

class TicketItem extends StatelessWidget {
  final TicketTypeEntity ticket;
  final DateTime? selectedDate;

  const TicketItem({
    super.key,
    required this.ticket,
    this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    bool isOverflowed = MediaQuery.of(context).size.width < 260;

    return GestureDetector(
      onTap: () => _showDetailTicketPage(context),
      child: Container(
        key: ValueKey(
            'TICKET-${ticket.tourId}-${ticket.ticketTypeId}-${ticket.date}'),
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
              isPaddingTitle: false,
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
                    CurrencyUtils.formatCurrency(ticket.ticketPrice),
                    style: const TextStyle(
                      color: currencyTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  if (!isOverflowed) _buildSelectButton(context),
                ],
              ),
            ),
            if (isOverflowed) ...[
              const SizedBox(height: 10),
              _buildSelectButton(context),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildSelectButton(BuildContext context) {
    return TextButton(
      onPressed: () => _navigateToAddTicketPage(context),
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
        builder: (context) => TicketDetailPage(
          ticketId: ticket.ticketTypeId,
          selectedDate: selectedDate,
        ),
      ),
    );
  }

  void _navigateToAddTicketPage(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddNumberVisitorPage(
            ticketId: ticket.ticketTypeId,
            selectedDate: selectedDate,
          ),
        ),
      );
}
