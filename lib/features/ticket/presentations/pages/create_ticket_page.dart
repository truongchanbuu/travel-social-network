import 'package:flutter/material.dart';

class CreateTicketPage extends StatefulWidget {
  final List<String> selectedDates;
  const CreateTicketPage({super.key, required this.selectedDates});

  @override
  State<CreateTicketPage> createState() => _CreateTicketPageState();
}

class _CreateTicketPageState extends State<CreateTicketPage> {
  List<String> selectedDates = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    selectedDates = widget.selectedDates;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSelectedDateList(),
      ],
    );
  }

  Widget _buildSelectedDateList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => _buildDateItem(selectedDates[index]),
      itemCount: selectedDates.length,
    );
  }

  Widget _buildDateItem(String date) => Container();
}
