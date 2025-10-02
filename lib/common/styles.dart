import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color darkGreen = Color(0xFF706D54);
const Color khaki = Color(0xFFA08963);
const Color beige = Color(0xFFC9B194);
const Color lightGray = Color(0xFFDBDBDB);

final ThemeData lightTheme = ThemeData(
  primaryColor: darkGreen,
  scaffoldBackgroundColor: Colors.white,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: GoogleFonts.latoTextTheme(),
  colorScheme: const ColorScheme.light(
    primary: darkGreen,
    secondary: khaki,
    surface: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
  ),
  appBarTheme: const AppBarTheme(elevation: 0, backgroundColor: darkGreen),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: darkGreen,
      foregroundColor: Colors.white,
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  primaryColor: beige,
  scaffoldBackgroundColor: Colors.grey[900],
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: GoogleFonts.latoTextTheme(ThemeData.dark().textTheme),
  colorScheme: const ColorScheme.dark(
    primary: beige,
    secondary: khaki,
    surface: Color(0xFF121212),
    onPrimary: Colors.black,
    onSecondary: Colors.white,
  ),
  appBarTheme: AppBarTheme(elevation: 0, backgroundColor: Colors.grey[850]),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: beige,
      foregroundColor: Colors.black,
    ),
  ),
);
