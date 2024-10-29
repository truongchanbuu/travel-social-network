import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../../../../config/themes/app_theme.dart';
import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../../review/domain/entities/review.dart';
import '../../../review/presentations/bloc/review_bloc.dart';
import '../../../review/presentations/pages/reviews_page.dart';
import '../../../review/presentations/widgets/tour_reviews_and_rating.dart';
import '../../../shared/presentations/widgets/app_progressing_indicator.dart';
import '../../../shared/presentations/widgets/detail_heading_text.dart';
import '../../../shared/presentations/widgets/detail_section_container.dart';
import '../../../shared/presentations/widgets/detail_section_spacer.dart';
import '../../../shared/presentations/widgets/quill_content.dart';
import '../../../ticket/domain/entities/ticket_type.dart';
import '../../../ticket/presentations/bloc/ticket_bloc.dart';
import '../../../ticket/presentations/widgets/available_date_list.dart';
import '../../../ticket/presentations/widgets/ticket_bottom_sheet.dart';
import '../../../ticket/presentations/widgets/ticket_grid_view.dart';
import '../../../ticket/presentations/widgets/ticket_item.dart';
import '../../domain/entities/tour.dart';
import '../bloc/tour_bloc.dart';
import '../widgets/info_section.dart';
import '../widgets/tour_bottom_sheet_template.dart';
import '../widgets/tour_desc_modal.dart';
import '../widgets/tour_detail_app_bar.dart';
import '../widgets/tour_more_info.dart';

class TourDetailPage extends StatefulWidget {
  final String tourId;
  const TourDetailPage({super.key, required this.tourId});

  @override
  State<TourDetailPage> createState() => _TourDetailPageState();
}

class _TourDetailPageState extends State<TourDetailPage> {
  late final ScrollController _scrollController;
  late TourEntity tour;

  List<TicketTypeEntity> tickets = [];
  List<DateTime> availableDates = [];
  List<ReviewEntity> reviews = [];

  Color titleColor = Colors.white;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    context.read<TourBloc>().add(GetTourByIdEvent(widget.tourId));
    context.read<TicketBloc>().add(GetAllTicketsByTourId(widget.tourId));
    context.read<ReviewBloc>().add(GetAllTourReviewsEvent(widget.tourId));
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
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<TourBloc, TourState>(
          builder: (context, tourState) {
            if (tourState is TourActionLoading || tourState is TourInitial) {
              return const AppProgressingIndicator();
            } else if (tourState is TourLoaded) {
              tour = tourState.tour;

              return CustomScrollView(
                controller: _scrollController,
                slivers: [
                  TourDetailAppBar(
                    expandedHeight: tourDetailPageExpandedAppBarHeight,
                    titleColor: titleColor,
                  ),
                  ...buildDetailSections(context),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  List<Widget> buildDetailSections(BuildContext context) => [
        _buildInfoSection(),
        if (tour.tourSchedule?.isNotEmpty ?? false) ...[
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
      const DetailSectionContainer(child: InfoSection());

  Widget _buildReviewsAndRating() => DetailSectionContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailHeadingText(
              onTap: _showReviewDetailPage,
              title: S.current.reviewTitle,
              trailing: Text(
                S.current.viewAll,
                style: const TextStyle(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: BlocConsumer<ReviewBloc, ReviewState>(
                listener: (context, reviewState) {
                  if (reviewState is ReviewDeleted) {
                    showToast(S.current.success, context: context);
                    context
                        .read<ReviewBloc>()
                        .add(GetAllTourReviewsEvent(widget.tourId));
                  }
                },
                builder: (context, reviewState) {
                  if (reviewState is! ListOfReviewsLoaded) {
                    return const AppProgressingIndicator();
                  }

                  if (reviews != reviewState.reviews) {
                    reviews = reviewState.reviews;
                  }

                  return TourReviewsAndRating(
                    tourId: tour.tourId,
                    reviews: reviews,
                    rating: tour.rating,
                  );
                },
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
            TourMoreInfo(additionalInfo: tour.additionalInfo),
          ],
        ),
      );

  Widget _buildTicketSection() => DetailSectionContainer(
        isPadding: false,
        child: Column(
          children: [
            TicketsGridView(
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
                  minimumSize: minBtnSize,
                ),
                child: Text(
                  '${S.current.viewAll} ${S.current.tickets}',
                  style: const TextStyle(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      );

  Widget _buildTourSchedule() => DetailSectionContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailHeadingText(title: S.current.tourSchedule),
            QuillContent(content: tour.tourSchedule!),
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
                    color: AppTheme.primaryColor,
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
              onPressed: _openTourDesc,
              style: TextButton.styleFrom(
                shape: const BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  side: BorderSide(width: 0.5, color: Colors.grey),
                ),
                backgroundColor: AppTheme.primaryColor,
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
        child: BlocBuilder<TicketBloc, TicketState>(
            builder: (context, ticketState) {
          if (ticketState is! ListOfTicketsLoaded) {
            return const AppProgressingIndicator();
          }

          tickets = ticketState.tickets;
          availableDates = tickets.map((ticket) => ticket.startDate).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DetailHeadingText(title: S.current.services),
              AvailableDateList(
                availableDates: availableDates,
                onSelectDate: _selectTravelDate,
                selectedDate: selectedDate,
              ),
            ],
          );
        }),
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
    if (selectedDate == null) return tickets;
    return tickets.where((t) => t.startDate == selectedDate).toList();
  }

  void _showReviewDetailPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
            create: (context) => getIt.get<ReviewBloc>(),
            child: ReviewsPage(tour: tour)),
      ),
    );
  }

  void _openTourDesc() {
    showModalBottomSheet(
      shape: bottomSheetShape,
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => TourDescModal(content: tour.tourDescription),
    );
  }

  void _showAllTickets(BuildContext context) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      shape: bottomSheetShape,
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
        builder: (context) => TourBottomSheetTemplate(
          title: S.current.tourSchedule,
          children: [QuillContent(content: tour.tourSchedule!)],
        ),
      );
}
