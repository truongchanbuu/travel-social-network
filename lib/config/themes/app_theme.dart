import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_social_network/cores/constants/constants.dart';

ThemeData themes() {
  return ThemeData(
    appBarTheme: appBarTheme(),
    fontFamily: GoogleFonts.roboto().fontFamily,
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    iconTheme: IconThemeData(color: secondaryColor),
    backgroundColor: primaryColor,
  );
}
