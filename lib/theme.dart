import 'package:flutter/material.dart';

ThemeData currioTheme() {
  TextTheme _basicTextTheme(TextTheme base) {
    return base.copyWith(
      headline1: base.headline1.copyWith(
        fontFamily: 'Karla',
      ),
     headline2: base.headline2.copyWith(
       fontFamily: 'Karla',

     ),

      caption: base.caption.copyWith(

        fontFamily: 'Montserrat',
      ),
      bodyText1: base.bodyText1.copyWith(
        fontFamily: 'Montserrat'
      ),
    );
  }

  final ThemeData base = ThemeData.light();
  return base.copyWith(
      textTheme: _basicTextTheme(base.textTheme),
      brightness: Brightness.dark,
  primaryColor: Color.fromARGB(255,236,137,46),
  accentColor: Color.fromARGB(255, 51, 69, 78),

);

}