import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/data/api_manager.dart';
import '../../../../../core/dependencies/dependency_init.dart';
import '../../../../../core/resources.dart';
import '../../../../../core/services/alert.dart';
import '../../../../../core/services/generic_error_handler.dart';
import '../../../../../core/services/redirect_manager.dart';
import '../../../../../core/utils/app_validator.dart';
import '../../../../../core/view/widgets/app_screen.dart';
import '../../../../../core/view/widgets/text_fields/app_loading.dart';
import '../../../../../core/view/widgets/text_fields/app_text_field.dart';
import '../../../../home/view/screens/home_screen.dart';
import '../../../forget_password/enter_email_screen.dart';
import '../../../register/data/model/user.dart';
import '../../../register/view/screens/register_screen.dart';
import '../../logic/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final cubit = getIt<LoginCubit>();
  final formKey = GlobalKey<FormState>();
  final username = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              50.heightBox(),
              ImageLoader(path: Assets.logo, height: 80),
              40.heightBox(),
              AppText(kIsWeb ? 'Web Login' : 'Login', style: AppStyles.bold18.copyWith(color: AppColors.primary)),
              30.heightBox(),
              AppTextField(
                hintKey: 'Username',
                controller: username,
                textInputType: TextInputType.name,
                validator: (value) => AppValidator.validatorRequired(value),
                prefixIcon: const Icon(Icons.person, color: AppColors.primary),
              ),
              AppTextField(
                hintKey: 'Password',
                controller: password,
                isPassword: true,
                validator: (value) => AppValidator.validatorRequired(value),
                prefixIcon: const Icon(Icons.lock, color: AppColors.primary),
              ),
              20.heightBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: _loginButton),
                  const Expanded(
                    child: InkWell(
                      // onTap: () => RedirectManager(context).redirect(EnterEmailScreen.id),
                      child: AppText('Forgot Password?', textAlign: TextAlign.right),
                    ),
                  ),
                ],
              ),
              // 40.heightBox(),
              // const AppText('Or sign in with'),
              // BlocConsumer<LoginCubit, LoginState>(
              //   bloc: cubit,
              //   listener: (context, state) {},
              //   builder: (context, state) {
              //     if (state.socialLoading) {
              //       return const Padding(
              //         padding: EdgeInsets.only(top: 20),
              //         child: AppLoadingWidget(),
              //       );
              //     }
              //     return Transform.scale(
              //       scale: .6,
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           GestureDetector(
              //             onTap: () {
              //               cubit.socialLogin(socialLogin: SocialLogin.google);
              //             },
              //             child: SizedBox(width: 100, height: 100, child: ImageLoader(path: Assets.google)),
              //           ),
              //           GestureDetector(
              //             onTap: () {
              //               cubit.socialLogin(socialLogin: SocialLogin.twitter);
              //             },
              //             child: SizedBox(width: 100, height: 100, child: ImageLoader(path: Assets.twitter)),
              //           ),
              //           GestureDetector(
              //             onTap: () {
              //               cubit.socialLogin(socialLogin: SocialLogin.facebook);
              //             },
              //             child: SizedBox(width: 100, height: 100, child: ImageLoader(path: Assets.facebook)),
              //           ),
              //         ],
              //       ),
              //     );
              //   },
              // ),
              30.heightBox(),
              AppButton(
                onPressed: () => RedirectManager(context).redirect(RegisterScreen.id),
                padding: symmetricPadding(0, 30),
                textKey: 'Create New Account',
              ),
              30.heightBox(),
              Navigator.canPop(context)
                  ? GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const AppText('Back'),
                    )
                  : GestureDetector(
                      onTap: () {
                        RedirectManager(context).redirectAndPopStack(HomeScreen.id);
                      },
                      child: const AppText('Skip'),
                    ),
              50.heightBox(),
            ],
          ),
        ),
      ),
    );
  }

  BlocConsumer<LoginCubit, LoginState> get _loginButton {
    return BlocConsumer<LoginCubit, LoginState>(
      bloc: cubit,
      listener: (context, state) {
        final failure = state.failure;
        if (failure is ErrorFailure && failure.error is MessageResponse) {
          Alert.instance.error(context, failure.error.convertErrorsToString());
        } else if (failure != null) {
          GenericErrorHandler.instance.handle(onRetry: () => null, failure: failure, context: context);
        } else if (state.loginResponse != null) {
          RedirectManager(context).redirectAndPopStack(HomeScreen.id);
        }
      },
      builder: (context, state) {
        if (state.loading) {
          return const AppLoadingWidget();
        }
        return AppButton(
          onPressed: () {
            if (formKey.currentState?.validate() == true) {
              final user = User(username: username.text, password: password.text);
              cubit.login(user: user);
            }
          },
          textKey: 'Login',
        );
      },
    );
  }
}
