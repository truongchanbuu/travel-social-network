import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:uuid/uuid.dart';

import '../../../../config/themes/app_theme.dart';
import '../../../../cores/constants/constants.dart';
import '../../../../cores/enums/policy_type.dart';
import '../../../../cores/utils/date_time_utils.dart';
import '../../../../cores/utils/formatters/quill_content_formatter.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../../auth/presentations/bloc/auth_bloc.dart';
import '../../../policy/domain/entities/policy.dart';
import '../../../policy/presentations/bloc/policy_bloc.dart';
import '../../../shared/presentations/widgets/app_progressing_indicator.dart';
import '../../../shared/presentations/widgets/default_white_appbar.dart';
import '../../../shared/presentations/widgets/detail_heading_text.dart';
import '../../../tour/presentations/bloc/tour_bloc.dart';
import '../../domain/entities/ticket.dart';
import '../../domain/entities/ticket_type.dart';
import '../bloc/ticket_bloc.dart';
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
  late TicketTypeEntity ticket;
  PolicyEntity? refundPolicy;
  PolicyEntity? reschedulePolicy;
  DateTime? selectedDate;

  List<DateTime> availableDates = [];
  List<TicketTypeEntity> ticketsTypeOnDate = [];
  List<TicketEntity> selectedTickets = [];

  num totalPrice = 0;

  @override
  void initState() {
    super.initState();
    context.read<TicketBloc>().add(GetTicketByIdEvent(widget.ticketId));
  }

  @override
  Widget build(BuildContext context) {
    final currentUser =
        context.select((AuthBloc authBloc) => authBloc.state.user);

    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: BlocBuilder<TicketBloc, TicketState>(
          builder: (context, ticketState) {
            if (ticketState is TicketActionLoading ||
                ticketState is TicketInitial) {
              return const AppProgressingIndicator();
            }

            if (ticketState is TicketLoaded) {
              ticket = ticketState.ticket;
              context
                  .read<TicketBloc>()
                  .add(GetAllTicketsByTourId(ticket.tourId));
              context
                  .read<PolicyBloc>()
                  .add(GetPolicyById(ticket.refundPolicyId));
              context
                  .read<PolicyBloc>()
                  .add(GetPolicyById(ticket.reschedulePolicyId));
            }

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildTicketBriefInfo(ticket),
                        if (ticketState is ListOfTicketsLoaded) ...[
                          _buildSelectedDateSection(ticketState),
                          _buildTicketTypeList(ticketState, currentUser.id)
                        ] else
                          const AppProgressingIndicator(),
                        BlocConsumer<PolicyBloc, PolicyState>(
                          listener: (context, policyState) {
                            if (policyState is PolicyLoaded) {
                              if (policyState.policy.policyType ==
                                  PolicyType.refund) {
                                refundPolicy = policyState.policy.toEntity();
                              } else if (policyState.policy.policyType ==
                                  PolicyType.reschedule) {
                                reschedulePolicy =
                                    policyState.policy.toEntity();
                              }
                            }
                          },
                          builder: (context, policyState) {
                            if (policyState is! PolicyLoaded ||
                                refundPolicy == null ||
                                reschedulePolicy == null) {
                              return const AppProgressingIndicator();
                            }

                            return _buildImportantInfo(
                                refundPolicy!, reschedulePolicy!);
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                _buildBookingButton(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBookingButton() {
    return TotalPriceWidget(
      totalPrice: totalPrice,
      tickets: selectedTickets,
    );
  }

  Widget _buildImportantInfo(
      PolicyEntity refundPolicy, PolicyEntity reschedulePolicy) {
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
                    color: AppTheme.primaryColor,
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
              QuillContentFormatter.convertToPlainText(message),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      );

  Widget _buildTicketTypeList(ListOfTicketsLoaded ticketState, String userId) {
    ticketsTypeOnDate = ticketState.tickets
        .where((ticket) =>
            selectedDate != null &&
            DateTimeUtils.isSameDate(selectedDate!, ticket.startDate))
        .toList();

    return Container(
      decoration: BoxDecoration(
        boxShadow: [detailSectionBoxShadow],
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TicketsGridView(
        tickets: ticketsTypeOnDate,
        itemHeight: 100,
        itemWidth: 400,
        horizontalSpacing: 10,
        verticalSpacing: 0,
        itemBuilder: (context, index) => AddTicketTypeItem(
          ticket: ticketsTypeOnDate[index],
          onChange: (value) => setState(() {
            totalPrice = value * ticketsTypeOnDate[index].ticketPrice;
            _updateSelectedTickets(ticketsTypeOnDate[index], value, userId);
          }),
        ),
      ),
    );
  }

  Widget _buildTicketBriefInfo(TicketTypeEntity ticket) => Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [detailSectionBoxShadow],
        ),
        child: TicketBriefInfo(
          ticketName: ticket.ticketTypeName,
          category: ticket.category,
          titleFontSize: 14,
          subtitleFontSize: 12,
        ),
      );

  Widget _buildSelectedDateSection(ListOfTicketsLoaded ticketState) {
    availableDates = ticketState.tickets.map((t) => t.startDate).toList();
    selectedDate = widget.selectedDate ?? availableDates[0];

    return Container(
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
  }

  AppBar _buildAppBar() => defaultWhiteAppBar(
        context: context,
        titleText: S.current.addVisitorNumber,
        centerTitle: true,
      );

  void _setDate(DateTime? date) => setState(() => selectedDate = date);

  void _navigateToTicketDetail() => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt.get<TourBloc>()),
              BlocProvider(create: (context) => getIt.get<TicketBloc>()),
              BlocProvider(create: (context) => getIt.get<PolicyBloc>()),
            ],
            child: TicketDetailPage(
              ticketId: ticket.ticketTypeId,
              selectedDate: selectedDate,
              isButtonShowed: false,
            ),
          ),
        ),
      );

  void _updateSelectedTickets(
    TicketTypeEntity ticket,
    int quantity,
    String userId,
  ) {
    final existingTicket = selectedTickets
        .firstWhereOrNull((t) => ticket.ticketTypeId == t.ticketTypeId);

    if (existingTicket != null && existingTicket.quantity != quantity) {
      selectedTickets.remove(existingTicket);
      selectedTickets.add(existingTicket.copyWith(quantity: quantity));
    } else {
      selectedTickets.add(
        TicketEntity(
          ticketId: const Uuid().v4(),
          category: ticket.category,
          tourId: ticket.tourId,
          quantity: quantity,
          ticketTypeId: ticket.ticketTypeId,
          customerId: userId,
          purchasedDate: DateTime.now(),
          ticketPrice: ticket.ticketPrice,
          discount: 0,
        ),
      );
    }
  }
}
