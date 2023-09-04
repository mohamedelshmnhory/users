import 'package:flutter/material.dart';

import '../../resources.dart';

class MBusyStack extends StatelessWidget {
  final Widget child;
  final bool isBusy;

  const MBusyStack({Key? key, required this.child, required this.isBusy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Visibility(
          visible: isBusy,
          child: Positioned(
              left: 0,
              top: 0,
              child: Container(
                color: Colors.black.withOpacity(.3),
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight,
              )),
        ),
        Visibility(visible: isBusy, child: const CircularProgressIndicator())
      ],
    );
  }
}
