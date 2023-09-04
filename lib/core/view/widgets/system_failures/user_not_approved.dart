import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../resources.dart';
import '../buttons/app_card_button.dart';

class UserNotApproved extends StatelessWidget {
  const UserNotApproved({Key? key}) : super(key: key);

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
        const AppText('not approved'),
        SizedBox(height: 12.h),
        AppCardButton(
          onTap: () => SystemNavigator.pop(),
          text: 'close',
        ),
      ],
    );
  }
}
