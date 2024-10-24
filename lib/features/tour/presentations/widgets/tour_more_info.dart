import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import 'additional_tour_info_bottom_sheet.dart';

class TourMoreInfo extends StatelessWidget {
  final String? additionalInfo;
  const TourMoreInfo({super.key, this.additionalInfo});

  @override
  Widget build(BuildContext context) {
    // TODO: TOUR ADDITIONAL TOUR INFO
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
            builder: (context) => AdditionalTourInfoBottomSheet(
              additionalInfo: additionalInfo ?? '',
            ),
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
