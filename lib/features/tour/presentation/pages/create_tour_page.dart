import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../widgets/create_tour_field.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CreateTourField(
            label: S.current.tourNameLabel,
            hintTexts: const [
              'Singapore Tour with Significant Lion State Visit',
              'Culture Heritage Tour at Ha Long Bay',
              'Historical Landmarks Exploration at Ho Chi Minh Museum',
              'Sunset Beach Tour at Da Nang'
            ],
          ),
          CreateTourField(
            label: S.current.tourDescLabel,
            enable: false,
            onTap: () {},
          )
        ],
      ),
    );
  }

  AppBar _buildAppBar() => AppBar(
        backgroundColor: Colors.white,
        title: Text(
          S.current.createTourPageTitle,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
          textDirection: defaultTextDirection,
          overflow: defaultTextOverflow,
        ),
      );
}
