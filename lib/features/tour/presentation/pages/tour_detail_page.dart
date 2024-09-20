import 'package:flutter/material.dart';
import 'package:travel_social_network/cores/constants/tickets.dart';
import 'package:travel_social_network/cores/constants/tours.dart';

import '../../../../cores/constants/constants.dart';
import '../../../review/presentations/pages/review_detail_page.dart';
import '../../../review/presentations/widgets/tour_reviews_and_rating.dart';
import '../../../shared/widgets/detail_heading_text.dart';
import '../../../shared/widgets/detail_section_container.dart';
import '../../../shared/widgets/detail_section_spacer.dart';
import '../../../shared/widgets/quill_content.dart';
import '../../../ticket/presentations/widgets/available_date_list.dart';
import '../../../ticket/presentations/widgets/ticket_bottom_sheet.dart';
import '../../../ticket/presentations/widgets/ticket_grid_view.dart';
import '../../domain/entities/tour.dart';
import '../../domain/entities/tour_schedule.dart';
import '../widgets/info_section.dart';
import '../widgets/tour_desc_modal.dart';
import '../widgets/tour_detail_app_bar.dart';
import '../widgets/tour_more_info.dart';
import '../widgets/tour_schedule_bottom_sheet.dart';
import '../widgets/tour_schedule_list.dart';

class TourDetailPage extends StatefulWidget {
  final String tourId;
  const TourDetailPage({super.key, required this.tourId});

  @override
  State<TourDetailPage> createState() => _TourDetailPageState();
}

class _TourDetailPageState extends State<TourDetailPage> {
  late final TourEntity tour;
  List<TourScheduleEntity> schedules = List.empty(growable: true);
  List<String> ticketIds = List.empty(growable: true);

  Color titleColor = Colors.white;
  late final ScrollController _scrollController;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    tour = generateSampleTours()
        .where((tour) => tour.tourId == widget.tourId)
        .first;
    ticketIds = sampleTickets.map((ticket) => ticket.ticketTypeId).toList();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    const double maxOffset =
        tourDetailPageExpandedAppBarHeight - kToolbarHeight;
    final double scrollOffset = _scrollController.offset;

    if (_scrollController.hasClients && scrollOffset > maxOffset) {
      setState(() => titleColor = Colors.black);
    } else {
      setState(() => titleColor = Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          TourDetailAppBar(
            expandedHeight: tourDetailPageExpandedAppBarHeight,
            titleColor: titleColor,
            tour: tour,
          ),
          ...buildDetailSections(context),
        ],
      ),
    );
  }

  List<Widget> buildDetailSections(BuildContext context) => [
        _buildInfoSection(),
        if (schedules.isNotEmpty) ...[
          const DetailSectionSpacer(),
          _buildTourSchedule(),
        ],
        const DetailSectionSpacer(),
        _buildServiceSection(),
        const DetailSectionSpacer(),
        _buildTicketSection(),
        const DetailSectionSpacer(),
        _buildOutstandingFeaturesDesc(),
        const DetailSectionSpacer(),
        _buildReviewsAndRating(),
        const DetailSectionSpacer(),
        _buildMoreInfoSection(),
        const DetailSectionSpacer(),
      ];

  Widget _buildInfoSection() =>
      DetailSectionContainer(child: InfoSection(tour: tour));

  Widget _buildReviewsAndRating() => DetailSectionContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailHeadingText(
              onTap: _showReviewDetailPage,
              title: 'Reviews & Rating',
              trailing: const Text(
                'View all',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: TourReviewsAndRating(reviews: []),
            ),
          ],
        ),
      );

  Widget _buildMoreInfoSection() => const DetailSectionContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailHeadingText(title: 'More Info'),
            TourMoreInfo(),
          ],
        ),
      );

  Widget _buildTicketSection() => DetailSectionContainer(
        isPadding: false,
        child: Column(
          children: [
            TicketGridView(tickets: ticketIds),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: TextButton(
                onPressed: () => _showAllTickets(context),
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

  Widget _buildTourSchedule() => DetailSectionContainer(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DetailHeadingText(title: 'Tour Schedule'),
            Expanded(child: TourScheduleList(tourSchedule: schedules)),
            GestureDetector(
              onTap: () => showModalBottomSheet(
                context: context,
                useSafeArea: true,
                isScrollControlled: true,
                builder: (context) =>
                    TourScheduleBottomSheet(schedules: schedules),
              ),
              child: Container(
                color: Colors.transparent,
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10.0),
                child: const Text(
                  'See Detail Tour Itinerary',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _buildOutstandingFeaturesDesc() => DetailSectionContainer(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: DetailHeadingText(title: 'Outstanding Features'),
            ),
            Expanded(child: QuillContent(content: tour.tourDescription)),
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
      );

  Widget _buildServiceSection() => DetailSectionContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DetailHeadingText(title: 'Services'),
            AvailableDateList(
              onSelectDate: _selectTravelDate,
              selectedDate: selectedDate,
            ),
          ],
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

  void _showReviewDetailPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewDetailPage(tourId: tour.tourId),
      ),
    );
  }

  void _showAllTickets(BuildContext context) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => TicketBottomSheet(
        tickets: ticketIds,
        selectedDate: selectedDate,
        onSelectDate: _selectTravelDate,
      ),
    );
  }
}
