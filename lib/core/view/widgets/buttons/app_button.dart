import 'package:flutter/material.dart';

import '../../../resources.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {Key? key,
      required this.textKey,
      required this.onPressed,
      this.height,
      this.width,
      this.margin,
      this.padding,
      this.child,
      this.suffix,
      this.prefix,
      this.color,
      this.isLoading = false,
      this.fontSize,
      this.startColor = const Color(0xff52b9b1),
      this.endColor = const Color(0xff004f9e),
      this.textColor})
      : super(key: key);

  final String textKey;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final Color? color;
  final Color? textColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Widget? child;
  final Widget? suffix;
  final Widget? prefix;
  final bool isLoading;
  final double? fontSize;
  final Color startColor;
  final Color endColor;

  @override
  Widget build(BuildContext context) {
    // final l10n = context.l10n;
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Container(
        width: width ?? double.infinity,
        margin: margin ?? EdgeInsets.zero,
        // height: SizeConfig.getFontSize(height ?? 50),
        decoration: const BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          // gradient: LinearGradient(
          //   begin: const Alignment(0.9, 0.5),
          //   end: const Alignment(0, 0.5),
          //   colors: [
          //     startColor,
          //     endColor,
          //   ],
          // ),
        ),
        child: MaterialButton(
          color: color,
          onPressed: onPressed,
          disabledColor: AppColors.brownishGrey,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: isLoading
              ? const CircularProgressIndicator(color: AppColors.white)
              : child ??
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: Center(child: prefix ?? const SizedBox())),
                      AppText(
                        textKey,
                        style: AppStyles.medium14.copyWith(
                          color: textColor ?? AppColors.white,
                          fontSize: fontSize,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Expanded(child: Center(child: suffix ?? const SizedBox())),
                    ],
                  ),
        ),
      ),
    );
  }
}
