import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../tour/presentation/widgets/date_time_item.dart';
import '../../domain/entities/ticket_type.dart';
import '../widgets/create_policy_section.dart';
import '../widgets/create_ticket_section.dart';

class CreateTicketPage extends StatefulWidget {
  final List<String> dates;
  final List<String> selectedDates;

  const CreateTicketPage({
    super.key,
    required this.dates,
    required this.selectedDates,
  });

  @override
  State<CreateTicketPage> createState() => _CreateTicketPageState();
}

class _CreateTicketPageState extends State<CreateTicketPage> {
  List<String> dates = List.empty(growable: true);
  List<String> selectedDates = List.empty(growable: true);

  late final TicketTypeEntity ticket;

  @override
  void initState() {
    super.initState();
    dates = widget.dates;
    selectedDates = widget.selectedDates;
    ticket = TicketTypeEntity.defaultWithId();
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
        const Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CreateTicketSection(),
                CreatePolicySection(),
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
          onPressed: () => Navigator.pop(context, selectedDates),
          icon: const Icon(Icons.arrow_back),
        ),
      );
}
