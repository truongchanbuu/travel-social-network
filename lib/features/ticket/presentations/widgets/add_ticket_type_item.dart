import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../../../shared/widgets/item_counter.dart';
import '../../domain/entities/ticket_type.dart';

class AddTicketTypeItem extends StatelessWidget {
  final TicketTypeEntity ticket;
  const AddTicketTypeItem({
    super.key,
    required this.ticket,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ticket.category.name.toUpperCase(),
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          Text(
            'VND ${ticket.ticketPrice}',
            style: const TextStyle(
              color: currencyTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
      trailing: const ItemCounter(),
    );
  }
}
