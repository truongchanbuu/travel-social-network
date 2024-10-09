import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:travel_social_network/cores/constants/policies.dart';
import 'package:travel_social_network/cores/constants/tickets.dart';
import 'package:travel_social_network/cores/constants/tours.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/date_time_utils.dart';
import '../../../../generated/l10n.dart';
import '../../../policy/domain/entities/policy.dart';
import '../../../shared/presentations/widgets/app_cached_image.dart';
import '../../../shared/presentations/widgets/detail_heading_text.dart';
import '../../../tour/domain/entities/tour.dart';
import '../../domain/entities/ticket_type.dart';
import '../widgets/add_ticket_type_item.dart';
import '../widgets/available_date_list.dart';
import '../widgets/ticket_brief_info.dart';
import '../widgets/ticket_grid_view.dart';
import '../widgets/total_price_widget.dart';
import 'ticket_detail_page.dart';

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
  DateTime? selectedDate;

  List<DateTime> availableDates = [];
  List<TicketTypeEntity> ticketTypeOnDate = [];

  num totalPrice = 0;

  @override
  void initState() {
    super.initState();
    ticket = tour1Tickets.where((t) => t.ticketTypeId == widget.ticketId).first;
    tour = generateSampleTours().where((t) => t.tourId == ticket.tourId).first;
    // availableDates = tour.tickets.map((t) => t.startDate).toList();
    selectedDate = widget.selectedDate ?? availableDates[0];
    // ticketTypeOnDate = tour.tickets
    //     .where((t) =>
    //         t.ticketTypeId == widget.ticketId &&
    //         selectedDate != null &&
    //         DateTimeUtils.isSameDate(selectedDate!, t.startDate))
    //     .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildTicketBriefInfo(),
                  _buildSelectedDateSection(),
                  _buildTicketTypeList(),
                  _buildImportantInfo(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          _buildBookingButton(),
        ],
      ),
    );
  }

  Widget _buildBookingButton() {
    return TotalPriceWidget(totalPrice: totalPrice);
  }

  Widget _buildImportantInfo() {
    final PolicyEntity refundPolicy =
        refundPolicies.where((p) => p.policyId == ticket.refundPolicyId).first;
    final PolicyEntity reschedulePolicy = reschedulePolicies
        .where((p) => p.policyId == ticket.reschedulePolicyId)
        .first;

    return Container(
      decoration: BoxDecoration(
        boxShadow: [detailSectionBoxShadow],
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(left: defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailHeadingText(title: S.current.importantThingsYouShouldKnow),
          Padding(
            padding: const EdgeInsets.only(
              left: 5,
              right: 5,
              bottom: 10,
              top: 5,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildImportantItem(
                    refundPolicy.policyDescription,
                    refundPolicy.isAllowed ? refundableIcon : nonrefundableIcon,
                  ),
                  _buildImportantItem(
                    reschedulePolicy.policyDescription,
                    reschedulePolicy.isAllowed
                        ? rescheduledIcon
                        : noRescheduledIcon,
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.maxFinite,
            decoration: const BoxDecoration(
              border: DashedBorder(
                dashLength: dashLength,
                top: BorderSide(width: 0.5, color: Colors.grey),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: RichText(
              textDirection: defaultTextDirection,
              overflow: defaultTextOverflow,
              text: TextSpan(children: [
                TextSpan(
                  text: '${S.current.forMoreInfoAboutTicket} ',
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                TextSpan(
                  text: S.current.seeHere,
                  style: const TextStyle(
                    color: primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = _navigateToTicketDetail,
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImportantItem(String message, IconData icon) => Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: Colors.grey.withOpacity(0.2),
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(right: 5, bottom: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon),
            const SizedBox(width: 10),
            Text(
              message,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      );

  Widget _buildTicketTypeList() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [detailSectionBoxShadow],
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TicketGridView(
        tickets: ticketTypeOnDate,
        itemHeight: 100,
        itemWidth: 400,
        horizontalSpacing: 10,
        verticalSpacing: 0,
        itemBuilder: (context, index) => AddTicketTypeItem(
          ticket: ticket,
          onChange: (value) => debugPrint(value.toString()),
        ),
      ),
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
              cacheKey: S.current.cacheKeyWithId(ticket.tourId, 0),
              imageUrl: tour.imageUrls.first,
              errorSemanticLabel: S.current.thumbDesc(
                  '${ticket.ticketTypeName} ${S.current.ofWord} ${tour.tourName}'),
              loadingSemanticLabel:
                  '${S.current.loading} ${S.current.ofWord} ${S.current.image}',
            ),
          ),
        ),
      );

  Widget _buildSelectedDateSection() => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [detailSectionBoxShadow],
        ),
        padding: const EdgeInsets.only(
          top: defaultPadding,
          bottom: 20,
          left: defaultPadding,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: AvailableDateList(
                availableDates: availableDates,
                onSelectDate: _setDate,
                selectedDate: selectedDate,
              ),
            ),
            Text(S.current.voucherCanBeUsedOn),
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
        title: Text(
          S.current.addVisitorNumber,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      );

  void _setDate(DateTime? date) => setState(() => selectedDate = date);

  void _navigateToTicketDetail() => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TicketDetailPage(
            ticketId: ticket.ticketTypeId,
            selectedDate: selectedDate,
            isButtonShowed: false,
          ),
        ),
      );
}
