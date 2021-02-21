import 'package:flutter/material.dart';

const brightness = Brightness.light;

const primaryColor = Colors.grey;
const primaryColorLight = Color(0xFFFCA639);
const primaryColorDark = Colors.black;
const accentColor = Color(0xFFFCA639);

const backgroundColor = Color(0xFFF9F9FA);
const errorColor = Color(0xFFB00020);

ThemeData lightTheme() {
  return ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: backgroundColor,
    backgroundColor: Colors.white,
    brightness: brightness,
    // tabBarTheme:
    // accentIconTheme:
    // accentTextTheme:
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: Colors.white,
      elevation: 5,
    ),
    // buttonTheme: new ButtonThemeData(
    //   buttonColor: Colors.orange,
    //   textTheme: ButtonTextTheme.primary,
    // ),
    // cardTheme: CardTheme(
    //   elevation: 5,
    //   color: Colors.indigo,
    // ),
    // chipTheme:
    // dialogTheme:
    // floatingActionButtonTheme:
    iconTheme: IconThemeData(
      color: Colors.black45,
    ),
    // inputDecorationTheme:
    // pageTransitionsTheme:
    // primaryIconTheme:
    // primaryTextTheme:
    // sliderTheme:
    //cardColor: Colors.white60,
    hintColor: Colors.grey[600],
    errorColor: errorColor,
    primaryColor: primaryColor,
    primaryColorLight: primaryColorLight,
    primaryColorDark: primaryColorDark,
    accentColor: accentColor,
    buttonColor: primaryColorLight,
    // fontFamily: 'Montserrat',
  );
}
