import 'package:flutter/material.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:travel_social_network/cores/constants/tickets.dart';

import '../../../../cores/constants/constants.dart';
import '../../../shared/widgets/detail_heading_text.dart';
import '../../../shared/widgets/detail_section_container.dart';
import '../../../shared/widgets/detail_section_spacer.dart';
import '../../../shared/widgets/quill_content.dart';
import '../../domain/entities/ticket_type.dart';
import '../widgets/ticket_page_app_bar.dart';

class TicketDetailPage extends StatefulWidget {
  final String ticketId;
  const TicketDetailPage({super.key, required this.ticketId});

  @override
  State<TicketDetailPage> createState() => _TicketDetailPageState();
}

class _TicketDetailPageState extends State<TicketDetailPage> {
  late final TicketTypeEntity ticket;
  late final ScrollController _scrollController;

  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    ticket = sampleTickets
        .where((ticket) => ticket.ticketTypeId == widget.ticketId)
        .first;
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
          const DetailSectionSpacer(),
          _buildBriefInfo(),
          _buildPriceSection(),
          buildDetailSections()
        ],
      ),
    );
  }

  Widget buildDetailSections() {
    return SliverToBoxAdapter(
      child: ExpansionPanelList(
        children: [
          _buildAboutTicket(),
        ],
      ),
    );
  }

  Widget _buildBriefInfo() => DetailSectionContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${ticket.ticketTypeName} - For ${ticket.category.name.toUpperCase()}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              textDirection: defaultTextDirection,
              overflow: defaultTextOverflow,
              maxLines: 2,
            ),
            Text(
              ticket.ticketDescription,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textDirection: defaultTextDirection,
              overflow: defaultTextOverflow,
              maxLines: 2,
            )
          ],
        ),
      );

  Widget _buildPriceSection() => DetailSectionContainer(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: const BoxDecoration(
            border: DashedBorder.symmetric(
              horizontal: BorderSide(width: 1, color: Colors.grey),
              dashLength: 10,
            ),
          ),
          child: Text(
            'VND ${ticket.ticketPrice}',
            style: const TextStyle(
              color: Colors.deepOrange,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      );

  ExpansionPanel _buildAboutTicket() {
    return ExpansionPanel(
      canTapOnHeader: true,
      headerBuilder: (context, isExpanded) =>
          const DetailHeadingText(title: 'About this ticket'),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: defaultPadding),
        child: QuillContent(content: ticket.ticketInfo, isVisible: true),
      ),
      isExpanded: true,
    );
  }
}
