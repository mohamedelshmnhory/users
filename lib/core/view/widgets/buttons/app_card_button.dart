import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../resources.dart';

class AppCardButton extends StatelessWidget {
  final Function? onTap;
  final String? text;
  final Color? color;
  final Color? shadowColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final Widget? child;
  final bool hasClicker;
  final Widget? prefix;
  final Widget? suffix;

  const AppCardButton({
    Key? key,
    this.onTap,
    this.text,
    this.color,
    this.height,
    this.child,
    this.width,
    this.prefix,
    this.suffix,
    this.shadowColor,
    this.hasClicker = false,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (hasClicker) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: color ?? AppColors.deepOrange,
        shadowColor: shadowColor ?? AppColors.shadow,
        elevation: 3,
        child: Container(
          width: width?.w ?? 200.w,
          height: height?.h ?? 56.h,
          decoration: AppStyles.buttonShadow(color: shadowColor),
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              prefix ?? const SizedBox(),
              child ??
                  AppText(text ?? "",
                      textAlign: TextAlign.center, style: AppStyles.bold15.copyWith(color: textColor ?? AppColors.black)),
              suffix ?? const SizedBox()
            ],
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: () => onTap?.call(),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: color ?? AppColors.deepOrange,
          shadowColor: shadowColor ?? AppColors.shadow,
          elevation: 3,
          child: Container(
            width: width?.w ?? 200.w,
            height: height?.h ?? 56.h,
            decoration: AppStyles.buttonShadow(color: shadowColor),
            alignment: Alignment.center,
            child: child ??
                AppText(text ?? "",
                    textAlign: TextAlign.center, style: AppStyles.bold15.copyWith(color: textColor ?? AppColors.black)),
          ),
        ),
      );
    }
  }
}
