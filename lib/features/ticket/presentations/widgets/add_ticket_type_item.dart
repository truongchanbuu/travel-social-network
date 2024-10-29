import 'package:flutter/material.dart';

import '../../../../config/themes/app_theme.dart';
import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/currency_helper.dart';
import '../../../shared/presentations/widgets/item_counter.dart';
import '../../domain/entities/ticket_type.dart';

class AddTicketTypeItem extends StatelessWidget {
  final TicketTypeEntity ticket;
  final void Function(int value) onChange;

  const AddTicketTypeItem({
    super.key,
    required this.ticket,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        boxShadow: [detailSectionBoxShadow],
      ),
      alignment: Alignment.center,
      child: ListTile(
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
              CurrencyHelper.formatCurrency(ticket.ticketPrice),
              style: const TextStyle(
                color: AppTheme.currencyTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        trailing: ItemCounter(onChange: onChange, maxValue: ticket.quantity),
      ),
    );
  }
}
