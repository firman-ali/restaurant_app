import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  textTheme: TextTheme(
    headline1: GoogleFonts.robotoCondensed(
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    headline2: GoogleFonts.robotoCondensed(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    headline3: GoogleFonts.robotoCondensed(
      fontSize: 14,
      letterSpacing: 1,
      color: Colors.white,
    ),
    headline4: GoogleFonts.robotoCondensed(
      fontSize: 12,
      letterSpacing: 1,
    ),
    headline5: GoogleFonts.robotoCondensed(
      fontSize: 18,
      letterSpacing: 1,
      color: Colors.blueGrey,
    ),
    subtitle1: GoogleFonts.oxygen(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    subtitle2: GoogleFonts.oxygen(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    bodyText1: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    bodyText2: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    button: GoogleFonts.poppins(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
    ),
    caption: GoogleFonts.poppins(
      fontSize: 12,
      color: Colors.white,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
    ),
  ),
  iconTheme: const IconThemeData(color: Colors.blue, size: 25),
  primarySwatch: Colors.blue,
);

const Color darkPrimaryColor = Color(0xFF000000);
const Color darkSecondaryColor = Color(0xff64ffda);

ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: Colors.white,
  textTheme: TextTheme(
    headline1: GoogleFonts.robotoCondensed(
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    headline2: GoogleFonts.robotoCondensed(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    headline3: GoogleFonts.robotoCondensed(
      fontSize: 14,
      letterSpacing: 1,
      color: Colors.white,
    ),
    headline4: GoogleFonts.robotoCondensed(
      fontSize: 12,
      letterSpacing: 1,
    ),
    headline5: GoogleFonts.robotoCondensed(
      fontSize: 18,
      letterSpacing: 1,
      color: Colors.blueGrey,
    ),
    subtitle1: GoogleFonts.oxygen(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    subtitle2: GoogleFonts.oxygen(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    bodyText1: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    bodyText2: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    button: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
    ),
    caption: GoogleFonts.poppins(
      fontSize: 12,
      color: Colors.white,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
    ),
  ),
  iconTheme: const IconThemeData(color: Colors.blue),
);
