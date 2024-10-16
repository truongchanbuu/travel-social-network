import 'dart:math';

import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/date_time_utils.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../../policy/presentations/bloc/policy_bloc.dart';
import '../../../shared/presentations/widgets/confirm_dialog.dart';
import '../../../shared/presentations/widgets/expanded_button.dart';
import '../../../ticket/domain/entities/ticket_type.dart';
import '../../../ticket/presentations/bloc/ticket_bloc.dart';
import '../../../ticket/presentations/pages/created_tickets_page.dart';
import '../../../ticket/presentations/pages/save_ticket_page.dart';
import '../../domain/entities/tour.dart';
import '../bloc/tour_bloc.dart';
import 'date_section_button.dart';
import 'date_time_item.dart';

class CreateTourDatesSection extends StatefulWidget {
  final String tourId;
  final void Function(List<String> dates)? onSelectedDates;

  const CreateTourDatesSection({
    super.key,
    this.onSelectedDates,
    required this.tourId,
  });

  @override
  State<CreateTourDatesSection> createState() => _CreateTourDatesSectionState();
}

// TODO: CREATED_BY PROP NEEDED
class _CreateTourDatesSectionState extends State<CreateTourDatesSection> {
  bool _isExpanded = false;
  int minLines = 2;
  late int maxLines;

  List<String> dates = [];
  List<String> selectedDates = [];
  List<TicketTypeEntity> tickets = [];

  @override
  void initState() {
    super.initState();
    context.read<TicketBloc>().add(GetAllTicketsByTourId(widget.tourId));
    maxLines = minLines + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExtendedWrap(
          maxLines: maxLines,
          minLines: minLines,
          overflowWidget: _buildOverflowWidget(),
          runSpacing: 10,
          spacing: 10,
          textDirection: defaultTextDirection,
          children: List.generate(dates.length, (index) {
            return _buildDateTimeItem(dates[index], index);
          }),
        ),
        const SizedBox(height: 20),
        _buildActionButton(
          onPressed:
              selectedDates.isNotEmpty ? _navigateToCreateTicketPage : null,
          title: S.current.createTicket,
        ),
        const SizedBox(height: 20),
        BlocBuilder<TicketBloc, TicketState>(
          builder: (context, state) {
            if (state is ListOfTicketsLoaded) {
              tickets = state.tickets;
              context.read<TourBloc>().add(UpdateTourFieldEvent(
                  TourEntity.ticketIdsFieldName,
                  tickets.map((ticket) => ticket.ticketTypeId).toList()));
            }

            return _buildActionButton(
              title: '${S.current.viewAll} ${S.current.tickets}',
              backgroundColor: Colors.white,
              textColor: primaryColor,
              onPressed: tickets.isNotEmpty ? _viewAllCreatedTickets : null,
            );
          },
        ),
      ],
    );
  }

  Widget _buildActionButton({
    void Function()? onPressed,
    required String title,
    Color textColor = Colors.white,
    Color backgroundColor = primaryColor,
  }) =>
      ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          minimumSize: minBtnSize,
          padding: const EdgeInsets.all(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: textColor.withOpacity(onPressed == null ? 0.5 : 1),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      );

  Widget _buildDateTimeItem(String date, int index) {
    bool isSelected = selectedDates.contains(date);

    return DateTimeItem(
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
        widget.onSelectedDates?.call(dates);
      },
    );
  }

  Widget _buildOverflowWidget() => Row(
        children: [
          DateSectionButton(
            title: S.current.addDate,
            icon: Icons.add,
            onTap: () => _addDate(context),
          ),
          const SizedBox(width: 5),
          DateSectionButton(
            title: S.current.delete,
            icon: Icons.delete,
            textColor: selectedDates.isNotEmpty
                ? Colors.red
                : Colors.red.withOpacity(0.6),
            onTap: selectedDates.isNotEmpty ? _deleteAll : null,
          ),
          const SizedBox(width: 5),
          if (dates.length >= minLines)
            ExpandedButton(
                isExpanded: _isExpanded,
                onPressed: () {
                  if (dates.length >= minLines) {
                    setState(() {
                      _isExpanded = !_isExpanded;
                      maxLines = _isExpanded
                          ? max(maxLines, dates.length)
                          : minLines + 1;
                    });
                  }
                }),
        ],
      );

  void _addDate(BuildContext context) async {
    var data = await showBoardDateTimeMultiPicker(
      context: context,
      pickerType: DateTimePickerType.datetime,
      useSafeArea: true,
      minimumDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: maximumDay)),
      maximumDate: DateTime.now().add(const Duration(days: maximumDay)),
      options: const BoardDateTimeOptions(activeColor: primaryColor),
    );

    if (data != null && context.mounted) {
      String formatted = DateTimeUtils.formatDateRange(data.start, data.end);

      bool isIncluded = dates.any((d) => d == formatted);

      if (isIncluded) {
        showToast(
          context: context,
          S.current.inUseDateError,
          position: StyledToastPosition.center,
        );
      } else {
        setState(() {
          dates.add(formatted);
        });
        showToast(
          context: context,
          S.current.tourDateAnnounce(data.start, data.end),
          position: StyledToastPosition.center,
        );
      }
    }
  }

  void _deleteAll() async {
    var isConfirmed = await showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: S.current.deleteConfirmTitle,
        content: S.current.deleteConfirmText,
        strongActionText: S.current.delete,
        softActionText: S.current.cancel,
        onCancel: () => Navigator.pop(context, false),
        onOk: () => Navigator.pop(context, true),
      ),
    );

    if (isConfirmed != null && isConfirmed) {
      setState(() {
        for (var date in selectedDates) {
          context.read<TicketBloc>().add(DeleteTourTicketByDateEvent(
              tourId: widget.tourId, rangeDate: date));
          dates.remove(date);
        }
        selectedDates.clear();
      });
    }
  }

  void _navigateToCreateTicketPage() async {
    final TicketBloc ticketBloc = context.read<TicketBloc>();

    var data = await Navigator.push(
      context,
      PageTransition(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt.get<TicketBloc>()),
            BlocProvider(create: (context) => getIt.get<PolicyBloc>()),
          ],
          child: SaveTicketPage(
            tourId: widget.tourId,
            dates: dates,
            selectedDates: selectedDates,
          ),
        ),
        type: PageTransitionType.leftToRight,
      ),
    );

    if (data != null) {
      if (data is List<String>) {
        setState(() => selectedDates = data);
      } else if (data is List<TicketTypeEntity>) {
        ticketBloc.add(UpdateListOfTicketsEvent(data));
      }
    }
  }

  void _viewAllCreatedTickets() {
    print(tickets);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt.get<TicketBloc>()),
              BlocProvider(create: (context) => getIt.get<PolicyBloc>()),
            ],
            child: CreatedTicketsPage(tickets: tickets),
          ),
        ));
  }
}
