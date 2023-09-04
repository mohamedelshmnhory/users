import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../resources.dart';
import '../buttons/app_card_button.dart';

class SomethingWentWrong extends StatefulWidget {
  const SomethingWentWrong({Key? key}) : super(key: key);

  @override
  State<SomethingWentWrong> createState() => _SomethingWentWrongState();
}

class _SomethingWentWrongState extends State<SomethingWentWrong> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.warning_rounded,
          color: AppColors.warningYellow,
          size: 100,
        ),
        SizedBox(height: 12.h),
        const AppText('some_thing_went_wrong'),
        SizedBox(height: 12.h),
        AppCardButton(
          onTap: () => _retry(),
          text: 'retry',
        ),
        SizedBox(height: 12.h),
        AppCardButton(
          onTap: () => SystemNavigator.pop(),
          text: 'close',
          color: AppColors.white,
          shadowColor: AppColors.white,
          textColor: AppColors.deepOrange,
        )
      ],
    );
  }

  void _retry() {
    // context.go(LoginScreen.id);
  }
}
