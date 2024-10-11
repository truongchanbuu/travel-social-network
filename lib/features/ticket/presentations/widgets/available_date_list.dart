import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/date_time_utils.dart';
import '../../../../generated/l10n.dart';

class AvailableDateList extends StatefulWidget {
  final List<DateTime> availableDates;
  final DateTime? selectedDate;
  final void Function(DateTime? date) onSelectDate;

  const AvailableDateList({
    super.key,
    required this.availableDates,
    required this.onSelectDate,
    this.selectedDate,
  });

  @override
  State<AvailableDateList> createState() => _AvailableDateListState();
}

class _AvailableDateListState extends State<AvailableDateList> {
  late final ScrollController _scrollController;

  List<DateTime> availableDates = [];

  double _itemWidth = 60;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    availableDates = widget.availableDates;

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
    int itemIndex = availableDates
        .map(DateTimeUtils.formatFullDate)
        .toList()
        .indexOf(DateTimeUtils.formatFullDate(widget.selectedDate!));
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
        if (availableDates.isNotEmpty) {
          _itemWidth =
              ((constraints.maxWidth / availableDates.length) + (2 * 20))
                  .ceil()
                  .toDouble();
        }

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
        DateTimeUtils.isSameDate(widget.selectedDate!, date);

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
              DateTimeUtils.formatDayAndMonth(date),
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
    if (availableDates.isNotEmpty) {
      final DateTime nearestDate = availableDates.reduce(
          (currentDate, nextDate) =>
              currentDate.isBefore(nextDate) ? currentDate : nextDate);
      final DateTime furthestDate = availableDates.reduce(
          (currentDate, nextDate) =>
              currentDate.isAfter(nextDate) ? currentDate : nextDate);

      print(nearestDate);
      print(furthestDate);
      var selectedDate = await showBoardDateTimePicker(
        context: context,
        useSafeArea: true,
        initialDate: widget.selectedDate,
        minimumDate: nearestDate,
        maximumDate: furthestDate,
        options: const BoardDateTimeOptions(activeColor: primaryColor),
        pickerType: DateTimePickerType.date,
      );

      print(selectedDate);
      if ((selectedDate != null) && widget.selectedDate != selectedDate) {
        widget.onSelectDate(selectedDate);
      }
    } else {
      showToast(S.current.noTickets, context: context);
    }
  }
}
