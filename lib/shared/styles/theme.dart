import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
    fontFamily: 'Display',
    scaffoldBackgroundColor: scaffoldColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: bottomNavColor,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.yellow,
      unselectedItemColor: Colors.grey,
    ));
