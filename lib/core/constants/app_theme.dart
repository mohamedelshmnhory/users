import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources.dart';

final radius = BorderRadius.circular(12.sp);

class AppTheme {
  AppTheme._();

  static final ThemeData light = ThemeData(
    // useMaterial3: true,
    fontFamily: 'Mooli',
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: AppColors.accent, elevation: 4.sp),
    // primaryColorBrightness: Brightness.light,
    colorScheme: const ColorScheme.light().copyWith(
      primary: AppColors.primary,
      secondary: AppColors.primary,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.primary,
    ),
    cardTheme: CardTheme(color: AppColors.accent, elevation: 4.sp, shape: RoundedRectangleBorder(borderRadius: radius)),
    // scaffoldBackgroundColor: AppColors.accent,
    //configure button theme
    buttonTheme: ButtonThemeData(
      colorScheme: const ColorScheme.light().copyWith(
        primary: AppColors.primary,
        secondary: AppColors.primary,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
          // minimumSize: const Size(double.infinity, 50),
          foregroundColor: AppColors.primary,
          textStyle: const TextStyle(color: AppColors.accent),
          shape: RoundedRectangleBorder(borderRadius: radius)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: radius, borderSide: const BorderSide(color: AppColors.greyApp)),
    ),
    //configure app bar theme
    appBarTheme: AppBarTheme(
      toolbarHeight: 60,
      elevation: 5,
      iconTheme: const IconThemeData(color: AppColors.black),
      // color: AppColors.primary,
      backgroundColor: AppColors.white,
      titleTextStyle: AppStyles.bold18.copyWith(fontFamily: 'Mooli'),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: AppColors.white),
    navigationBarTheme: const NavigationBarThemeData(backgroundColor: AppColors.white, elevation: 15, height: 60),
    navigationRailTheme: const NavigationRailThemeData(backgroundColor: AppColors.white, elevation: 15),
    //list tile
    listTileTheme: ListTileThemeData(
      iconColor: AppColors.primary,
      shape: RoundedRectangleBorder(borderRadius: radius),
    ),
    // textTheme: const TextTheme(
    //   displayLarge: TextStyle(color: AppColors.black, fontSize: 22, fontWeight: FontWeight.w700),
    //   displayMedium: TextStyle(color: AppColors.black, fontSize: 22, fontWeight: FontWeight.w600),
    //   displaySmall: TextStyle(color: AppColors.black, fontSize: 22, fontWeight: FontWeight.w500),
    //   headlineMedium: TextStyle(color: AppColors.black, fontSize: 22, fontWeight: FontWeight.w400),
    //   headlineSmall: TextStyle(color: AppColors.black, fontSize: 22, fontWeight: FontWeight.w300),
    //   bodyLarge: TextStyle(color: AppColors.black, fontSize: 18, fontWeight: FontWeight.w500),
    //   bodyMedium: TextStyle(color: AppColors.black, fontSize: 16, fontWeight: FontWeight.w400),
    //   titleMedium: TextStyle(color: Color(0xff6A6A6A), fontSize: 17, fontWeight: FontWeight.w500),
    //   titleSmall: TextStyle(color: Color(0xff6A6A6A), fontSize: 17, fontWeight: FontWeight.w400),
    //   labelLarge: TextStyle(color: AppColors.black, fontSize: 16, fontWeight: FontWeight.w700),
    // ),
  );

  static final ThemeData dark = ThemeData(
    fontFamily: 'Mooli',
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    // primaryColorBrightness: Brightness.dark,
    colorScheme: const ColorScheme.dark().copyWith(secondary: AppColors.primary),
  );
}
