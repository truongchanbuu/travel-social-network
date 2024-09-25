import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../widgets/create_tour_field.dart';
import '../widgets/tour_desc_field.dart';

class CreateTourPage extends StatefulWidget {
  const CreateTourPage({super.key});

  @override
  State<CreateTourPage> createState() => _CreateTourPageState();
}

class _CreateTourPageState extends State<CreateTourPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [detailSectionBoxShadow],
        color: Colors.white,
      ),
      margin: const EdgeInsets.all(defaultPadding),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CreateTourField(
            label: S.current.tourNameLabel,
            hintTexts: const [
              'Singapore Tour with Significant Lion State Visit',
              'Culture Heritage Tour at Ha Long Bay',
              'Historical Landmarks Exploration at Ho Chi Minh Museum',
              'Sunset Beach Tour at Da Nang',
            ],
          ),
          const SizedBox(height: 20),
          const TourDescField(),
        ],
      ),
    );
  }

  AppBar _buildAppBar() => AppBar(
        backgroundColor: Colors.white,
      );
}
