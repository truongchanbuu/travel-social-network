import 'dart:convert';

import 'package:flutter/material.dart';

import 'additional_tour_info_bottom_sheet.dart';
import '../../../../../cores/constants/constants.dart';

class TourMoreInfo extends StatelessWidget {
  const TourMoreInfo({super.key});

  @override
  Widget build(BuildContext context) {
    var data = [
      {"insert": "Sapa Adventure Tour\n"},
      {
        "attributes": {"header": 1},
        "insert": "\n"
      },
      {"insert": "Duration: 3 Days, 2 Nights\n"},
      {
        "attributes": {"bold": true},
        "insert": "Highlights:"
      },
      {"insert": "\n"},
      {
        "attributes": {"list": "bullet"},
        "insert": "Climbing Fansipan by cable car\n"
      },
      {
        "attributes": {"list": "bullet"},
        "insert": "Exploring Silver Waterfall\n"
      },
      {
        "attributes": {"list": "bullet"},
        "insert": "Experiencing local culture\n"
      },
      {"insert": "\n"},
      {
        "attributes": {"italic": true},
        "insert": "Day 1: Arrival and Exploration\n"
      },
      {
        "attributes": {"bold": true},
        "insert": "Time: "
      },
      {"insert": "06:30 AM\n"},
      {"insert": "Activity: Climb Fansipan by cable car.\n"},
      {
        "attributes": {"italic": true},
        "insert": "Transportation: Cable car\n"
      },
      {"insert": "\n"},
      {
        "attributes": {"italic": true},
        "insert": "Day 2: Sightseeing and Relaxing\n"
      },
      {
        "attributes": {"bold": true},
        "insert": "Time: "
      },
      {"insert": "14:00 PM\n"},
      {"insert": "Activity: Visit Silver Waterfall.\n"},
      {
        "attributes": {"italic": true},
        "insert": "Transportation: Bus\n"
      }
    ];

    return Column(
      children: [
        ListTile(
          onTap: () {},
          leading: const Icon(Icons.phone),
          title: const Text('Contact service provider'),
          trailing: const Icon(
            Icons.chevron_right,
            color: primaryColor,
          ),
        ),
        ListTile(
          onTap: () => showModalBottomSheet(
            context: context,
            useSafeArea: true,
            isScrollControlled: true,
            builder: (context) =>
                AdditionalTourInfoBottomSheet(additionalInfo: jsonEncode(data)),
          ),
          leading: const Icon(Icons.info),
          title: const Text('Additional Information'),
          trailing: const Icon(
            Icons.chevron_right,
            color: primaryColor,
          ),
        ),
      ],
    );
  }
}
