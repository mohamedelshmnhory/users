import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/decorations.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
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
    this.suffix,
    this.prefix,
    this.prefixIcon,
    this.userInput = true,
    this.onUserTap,
    this.maxLines = 1,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.focusNode,
    this.isDense = true,
    this.isPassword = false,
    this.maxLength,
    this.textStyle,
    this.autovalidateMode,
    this.textAlign,
    this.textDirection,
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
  final Widget? suffix;
  final Widget? prefix;
  final Widget? prefixIcon;
  final bool userInput;
  final GestureTapCallback? onUserTap;
  final int maxLines;
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final FocusNode? focusNode;
  final bool? isDense;
  final int? maxLength;
  final TextStyle? textStyle;
  final AutovalidateMode? autovalidateMode;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelKey != null)
          Row(
            children: [
              Text(
                labelKey ?? '',
                style: const TextStyle(
                  color: AppColors.browngrey,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 14.0,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(width: 4.0),
              Text(
                subLabel ?? '',
                style: const TextStyle(
                  color: AppColors.pinkishGrey,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.0,
                ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        GestureDetector(
          onTap: onUserTap,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              color: Colors.transparent,
            ),
            margin: margin ?? const EdgeInsets.symmetric(vertical: 10),
            child: Theme(
              data: Theme.of(context).copyWith(
                primaryColor: AppColors.brownishGrey,
              ),
              child: TextFormField(
                textAlign: textAlign ?? TextAlign.start,
                focusNode: focusNode,
                controller: controller,
                maxLines: maxLines,
                keyboardType: maxLines > 1 ? TextInputType.multiline : textInputType,
                enabled: userInput,
                initialValue: initialValue,
                validator: validator,
                onChanged: onChanged,
                obscureText: isPassword,
                textDirection: textDirection,
                autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
                style: const TextStyle(color: AppColors.blacktext, fontWeight: FontWeight.w600, fontSize: 15.0),
                onTap: () {
                  if (controller != null) {
                    if (controller!.selection == TextSelection.fromPosition(TextPosition(offset: controller!.text.length - 1))) {
                      controller!.selection = TextSelection.fromPosition(TextPosition(offset: controller!.text.length));
                    }
                  }
                },
                decoration: AppDecorations.inputTextDecoration(
                  suffix: suffix,
                  prefix: prefix,
                  prefixIcon: prefixIcon,
                  suffixIcon: suffixIcon,
                  fillColor: fillColor,
                  borderColor: borderColor,
                  focusedBorderColor: focusedBorderColor,
                  hint: hintKey,
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
