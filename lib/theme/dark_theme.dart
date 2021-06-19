import 'package:flutter/material.dart';

get darkTheme => ThemeData(
      primarySwatch: Colors.grey,
      appBarTheme: AppBarTheme(
        brightness: Brightness.dark,
        color: Colors.black,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.blueGrey),
        labelStyle: TextStyle(color: Colors.white),
      ),
      brightness: Brightness.dark,
      canvasColor: Colors.black45,
      accentColor: Colors.cyanAccent,
      cardColor: Color(0xff1c1c1c),
      accentIconTheme: IconThemeData(color: Colors.white),
      fontFamily: 'OpenSans',
      buttonColor: Colors.white,
      textTheme: TextTheme(
        headline1: TextStyle(
          color: Colors.white,
          fontFamily: 'OpenSans',
          fontSize: 14,
        ),
        headline2: TextStyle(
          color: Colors.white,
          fontFamily: 'OpenSans',
          fontSize: 11,
        ),
        headline3: TextStyle(
          color: Colors.white,
          fontFamily: 'OpenSans',
          fontSize: 30,
        ),
        bodyText1: TextStyle(
          color: Colors.black,
          fontFamily: 'OpenSans',
          fontSize: 9,
        ),
      ),
    );
