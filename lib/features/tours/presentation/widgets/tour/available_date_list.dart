import 'package:flutter/material.dart';

import '../../../../../cores/constants/constants.dart';
import '../../../../../cores/utils/date_time_utils.dart';

class AvailableDateList extends StatefulWidget {
  final DateTime? selectedDate;
  final Function(DateTime date) onSelectDate;
  const AvailableDateList({
    super.key,
    required this.onSelectDate,
    this.selectedDate,
  });

  @override
  State<AvailableDateList> createState() => _AvailableDateListState();
}

class _AvailableDateListState extends State<AvailableDateList> {
  List<DateTime> availableDates = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    availableDates = [
      DateTime(2024, 10, 10),
      DateTime(2024, 10, 15),
      DateTime(2024, 10, 22),
      DateTime(2024, 11, 1),
      DateTime(2024, 11, 5),
      DateTime(2024, 12, 6),
      DateTime(2024, 12, 9),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          _buildDatePicker(),
          _buildAvailableDate(),
        ],
      ),
    );
  }

  Widget _buildDatePicker() {
    const BorderRadius borderRadius = BorderRadius.all(Radius.circular(10));
    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      child: InkWell(
        borderRadius: borderRadius,
        onTap: () => debugPrint('Select Date'),
        child: const Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            children: [
              Icon(Icons.calendar_month),
              Icon(Icons.keyboard_arrow_down),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvailableDate() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: availableDates.map(_buildAvailableDateItem).toList(),
        ),
      ),
    );
  }

  Widget _buildAvailableDateItem(DateTime date) {
    bool isSameDate = widget.selectedDate != null &&
        widget.selectedDate!.compareTo(date) == 0;

    const double borderWidth = 1;

    return GestureDetector(
      onTap: () => widget.onSelectDate(date),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [detailSectionBoxShadow],
          border: isSameDate
              ? Border.all(
                  color: primaryColor,
                  width: borderWidth,
                )
              : Border.all(width: borderWidth, color: Colors.transparent),
        ),
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            Text(
              DateTimeUtils.getWeekdays(date),
              style: TextStyle(
                color: isSameDate ? primaryColor : Colors.black,
              ),
            ),
            Text(
              DateTimeUtils.formatDateTime(date),
              style: TextStyle(
                color: isSameDate ? primaryColor : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
