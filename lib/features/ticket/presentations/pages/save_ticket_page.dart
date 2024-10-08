import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/date_time_utils.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/presentations/widgets/app_progressing_indicator.dart';
import '../../../shared/presentations/widgets/confirm_deletion_dialog.dart';
import '../../../shared/presentations/widgets/confirm_dialog.dart';
import '../../../shared/presentations/widgets/default_white_appabar.dart';
import '../../../shared/presentations/widgets/save_button.dart';
import '../../../tour/presentations/widgets/date_time_item.dart';
import '../../domain/entities/ticket_type.dart';
import '../bloc/ticket_bloc.dart';
import '../widgets/create_ticket_section.dart';

class SaveTicketPage extends StatefulWidget {
  final TicketTypeEntity? ticket;
  final String tourId;
  final List<String> dates;
  final List<String> selectedDates;

  const SaveTicketPage({
    super.key,
    required this.tourId,
    required this.dates,
    required this.selectedDates,
    this.ticket,
  });

  @override
  State<SaveTicketPage> createState() => _SaveTicketPageState();
}

class _SaveTicketPageState extends State<SaveTicketPage> {
  late final GlobalKey<CreateTicketSectionState> ticketFormKey;
  List<String> dates = [];
  List<String> selectedDates = [];

  @override
  void initState() {
    super.initState();
    dates = widget.dates;
    selectedDates = widget.ticket != null
        ? [
            DateTimeUtils.formatDateRange(
                widget.ticket!.startDate, widget.ticket!.endDate)
          ]
        : widget.selectedDates;
    ticketFormKey = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: BlocConsumer<TicketBloc, TicketState>(
          builder: (context, state) {
            if (state is TicketActionLoading) {
              return const AppProgressingIndicator();
            }

            return _buildBody();
          },
          listener: (context, state) {
            if (state is ListOfTicketsSuccess || state is TicketActionSuccess) {
              showToast(S.current.success, context: context);
              if (state is ListOfTicketsSuccess) {
                Navigator.pop(context, state.tickets);
              } else if (state is TicketActionSuccess) {
                Navigator.pop(context, state.ticket);
              }
            } else if (state is TicketFailure) {
              showToast(state.message, context: context);
            } else if (state is TicketsGenerated) {
              if (state.invalidTickets.isNotEmpty) {
                _handleDuplicateTicket(state);
              } else {
                _createTickets(state.validTickets);
              }
            }
          },
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding,
            vertical: 5,
          ),
          child: Text(
            '${S.current.selectedDate}s'.toUpperCase(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textDirection: defaultTextDirection,
            overflow: defaultTextOverflow,
          ),
        ),
        _buildSelectedDateList(),
        Expanded(
          child: CreateTicketSection(
            key: ticketFormKey,
            tourId: widget.tourId,
            ticket: widget.ticket,
          ),
        )
      ],
    );
  }

  Widget _buildSelectedDateList() => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: (widget.ticket != null ? selectedDates : dates)
              .map(_buildDateItem)
              .toList(),
        ),
      );

  Widget _buildDateItem(String date) {
    bool isSelected =
        widget.ticket != null ? true : selectedDates.contains(date);

    return Padding(
      padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10, left: 5),
      child: DateTimeItem(
        date: date,
        isSelected: isSelected,
        onTap: () {
          setState(() {
            if (!isSelected) {
              selectedDates.add(date);
            } else {
              if (widget.ticket != null) {
                _deleteTicket(context);
              }

              selectedDates.remove(date);
            }
          });
        },
      ),
    );
  }

  AppBar _buildAppBar() => defaultWhiteAppBar(
        onBack: _backToPrevious,
        actions: [
          SaveButton(
            onTap: widget.ticket != null
                ? () => _saveTicket(context)
                : () => validateTicketForm(context),
          )
        ],
      );

  void _backToPrevious() {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        onOk: () {
          _deletePolicy();
          Navigator.of(context)
            ..pop()
            ..pop(selectedDates);
        },
      ),
    );
  }

  void validateTicketForm(BuildContext context) async {
    if (!_isFormValid()) return;

    final TicketTypeEntity generalTicket = _getFormData();

    context
        .read<TicketBloc>()
        .add(GenerateListOfTicketsEvent(generalTicket, selectedDates));
  }

  bool _isFormValid() {
    final isValidated = ticketFormKey.currentState?.validateForm() ?? false;

    if (!isValidated) {
      showToast(
        S.current.invalidForm,
        context: context,
      );

      return false;
    }

    return true;
  }

  TicketTypeEntity _getFormData() {
    return ticketFormKey.currentState!.getData();
  }

  Future<void> _handleDuplicateTicket(TicketsGenerated state) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.current.duplicateTicketAlert),
        content: Text(S.current.duplicateTicketMessage),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _createTickets(state.validTickets);
            },
            child: Text(
              S.current.continueLabel,
              style: const TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              showToast(S.current.createTicketError, context: context);
            },
            child: Text(
              S.current.stop,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  void _saveTicket(BuildContext context) {
    final TicketTypeEntity changedTicket = _getFormData();

    context.read<TicketBloc>().add(UpdateTicketEvent(
          oldTicket: widget.ticket!,
          newTicket: changedTicket,
        ));
  }

  void _createTickets(List<TicketTypeEntity> tickets) {
    if (tickets.isEmpty) {
      _deletePolicy();
    }

    context.read<TicketBloc>().add(CreateListOfTicketsEvent(tickets));
  }

  Future<void> _deleteTicket(BuildContext context) async {
    final TicketBloc ticketBloc = context.read<TicketBloc>();
    bool confirmed = await confirmDeletion(context);

    if (confirmed) {
      ticketBloc.add(DeleteTicketEvent(widget.ticket!.ticketTypeId));
    }
  }

  void _deletePolicy() {
    ticketFormKey.currentState?.deletePolicy();
  }
}
