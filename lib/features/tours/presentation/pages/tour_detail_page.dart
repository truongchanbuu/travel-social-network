import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../../data/models/tour.dart';
import '../widgets/tour/available_date_list.dart';
import '../widgets/tour/info_section.dart';
import '../widgets/tour/ticket_bottom_sheet.dart';
import '../widgets/tour/ticket_grid_view.dart';
import '../widgets/tour/tour_desc.dart';
import '../widgets/tour/tour_desc_modal.dart';
import '../widgets/tour/tour_detail_app_bar.dart';

class TourDetailPage extends StatefulWidget {
  final Tour tour;
  const TourDetailPage({
    super.key,
    required this.tour,
  });

  @override
  State<TourDetailPage> createState() => _TourDetailPageState();
}

class _TourDetailPageState extends State<TourDetailPage> {
  late final Tour tour;
  List<String> tickets = List.empty(growable: true);

  Color titleColor = Colors.white;
  final double expandedHeight = 250;
  late final ScrollController _scrollController;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    tour = widget.tour;
    tickets = [
      'Depart with Vietnam Airlines',
      'Depart with VietJet',
      'Depart with Bamboo Airline',
      'Depart with Singapore Airline',
      'Depart with Malaysia Airline',
      'Depart with Indonesia Airline',
      'Depart with US Airline',
      'Depart with Taiwan Airline',
      'Depart with Greenland Airline',
      'Depart with Iceland Airline',
      'Depart with Belgium Airline',
      'Depart with Cambodia Airline',
      'Depart with India Airline',
      'Depart with Poland Airline',
      'Depart with France Airline',
      'Depart with Taiwan Airline',
      'Depart with JP Airline',
      'Depart with Laos Airline',
      'Depart with Taiwan Airline',
      'Depart with Taiwan Airline',
      'Depart with Finland Airline',
      'Depart with New Zealand Airline',
      'Depart with Australia Airline',
      'Depart with Thailand Airline',
      'Depart with China Airline',
    ];
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final double maxOffset = expandedHeight - kToolbarHeight;
    final double scrollOffset = _scrollController.offset;

    if (_scrollController.hasClients && scrollOffset > maxOffset) {
      setState(() => titleColor = Colors.black);
    } else {
      setState(() => titleColor = Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    const SliverToBoxAdapter spacing =
        SliverToBoxAdapter(child: SizedBox(height: 10));

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          TourDetailAppBar(
            expandedHeight: expandedHeight,
            titleColor: titleColor,
            tour: tour,
          ),
          spacing,
          const SliverToBoxAdapter(child: InfoSection()),
          spacing,
          _buildTourSchedule(),
          spacing,
          _buildServiceSection(),
          spacing,
          _buildTicketSection(),
          spacing,
          _buildOutstandingFeaturesDesc(),
        ],
      ),
    );
  }

  Widget _buildTicketSection() => SliverToBoxAdapter(
        child: Column(
          children: [
            TicketGridView(tickets: tickets),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: TextButton(
                onPressed: () => showModalBottomSheet(
                  useSafeArea: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => TicketBottomSheet(
                    tickets: tickets,
                    selectedDate: selectedDate,
                    onSelectDate: _selectTravelDate,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey.withOpacity(0.2),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text(
                  'See All Tickets',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      );

  Widget _buildTourSchedule() => SliverToBoxAdapter(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [detailSectionBoxShadow],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeadingText('Tour Schedule'),
            ],
          ),
        ),
      );

  Widget _buildOutstandingFeaturesDesc() => SliverToBoxAdapter(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [detailSectionBoxShadow],
          ),
          padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: _buildHeadingText('Outstanding Features'),
              ),
              const SizedBox(height: 10),
              Expanded(child: TourDesc(content: tour.tourDescription)),
              TextButton(
                onPressed: () {
                  showModalBottomSheet(
                    useSafeArea: true,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) =>
                        TourDescModal(content: tour.tourDescription),
                  );
                },
                style: TextButton.styleFrom(
                  shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    side: BorderSide(width: 0.5, color: Colors.grey),
                  ),
                  backgroundColor: primaryColor,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Show more',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    Icon(
                      Icons.keyboard_double_arrow_down,
                      color: Colors.white,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildServiceSection() => SliverToBoxAdapter(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
            boxShadow: [detailSectionBoxShadow],
          ),
          margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeadingText('Services'),
              AvailableDateList(
                onSelectDate: _selectTravelDate,
                selectedDate: selectedDate,
              ),
            ],
          ),
        ),
      );

  Widget _buildHeadingText(String title) => Padding(
        padding: const EdgeInsets.only(
          top: 10,
          left: 10,
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      );

  void _selectTravelDate(DateTime? date) {
    setState(() {
      if (date == selectedDate) {
        selectedDate = null;
      } else {
        selectedDate = date;
      }
    });
  }
}
