import 'package:flutter/material.dart';

Color _mainColor = Color.fromARGB(255, 4, 119, 251);
Color _mainDarkColor = const Color(0xFFFBBA04);
Color _secondColor = const Color(0xFF344968);
Color _secondDarkColor = const Color(0xFFccccdd);
Color _accentColor = const Color(0xFF83d5d0);
Color _accentDarkColor = const Color(0xFF9999aa);
Color _scaffoldDarkColor = const Color(0xFF2C2C2C);
Color _scaffoldColor = const Color(0xFFFAFAFA);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF252525),
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(secondary: Colors.red, primary: _mainColor),
  hintColor: _secondDarkColor,
  focusColor: _accentDarkColor,
  scaffoldBackgroundColor: const Color(0xFF2C2C2C),
  appBarTheme: AppBarTheme(backgroundColor:_secondColor ),
  textTheme: TextTheme(
    headline1: TextStyle(
        fontWeight: FontWeight.w400, fontSize: 20.0, color: _secondColor),
    headline2: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: _secondColor),
    headline3: TextStyle(
        fontSize: 20.0, fontWeight: FontWeight.w600, color: _secondColor),
    headline4: TextStyle(
        fontSize: 22.0, fontWeight: FontWeight.w700, color: _mainColor),
    headline5: TextStyle(
        fontSize: 22.0, fontWeight: FontWeight.w300, color: _secondColor),
    subtitle2: TextStyle(
        fontSize: 15.0, fontWeight: FontWeight.w500, color: _secondColor),
    subtitle1: TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.w600, color: _mainColor),
    bodyText1: TextStyle(fontSize: 12.0, color: _secondColor),
    bodyText2: TextStyle(fontSize: 14.0, color: _secondColor),
    caption: TextStyle(fontSize: 12.0, color: _accentColor),
  ),
);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.white,
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(secondary: Colors.red, primary: _mainColor),
  hintColor: _secondDarkColor,
  focusColor: _accentDarkColor,

  textTheme: TextTheme(
    headline1: TextStyle(
        fontWeight: FontWeight.w400, fontSize: 20.0, color: _secondColor),
    headline2: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: _secondColor),
    headline3: TextStyle(
        fontSize: 20.0, fontWeight: FontWeight.w600, color: _secondColor),
    headline4: TextStyle(
        fontSize: 22.0, fontWeight: FontWeight.w700, color: _mainColor),
    headline5: TextStyle(
        fontSize: 22.0, fontWeight: FontWeight.w300, color: _secondColor),
    subtitle2: TextStyle(
        fontSize: 15.0, fontWeight: FontWeight.w500, color: _secondColor),
    subtitle1: TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.w600, color: _mainColor),
    bodyText1: TextStyle(fontSize: 12.0, color: _secondColor),
    bodyText2: TextStyle(fontSize: 14.0, color: _secondColor),
    caption: TextStyle(fontSize: 12.0, color: _accentColor),
  ),
);
