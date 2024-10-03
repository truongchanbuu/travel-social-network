import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:travel_social_network/features/shared/widgets/app_progressing_indicator.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/enums/ticket_category.dart';
import '../../../../cores/utils/date_time_utils.dart';
import '../../../../generated/l10n.dart';
import '../../../policy/presentations/bloc/policy_bloc.dart';
import '../../../tour/presentations/widgets/date_time_item.dart';
import '../../data/models/ticket_type.dart';
import '../../domain/entities/ticket_type.dart';
import '../bloc/ticket_bloc.dart';
import '../coordinator/ticket_creation_coordinator.dart';
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
  List<String> dates = List.empty(growable: true);
  List<String> selectedDates = List.empty(growable: true);

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
            if (state is TicketCreating || state is TicketUpdating) {
              return const AppProgressingIndicator();
            }

            return _buildBody();
          },
          listener: (context, state) {
            if (state is ListOfTicketSaveSuccess) {
              Navigator.pop(context, state.tickets);
            } else if (state is TicketFailure) {
              showToast(state.message, context: context);
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
                .toList()),
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

  AppBar _buildAppBar() => AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: _backToPrevious,
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          GestureDetector(
            onTap: widget.ticket != null
                ? () => _saveTicket(context)
                : () => validateTicketForm(context),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                S.current.save.toUpperCase(),
                style: const TextStyle(
                  color: primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      );

  void _backToPrevious() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          S.current.discardUnsavedWork,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        content: Text(S.current.discardAlertMessage),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                S.current.stay,
                style: const TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              )),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context, selectedDates);
              },
              child: Text(
                S.current.leave,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ],
      ),
    );
  }

  Future<void> validateTicketForm(BuildContext context) async {
    if (!_isFormValid()) return;

    TicketTypeEntity generalTicket = _getFormData();
    List<TicketTypeEntity> tickets = [];

    for (var date in selectedDates) {
      var ticket = await _createTicketForDate(generalTicket, date);

      if (ticket != null) {
        tickets.add(ticket);
      }
    }

    if (tickets.isNotEmpty && context.mounted) {
      final TicketCreationCoordinator ticketCreationCoordinator =
          TicketCreationCoordinator(
              policyBloc: context.read<PolicyBloc>(),
              ticketBloc: context.read<TicketBloc>());

      // String message = await ticketCreationCoordinator.createPolicyAndTickets(
      //   [refundPolicy!, reschedulePolicy!].map(Policy.fromEntity).toList(),
      //   tickets.map(TicketType.fromEntity).toList(),
      // );

      // if (context.mounted) {
      //   showToast(message, context: context);
      // }
    }
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

  Future<TicketTypeEntity?> _createTicketForDate(
      TicketTypeEntity generalTicket, String date) async {
    var [startDateTime, endDateTime] = DateTimeUtils.parseDateTimeRange(date);

    var existingTicket =
        _findDuplicateTicket(generalTicket, startDateTime, endDateTime);

    if (existingTicket != null) {
      bool shouldContinue = await _handleDuplicateTicket(generalTicket);
      if (!shouldContinue) return null;
    }

    return TicketTypeEntity.defaultWithId().copyWith(
      ticketTypeName: generalTicket.ticketTypeName,
      ticketDescription: generalTicket.ticketDescription,
      quantity: generalTicket.quantity,
      redemptionMethodDesc: generalTicket.redemptionMethodDesc,
      ticketInfo: generalTicket.ticketInfo,
      ticketPrice: generalTicket.ticketPrice,
      category: generalTicket.category,
      tourId: widget.tourId,
      startDate: startDateTime,
      endDate: endDateTime,
      createdAt: DateTime.now(),
      refundPolicyId: generalTicket.refundPolicyId,
      reschedulePolicyId: generalTicket.reschedulePolicyId,
    );
  }

  TicketTypeEntity? _findDuplicateTicket(
      TicketTypeEntity ticket, DateTime start, DateTime end) {
    List<TicketTypeEntity> potentialDuplicates =
        fetchDuplicatedTickets(ticket.ticketTypeName, ticket.category);
    return potentialDuplicates.firstWhereOrNull((t) =>
        DateTimeUtils.isSameDateTimeWithoutSecond(t.startDate, start) &&
        DateTimeUtils.isSameDateTimeWithoutSecond(t.endDate, end));
  }

  Future<bool> _handleDuplicateTicket(TicketTypeEntity ticket) async {
    return await showDialog(
      context: context,
      useSafeArea: true,
      builder: (context) => AlertDialog(
        title: Text(
          S.current.duplicateTicketAlert(
            ticket.ticketTypeName,
            ticket.category.name.toUpperCase(),
          ),
        ),
        content: Text(S.current.duplicateTicketMessage),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(
                S.current.cancel,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              )),
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text(
                'OK',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ))
        ],
      ),
    );
  }

  List<TicketTypeEntity> fetchDuplicatedTickets(
      String name, TicketCategory category) {
    return [];
  }

  void _saveTicket(BuildContext context) {
    final changedTicket = _getFormData();
    if (_isTicketChanged(changedTicket)) {
      // _updatePolicy();
      context.read<TicketBloc>().add(UpdateTicketEvent(
            id: widget.ticket!.ticketTypeId,
            newTicket: TicketType.fromEntity(widget.ticket!.copyWith(
              ticketTypeName: changedTicket.ticketTypeId,
              ticketPrice: changedTicket.ticketPrice,
              refundPolicyId: changedTicket.refundPolicyId,
              reschedulePolicyId: changedTicket.reschedulePolicyId,
              redemptionMethodDesc: changedTicket.redemptionMethodDesc,
              ticketDescription: changedTicket.ticketDescription,
              quantity: changedTicket.quantity,
              category: changedTicket.category,
              updatedAt: DateTime.now(),
              ticketInfo: changedTicket.ticketInfo,
            )),
          ));
    }
  }

  bool _isTicketChanged(TicketTypeEntity changedTicket) {
    return changedTicket.ticketTypeName != widget.ticket!.ticketTypeName ||
        changedTicket.ticketDescription != widget.ticket!.ticketDescription ||
        changedTicket.redemptionMethodDesc !=
            widget.ticket!.redemptionMethodDesc ||
        changedTicket.ticketInfo != widget.ticket!.ticketInfo ||
        changedTicket.category != widget.ticket!.category ||
        changedTicket.ticketPrice != widget.ticket!.ticketPrice ||
        changedTicket.quantity != widget.ticket!.quantity;
  }

  // void _updatePolicy() {
  //   if (refundPolicy!.policyId != widget.ticket!.refundPolicyId) {
  //     context.read<PolicyBloc>().add(
  //           UpdatePolicyEvent(
  //             id: widget.ticket!.refundPolicyId,
  //             policy: Policy.fromEntity(refundPolicy!),
  //           ),
  //         );
  //   }
  //
  //   if (reschedulePolicy!.policyId != widget.ticket!.reschedulePolicyId) {
  //     context.read<PolicyBloc>().add(
  //           UpdatePolicyEvent(
  //             id: widget.ticket!.reschedulePolicyId,
  //             policy: Policy.fromEntity(reschedulePolicy!),
  //           ),
  //         );
  //   }
  // }

  Future<void> _deleteTicket(BuildContext context) async {
    bool confirmed = await _confirmDeletion(context);

    if (confirmed) {
      // TODO: Confirm => Delete Ticket in DB and back to previous page
    }
  }

  Future<bool> _confirmDeletion(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          S.current.deleteConfirmTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        content: Text(S.current.deleteConfirmText),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              S.current.cancel,
              style: const TextStyle(
                  color: primaryColor, fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(
                S.current.delete,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ))
        ],
      ),
    );
  }
}
