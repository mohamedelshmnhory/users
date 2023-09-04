import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:users/core/constants/app_theme.dart';

import 'core/app_flavor.dart';
import 'core/dependencies/dependency_init.dart';
import 'core/services/app_logger.dart';
import 'features/users/view/screens/users_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppFlavor.appFlavor = Flavors.production;
  configureDependencies();
  FlutterError.onError = (details) {
    AppLogger.instance.log(details.exceptionAsString(), logLevel: LogLevel.error, stackTrace: details.stack);
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        useInheritedMediaQuery: true,
        builder: (context, mediaQuery) {
          return MaterialApp(
            title: 'Users',
            theme: AppTheme.light,
            home: const UsersList(),
          );
        });
  }
}
