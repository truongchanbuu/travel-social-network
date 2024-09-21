import 'package:flutter/material.dart';
import 'package:travel_social_network/cores/constants/constants.dart';
import 'package:travel_social_network/cores/constants/tickets.dart';
import 'package:travel_social_network/cores/constants/tours.dart';

import '../../../../cores/utils/date_time_utils.dart';
import '../../../shared/widgets/app_cached_image.dart';
import '../../../tour/domain/entities/tour.dart';
import '../../domain/entities/ticket_type.dart';
import '../widgets/available_date_list.dart';
import '../widgets/ticket_brief_info.dart';

class AddNumberVisitorPage extends StatefulWidget {
  final String ticketId;
  final DateTime? selectedDate;

  const AddNumberVisitorPage({
    super.key,
    required this.ticketId,
    this.selectedDate,
  });

  @override
  State<AddNumberVisitorPage> createState() => _AddNumberVisitorPageState();
}

class _AddNumberVisitorPageState extends State<AddNumberVisitorPage> {
  late final TicketTypeEntity ticket;
  late final TourEntity tour;

  List<DateTime> availableDates = List.empty(growable: true);

  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();

    selectedDate = widget.selectedDate;

    ticket =
        sampleTickets.where((t) => t.ticketTypeId == widget.ticketId).first;
    tour = generateSampleTours().where((t) => t.tourId == ticket.tourId).first;
    availableDates = tour.tickets.map((ticket) => ticket.createdAt).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildTicketBriefInfo(),
            _buildSelectedDateSection(),
            _buildTicketTypeList(),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketTypeList() {
    return Column(
      children: [],
    );
  }

  Widget _buildTicketBriefInfo() => Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [detailSectionBoxShadow],
        ),
        child: TicketBriefInfo(
          ticketName: ticket.ticketTypeName,
          ticketCategory: ticket.category.name.toUpperCase(),
          ticketDescription: ticket.ticketDescription,
          titleFontSize: 14,
          subtitleFontSize: 12,
          leading: Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: AppCachedImage(
              width: 50,
              height: 50,
              cacheKey: '${ticket.tourId}-img-0',
              imageUrl: tour.imageUrls.first,
              errorSemanticLabel:
                  'Thumb for ${ticket.ticketTypeName} of ${tour.tourName}',
              loadingSemanticLabel:
                  'Loading thumb for ${ticket.ticketTypeName} of ${tour.tourName}',
            ),
          ),
        ),
      );

  Widget _buildSelectedDateSection() => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [detailSectionBoxShadow],
        ),
        padding: const EdgeInsets.only(top: 10, bottom: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: AvailableDateList(
                availableDates: availableDates,
                onSelectDate: _setDate,
                selectedDate: selectedDate ?? availableDates[0],
              ),
            ),
            const Text('Voucher can be used on'),
            Text(
              DateTimeUtils.formatFullDate(selectedDate ?? availableDates[0]),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );

  AppBar _buildAppBar() => AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Add Visitor Number',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      );

  void _setDate(DateTime? date) => setState(() => selectedDate = date);
}
