import 'package:flutter/cupertino.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CupertinoActivityIndicator());
    // return const Center(child: CircularProgressIndicator.adaptive());
  }
}
