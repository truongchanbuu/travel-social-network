import 'package:flutter/material.dart';

import 'available_date_list.dart';
import 'ticket_grid_view.dart';
import 'tour_bottom_sheet_template.dart';

class TicketBottomSheet extends StatefulWidget {
  final List<String> tickets;
  final DateTime? selectedDate;
  final void Function(DateTime? date) onSelectDate;
  const TicketBottomSheet({
    super.key,
    required this.tickets,
    required this.onSelectDate,
    this.selectedDate,
  });

  @override
  State<TicketBottomSheet> createState() => _TicketBottomSheetState();
}

class _TicketBottomSheetState extends State<TicketBottomSheet> {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return TourBottomSheetTemplate(
      title: 'Ticket Booking',
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: AvailableDateList(
            onSelectDate: (date) {
              widget.onSelectDate(date);
              setState(() {
                if (date == selectedDate) {
                  selectedDate = null;
                } else {
                  selectedDate = date;
                }
              });
            },
            selectedDate: selectedDate,
          ),
        ),
        Expanded(
          child: TicketGridView(
            tickets: widget.tickets,
            scrollable: true,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
