import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import 'additional_tour_info_bottom_sheet.dart';

class TourMoreInfo extends StatelessWidget {
  const TourMoreInfo({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: TOUR ADDITIONAL TOUR INFO
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
          // TODO: ADD OWNER PHONE NUMBER
          onTap: () => _callToServiceProvider(context, "0123456789"),
          leading: const Icon(Icons.phone),
          title: Text(S.current.contactServiceProvider),
          trailing: const Icon(
            Icons.chevron_right,
            color: primaryColor,
          ),
        ),
        ListTile(
          onTap: () => showModalBottomSheet(
            context: context,
            shape: bottomSheetShape,
            useSafeArea: true,
            isScrollControlled: true,
            builder: (context) =>
                AdditionalTourInfoBottomSheet(additionalInfo: jsonEncode(data)),
          ),
          leading: const Icon(Icons.info),
          title: Text(S.current.additionalInformation),
          trailing: const Icon(
            Icons.chevron_right,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Future<void> _callToServiceProvider(
    BuildContext context,
    String phoneNumber,
  ) async {
    ScaffoldMessengerState scaffoldMessengerState =
        ScaffoldMessenger.of(context);
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);

    try {
      if (!await canLaunchUrl(phoneUri)) {
        _showSnackBar(scaffoldMessengerState, S.current.makeCallFailure);
        return;
      }

      await launchUrl(
        phoneUri,
        mode: defaultTargetPlatform == TargetPlatform.iOS
            ? LaunchMode.externalApplication
            : LaunchMode.platformDefault,
      );
    } catch (e) {
      debugPrint(e.toString());
      _showSnackBar(scaffoldMessengerState, S.current.makeCallFailure);
    }
  }

  void _showSnackBar(
      ScaffoldMessengerState scaffoldMessengerState, String message) {
    SnackBar snackBar = SnackBar(
      content: Text(message),
      dismissDirection: DismissDirection.startToEnd,
    );

    scaffoldMessengerState.showSnackBar(snackBar);
  }
}
