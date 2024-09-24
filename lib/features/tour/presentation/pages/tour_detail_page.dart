import 'package:flutter/material.dart';
import 'package:travel_social_network/cores/constants/reviews.dart';
import 'package:travel_social_network/cores/constants/tours.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../review/domain/entities/review.dart';
import '../../../review/presentations/pages/review_detail_page.dart';
import '../../../review/presentations/widgets/tour_reviews_and_rating.dart';
import '../../../shared/widgets/detail_heading_text.dart';
import '../../../shared/widgets/detail_section_container.dart';
import '../../../shared/widgets/detail_section_spacer.dart';
import '../../../shared/widgets/quill_content.dart';
import '../../../ticket/domain/entities/ticket_type.dart';
import '../../../ticket/presentations/widgets/available_date_list.dart';
import '../../../ticket/presentations/widgets/ticket_bottom_sheet.dart';
import '../../../ticket/presentations/widgets/ticket_grid_view.dart';
import '../../../ticket/presentations/widgets/ticket_item.dart';
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
  late final ScrollController _scrollController;
  late final TourEntity tour;

  List<TourScheduleEntity> schedules = List.empty(growable: true);
  List<TicketTypeEntity> tickets = List.empty(growable: true);
  List<DateTime> availableDates = List.empty(growable: true);
  List<ReviewEntity> reviews = List.empty(growable: true);

  Color titleColor = Colors.white;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);

    tour = generateSampleTours()
        .where((tour) => tour.tourId == widget.tourId)
        .first;
    tickets = tour.tickets;
    availableDates = tour.tickets.map((t) => t.date).toList();
    reviews = sampleReviews.where((r) => r.tourId == widget.tourId).toList();
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
              title: S.current.reviews,
              trailing: Text(
                S.current.viewAll,
                style: const TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: TourReviewsAndRating(
                reviews: reviews,
                rating: tour.rating,
              ),
            ),
          ],
        ),
      );

  Widget _buildMoreInfoSection() => DetailSectionContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailHeadingText(title: S.current.moreInfo),
            const TourMoreInfo(),
          ],
        ),
      );

  Widget _buildTicketSection() => DetailSectionContainer(
        isPadding: false,
        child: Column(
          children: [
            TicketGridView(
              tickets: tickets,
              itemBuilder: (BuildContext context, int index) => TicketItem(
                ticket: tickets[index],
                selectedDate: selectedDate,
              ),
            ),
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
                child: Text(
                  '${S.current.viewAll} ${S.current.tickets}',
                  style: const TextStyle(
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
            DetailHeadingText(title: S.current.tourSchedule),
            Expanded(child: TourScheduleList(tourSchedule: schedules)),
            GestureDetector(
              onTap: () => _showTourScheduleBottomSheet(context),
              child: Container(
                color: Colors.transparent,
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  '${S.current.see} ${S.current.detail} ${S.current.tourItinerary}',
                  style: const TextStyle(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: DetailHeadingText(title: S.current.outStandingFeatures),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.current.showMore,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const Icon(
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
            DetailHeadingText(title: S.current.services),
            AvailableDateList(
              availableDates: availableDates,
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

      tickets = _getTicketsByDate();
    });
  }

  List<TicketTypeEntity> _getTicketsByDate() {
    if (selectedDate == null) return tour.tickets;
    return tour.tickets.where((t) => t.date == selectedDate).toList();
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
        availableDates: availableDates,
        tickets: tickets,
        selectedDate: selectedDate,
        onSelectDate: _selectTravelDate,
      ),
    );
  }

  void _showTourScheduleBottomSheet(BuildContext context) =>
      showModalBottomSheet(
        context: context,
        shape: bottomSheetShape,
        useSafeArea: true,
        isScrollControlled: true,
        builder: (context) => TourScheduleBottomSheet(schedules: schedules),
      );
}
