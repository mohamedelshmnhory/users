import 'package:flutter/material.dart';
import 'package:users/core/resources.dart';

class IconTextTile extends StatelessWidget {
  const IconTextTile({Key? key, required this.text, required this.icon, this.textColor, this.btn}) : super(key: key);
  final String text;
  final String icon;
  final Widget? btn;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      textBaseline: TextBaseline.alphabetic,
      children: [
        5.widthBox(),
        ImageLoader(path: icon, scale: .5, color: AppColors.dark),
        5.widthBox(),
        Expanded(
          child: AppText(
            text,
            textDirection: text.contains('+') ? TextDirection.ltr : null,
            textAlign: TextAlign.right,
            style: AppStyles.medium14.copyWith(color: textColor ?? AppColors.dark),
          ),
        ),
        5.widthBox(),
        btn ?? const SizedBox(),
      ],
    );
  }
}
