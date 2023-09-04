import 'package:flutter/material.dart';

import '../resources.dart';

ThemeData datePickerThemeDate() => ThemeData(
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: Colors.white,
        onSurface: AppColors.primary,
        onSecondary: AppColors.primary,
        secondary: AppColors.bannerBackground,
      ),
      textTheme: TextTheme(
        labelLarge: AppStyles.generalTextStyle(),
        labelSmall: AppStyles.generalTextStyle(),
        titleSmall: AppStyles.generalTextStyle(),
        bodySmall: AppStyles.generalTextStyle(),
      ),
      dialogTheme: const DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    );
