import 'package:flutter/material.dart';


class AppBackButton extends StatelessWidget {
  const AppBackButton({
    Key? key,
    this.iconColor,
    this.onPressed,
  }) : super(key: key);

  final Color? iconColor;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      splashRadius: 20,
      onPressed: onPressed ??
          () {
            FocusScope.of(context).unfocus();
            if (Navigator.canPop(context)) Navigator.pop(context);
          },
      icon: const Icon(Icons.arrow_back),
    );
  }
}
