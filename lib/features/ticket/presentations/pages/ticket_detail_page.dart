import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

import '../../../../config/themes/app_theme.dart';
import '../../../../cores/constants/constants.dart';
import '../../../../cores/enums/policy_type.dart';
import '../../../../cores/utils/currency_helper.dart';
import '../../../../cores/utils/date_time_utils.dart';
import '../../../../cores/utils/formatters/quill_content_formatter.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../../policy/domain/entities/policy.dart';
import '../../../policy/presentations/bloc/policy_bloc.dart';
import '../../../shared/presentations/widgets/app_progressing_indicator.dart';
import '../../../shared/presentations/widgets/detail_heading_text.dart';
import '../../../shared/presentations/widgets/detail_section_container.dart';
import '../../../shared/presentations/widgets/quill_content.dart';
import '../../../tour/presentations/bloc/tour_bloc.dart';
import '../../domain/entities/ticket_type.dart';
import '../bloc/ticket_bloc.dart';
import '../widgets/ticket_brief_info.dart';
import '../widgets/ticket_page_app_bar.dart';
import 'add_number_visitor_page.dart';

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
  Map<String, bool> sectionExpandedMap = {};

  TicketTypeEntity? ticket;
  PolicyEntity? refundPolicy;
  PolicyEntity? reschedulePolicy;

  bool _isVisible = false;
  DateTime? selectedDate;

  static const String aboutKey = 'about';
  static const String expirationKey = 'expiration';
  static const String redemptionKey = 'redemption';
  static const String policyKey = 'policy';

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    context.read<TicketBloc>().add(GetTicketByIdEvent(widget.ticketId));
    sectionExpandedMap = {
      aboutKey: true,
      expirationKey: true,
      redemptionKey: true,
      policyKey: true,
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
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<TicketBloc, TicketState>(
          builder: (context, state) {
            if (state is TicketActionLoading || state is TicketInitial) {
              return const AppProgressingIndicator();
            } else if (state is TicketLoaded) {
              ticket = state.ticket;

              context
                  .read<PolicyBloc>()
                  .add(GetPolicyById(ticket!.refundPolicyId));
              context
                  .read<PolicyBloc>()
                  .add(GetPolicyById(ticket!.reschedulePolicyId));
              context.read<TourBloc>().add(GetTourImagesEvent(ticket!.tourId));

              return _buildBody();
            }

            return const SizedBox.shrink();
          },
        ),
        bottomNavigationBar: widget.isButtonShowed ? _buildBuyButton() : null,
      ),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<PolicyBloc, PolicyState>(
      listener: (context, state) {
        if (state is PolicyLoaded) {
          if (state.policy.policyType == PolicyType.refund) {
            refundPolicy = state.policy;
          } else if (state.policy.policyType == PolicyType.reschedule) {
            reschedulePolicy = state.policy;
          }
        }
      },
      builder: (context, state) {
        if (state is! PolicyLoaded ||
            refundPolicy == null ||
            reschedulePolicy == null) {
          return const AppProgressingIndicator();
        }

        return BlocBuilder<TourBloc, TourState>(
          builder: (context, tourState) {
            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                TicketPageAppBar(
                  ticketName: ticket!.ticketTypeName,
                  isVisible: _isVisible,
                  isLoading: tourState is! TourImagesLoaded,
                  expandedHeight: ticketDetailPageExpandedAppBarHeight,
                  imageUrls: tourState is TourImagesLoaded
                      ? tourState.images.map((image) => image.path!).toList()
                      : [],
                ),
                _buildBriefInfo(ticket!),
                _buildPriceSection(),
                _buildDetailSections()
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildBuyButton() => Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(width: 0.5, color: Colors.grey)),
        ),
        padding: const EdgeInsets.all(defaultPadding),
        child: ElevatedButton(
          onPressed: () => _navigateToAddVisitorPage(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryColor,
            padding: const EdgeInsets.all(20),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(3)),
            ),
          ),
          child: Text(
            S.current.buyTicket,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      );

  Widget _buildBriefInfo(TicketTypeEntity ticket) => DetailSectionContainer(
        isPadding: false,
        child: TicketBriefInfo(
          ticketName: ticket.ticketTypeName,
          category: ticket.category,
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
            CurrencyHelper.formatCurrency(ticket!.ticketPrice),
            style: const TextStyle(
              color: Colors.deepOrange,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      );

  ExpansionPanel _buildAboutTicket() => ExpansionPanel(
        backgroundColor: AppTheme.backGroundExpansionItemColor,
        canTapOnHeader: true,
        headerBuilder: (context, isExpanded) =>
            DetailHeadingText(title: S.current.aboutThisTicket),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding),
          child: QuillContent(content: ticket!.ticketInfo, isVisible: true),
        ),
        isExpanded: sectionExpandedMap[aboutKey] ?? true,
      );

  ExpansionPanel _buildVoucherExpiration() {
    const double fontSize = 14;
    return ExpansionPanel(
      backgroundColor: AppTheme.backGroundExpansionItemColor,
      headerBuilder: (context, isExpanded) =>
          DetailHeadingText(title: S.current.voucherExp),
      canTapOnHeader: true,
      body: ListTile(
        leading: const Icon(
          Icons.calendar_month,
          color: AppTheme.subtitleTicketDetailColor,
        ),
        title: RichText(
          overflow: defaultTextOverflow,
          textDirection: defaultTextDirection,
          text: TextSpan(children: [
            TextSpan(
              text: '${S.current.voucherCanBeUsedOn} ',
              style: const TextStyle(
                color: AppTheme.subtitleTicketDetailColor,
                fontSize: fontSize,
              ),
            ),
            TextSpan(
              text: selectedDate == null
                  ? S.current.selectedDate
                  : DateTimeUtils.formatFullDate(selectedDate!),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
                color: AppTheme.subtitleTicketDetailColor,
              ),
            ),
          ]),
        ),
      ),
      isExpanded: sectionExpandedMap[expirationKey] ?? true,
    );
  }

  ExpansionPanel _buildRedemptionMethod() => ExpansionPanel(
        backgroundColor: AppTheme.backGroundExpansionItemColor,
        canTapOnHeader: true,
        isExpanded: sectionExpandedMap[redemptionKey] ?? true,
        headerBuilder: (context, isExpanded) =>
            DetailHeadingText(title: S.current.redemptionMethod),
        body: Padding(
          padding: const EdgeInsets.only(
            left: defaultPadding,
            bottom: defaultPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.current.howToRedeem,
                style: const TextStyle(
                  color: AppTheme.subtitleTicketDetailColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                textDirection: defaultTextDirection,
                overflow: defaultTextOverflow,
              ),
              const SizedBox(height: 5),
              QuillContent(
                content: ticket!.redemptionMethodDesc,
                isVisible: true,
              ),
            ],
          ),
        ),
      );

  ExpansionPanel _buildPolicies() {
    bool canRefund = refundPolicy!.isAllowed;
    String refundDescription = QuillContentFormatter.convertToPlainText(
        refundPolicy!.policyDescription);

    bool canRescheduled = reschedulePolicy!.isAllowed;
    String rescheduleDescription = QuillContentFormatter.convertToPlainText(
        reschedulePolicy!.policyDescription);

    return ExpansionPanel(
      backgroundColor: AppTheme.backGroundExpansionItemColor,
      canTapOnHeader: true,
      headerBuilder: (context, isExpanded) =>
          DetailHeadingText(title: S.current.refundAndReschedule),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPolicyText(
            canRescheduled
                ? S.current.canBeRescheduled
                : S.current.cannotBeRescheduled,
            rescheduleDescription,
            canRescheduled ? rescheduledIcon : noRescheduledIcon,
          ),
          _buildPolicyText(
            canRefund ? S.current.refundable : S.current.nonRefundable,
            refundDescription,
            canRefund ? refundableIcon : nonrefundableIcon,
          ),
        ],
      ),
      isExpanded: sectionExpandedMap[policyKey] ?? true,
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
        overflow: defaultTextOverflow,
        textDirection: defaultTextDirection,
      ),
      subtitle: Text(subtitle),
    );
  }

  void _setExpandedState(int index, bool isExpanded) {
    String key;
    switch (index) {
      case 0:
        key = aboutKey;
        break;
      case 1:
        key = expirationKey;
        break;
      case 2:
        key = redemptionKey;
        break;
      case 3:
        key = policyKey;
        break;
      default:
        return;
    }

    if (sectionExpandedMap[key] != isExpanded) {
      setState(() => sectionExpandedMap[key] = isExpanded);
    }
  }

  void _navigateToAddVisitorPage(BuildContext context) async {
    var navigator = Navigator.of(context);

    navigator.pop();

    await Future.delayed(const Duration(milliseconds: 300));

    navigator.push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt.get<TicketBloc>()),
            BlocProvider(create: (context) => getIt.get<PolicyBloc>()),
          ],
          child: AddNumberVisitorPage(
            ticketId: ticket!.ticketTypeId,
            selectedDate: selectedDate,
          ),
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
