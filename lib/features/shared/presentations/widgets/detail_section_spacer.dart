import 'package:flutter/material.dart';

import 'detail_section_container.dart';

class DetailSectionSpacer extends StatelessWidget {
  const DetailSectionSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    return const DetailSectionContainer(
        isPadding: false, child: SizedBox(height: 20));
  }
}
