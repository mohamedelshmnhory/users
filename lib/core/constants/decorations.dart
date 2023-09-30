import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources.dart';

class AppDecorations {
  static InputDecoration inputTextDecoration({
    String? hint,
    String? label,
    Widget? suffixIcon,
    Widget? suffix,
    Widget? prefix,
    Widget? prefixIcon,
    Color? fillColor,
    Color? borderColor,
    Color? focusedBorderColor,
    bool? isDense,
  }) =>
      InputDecoration(
        prefixIconConstraints: const BoxConstraints(minHeight: 16, minWidth: 46),
        prefixIcon: prefixIcon,
        suffix: suffix,
        prefix: prefix,
        contentPadding: isDense == null ? const EdgeInsets.symmetric(horizontal: 16, vertical: 18) : symmetricPadding(12, 12),
        suffixIcon: suffixIcon,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            width: 1.5,
            color: focusedBorderColor ?? AppColors.primary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            width: 1.5,
            color: borderColor ?? AppColors.veryLightBlue,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(width: 1.5, color: AppColors.veryLightBlue),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: AppColors.cherryRed),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: AppColors.cherryRed),
        ),
        errorStyle: const TextStyle(
          color: AppColors.watermelon,
          fontWeight: FontWeight.w400,
          height: 1.0,
          fontSize: 14.0,
        ),
        hintText: hint,
        labelText: label,
        hintStyle: AppStyles.medium12,
        fillColor: fillColor ?? AppColors.white,
        // focusColor: AppColors.brownishGrey,
        filled: true,
        alignLabelWithHint: true,
        isDense: isDense,
      );

  static final DecorationTween _tween = DecorationTween(
    begin: BoxDecoration(
      color: CupertinoColors.systemYellow,
      boxShadow: const <BoxShadow>[],
      borderRadius: BorderRadius.circular(20.0),
    ),
    end: BoxDecoration(
      color: CupertinoColors.systemYellow,
      boxShadow: CupertinoContextMenu.kEndBoxShadow,
      borderRadius: BorderRadius.circular(20.0),
    ),
  );

  // Or just do this inline in the builder below?
  static Animation<Decoration> boxDecorationAnimation(Animation<double> animation) {
    return _tween.animate(
      CurvedAnimation(
        parent: animation,
        curve: Interval(0.0, CupertinoContextMenu.animationOpensAt),
      ),
    );
  }
}

// DropDownDecoratorProps buildDropDownDecoratorProps(String title) {
//   return DropDownDecoratorProps(
//     baseStyle: AppStyles.medium14,
//     dropdownSearchDecoration: InputDecoration(
//       hintText: '${''} $title',
//       hintStyle: TextStyle(fontSize: 12.sp),
//       filled: true,
//       fillColor: Colors.white,
//       border: buildOutlineInputBorder,
//       enabledBorder: buildOutlineInputBorder,
//       focusedBorder: buildOutlineInputBorder,
//       isDense: true,
//       contentPadding: EdgeInsets.only(right: 10.w, left: 10.w, top: 5.h, bottom: 15.h),
//     ),
//
//     // contentPadding: EdgeInsetsDirectional.only(start: SizeConfig.getW(10))),
//   );
// }

OutlineInputBorder get buildOutlineInputBorder {
  return OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.grey));
}

// TextFieldProps buildSearchFieldProps(String title) {
//   return TextFieldProps(
//     decoration: InputDecoration(
//       labelText: '${'Search'} $title',
//       prefixIcon: const Icon(Icons.search),
//     ),
//   );
// }
