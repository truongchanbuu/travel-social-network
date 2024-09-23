import 'package:flutter/material.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:travel_social_network/cores/constants/policies.dart';
import 'package:travel_social_network/cores/constants/tickets.dart';
import 'package:travel_social_network/features/ticket/presentations/pages/add_number_visitor_page.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/currency_util.dart';
import '../../../../cores/utils/date_time_utils.dart';
import '../../../shared/widgets/detail_heading_text.dart';
import '../../../shared/widgets/detail_section_container.dart';
import '../../../shared/widgets/quill_content.dart';
import '../../domain/entities/policy.dart';
import '../../domain/entities/ticket_type.dart';
import '../widgets/ticket_brief_info.dart';
import '../widgets/ticket_page_app_bar.dart';

class TicketDetailPage extends StatefulWidget {
  final String ticketId;
  final DateTime? selectedDate;
  final bool isButtonShowed;

  const TicketDetailPage({
    super.key,
    required this.ticketId,
    this.selectedDate,
    this.isButtonShowed = true,
  });

  @override
  State<TicketDetailPage> createState() => _TicketDetailPageState();
}

class _TicketDetailPageState extends State<TicketDetailPage> {
  late final ScrollController _scrollController;
  late final Map<String, bool> sectionExpandedMap;

  late final TicketTypeEntity ticket;
  late final PolicyEntity refundPolicy;
  late final PolicyEntity reschedulePolicy;

  bool _isVisible = false;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    ticket = tour1Tickets
        .where((ticket) => ticket.ticketTypeId == widget.ticketId)
        .first;

    refundPolicy =
        refundPolicies.where((p) => p.policyId == ticket.refundPolicyId).first;
    reschedulePolicy = reschedulePolicies
        .where((p) => p.policyId == ticket.reschedulePolicyId)
        .first;

    sectionExpandedMap = {
      'about': true,
      'expiration': true,
      'redemption': true,
      'policy': true,
    };
    selectedDate = widget.selectedDate;
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    const double maxOffset =
        ticketDetailPageExpandedAppBarHeight - kToolbarHeight;

    final double scrollOffset = _scrollController.offset;

