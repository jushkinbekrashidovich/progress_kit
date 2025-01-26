import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppThemes {
  AppThemes._();

  static final light = ThemeData.light().copyWith(
    scaffoldBackgroundColor:  AppColors.backgroundColor, // Body background color
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: AppColors.backgroundColor, // App bar background color
      iconTheme: IconThemeData(color: AppColors.white),
      titleTextStyle: TextStyle(color: AppColors.white, fontSize: 18, fontWeight: FontWeight.w700),
    ),



    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.mainColor),
      bodyMedium: TextStyle(color: AppColors.white),
    ),
  );



}