import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class AppStyles {
  static TextStyle bold18 = const TextStyle(color: AppColors.fontColor, fontWeight: FontWeight.bold, fontSize: 18);
  static TextStyle bold14 = const TextStyle(color: AppColors.fontColor, fontWeight: FontWeight.bold, fontSize: 14);
  static TextStyle bold15 = const TextStyle(color: AppColors.fontColor, fontWeight: FontWeight.bold, fontSize: 15);

  static TextStyle bold10 = const TextStyle(color: AppColors.fontColor, fontWeight: FontWeight.bold, fontSize: 10);
  static TextStyle bold12 = const TextStyle(color: AppColors.fontColor, fontWeight: FontWeight.bold, fontSize: 12);
  static TextStyle bold22 = const TextStyle(color: AppColors.fontColor, fontWeight: FontWeight.bold, fontSize: 22);

  static TextStyle bold20 = const TextStyle(color: AppColors.fontColor, fontWeight: FontWeight.bold, fontSize: 20);
  static TextStyle bold24 = const TextStyle(color: AppColors.fontColor, fontWeight: FontWeight.bold, fontSize: 24);

  static TextStyle medium18 = const TextStyle(color: AppColors.fontColor, fontWeight: FontWeight.normal, fontSize: 18);

  static TextStyle medium16 = const TextStyle(color: AppColors.fontColor, fontWeight: FontWeight.normal, fontSize: 16);
  static TextStyle medium20 = const TextStyle(color: AppColors.fontColor, fontWeight: FontWeight.normal, fontSize: 20);
  static TextStyle medium22 = const TextStyle(color: AppColors.fontColor, fontWeight: FontWeight.normal, fontSize: 22);
  static TextStyle medium12 = const TextStyle(color: AppColors.fontColor, fontWeight: FontWeight.normal, fontSize: 12);
  static TextStyle medium10 = const TextStyle(color: AppColors.fontColor, fontWeight: FontWeight.normal, fontSize: 10);
  static TextStyle medium14 = const TextStyle(color: AppColors.fontColor, fontWeight: FontWeight.normal, fontSize: 14);

  static BoxDecoration buttonShadow({Color? color}) => BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color ?? AppColors.shadow,
            blurRadius: 5,
            offset: const Offset(2, 4),
          ),
        ],
      );

  static TextStyle generalTextStyle({double? fontSize, Color? color, FontWeight? fontWeight}) => TextStyle(
        fontWeight: fontWeight ?? FontWeight.w500,
        color: color ?? Colors.black,
        fontSize: fontSize ?? 18,
        // fontFamily: 'Hacen-Tunisia',
      );
}
