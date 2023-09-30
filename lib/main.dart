import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:users/router/app_router.dart';
import 'package:users/core/constants/app_theme.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'core/app_flavor.dart';
import 'core/dependencies/dependency_init.dart';
import 'core/services/app_logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppFlavor.appFlavor = Flavors.production;
  configureDependencies();
  FlutterError.onError = (details) {
    AppLogger.instance.log(details.exceptionAsString(), logLevel: LogLevel.error, stackTrace: details.stack);
  };
  usePathUrlStrategy();
  // HttpOverrides.global = MyHttpOverrides();
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
        return MaterialApp.router(
          title: 'Users',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          // routerConfig: AppRouter.router,
          routerConfig: goRouter,
        );
      },
    );
  }
}

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
//   }
// }