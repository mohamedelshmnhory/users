import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      this.centerTitle = false,
      this.padding,
      this.leading,
      this.floatingActionButton,
      this.backgroundColor = AppColors.blueyGrey,
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
    // final uiOverlayStyle =   SystemUiOverlayStyle(
    //     // statusBarColor: AppColors.transparent,
    //     // statusBarIconBrightness: lightStatusBar ? Brightness.light : Brightness.dark,
    //     // // For Android (dark icons)
    //     // statusBarBrightness: lightStatusBar ? Brightness.dark : Brightness.light,
    //     // // For iOS (dark icons)
    //     // systemStatusBarContrastEnforced: true,
    //     // systemNavigationBarColor: Colors.transparent,
    //     // // systemNavigationBarDividerColor: Colors.transparent,
    //     // systemNavigationBarIconBrightness: lightStatusBar ? Brightness.light : Brightness.dark,
    //     );

    return
        // AnnotatedRegion(
        // value: uiOverlayStyle,
        // child:
        Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: padding ?? symmetricPadding(15, 15),
        child: child,
      ),
      appBar: withBack || appBar != null || title != null || !isNullOrEmpty(actions) ? buildAppBar(context) : null,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      drawer: drawer,
      // ),
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
    return withBack && Navigator.of(context).canPop() ? const AppBackButton() : leading;
  }

  PreferredSizeWidget? buildAppBar(BuildContext context) {
    if (appBar != null) {
      return appBar;
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
  bool centerTitle = false,
}) {
  return AppBar(
    toolbarHeight: 60,
    centerTitle: centerTitle,
    automaticallyImplyLeading: false,
    leading: leading ?? (Navigator.canPop(context) ? const AppBackButton() : null),
    title: AppText(title ?? ''),
    actions: actions,
  );
}
