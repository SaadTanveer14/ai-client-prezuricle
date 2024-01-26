import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeManager with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  get themeMode => _themeMode;

  toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

// const primaryColor = Color(0xFF2656F5);
const primaryColor = Color(0xff083788);
// const primaryColor = Color(0xff8424FF);
const lightTitleColor = Color(0xFF171717);
const lightGreyTextColor = Color(0xFFA3A3A3);
const darkTitleColor = Color(0xFFFFFFFF);
const darkContainer = Color(0xff323241);
const darkGreyTextColor = Color(0xFFA1A4A8);
const darkContainerColor = Color(0xFF181824);
const lightContainerColor = Color(0xFFF4F4F4);
const lightIconColor = Color(0xFF171717);
const darkIconColor = Color(0xFFFFFFFF);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: primaryColor,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: primaryColor),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    brightness: Brightness.light,
    primary: const Color(0xFF204DE9),
    primaryContainer: const Color(0xffFFFFFF),
    secondaryContainer: const Color(0xffFFFFFF),
    background: const Color(0xffF3F7FF),
    onBackground: const Color(0xFFEAECFF),
    // background: const Color(0xFFFFFFFF),
    // onBackground: const Color(0xFFFFFFFF),
    shadow: const Color(0xffE5E5E5),
    // shadow: const Color(0xFFFFFFFF),
  ),
  inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0), borderSide: BorderSide.none), filled: true, fillColor: Colors.grey.withOpacity(0.1)),
  textTheme: TextTheme(
    titleMedium: GoogleFonts.inter(color: const Color(0xff0d1414), fontWeight: FontWeight.bold, fontSize: 16.0),
    bodyMedium: const TextStyle(color: Color(0xff0d1414), fontFamily: 'Display', fontSize: 14),
    bodySmall: const TextStyle(color: Color(0xff0d1414), fontFamily: 'Display', fontSize: 12),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  switchTheme: SwitchThemeData(
    trackColor: MaterialStateProperty.all<Color>(Colors.grey),
    thumbColor: MaterialStateProperty.all<Color>(Colors.white),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    brightness: Brightness.dark,
    primary: const Color(0xFF204DE9),
    primaryContainer: const Color(0xff01040D),
    secondaryContainer: const Color(0xff1A1D25),
    background: const Color(0xff01040D),
    onBackground: const Color(0xFF1A1D25),
    shadow: const Color(0xff01040D),
  ),
  inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0), borderSide: BorderSide.none), filled: true, fillColor: Colors.grey.withOpacity(0.1)),
  textTheme: TextTheme(
    titleMedium: GoogleFonts.inter(color: const Color(0xff0d1414), fontWeight: FontWeight.bold, fontSize: 16.0),
    bodyMedium: const TextStyle(color: Colors.white, fontFamily: 'Display', fontSize: 14),
    bodySmall: const TextStyle(color: Colors.white, fontFamily: 'Display', fontSize: 12),
  ),
);

final kButtonStyle = ButtonStyle(
  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
    const EdgeInsets.symmetric(horizontal: 100, vertical: 15.0),
  ),
  backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
  shape: MaterialStateProperty.all<OutlinedBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
);

LinearGradient kPrimaryGradiant = const LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFFFDFDFF),
    Color(0xFFF3F7FF),
  ],
);
