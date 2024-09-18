import 'package:flutter/material.dart';

// App
const String appName = 'Traveround';

// Color
const Color primaryColor = Colors.blueAccent;
const Color secondaryColor = Colors.white;
const Color textButtonColor = Colors.white;
Color scaffoldBackgroundColor = Colors.grey.shade200;

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
const double defaultPadding = 20;

// Duration
const int pageChangeTransitionDuration = 500;

// TextDirection
const TextDirection defaultTextDirection = TextDirection.ltr;

// Size
const double reviewBoxSize = 300;
const double reviewBoxHeight = 200;

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

// API
const String baseUrl = 'http://localhost:3000/api';
