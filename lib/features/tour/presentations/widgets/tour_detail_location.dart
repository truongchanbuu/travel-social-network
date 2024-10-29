import 'package:flutter/material.dart';

import '../../../../config/themes/app_theme.dart';
import '../../../../generated/l10n.dart';

class TourDetailLocation extends StatelessWidget {
  final String location;
  const TourDetailLocation({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 0.5,
                    color: Colors.grey,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  S.current.locationInfo,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              width: double.infinity,
              height: 200,
            ),
            const SizedBox(height: 5),
            Text(
              location,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              // TODO: LOCATION FEATURE
              onTap: () => debugPrint('Use this location'),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(
                    color: Colors.grey,
                    width: 0.3,
                  ),
                ),
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 10,
                  bottom: 10,
                  right: 15,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.near_me,
                      color: AppTheme.primaryColor,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      S.current.guideToLocation,
                      style: const TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
