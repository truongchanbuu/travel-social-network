import 'package:flutter/material.dart';

// App
const String appName = 'Traveround';
const String currentVersion = '1.0.0+1';

// Color
const Color primaryColor = Colors.blueAccent;
const Color secondaryColor = Colors.white;
const Color textButtonColor = Colors.white;
Color scaffoldBackgroundColor = Colors.grey.shade200;
const Color backGroundExpansionItemColor = Colors.white;
const Color subtitleTicketDetailColor = Colors.amber;
const Color currencyTextColor = Colors.orange;

// Border Radius
const BorderRadius inputFieldBorderRadius =
    BorderRadius.all(Radius.circular(5));

// Box Shadow
BoxShadow detailSectionBoxShadow = BoxShadow(
  blurRadius: 5,
  spreadRadius: 5,
  color: Colors.grey.withOpacity(0.1),
);

// Spacing
const SizedBox verticalInputSpacing = SizedBox(height: 22);

// Padding
const double defaultPadding = 10;

// Duration
const int pageChangeTransitionDuration = 500;

// TextDirection
const TextDirection defaultTextDirection = TextDirection.ltr;

// Overflow
const TextOverflow defaultTextOverflow = TextOverflow.ellipsis;

// Size
const double reviewBoxSize = 320;
const double reviewBoxHeight = 280;
const double reviewItemDetailPageHeight = 350;
const double reviewItemDetailImageSize = 140;
const double circleAvatarRadius = 25;
const double ticketItemWidth = 500;
const double tourDetailPageExpandedAppBarHeight = 250;
const double ticketDetailPageExpandedAppBarHeight = 250;
const double imageIndicatorHeight = 80;
const double dashLength = 10;

// Icons
const IconData refundableIcon = Icons.money;
const IconData nonrefundableIcon = Icons.money_off;
const IconData rescheduledIcon = Icons.event_available;
const IconData noRescheduledIcon = Icons.event_busy;

// Tour Item Size
const List<double> tourItemSizes = [
  200,
  250,
  300,
  320,
  350,
  380,
  400,
  420,
  450,
  500
];
const double recommendedTourItemSize = 250;
const int maxItemCount = 4;

// Item
const int maxReviewItem = 7;
const int minimumImageShowed = 5;

// Shape
const OutlinedBorder bottomSheetShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(5)),
);

// API
const String baseUrl = 'http://localhost:3000/api';

