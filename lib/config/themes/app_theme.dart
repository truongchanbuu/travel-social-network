import 'package:flutter/material.dart';
import 'package:go_transitions/go_transitions.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Colors.blueAccent;
  static const Color secondaryColor = Colors.white;
  static const primaryColorDark = Color(0xFF121212);
  static const secondaryColorDark = Colors.grey;
  static const sectionColorDark = Colors.blueGrey;

  static const Color backGroundExpansionItemColor = Colors.white;

  static const Color subtitleTicketDetailColor = Colors.amber;

  static const Color blackTextColor = Colors.black;
  static const Color whiteTextColor = Colors.white;
  static const Color textButtonColor = Colors.white;
  static const Color currencyTextColor = Colors.orange;

  static Color scaffoldBackgroundColor = Colors.grey.shade200;

  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      appBarTheme: _appBarTheme(isLight: true),
      fontFamily: GoogleFonts.roboto().fontFamily,
      pageTransitionsTheme: _pageTransitionsTheme(),
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
      ),
      scaffoldBackgroundColor: Colors.white,
      cardColor: Colors.white,
      dividerColor: Colors.grey[300],
      textTheme: _textTheme(isLight: true),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      appBarTheme: _appBarTheme(isLight: false),
      fontFamily: GoogleFonts.roboto().fontFamily,
      pageTransitionsTheme: _pageTransitionsTheme(),
      colorScheme: const ColorScheme.dark(
        primary: primaryColorDark,
        secondary: secondaryColorDark,
        surface: Color(0xFF1E1E1E),
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.white,
      ),
      scaffoldBackgroundColor: const Color(0xFF121212),
      cardColor: const Color(0xFF1E1E1E),
      dividerColor: Colors.grey[800],
      textTheme: _textTheme(isLight: false),
    );
  }

  static AppBarTheme _appBarTheme({required bool isLight}) {
    return AppBarTheme(
      iconTheme: const IconThemeData(color: secondaryColor),
      backgroundColor: isLight ? primaryColor : primaryColorDark,
      elevation: 0,
      centerTitle: true,
      foregroundColor: isLight ? Colors.black : Colors.white,
    );
  }

  static PageTransitionsTheme _pageTransitionsTheme() {
    return const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: GoTransitions.fadeUpwards,
        TargetPlatform.windows: GoTransitions.slide,
        TargetPlatform.iOS: GoTransitions.cupertino,
        TargetPlatform.macOS: GoTransitions.cupertino,
      },
    );
  }

  static TextTheme _textTheme({required bool isLight}) {
    Color textColor = isLight ? blackTextColor : whiteTextColor;

    return TextTheme(
      displayLarge: TextStyle(
        color: textColor,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: textColor,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        color: textColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: textColor,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        color: textColor,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: textColor,
        fontSize: 14,
      ),
    );
  }
}
