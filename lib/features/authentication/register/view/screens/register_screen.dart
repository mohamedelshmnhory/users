import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/dependencies/dependency_init.dart';
import '../../../../../core/services/alert.dart';
import '../../../../../core/services/generic_error_handler.dart';
import '../../../../../core/utils/app_validator.dart';
import '../../../../home/view/screens/home_screen.dart';
import '../../../../layout/layout.dart';
import '../../data/model/user.dart';
import '../../logic/register_cubit.dart';
import '../../../../../core/data/failures.dart';
import '../../../../../core/data/models/message_response.dart';
import '../../../../../core/resources.dart';
import '../../../../../core/services/redirect_manager.dart';
import '../../../../../core/view/widgets/app_screen.dart';
import '../../../../../core/view/widgets/text_fields/app_loading.dart';
import '../../../../../core/view/widgets/text_fields/app_text_field.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = '/register';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final cubit = getIt<RegisterCubit>();
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final passwordC = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

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
              AppText('Register a New Account', style: AppStyles.bold18.copyWith(color: AppColors.primary)),
              30.heightBox(),
              AppTextField(
                hintKey: 'Username',
                controller: name,
                textInputType: TextInputType.name,
                validator: (value) => AppValidator.validatorRequired(value),
                prefixIcon: const Icon(Icons.person, color: AppColors.primary),
              ),
              AppTextField(
                hintKey: 'Email',
                controller: email,
                textInputType: TextInputType.emailAddress,
                validator: (value) => AppValidator.validatorRequired(value),
                prefixIcon: const Icon(Icons.email, color: AppColors.primary),
              ),
              AppTextField(
                hintKey: 'Password',
                controller: password,
                isPassword: true,
                validator: (value) => AppValidator().validatePassword(value),
                prefixIcon: const Icon(Icons.lock, color: AppColors.primary),
              ),
              AppTextField(
                hintKey: 'Confirm Password',
                controller: passwordC,
                isPassword: true,
                validator: (value) => AppValidator().validatePassword(value, confirmPassword: password.text),
                prefixIcon: const Icon(Icons.lock, color: AppColors.primary),
              ),
              30.heightBox(),
              const AppText('By using the app, you agree to the'),
              GestureDetector(
                onTap: () {
                  // RedirectManager(context).redirect(Terms.id);
                },
                child: AppText(
                  'Privacy Policy and Terms of Service',
                  style: AppStyles.medium14.copyWith(
                    height: 1.5,
                    color: AppColors.appGreen,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              80.heightBox(),
              _registerButton,
              30.heightBox(),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: AppText(
                  'Back',
                  style: AppStyles.medium18.copyWith(
                    height: 2,
                    color: AppColors.darkGrey,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              50.heightBox(),
            ],
          ),
        ),
      ),
    );
  }

  BlocConsumer<RegisterCubit, RegisterState> get _registerButton {
    return BlocConsumer<RegisterCubit, RegisterState>(
      bloc: cubit,
      listener: (context, state) {
        final failure = state.failure;
        if (failure is ErrorFailure && failure.error is MessageResponse) {
          Alert.instance.error(context, failure.error.convertErrorsToString());
        } else if (failure != null) {
          GenericErrorHandler.instance.handle(onRetry: () => null, failure: failure, context: context);
        } else if (state.loginResponseModel != null) {
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
              final user = User(username: name.text, email: email.text, password: password.text);
              cubit.register(user: user);
            }
          },
          padding: symmetricPadding(0, 30),

          textKey: 'Create account',
        );
      },
    );
  }
}