    if (_scrollController.hasClients && scrollOffset > maxOffset) {
      setState(() => _isVisible = true);
    } else {
      setState(() => _isVisible = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          TicketPageAppBar(
            ticket: ticket,
            isVisible: _isVisible,
            expandedHeight: ticketDetailPageExpandedAppBarHeight,
          ),
          _buildBriefInfo(),
          _buildPriceSection(),
          _buildDetailSections()
        ],
      ),
      bottomNavigationBar: widget.isButtonShowed ? _buildBuyButton() : null,
    );
  }

  Widget _buildBuyButton() => Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(width: 0.5, color: Colors.grey)),
        ),
        padding: const EdgeInsets.all(defaultPadding),
        child: ElevatedButton(
          // TODO: pop -> push
          onPressed: () => _navigateToAddVisitorPage(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            padding: const EdgeInsets.all(20),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(3)),
            ),
          ),
          child: const Text(
            'Buy Ticket',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      );

  Widget _buildBriefInfo() => DetailSectionContainer(
        isPadding: false,
        child: TicketBriefInfo(
          ticketName: ticket.ticketTypeName,
          ticketCategory: ticket.category.name.toUpperCase(),
          ticketDescription: ticket.ticketDescription,
        ),
      );

  Widget _buildDetailSections() {
    return SliverToBoxAdapter(
      child: ExpansionPanelList(
        expansionCallback: _setExpandedState,
        expandedHeaderPadding: EdgeInsets.zero,
        children: [
          _buildAboutTicket(),
          _buildVoucherExpiration(),
          _buildRedemptionMethod(),
          _buildPolicies(),
        ],
      ),
    );
  }

  Widget _buildPriceSection() => DetailSectionContainer(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: const BoxDecoration(
            border: DashedBorder.symmetric(
              horizontal: BorderSide(width: 1, color: Colors.grey),
              dashLength: dashLength,
            ),
          ),
          child: Text(
            CurrencyUtils.formatCurrency(ticket.ticketPrice),
            style: const TextStyle(
              color: Colors.deepOrange,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      );

  ExpansionPanel _buildAboutTicket() => ExpansionPanel(
        backgroundColor: backGroundExpansionItemColor,
        canTapOnHeader: true,
        headerBuilder: (context, isExpanded) =>
            const DetailHeadingText(title: 'About this ticket'),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding),
          child: QuillContent(content: ticket.ticketInfo, isVisible: true),
        ),
        isExpanded: sectionExpandedMap['about'] ?? true,
      );

  ExpansionPanel _buildVoucherExpiration() {
    const double fontSize = 14;
    return ExpansionPanel(
      backgroundColor: backGroundExpansionItemColor,
      headerBuilder: (context, isExpanded) =>
          const DetailHeadingText(title: 'Voucher Expiration'),
      canTapOnHeader: true,
      body: ListTile(
        leading: const Icon(
          Icons.calendar_month,
          color: subtitleTicketDetailColor,
        ),
        title: RichText(
          overflow: defaultTextOverflow,
          textDirection: defaultTextDirection,
          text: TextSpan(children: [
            const TextSpan(
              text: 'Available to use on ',
              style: TextStyle(
                color: subtitleTicketDetailColor,
                fontSize: fontSize,
              ),
            ),
            TextSpan(
              text: selectedDate == null
                  ? 'visit date'
                  : DateTimeUtils.formatFullDate(selectedDate!),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
                color: subtitleTicketDetailColor,
              ),
            ),
          ]),
        ),
      ),
      isExpanded: sectionExpandedMap['expiration'] ?? true,
    );
  }

  ExpansionPanel _buildRedemptionMethod() => ExpansionPanel(
        backgroundColor: backGroundExpansionItemColor,
        canTapOnHeader: true,
        isExpanded: sectionExpandedMap['redemption'] ?? true,
        headerBuilder: (context, isExpanded) =>
            const DetailHeadingText(title: 'Redemption Method'),
        body: Padding(
          padding: const EdgeInsets.only(
              left: defaultPadding, bottom: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'How to redeem:',
                style: TextStyle(
                  color: subtitleTicketDetailColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                textDirection: defaultTextDirection,
                overflow: defaultTextOverflow,
              ),
              const SizedBox(height: 5),
              QuillContent(
                  content: ticket.redemptionMethodDesc, isVisible: true),
            ],
          ),
        ),
      );

  ExpansionPanel _buildPolicies() {
    bool canRefund = refundPolicy.isAllowed;
    String refundDescription = refundPolicy.policyDescription;

    bool canRescheduled = reschedulePolicy.isAllowed;
    String rescheduleDescription = reschedulePolicy.policyDescription;

    return ExpansionPanel(
      backgroundColor: backGroundExpansionItemColor,
      canTapOnHeader: true,
      headerBuilder: (context, isExpanded) =>
          const DetailHeadingText(title: 'Refund & Reschedule'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPolicyText(
            canRescheduled ? 'Can be Rescheduled' : 'Cannot be Rescheduled',
            rescheduleDescription,
            canRescheduled ? rescheduledIcon : noRescheduledIcon,
          ),
          _buildPolicyText(
            canRefund ? 'Can be Refunded' : 'Cannot be Refunded',
            refundDescription,
            canRefund ? refundableIcon : nonrefundableIcon,
          ),
        ],
      ),
      isExpanded: sectionExpandedMap['policy'] ?? true,
    );
  }

  Widget _buildPolicyText(String message, String subtitle, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        message,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(subtitle),
    );
  }

  void _setExpandedState(int index, bool isExpanded) => setState(() {
        switch (index) {
          case 0:
            sectionExpandedMap['about'] = isExpanded;
            break;
          case 1:
            sectionExpandedMap['expiration'] = isExpanded;
            break;
          case 2:
            sectionExpandedMap['redemption'] = isExpanded;
            break;
          case 3:
            sectionExpandedMap['policy'] = isExpanded;
            break;
        }
      });

  void _navigateToAddVisitorPage(BuildContext context) async {
    var navigator = Navigator.of(context);

    navigator.pop();

    await Future.delayed(const Duration(milliseconds: 300));

    navigator.push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            AddNumberVisitorPage(
          ticketId: ticket.ticketTypeId,
          selectedDate: selectedDate,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }
}
