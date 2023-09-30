import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../resources.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key, this.text, this.icon}) : super(key: key);
  final String? text;
  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: symmetricPadding(0, 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon ?? const Icon(CupertinoIcons.list_bullet),
            20.heightBox(),
            AppText(
              text ?? 'empty',
              textAlign: TextAlign.center,
              style: AppStyles.medium18.copyWith(color: Colors.black45),
            ),
            70.heightBox(),
          ],
        ),
      ),
    );
  }
}
