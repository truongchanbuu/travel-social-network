import 'dart:math';

import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/date_time_utils.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/widgets/expanded_button.dart';
import '../../../ticket/domain/entities/ticket_type.dart';
import '../../../ticket/presentations/pages/created_tickets_page.dart';
import '../../../ticket/presentations/pages/save_ticket_page.dart';
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

class _CreateTourDatesSectionState extends State<CreateTourDatesSection> {
  bool _isExpanded = false;
  int minLines = 2;
  late int maxLines;

  List<String> dates = List.empty(growable: true);
  List<String> selectedDates = List.empty(growable: true);
  List<TicketTypeEntity> tickets = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
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
        _buildActionButton(
          title: '${S.current.viewAll} ${S.current.tickets}',
          backgroundColor: Colors.white,
          textColor: primaryColor,
          onPressed: tickets.isNotEmpty ? _viewAllCreatedTickets : null,
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
          minimumSize: const Size.fromHeight(50),
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
      builder: (context) => AlertDialog(
        title: Text(S.current.deleteConfirmTitle),
        content: Text(S.current.deleteConfirmText),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              S.current.cancel,
              style: const TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              S.current.delete,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );

    if (isConfirmed) {
      setState(() {
        for (var date in selectedDates) {
          dates.remove(date);
        }
        selectedDates.clear();
      });
    }
  }

  void _navigateToCreateTicketPage() async {
    var data = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SaveTicketPage(
                tourId: widget.tourId,
                dates: dates,
                selectedDates: selectedDates,
              )),
    );

    if (data is List<String>) {
      setState(() => selectedDates = data);
    } else {
      setState(() => tickets = data);
    }
  }

  void _viewAllCreatedTickets() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CreatedTicketsPage(tickets: tickets)));
  }
}
