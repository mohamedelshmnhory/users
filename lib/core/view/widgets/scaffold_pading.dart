import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'sizeConfig.dart';

class ScaffoldPadding extends StatelessWidget {
  final Widget child;
  final double? bottomPadding;
  const ScaffoldPadding({required this.child, this.bottomPadding, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: 16.w,
        left: 16.w,
        top: MediaQuery.of(context).padding.top,
        bottom: bottomPadding ?? 0,
      ),
      child: child,
    );
  }
}

EdgeInsets symmetricPadding(height, width) {
  return EdgeInsets.symmetric(horizontal: SizeConfig.getW(width), vertical: SizeConfig.getH(height));
}
