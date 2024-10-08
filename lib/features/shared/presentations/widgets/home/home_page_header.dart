import 'package:flutter/material.dart';

import '../../../../../cores/constants/constants.dart';
import '../../../../../cores/utils/date_time_utils.dart';
import '../../../../../generated/l10n.dart';
import '../badge_notification.dart';

class HomePageHeader extends StatelessWidget {
  final String username;
  const HomePageHeader({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.current.helloUser(username),
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _getGreetingSentence(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: defaultPadding),
          child: BadgeNotification(badges: 10),
        ),
      ],
    );
  }

  String _getGreetingSentence() {
    String periodOfDay = DateTimeUtils.getThePeriodOfTheDay();

    switch (periodOfDay.toLowerCase()) {
      case 'morning':
        return S.current.morningText;
      case 'afternoon':
        return S.current.afternoonText;
      case 'evening':
        return S.current.eveningText;
      case 'night':
        return S.current.nightText;
      default:
        return S.current.defaultText;
    }
  }
}
