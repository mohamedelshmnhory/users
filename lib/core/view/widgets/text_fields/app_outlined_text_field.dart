import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/app_colors.dart';

class AppOutlinedTextField extends StatelessWidget {
  const AppOutlinedTextField({
    Key? key,
    this.controller,
    this.hintKey,
    this.labelKey,
    this.subLabel,
    this.validator,
    this.onChanged,
    this.textInputType,
    this.initialValue,
    this.textInputAction,
    this.onFieldSubmitted,
    this.margin,
    this.suffixIcon,
    this.prefixIcon,
    this.userInput = true,
    this.onUserTap,
    this.maxLines,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.focusNode,
    this.isDense,
    this.maxLength,
    this.textStyle,
    this.autovalidateMode,
    this.textAlign,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? hintKey;
  final String? labelKey;
  final String? subLabel;
  final String? initialValue;
  final FormFieldValidator<String>? validator;
  final Function(String value)? onChanged;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final EdgeInsets? margin;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool userInput;
  final GestureTapCallback? onUserTap;
  final int? maxLines;
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final FocusNode? focusNode;
  final bool? isDense;
  final int? maxLength;
  final TextStyle? textStyle;
  final AutovalidateMode ? autovalidateMode;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onUserTap,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                color: Colors.transparent,
                border: Border.all(color: AppColors.guageGrey)
            ),
            margin: margin ?? EdgeInsets.symmetric(vertical: 6.sp),
            child: Theme(
              data: Theme.of(context).copyWith(
                primaryColor: AppColors.brownishGrey,
              ),
              child: TextFormField(
                textAlign: textAlign ?? TextAlign.start,
                focusNode: focusNode,
                controller: controller,
                maxLines: maxLines,
                keyboardType: (maxLines ?? 0) > 1
                    ? TextInputType.multiline
                    : textInputType,
                enabled: userInput,
                initialValue: initialValue,
                validator: validator,
                onChanged: onChanged,
                autovalidateMode: autovalidateMode?? AutovalidateMode.always,
                style: const TextStyle(
                  color: AppColors.blacktext,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0,
                ),

                decoration: InputDecoration(
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  alignLabelWithHint: true,
                  prefixIcon: prefixIcon,
                  suffixIcon: suffixIcon,
                  fillColor: fillColor,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.sp,vertical: 10.sp),
                  border: InputBorder.none,
                  labelText: labelKey,
                  hintText: hintKey,
                  isDense: isDense,
                ),
                textInputAction: textInputAction ?? TextInputAction.next,
                onFieldSubmitted: onFieldSubmitted,
                maxLength: maxLength,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
