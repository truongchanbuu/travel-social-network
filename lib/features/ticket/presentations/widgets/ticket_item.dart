import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cores/constants/constants.dart';
import '../../../../config/themes/app_theme.dart';
import '../../../../cores/utils/currency_helper.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../../policy/presentations/bloc/policy_bloc.dart';
import '../../../tour/presentations/bloc/tour_bloc.dart';
import '../../domain/entities/ticket_type.dart';
import '../bloc/ticket_bloc.dart';
import '../pages/add_number_visitor_page.dart';
import '../pages/ticket_detail_page.dart';

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
            'TICKET-${ticket.tourId}-${ticket.ticketTypeId}-${ticket.startDate}'),
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
            Text(
              '${ticket.ticketTypeName} - ${S.current.forType(ticket.category.name).toUpperCase()}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textDirection: defaultTextDirection,
              overflow: defaultTextOverflow,
              maxLines: 2,
            ),
            const SizedBox(height: 5),
            Text(
              '${S.current.see} ${S.current.detail}',
              style: const TextStyle(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            const Divider(color: Colors.grey, thickness: 0.5),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  CurrencyHelper.formatCurrency(ticket.ticketPrice),
                  style: const TextStyle(
                    color: AppTheme.currencyTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                if (!isOverflowed) _buildSelectButton(context),
              ],
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
        backgroundColor: AppTheme.primaryColor,
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 30,
        ),
      ),
      child: Text(
        S.current.select,
        textAlign: TextAlign.center,
        style: const TextStyle(
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
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt.get<TicketBloc>()),
            BlocProvider(create: (context) => getIt.get<PolicyBloc>()),
            BlocProvider(create: (context) => getIt.get<TourBloc>())
          ],
          child: TicketDetailPage(
            ticketId: ticket.ticketTypeId,
            selectedDate: selectedDate,
          ),
        ),
      ),
    );
  }

  void _navigateToAddTicketPage(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt.get<TicketBloc>()),
              BlocProvider(create: (context) => getIt.get<PolicyBloc>()),
            ],
            child: AddNumberVisitorPage(
              ticketId: ticket.ticketTypeId,
              selectedDate: selectedDate,
            ),
          ),
        ),
      );
}
