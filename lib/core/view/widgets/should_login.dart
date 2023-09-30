import 'package:flutter/material.dart';
import 'package:users/core/services/redirect_manager.dart';

import '../../../features/authentication/login/logic/auth_handler.dart';
import '../../../features/authentication/login/view/screen/login_screen.dart';
import '../../dependencies/dependency_init.dart';
import '../../resources.dart';

class ShouldLogin extends StatefulWidget {
  final Widget? child;
  final bool dialog;
  const ShouldLogin({Key? key, this.child, this.dialog = false}) : super(key: key);

  @override
  State<ShouldLogin> createState() => _ShouldLoginState();
}

class _ShouldLoginState extends State<ShouldLogin> {
  @override
  Widget build(BuildContext context) {
    return getIt<AuthHandler>().loginModel == null
        ? Scaffold(
            backgroundColor: AppColors.white,
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // AppText("Register first", style: AppStyles.medium22),
                  // 20.heightBox(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: AppButton(
                      onPressed: () {
                        if (widget.dialog) {
                          Navigator.pop(context);
                        }
                        // showModalBottomSheet(
                        //   context: context,
                        //   isScrollControlled: true,
                        //   builder: (BuildContext context) {
                        //     return const LoginScreen();
                        //   },
                        // ).then((value) {
                        //   if (mounted) {
                        //     setState(() {});
                        //   }
                        // });
                        RedirectManager(context).redirectAndPopStack(LoginScreen.id);
                      },
                      textKey: 'LOGIN',
                    ),
                  ),
                ],
              ),
            ),
          )
        : widget.child!;
  }
}

Future<dynamic>? showLoginDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (ctx) => const Dialog(
            // backgroundColor: PRIMARY_COLOR,
            child: SizedBox(height: 200, child: ShouldLogin(dialog: true)),
          ));
}

class AdminWidget extends StatelessWidget {
  const AdminWidget({Key? key, this.child, this.adminWidget}) : super(key: key);
  final Widget? child;
  final Widget? adminWidget;
  @override
  Widget build(BuildContext context) {
    return (getIt<AuthHandler>().loginModel?.user?.is_superuser != true ? child : adminWidget) ?? const SizedBox();
  }
}
