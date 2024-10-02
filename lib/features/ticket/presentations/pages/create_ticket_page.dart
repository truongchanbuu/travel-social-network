import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/enums/ticket_category.dart';
import '../../../../cores/utils/date_time_utils.dart';
import '../../../../generated/l10n.dart';
import '../../../tour/presentation/widgets/date_time_item.dart';
import '../../domain/entities/policy.dart';
import '../../domain/entities/ticket_type.dart';
import '../widgets/create_policy_section.dart';
import '../widgets/create_ticket_section.dart';

class CreateTicketPage extends StatefulWidget {
  final String tourId;
  final List<String> dates;
  final List<String> selectedDates;

  const CreateTicketPage({
    super.key,
    required this.tourId,
    required this.dates,
    required this.selectedDates,
  });

  @override
  State<CreateTicketPage> createState() => _CreateTicketPageState();
}

class _CreateTicketPageState extends State<CreateTicketPage> {
  late final GlobalKey<CreateTicketSectionState> ticketFormKey;
  List<String> dates = List.empty(growable: true);
  List<String> selectedDates = List.empty(growable: true);

  late PolicyEntity refundPolicy;
  late PolicyEntity reschedulePolicy;

  @override
  void initState() {
    super.initState();
    dates = widget.dates;
    selectedDates = widget.selectedDates;

    refundPolicy = PolicyEntity.nonRefundable(policyDescription: '');
    reschedulePolicy = PolicyEntity.cannotReschedule(policyDescription: '');

    ticketFormKey = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding,
            vertical: defaultPadding,
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                CreateTicketSection(key: ticketFormKey),
                CreatePolicySection(
                  refundPolicy: refundPolicy,
                  reschedulePolicy: reschedulePolicy,
                  onSaved: (refundPolicy, reschedulePolicy) {
                    this.refundPolicy = refundPolicy;
                    this.reschedulePolicy = reschedulePolicy;
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildSelectedDateList() {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => _buildDateItem(dates[index]),
        itemCount: dates.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
      ),
    );
  }

  Widget _buildDateItem(String date) {
    bool isSelected = selectedDates.contains(date);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5,
          color: Colors.grey,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(999)),
      ),
      child: DateTimeItem(
        date: date,
        isSelected: isSelected,
        onTap: () {
          setState(() {
            if (!isSelected) {
              selectedDates.add(date);
            } else {
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
            onTap: () => validateTicketForm(context),
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Text(
                S.current.save.toUpperCase(),
                style: const TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
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

    if (context.mounted) {
      Navigator.pop(context, tickets);
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
      refundPolicyId: refundPolicy.policyId,
      reschedulePolicyId: reschedulePolicy.policyId,
    );
  }

  TicketTypeEntity? _findDuplicateTicket(
      TicketTypeEntity ticket, DateTime start, DateTime end) {
    List<TicketTypeEntity> potentialDuplicates =
        fetchDuplicatedTickets(ticket.ticketTypeName, ticket.category);
    return potentialDuplicates
        .firstWhereOrNull((t) => t.startDate == start && t.endDate == end);
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
}
