import 'package:flutter/material.dart';
import 'package:travel_social_network/cores/constants/constants.dart';

class AppName extends StatelessWidget {
  const AppName({super.key});

  @override
  Widget build(BuildContext context) {
    const double fontSize = 18;

    return RichText(
      text: const TextSpan(
        children: [
          TextSpan(
            text: 'Travelround',
            style: TextStyle(
              color: appNameLogoPrimaryColor,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: '.com',
            style: TextStyle(
              color: appNameLogoSecondaryColor,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
