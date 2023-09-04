import 'package:flutter/material.dart';

import '../../../resources.dart';

class AppMaterialButton extends StatelessWidget {
  final Function? onTap;
  final String? image;
  final String? text;
  final Color? textColor;
  final Color? background;

  const AppMaterialButton({
    Key? key,
    this.onTap,
    this.image,
    this.text,
    this.background = Colors.white,
    this.textColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: () => onTap?.call(),
        tileColor: background,
        minLeadingWidth: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: image == null ? null : ImageLoader(path: image!),
        title: text == null ? null : Text(text!, style: TextStyle(color: textColor, fontWeight: FontWeight.w500)),
      ),
    );
  }
}
