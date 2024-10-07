import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/tour.dart';
import '../bloc/tour_bloc.dart';
import '../../../shared/widgets/add_image_view.dart';
import '../widgets/create_tour_dates_section.dart';
import '../widgets/create_tour_details.dart';

class CreateTourPage extends StatefulWidget {
  const CreateTourPage({super.key});

  @override
  State<CreateTourPage> createState() => _CreateTourPageState();
}

class _CreateTourPageState extends State<CreateTourPage> {
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
        appBar: _buildAppBar(),
        body: BlocConsumer<TourBloc, TourState>(
          builder: (context, state) {
            if (state is TourLoaded) {
              tour = state.tour;
            }

            return _buildBody();
          },
          listener: (context, state) {},
        ),
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
        body: CreateTourDetails(tour: tour),
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

  AppBar _buildAppBar() => AppBar(backgroundColor: Colors.white);

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
}
