import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'fonts.dart' show Fonts;

ThemeData get themeData => ThemeData(
      fontFamily: Fonts.cookie,
      primaryColor: Colors.green,
      accentColor: Colors.green[400],
      hoverColor: Colors.grey,
      buttonColor: Colors.green[800],
      // * Icon theme
      iconTheme: IconThemeData(color: Colors.white, size: 40.0),
      // * Text theme
      textTheme: TextTheme(
          headline1: TextStyle(
            fontFamily: Fonts.cookie,
            fontSize: 28.0,
            color: Colors.white,
          ),
          headline2: GoogleFonts.abel(
            color: Colors.white,
            fontSize: 18,
          )),
      // * textButton theme
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(
              GoogleFonts.alikeAngular(fontSize: 26.0)),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          backgroundColor: MaterialStateProperty.all(Colors.green[800]),
        ),
      ),
      // * Button theme
      // buttonTheme: ButtonThemeData(),
      // * Platform Target
      platform: TargetPlatform.windows,
    );
