import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../resources.dart';
import '../../utils/utils.dart';
import 'buttons/app_back_button.dart';

class AppScreen extends StatelessWidget {
  const AppScreen(
      {Key? key,
      required this.child,
      this.bottomNavigationBar,
      this.withBack = true,
      this.appBar,
      this.title,
      this.lightStatusBar = false,
      this.displayActions = false,
      this.actions,
      this.centerTitle = true,
      this.padding,
      this.leading,
      this.floatingActionButton,
      this.backgroundColor = AppColors.white,
      this.drawer})
      : super(key: key);

  final Widget child;
  final Widget? bottomNavigationBar;
  final AppBar? appBar;
  final String? title;
  final bool lightStatusBar;
  final bool centerTitle;
  final EdgeInsetsGeometry? padding;
  final bool displayActions;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final Widget? drawer;
  final bool withBack;

  @override
  Widget build(BuildContext context) {
    final uiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: AppColors.transparent,
      statusBarIconBrightness: lightStatusBar ? Brightness.light : Brightness.dark,
      // For Android (dark icons)
      statusBarBrightness: lightStatusBar ? Brightness.dark : Brightness.light,
      // For iOS (dark icons)
      systemStatusBarContrastEnforced: true,
      systemNavigationBarColor: Colors.transparent,
      // systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: lightStatusBar ? Brightness.light : Brightness.dark,
    );

    return AnnotatedRegion(
      value: uiOverlayStyle,
      child: Scaffold(
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(padding: padding ?? symmetricPadding(0, 15), child: child),
        ),
        appBar: withBack || appBar != null || title != null || !isNullOrEmpty(actions) ? buildAppBar(context) : null,
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
        drawer: drawer,
      ),
    );
  }

  List<Widget> buildActions(BuildContext context) {
    if (actions != null) {
      return actions!;
    }
    // if (displayActions) {
    //   return [
    //     const CartIcon(color: AppColors.black),
    //     if (signedInUser)
    //       IconButton(
    //         onPressed: () =>
    //             Navigator.of(context).pushNamed(NotificationsScreen.id),
    //         icon: SvgPicture.asset(Assets.notification),
    //       ),
    //   ];
    // }
    return [];
  }

  buildLeading(BuildContext context) {
    return withBack && Navigator.of(context).canPop()
        ? InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: EdgeInsets.all(3.0.sp),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(
                    CupertinoIcons.back,
                    color: Colors.deepOrange,
                    size: 24.sp,
                  ),
                ),
              ),
            ),
          )
        : leading ?? const SizedBox();
  }

  PreferredSizeWidget? buildAppBar(BuildContext context) {
    if (appBar != null) {
      return AppBar(
        automaticallyImplyLeading: false,
        title: appBar!.title,
        leading: buildLeading(context),
        actions: buildActions(context),
        centerTitle: true,
        backgroundColor: AppColors.cherryRed,
      );
    }
    if (title != null || lightStatusBar) {
      return getAppbar(context,
          title: title,
          leading: buildLeading(context),
          transparent: lightStatusBar,
          actions: buildActions(context),
          centerTitle: centerTitle);
    }
    return null;
  }
}

AppBar getAppbar(
  BuildContext context, {
  String? title,
  String? titleColor,
  List<Widget>? actions,
  bool? transparent,
  Widget? leading,
  bool centerTitle = true,
}) {
  return AppBar(
    centerTitle: centerTitle,
    automaticallyImplyLeading: false,
    backgroundColor: transparent == null ? AppColors.accent : AppColors.accent,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: AppColors.transparent,
      statusBarIconBrightness: transparent ?? false ? Brightness.light : Brightness.dark,
      // For Android (dark icons)
      statusBarBrightness: transparent ?? false ? Brightness.dark : Brightness.light,
      // For iOS (dark icons)
      systemStatusBarContrastEnforced: true,
      systemNavigationBarColor: Colors.transparent,
      // systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: transparent ?? false ? Brightness.light : Brightness.dark,
    ),
    leading: leading ?? (Navigator.canPop(context) ? const AppBackButton() : null),
    title: AppText(
      title ?? '',
      style: AppStyles.bold18,
    ),
    actions: actions,
  );
}
