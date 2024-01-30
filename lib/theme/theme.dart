import 'package:ecommerce_app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeSelector with ChangeNotifier {

  ThemeMode _currentTheme = ThemeMode.system;
  ThemeMode get themeMode => _currentTheme;

  set themeMode(ThemeMode theme) {
    _currentTheme = theme;
    notifyListeners();
  }
}

class EcommerceTheme {

  static ThemeData buildLightTheme(BuildContext context) {
    final base = ThemeData.light();
    return base.copyWith(
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: blue700,
        modalBackgroundColor: Colors.white.withOpacity(0.7),
      ),
      // useMaterial3: true,
      cardColor: lightCardBackground,
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
        titleTextStyle: Theme.of(context).textTheme.headlineSmall
      ),
      textTheme: _buildLightTextTheme(base.textTheme),
    );
  }

  static ThemeData buildDarkTheme(BuildContext context) {
    final base = ThemeData.dark();
    return base.copyWith(
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: darkDrawerBackground,
        modalBackgroundColor: Colors.black.withOpacity(0.7)
      ),
      // useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: black900,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white
      ),
      appBarTheme: AppBarTheme(
        titleTextStyle: Theme.of(context).textTheme.headlineSmall
      ),
      textTheme: _buildDarkTextTheme(base.textTheme)
    );
  }
}

TextTheme _buildLightTextTheme(TextTheme base) {
  return base.copyWith(
    headlineMedium: GoogleFonts.workSans(
      fontWeight: FontWeight.w600,
      fontSize: 34,
      height: 0.9,
      color: lightText,
    ),

    headlineSmall: GoogleFonts.workSans(
      fontWeight: FontWeight.bold,
      fontSize: 24,
      color: lightText,
    ),

    titleLarge: GoogleFonts.workSans(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: lightText
    ),

    bodyLarge: GoogleFonts.workSans(
      fontWeight: FontWeight.normal,
      fontSize: 18,
      color: lightText
    ),

    bodyMedium: GoogleFonts.workSans(
      fontWeight: FontWeight.normal,
      fontSize: 16,
      color: lightText,
    ),

    bodySmall: GoogleFonts.workSans(
      fontWeight: FontWeight.normal,
      fontSize: 14,
      color: lightText
    )
  );
}

TextTheme _buildDarkTextTheme(TextTheme base) {
  return base.copyWith(
    headlineMedium: GoogleFonts.workSans(
      fontWeight: FontWeight.w600,
      fontSize: 34,
      height: 0.9,
      color: Colors.black
    ),

    headlineSmall: GoogleFonts.workSans(
      fontWeight: FontWeight.bold,
      fontSize: 24,
      color: Colors.black,
    ),

    titleLarge: GoogleFonts.workSans(
      fontWeight: FontWeight.w600,
      fontSize: 18,
      color: darkText
    ),

    titleMedium: GoogleFonts.workSans(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: darkText,
    ),

    titleSmall: GoogleFonts.workSans(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      color: darkText
    ),

    bodyLarge: GoogleFonts.workSans(
      fontWeight: FontWeight.normal,
      fontSize: 18,
      color: darkText,
    ),

    bodyMedium: GoogleFonts.workSans(
      fontWeight: FontWeight.normal,
      fontSize: 16,
      color: darkText,
    ),

    bodySmall: GoogleFonts.workSans(
      fontWeight: FontWeight.normal,
      fontSize: 14,
      color: darkText
    )
  );
}