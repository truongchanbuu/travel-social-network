import 'package:flutter/material.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/tour.dart';
import '../widgets/create_tour_add_image_section.dart';
import '../widgets/create_tour_dates_section.dart';
import '../widgets/create_tour_details.dart';

class CreateTourPage extends StatefulWidget {
  const CreateTourPage({super.key});

  @override
  State<CreateTourPage> createState() => _CreateTourPageState();
}

class _CreateTourPageState extends State<CreateTourPage> {
  List<ImageFile> images = List.empty(growable: true);
  Map<String, bool> expansionDetails = {};

  late final TourEntity tour;

  @override
  void initState() {
    super.initState();
    tour = TourEntity.defaultWithId();

    expansionDetails = {
      'detail': true,
      'images': true,
      'dates': true,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
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
        expansionKey: 'dates',
        header: _buildHeadingText(S.current.tourDatesLabel,
            leading: const Icon(Icons.calendar_month)),
        body: CreateTourDatesSection(tourId: tour.tourId),
      );

  ExpansionPanel _buildImageSelection() => _buildTemplateExpansionPanel(
        width: double.infinity,
        height: createTourImagesBox,
        expansionKey: 'images',
        header: _buildHeadingText(
          S.current.addImageLabel,
          leading: const Icon(Icons.image),
        ),
        body: CreateTourAddImageSection(
          images: images,
          onImageSaved: (images) => this.images = images,
        ),
      );

  ExpansionPanel _buildTourDetails() => _buildTemplateExpansionPanel(
        expansionKey: 'detail',
        header: _buildHeadingText(
          S.current.tourDetails,
          leading: const Icon(Icons.location_on_outlined),
        ),
        body: const CreateTourDetails(),
      );

  Widget _buildHeadingText(String title, {Widget? leading}) => ListTile(
        leading: leading,
        minLeadingWidth: 0,
        contentPadding: EdgeInsets.zero,
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
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
    bool isCustomizable = true,
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
        body: isCustomizable
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
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                  bottom: 20,
                ),
                child: body,
              )
            : body,
      );

  AppBar _buildAppBar() => AppBar(
        backgroundColor: Colors.white,
      );

  void _expansionCallBack(int index, bool isExpanded) {
    String key;
    switch (index) {
      case 0:
        key = 'detail';
        break;
      case 1:
        key = 'images';
      case 2:
        key = 'dates';
      default:
        return;
    }

    if (expansionDetails[key] != isExpanded) {
      setState(() => expansionDetails[key] = isExpanded);
    }
  }
}
