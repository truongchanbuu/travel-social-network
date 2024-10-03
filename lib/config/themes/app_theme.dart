import 'package:flutter/material.dart';
import 'package:go_transitions/go_transitions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_social_network/cores/constants/constants.dart';

ThemeData themes() {
  return ThemeData(
    appBarTheme: appBarTheme(),
    fontFamily: GoogleFonts.roboto().fontFamily,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: GoTransitions.fadeUpwards,
        TargetPlatform.windows: GoTransitions.slide,
        TargetPlatform.iOS: GoTransitions.cupertino,
        TargetPlatform.macOS: GoTransitions.cupertino,
      },
    ),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    iconTheme: IconThemeData(color: secondaryColor),
    backgroundColor: primaryColor,
  );
}
