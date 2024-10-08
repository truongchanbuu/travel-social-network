import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../cores/utils/date_time_utils.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../../policy/presentations/bloc/policy_bloc.dart';
import '../../../shared/presentations/widgets/confirm_deletion_dialog.dart';
import '../../../shared/presentations/widgets/default_white_appabar.dart';
import '../../../tour/presentations/widgets/date_time_item.dart';
import '../../domain/entities/ticket_type.dart';
import '../bloc/ticket_bloc.dart';
import '../widgets/ticket_brief_info.dart';
import 'save_ticket_page.dart';

class CreatedTicketsPage extends StatefulWidget {
  final List<TicketTypeEntity> tickets;
  const CreatedTicketsPage({super.key, required this.tickets});

  @override
  State<CreatedTicketsPage> createState() => _CreatedTicketsPageState();
}

class _CreatedTicketsPageState extends State<CreatedTicketsPage> {
  List<TicketTypeEntity> tickets = [];
  List<String> dateRanges = [];
  List<String> selectedDateRange = [];

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
    return SafeArea(
      child: Scaffold(
        appBar: defaultWhiteAppBar(titleText: S.current.ticketList),
        body: BlocBuilder<TicketBloc, TicketState>(
          builder: (context, state) {
            if (state is TicketDeleted) {
              tickets.remove(state.ticket);
            }

            return _buildBody();
          },
        ),
      ),
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
          ticketCategory: cleanTicketTypeEnum(tickets[index].category.name),
          trailing: GestureDetector(
              onTap: () => _deleteTicket(tickets[index]),
              child: const Icon(Icons.delete)),
        ),
      );

  List<TicketTypeEntity> _getTicketsByDates() {
    if (selectedDateRange.isEmpty) return widget.tickets;
    List<TicketTypeEntity> ticketsByDates = [];

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
        PageTransition(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt.get<TicketBloc>()),
              BlocProvider(create: (context) => getIt.get<PolicyBloc>()),
            ],
            child: SaveTicketPage(
              ticket: ticket,
              tourId: ticket.tourId,
              dates: const [],
              selectedDates: const [],
            ),
          ),
          type: PageTransitionType.leftToRight,
        ),
      );

  void _deleteTicket(TicketTypeEntity ticket) async {
    final TicketBloc ticketBloc = context.read<TicketBloc>();
    bool confirmed = await confirmDeletion(context);
    if (confirmed) {
      ticketBloc.add(DeleteTicketEvent(ticket.ticketTypeId));
    }
  }

  String cleanTicketTypeEnum(String name) {
    return name.replaceAll('_', ' ').toUpperCase();
  }
}
