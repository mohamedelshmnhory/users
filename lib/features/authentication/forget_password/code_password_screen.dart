import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/resources.dart';
import '../../../../core/services/redirect_manager.dart';
import '../../../../core/view/widgets/app_screen.dart';
import '../../../../core/view/widgets/text_fields/app_text_field.dart';
import '../../../core/data/api_manager.dart';
import '../../../core/dependencies/dependency_init.dart';
import '../../../core/services/alert.dart';
import '../../../core/services/generic_error_handler.dart';
import '../../../core/utils/app_validator.dart';
import '../../../core/view/widgets/text_fields/app_loading.dart';
import '../login/view/screen/login_screen.dart';
import '../register/data/model/user.dart';
import 'logic/forget_cubit.dart';

class CodePasswordScreen extends StatefulWidget {
  static const String id = '/code_password';
  const CodePasswordScreen({Key? key, required this.email}) : super(key: key);
  final String email;
  @override
  State<CodePasswordScreen> createState() => _CodePasswordScreenState();
}

class _CodePasswordScreenState extends State<CodePasswordScreen> {
  final cubit = getIt<ForgetCubit>();
  final code = TextEditingController();
  final password = TextEditingController();
  final passwordConfirmation = TextEditingController();
  final _key = GlobalKey();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      backgroundColor: Colors.transparent,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            50.heightBox(),
            ImageLoader(path: Assets.logo, height: 80),
            40.heightBox(),
            AppText('Enter the code and new password.', style: AppStyles.bold18.copyWith(color: AppColors.primary)),
            40.heightBox(),
            Directionality(
              textDirection: TextDirection.ltr,
              child: PinCodeTextField(
                length: 4,
                key: _key,
                cursorColor: AppColors.primary,
                animationType: AnimationType.scale,
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  disabledColor: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(12),
                  activeColor: AppColors.primary,
                  fieldWidth: SizeConfig.getW(70),
                  borderWidth: 2,
                  inactiveFillColor: AppColors.white,
                  inactiveColor: AppColors.accent,
                  selectedColor: AppColors.accent,
                  selectedFillColor: AppColors.accent,
                  activeFillColor: AppColors.primary,
                ),
                controller: code,
                textStyle: const TextStyle(color: AppColors.accent),
                enableActiveFill: true,
                onCompleted: (v) {},
                beforeTextPaste: (text) {
                  return true;
                },
                appContext: context,
                onChanged: (String value) {
                  code.text = value;
                },
              ),
            ),
            AppTextField(
              hintKey: 'Password',
              controller: password,
              validator: (value) => AppValidator().validatePassword(value),
              isPassword: true,
              prefixIcon: const Icon(Icons.lock, color: AppColors.primary ),
            ),
            AppTextField(
              hintKey: 'Confirm password',
              controller: passwordConfirmation,
              validator: (value) => AppValidator().validatePassword(value, confirmPassword: password.text),
              isPassword: true,
              prefixIcon: const Icon(Icons.lock, color: AppColors.primary),
            ),
            50.heightBox(),
            const Spacer(),
            _sendButton,
            30.heightBox(),
            if (Navigator.canPop(context))
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const AppText('Back'),
              ),
            50.heightBox(),
          ],
        ),
      ),
    );
  }

  BlocConsumer<ForgetCubit, ForgetState> get _sendButton {
    return BlocConsumer<ForgetCubit, ForgetState>(
      bloc: cubit,
      listener: (context, state) {
        final failure = state.failure;
        if (failure is ErrorFailure && failure.error is MessageResponse) {
          Alert.instance.error(context, failure.error.convertErrorsToString());
        } else if (failure != null) {
          GenericErrorHandler.instance.handle(onRetry: () => null, failure: failure, context: context);
        } else if (state.status == true) {
          RedirectManager(context).redirectAndPopStack(LoginScreen.id);
        }
      },
      builder: (context, state) {
        if (state.loading) {
          return const AppLoadingWidget();
        }
        return AppButton(
          onPressed: () {
            if (formKey.currentState?.validate() == true) {
              final user = User(email: widget.email, code: code.text, password: password.text);
              cubit.forgetUpdate(user: user);
            }
          },
          padding: symmetricPadding(0, 30),

          textKey: 'Confirm',
        );
      },
    );
  }
}
