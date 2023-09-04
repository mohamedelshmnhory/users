import 'package:flutter/material.dart';

import '../../constants/app_styles.dart';

class AppText extends StatelessWidget {
  const AppText(this.text, {Key? key, this.style, this.textAlign, this.maxLines, this.textDirection}) : super(key: key);
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? AppStyles.medium16,
      textAlign: textAlign,
      maxLines: maxLines,
      textDirection: textDirection,
    );
  }
}
