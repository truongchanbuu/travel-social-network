import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../config/themes/app_theme.dart';
import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/extensions/context_extension.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../../auth/presentations/bloc/auth_bloc.dart';
import '../../../shared/presentations/widgets/add_image_view.dart';
import '../../../shared/presentations/widgets/app_progressing_indicator.dart';
import '../../../shared/presentations/widgets/confirm_dialog.dart';
import '../../../shared/presentations/widgets/default_white_appbar.dart';
import '../../../ticket/presentations/bloc/ticket_bloc.dart';
import '../../domain/entities/tour.dart';
import '../bloc/tour_bloc.dart';
import '../widgets/create_tour_dates_section.dart';
import '../widgets/create_tour_details.dart';
import 'your_tours_page.dart';

class SaveTourPage extends StatefulWidget {
  final TourEntity? tour;
  const SaveTourPage({super.key, this.tour});

  @override
  State<SaveTourPage> createState() => _SaveTourPageState();
}

class _SaveTourPageState extends State<SaveTourPage> {
  late final GlobalKey<CreateTourDetailsState> _tourDetailKey;

  List<ImageFile> images = [];
  Map<String, bool> expansionDetails = {};
  late TourEntity tour;

  static const String detailKey = 'detail';
  static const String imagesKey = 'images';
  static const String datesKey = 'dates';
  static const padding20 = EdgeInsets.all(20);

  @override
  void initState() {
    super.initState();
    _tourDetailKey = GlobalKey();

    expansionDetails = {
      detailKey: true,
      imagesKey: true,
      datesKey: true,
    };

    if (widget.tour != null) {
      tour = widget.tour!;
      if (tour.imageUrls.isNotEmpty) {
        context.read<TourBloc>().add(GetTourImagesEvent(tour.tourId));
      }
    } else {
      context.read<TourBloc>().add(InitializeNewTourEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthBloc authBloc) => authBloc.state.user);
    return BlocConsumer<TourBloc, TourState>(
      builder: (context, state) {
        if (state is TourLoaded) {
          tour = state.tour;
        } else if (state is TourImagesLoaded) {
          images = state.images;
        }

        return SafeArea(
          child: Scaffold(
            appBar: defaultWhiteAppBar(
                context: context, onBack: () => _backToPrevious(context)),
            body: state is TourLoaded || widget.tour != null
                ? _buildBody()
                : const AppProgressingIndicator(),
            bottomNavigationBar: state is TourActionLoading
                ? const AppProgressingIndicator()
                : _buildSaveTourButton(user.id),
          ),
        );
      },
      listener: (context, state) {
        if (state is TourActionFailed) {
          showToast(state.message,
              position: StyledToastPosition.center, context: context);
        } else if (state is TourActionSuccess) {
          _navigateToYourToursPage(user.id);
        }
      },
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: ExpansionPanelList(
        expansionCallback: _expansionCallBack,
        expandedHeaderPadding: const EdgeInsets.symmetric(vertical: 0),
        children: [
          _buildTourDetails(),
          _buildImageSelection(),
          _buildTourDates(),
        ],
      ),
    );
  }

  ExpansionPanel _buildTourDates() => _buildTemplateExpansionPanel(
        width: double.infinity,
        expansionKey: datesKey,
        header: _buildHeadingText(S.current.tourDatesLabel,
            leading: const Icon(Icons.calendar_month)),
        body: CreateTourDatesSection(
          tourId: tour.tourId,
          duration: tour.duration,
        ),
      );

  ExpansionPanel _buildImageSelection() => _buildTemplateExpansionPanel(
        width: double.infinity,
        height: createTourImagesBox,
        expansionKey: imagesKey,
        header: _buildHeadingText(
          S.current.addImageLabel,
          leading: const Icon(Icons.image),
        ),
        body: AddImageView(
          images: images,
          onImageSaved: (images) => this.images = images,
        ),
      );

  ExpansionPanel _buildTourDetails() => _buildTemplateExpansionPanel(
        expansionKey: detailKey,
        header: _buildHeadingText(
          S.current.tourDetails,
          leading: const Icon(Icons.location_on_outlined),
        ),
        body: CreateTourDetails(key: _tourDetailKey, tour: tour),
      );

  Widget _buildHeadingText(String title, {Widget? leading}) => ListTile(
        leading: leading,
        minLeadingWidth: 0,
        contentPadding: EdgeInsets.zero,
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
          textDirection: defaultTextDirection,
          overflow: defaultTextOverflow,
        ),
      );

  ExpansionPanel _buildTemplateExpansionPanel({
    required String expansionKey,
    required Widget header,
    required Widget body,
    bool isCustomized = true,
    double? width,
    double? height,
  }) =>
      ExpansionPanel(
        canTapOnHeader: true,
        isExpanded: expansionDetails[expansionKey] ?? true,
        headerBuilder: (context, isExpanded) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: header,
        ),
        body: isCustomized
            ? Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: defaultFieldBorderRadius,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5,
                      spreadRadius: 1,
                    )
                  ],
                  color: !context.isDarkMode
                      ? AppTheme.secondaryColor
                      : AppTheme.primaryColorDark,
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: padding20,
                padding: padding20,
                child: body,
              )
            : body,
      );

  void _expansionCallBack(int index, bool isExpanded) {
    String key;
    switch (index) {
      case 0:
        key = detailKey;
        break;
      case 1:
        key = imagesKey;
      case 2:
        key = datesKey;
      default:
        return;
    }

    if (expansionDetails[key] != isExpanded) {
      setState(() => expansionDetails[key] = isExpanded);
    }
  }

  Widget _buildSaveTourButton(String userId) {
    return ElevatedButton(
      onPressed: () => _createTour(userId),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primaryColor,
        minimumSize: minBtnSize,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
      child: Text(
        S.current.save,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _createTour(String userId) {
    bool isValid = (_tourDetailKey.currentState?.validateForm() ?? false) &&
        images.isNotEmpty &&
        tour.ticketIds.isNotEmpty;

    if (!isValid) {
      showToast(S.current.invalidForm, context: context);
      return;
    }

    context.read<TourBloc>().add(CreateTourEvent(
          tour: tour,
          images: images,
          createdBy: userId,
        ));
  }

  void _backToPrevious(BuildContext ctx) {
    if (tour == widget.tour) {
      Navigator.pop(ctx);
      return;
    }

    showDialog(
      context: ctx,
      builder: (context) => ConfirmDialog(onOk: () {
        if (tour.ticketIds.isNotEmpty && widget.tour == null) {
          for (String id in tour.ticketIds) {
            ctx.read<TicketBloc>().add(DeleteTicketEvent(id));
          }
        }

        Navigator.of(context).pop();
        Navigator.of(ctx).pop();
      }),
    );
  }

  void _navigateToYourToursPage(String userId) {
    Navigator.of(context)
      ..pop()
      ..push(PageTransition(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) =>
                    getIt.get<TourBloc>()..add(GetToursByUserIdEvent(userId))),
            BlocProvider(create: (context) => getIt.get<TicketBloc>()),
          ],
          child: YourToursPage(userId: userId),
        ),
        type: PageTransitionType.leftToRight,
      ));
  }
}
