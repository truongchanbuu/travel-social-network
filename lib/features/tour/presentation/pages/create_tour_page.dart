import 'package:flutter/material.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../widgets/create_tour_add_image_section.dart';
import '../widgets/create_tour_details.dart';

class CreateTourPage extends StatefulWidget {
  const CreateTourPage({super.key});

  @override
  State<CreateTourPage> createState() => _CreateTourPageState();
}

class _CreateTourPageState extends State<CreateTourPage> {
  List<ImageFile> images = List.empty(growable: true);
  Map<String, bool> expansionDetails = {};

  @override
  void initState() {
    super.initState();
    expansionDetails = {
      'detail': true,
      'images': true,
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
        ],
      ),
    );
  }

  ExpansionPanel _buildImageSelection() => _buildTemplateExpansionPanel(
        isCustomizable: false,
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
                decoration: BoxDecoration(
                  borderRadius: inputFieldBorderRadius,
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
                margin: const EdgeInsets.symmetric(
                    vertical: defaultPadding, horizontal: defaultPadding),
                padding: const EdgeInsets.only(
                  left: defaultPadding,
                  right: defaultPadding,
                  top: 10,
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
      default:
        return;
    }

    if (expansionDetails[key] != isExpanded) {
      setState(() => expansionDetails[key] = isExpanded);
    }
  }
}
