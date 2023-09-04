import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../resources.dart';
import '../buttons/app_card_button.dart';

class UpdateVersion extends StatelessWidget {
  final bool nominal;

  const UpdateVersion({Key? key, required this.nominal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (nominal) {
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
          const AppText('critical_update'),
          SizedBox(height: 12.h),
          AppCardButton(
            onTap: () => _downloadNewVersion(),
            text: 'download_now',
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
    } else {
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
          const AppText('critical_update'),
          SizedBox(height: 12.h),
          AppCardButton(
            onTap: () => _downloadNewVersion(),
            text: 'download_now',
          ),
        ],
      );
    }
  }

  void _downloadNewVersion() {
    if (Platform.isAndroid) {
      // launchUrlString("https://play.google.com/store/apps/dev?id=");
    } else if (Platform.isIOS) {}
  }
}
