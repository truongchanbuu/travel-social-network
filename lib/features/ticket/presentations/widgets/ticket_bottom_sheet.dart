import 'package:flutter/material.dart';

import '../../../tour/presentation/widgets/tour_bottom_sheet_template.dart';
import '../../domain/entities/ticket_type.dart';
import 'available_date_list.dart';
import 'ticket_grid_view.dart';

class TicketBottomSheet extends StatefulWidget {
  final List<TicketTypeEntity> tickets;
  final DateTime? selectedDate;
  final List<DateTime> availableDates;

  final void Function(DateTime? date) onSelectDate;
  const TicketBottomSheet({
    super.key,
    required this.tickets,
    required this.onSelectDate,
    required this.availableDates,
    this.selectedDate,
  });

  @override
  State<TicketBottomSheet> createState() => _TicketBottomSheetState();
}

class _TicketBottomSheetState extends State<TicketBottomSheet> {
  DateTime? selectedDate;
  List<DateTime> availableDates = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    selectedDate = widget.selectedDate;
    availableDates = widget.availableDates;
  }

  @override
  Widget build(BuildContext context) {
    return TourBottomSheetTemplate(
      title: 'Ticket Booking',
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: AvailableDateList(
            availableDates: availableDates,
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
