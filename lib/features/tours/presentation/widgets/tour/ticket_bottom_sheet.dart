import 'package:flutter/material.dart';

import '../../../../../cores/constants/constants.dart';
import 'available_date_list.dart';
import 'ticket_grid_view.dart';

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
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.5, color: Colors.grey),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: const Center(
              child: Text(
                'Tickets Booking',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.zero,
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
      ),
    );
  }
}
