import 'package:flutter/material.dart';

get darkTheme => ThemeData(
      hintColor: Colors.yellow,
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
      accentIconTheme: IconThemeData(color: Colors.white),
      fontFamily: 'OpenSans',
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
        bodyText1: TextStyle(
          color: Colors.white,
          fontFamily: 'OpenSans',
          fontSize: 9,
        ),
      ),
    );
