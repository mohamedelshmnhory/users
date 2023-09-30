import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/constatnts.dart';
import '../../../core/data/failures.dart';
import '../../../core/data/models/message_response.dart';
import '../../../core/dependencies/dependency_init.dart';
import '../../../core/resources.dart';
import '../../../core/services/alert.dart';
import '../../../core/services/generic_error_handler.dart';
import '../../../core/utils/app_validator.dart';
import '../../../core/view/widgets/app_screen.dart';
import '../../../core/view/widgets/text_fields/app_loading.dart';
import '../../../core/view/widgets/text_fields/app_text_field.dart';
import '../../authentication/login/logic/auth_handler.dart';
import '../../authentication/register/data/model/user.dart';
import '../logic/profile_cubit.dart';

class EditPasswordScreen extends StatefulWidget {
  static const id = '/edit-password-screen';

  const EditPasswordScreen({super.key});

  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  final cubit = getIt<ProfileCubit>();
  final authHandler = getIt<AuthHandler>();
  final old = TextEditingController();
  final newPassword = TextEditingController();
  final newPasswordConfirm = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      title: 'Edit Password',
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            40.heightBox(),
            AppText('Enter your old password', style: buildGreyStyle),
            5.heightBox(),
            AppTextField(
              isPassword: true,
              controller: old,
              validator: (value) => AppValidator().validatePassword(value),
            ),
            15.heightBox(),
            AppText('Enter your new password', style: buildGreyStyle),
            5.heightBox(),
            AppTextField(
              isPassword: true,
              controller: newPassword,
              validator: (value) => AppValidator().validatePassword(value),
            ),
            15.heightBox(),
            AppText('Re-enter your new password', style: buildGreyStyle),
            5.heightBox(),
            AppTextField(
              isPassword: true,
              controller: newPasswordConfirm,
              validator: (value) => AppValidator().validatePassword(value, confirmPassword: newPassword.text),
            ),
            const Spacer(),
            _saveButton,
            25.heightBox(),
          ],
        ),
      ),
    );
  }

  BlocConsumer<ProfileCubit, ProfileState> get _saveButton {
    return BlocConsumer<ProfileCubit, ProfileState>(
      bloc: cubit,
      listener: (context, state) {
        final failure = state.failure;
        if (failure is ErrorFailure) {
          final error = failure.error;
          if (error is MessageResponse) {
            Alert.instance.error(context, error.message);
          }
        } else if (failure != null) {
          GenericErrorHandler.instance.handle(
            onRetry: () {},
            failure: failure,
            context: context,
          );
        } else if (state.profileResponseModel != null) {
          Navigator.of(context).pop(true);
        }
      },
      builder: (context, state) {
        if (state.loading) {
          return const AppLoadingWidget();
        }
        return AppButton(
          onPressed: () {
            if (formKey.currentState?.validate() != true) return;
            final user = User(method: PUT, new_password: newPassword.text, old_password: old.text);
            cubit.updateProfile(user);
          },
          padding: symmetricPadding(0, 50),
          textKey: 'Save',
        );
      },
    );
  }

  TextStyle get buildTextUnderline {
    return AppStyles.medium18.copyWith(height: 2, color: AppColors.primary, decoration: TextDecoration.underline);
  }

  TextStyle get buildGreyStyle => AppStyles.medium12.copyWith(color: AppColors.darkGrey);
}
