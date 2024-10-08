import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:travel_social_network/features/tour/presentations/pages/your_tours_page.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/presentations/widgets/add_image_view.dart';
import '../../../shared/presentations/widgets/app_progressing_indicator.dart';
import '../../../shared/presentations/widgets/confirm_dialog.dart';
import '../../../shared/presentations/widgets/default_white_appabar.dart';
import '../../domain/entities/tour.dart';
import '../bloc/tour_bloc.dart';
import '../widgets/create_tour_dates_section.dart';
import '../widgets/create_tour_details.dart';

class CreateTourPage extends StatefulWidget {
  const CreateTourPage({super.key});

  @override
  State<CreateTourPage> createState() => _CreateTourPageState();
}

class _CreateTourPageState extends State<CreateTourPage> {
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
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: defaultWhiteAppBar(onBack: _backToPrevious),
        body: BlocConsumer<TourBloc, TourState>(
          builder: (context, state) {
            if (state is TourActionLoading) {
              return const AppProgressingIndicator();
            } else if (state is TourLoaded) {
              tour = state.tour;
            }

            return _buildBody();
          },
          listener: (context, state) {
            if (state is TourActionFailed) {
              showToast(state.message,
                  position: StyledToastPosition.center, context: context);
            } else if (state is TourActionSucceed) {
              // TODO: SEE WHAT TODO IF TOUR CREATED
            }
          },
        ),
        bottomNavigationBar: _buildSaveTourButton(),
      ),
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
        body: CreateTourDatesSection(tourId: tour.tourId),
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
          style: const TextStyle(
            color: blackTextColor,
            fontWeight: FontWeight.bold,
          ),
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
                  color: Colors.white,
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

  Widget _buildSaveTourButton() {
    return ElevatedButton(
      onPressed: _createTour,
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
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

  void _createTour() {
    // TODO: CHECK FOR THE USER LATER
    bool isValid = (_tourDetailKey.currentState?.validateForm() ?? false) &&
        images.isNotEmpty &&
        tour.tickets.isNotEmpty;

    if (!isValid) {
      showToast(S.current.invalidForm, context: context);
      return;
    }

    context.read().add(CreateTourEvent(tour: tour, images: images));
  }

  void _backToPrevious() {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(onOk: () {
        Navigator.of(context)
          ..pop()
          ..push(
              MaterialPageRoute(builder: (context) => const YourToursPage()));
      }),
    );
  }
}
