import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../../cores/utils/date_time_utils.dart';
import '../../../../generated/l10n.dart';
import '../../../tour/presentation/widgets/date_time_item.dart';
import '../../domain/entities/ticket_type.dart';
import '../widgets/ticket_brief_info.dart';
import 'save_ticket_page.dart';

class CreatedTicketsPage extends StatefulWidget {
  final List<TicketTypeEntity> tickets;
  const CreatedTicketsPage({super.key, required this.tickets});

  @override
  State<CreatedTicketsPage> createState() => _CreatedTicketsPageState();
}

class _CreatedTicketsPageState extends State<CreatedTicketsPage> {
  List<TicketTypeEntity> tickets = List.empty(growable: true);
  List<String> dateRanges = List.empty(growable: true);
  List<String> selectedDateRange = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    tickets = widget.tickets;
    dateRanges = tickets
        .map((ticket) =>
            DateTimeUtils.formatDateRange(ticket.startDate, ticket.endDate))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          S.current.ticketList,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          child: Row(children: dateRanges.map(_buildDateTimeItem).toList()),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.separated(
            itemBuilder: _buildTicketItem,
            itemCount: tickets.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
          ),
        )
      ],
    );
  }

  Widget _buildDateTimeItem(String date) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: DateTimeItem(
        date: date,
        isSelected: selectedDateRange.contains(date),
        onTap: () => setState(
          () {
            if (selectedDateRange.contains(date)) {
              selectedDateRange.remove(date);
            } else {
              selectedDateRange.add(date);
            }

            tickets = _getTicketsByDates();
          },
        ),
      ),
    );
  }

  Widget _buildTicketItem(BuildContext context, int index) => GestureDetector(
        onTap: () => _updateTicket(tickets[index]),
        child: TicketBriefInfo(
          ticketName: tickets[index].ticketTypeName,
          ticketDescription: '',
          ticketCategory:
              tickets[index].category.name.replaceAll('_', ' ').toUpperCase(),
          trailing: GestureDetector(
              onTap: () => _deleteTicket, child: const Icon(Icons.delete)),
        ),
      );

  List<TicketTypeEntity> _getTicketsByDates() {
    if (selectedDateRange.isEmpty) return widget.tickets;
    List<TicketTypeEntity> ticketsByDates = List.empty(growable: true);

    for (var date in selectedDateRange) {
      var [startDate, endDate] = DateTimeUtils.parseDateTimeRange(date);

      var foundTicket = widget.tickets.firstWhereOrNull((ticket) =>
          DateTimeUtils.isSameDateTimeWithoutSecond(
              ticket.startDate, startDate) &&
          DateTimeUtils.isSameDateTimeWithoutSecond(ticket.endDate, endDate));

      if (foundTicket != null) ticketsByDates.add(foundTicket);
    }

    return ticketsByDates;
  }

  void _updateTicket(TicketTypeEntity ticket) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SaveTicketPage(
            ticket: ticket,
            tourId: ticket.tourId,
            dates: const [],
            selectedDates: const [],
          ),
        ),
      );

  void _deleteTicket() {
    // TODO: DELETE TICKET
  }
}
