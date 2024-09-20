import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

import '../../../../../cores/constants/constants.dart';
import '../../../../../cores/utils/date_time_utils.dart';

class AvailableDateList extends StatefulWidget {
  final DateTime? selectedDate;
  final void Function(DateTime? date) onSelectDate;
  const AvailableDateList({
    super.key,
    required this.onSelectDate,
    this.selectedDate,
  });

  @override
  State<AvailableDateList> createState() => _AvailableDateListState();
}

class _AvailableDateListState extends State<AvailableDateList> {
  late final ScrollController _scrollController;

  List<DateTime> availableDates = List.empty(growable: true);

  double _itemWidth = 60;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    availableDates = [
      DateTime(2024, 10, 10),
      DateTime(2024, 10, 15),
      DateTime(2024, 10, 22),
      DateTime(2024, 11, 1),
      DateTime(2024, 11, 5),
      DateTime(2024, 12, 6),
      DateTime(2024, 12, 9),
    ];

    if (widget.selectedDate != null) {
      WidgetsFlutterBinding.ensureInitialized()
          .addPostFrameCallback((_) => _scrollToDate());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToDate() {
    if (widget.selectedDate == null) return;
    int itemIndex = availableDates.indexOf(widget.selectedDate!);
    if (itemIndex == -1) return;

    double position = itemIndex * _itemWidth;

    _scrollController.animateTo(
      position,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  void didUpdateWidget(covariant AvailableDateList oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsFlutterBinding.ensureInitialized()
        .addPostFrameCallback((_) => _scrollToDate());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
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
        onTap: _showDatePicker,
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

  // TODO: Can be optimized
  Widget _buildAvailableDate() {
    return Expanded(
      child: LayoutBuilder(builder: (context, constraints) {
        _itemWidth = (constraints.maxWidth / availableDates.length + (2 * 10))
            .ceil()
            .toDouble();

        return SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          child: Row(
            children: availableDates.map(_buildAvailableDateItem).toList(),
          ),
        );
      }),
    );
  }

  Widget _buildAvailableDateItem(DateTime date) {
    bool isSameDate = widget.selectedDate != null &&
        DateTimeUtils.isToday(widget.selectedDate!);

    const double borderWidth = 1;

    return GestureDetector(
      key: ValueKey(date.toString()),
      onTap: () => widget.onSelectDate(date),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              spreadRadius: 1,
              color: Colors.grey.withOpacity(0.2),
            ),
          ],
          border: isSameDate
              ? Border.all(
                  color: primaryColor,
                  width: borderWidth,
                )
              : Border.all(
                  width: borderWidth, color: Colors.grey.withOpacity(0.3)),
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
              DateTimeUtils.formatDate(date),
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

  void _showDatePicker() async {
    var selectedDate = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        allowSameValueSelection: false,
        currentDate: widget.selectedDate,
        firstDate: availableDates.first,
        lastDate: availableDates.last,
        calendarViewMode: CalendarDatePicker2Mode.day,
        calendarType: CalendarDatePicker2Type.single,
        selectedDayHighlightColor: primaryColor,
        selectableDayPredicate: (day) => availableDates.contains(day),
      ),
      dialogSize: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height * 0.5),
    );

    if ((selectedDate?.isNotEmpty ?? false) &&
        widget.selectedDate != selectedDate?.first) {
      widget.onSelectDate(selectedDate?.first);
    }
  }
}
