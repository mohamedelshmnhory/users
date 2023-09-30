import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class AppStyles {
  static TextStyle bold18 = TextStyle(color: AppColors.fontColor, fontWeight: FontWeight.bold, fontSize: 18.sp);
  static TextStyle bold14 = TextStyle(color: AppColors.fontColor, fontWeight: FontWeight.bold, fontSize: 14.sp);
  static TextStyle bold15 = TextStyle(color: AppColors.fontColor, fontWeight: FontWeight.bold, fontSize: 15.sp);

  static TextStyle bold10 = TextStyle(color: AppColors.fontColor, fontWeight: FontWeight.bold, fontSize: 10.sp);
  static TextStyle bold12 = TextStyle(color: AppColors.fontColor, fontWeight: FontWeight.bold, fontSize: 12.sp);
  static TextStyle bold22 = TextStyle(color: AppColors.fontColor, fontWeight: FontWeight.bold, fontSize: 22.sp);

  static TextStyle bold20 = TextStyle(color: AppColors.fontColor, fontWeight: FontWeight.bold, fontSize: 20.sp);
  static TextStyle bold24 = TextStyle(color: AppColors.fontColor, fontWeight: FontWeight.bold, fontSize: 24.sp);

  static TextStyle medium18 = TextStyle(color: AppColors.fontColor, fontWeight: FontWeight.normal, fontSize: 18.sp);

  static TextStyle medium16 = TextStyle(color: AppColors.fontColor, fontWeight: FontWeight.normal, fontSize: 16.sp);
  static TextStyle medium20 = TextStyle(color: AppColors.fontColor, fontWeight: FontWeight.normal, fontSize: 20.sp);
  static TextStyle medium22 = TextStyle(color: AppColors.fontColor, fontWeight: FontWeight.normal, fontSize: 22.sp);
  static TextStyle medium12 = TextStyle(color: AppColors.fontColor, fontWeight: FontWeight.normal, fontSize: 12.sp);
  static TextStyle medium10 = TextStyle(color: AppColors.fontColor, fontWeight: FontWeight.normal, fontSize: 10.sp);
  static TextStyle medium14 = TextStyle(color: AppColors.fontColor, fontWeight: FontWeight.normal, fontSize: 14.sp);

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
