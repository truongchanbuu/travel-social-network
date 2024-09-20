import 'package:flutter/material.dart';

import '../../../../cores/utils/date_time_utils.dart';
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
                'Hello $username,',
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
          padding: EdgeInsets.only(left: 10.0),
          child: BadgeNotification(badges: 10),
        ),
      ],
    );
  }

  String _getGreetingSentence() {
    String periodOfDay = DateTimeUtils.getThePeriodOfTheDay();

    switch (periodOfDay.toLowerCase()) {
      case 'morning':
        return 'Good morning! Ready for today\'s adventures?';
      case 'afternoon':
        return 'Good afternoon! Discover top spots and activities.';
      case 'evening':
        return 'Good evening! Check out evening activities and dining.';
      case 'night':
        return 'Good night! Rest up for tomorrow\'s adventures.';
      default:
        return 'Hello! Hope you\'re doing well.';
    }
  }
}
