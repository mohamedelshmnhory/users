import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources.dart';
import '../../../../core/services/redirect_manager.dart';
import '../../../../core/view/widgets/app_screen.dart';
import '../../../../core/view/widgets/text_fields/app_text_field.dart';
import '../../../core/data/failures.dart';
import '../../../core/data/models/message_response.dart';
import '../../../core/dependencies/dependency_init.dart';
import '../../../core/services/alert.dart';
import '../../../core/services/generic_error_handler.dart';
import '../../../core/view/widgets/text_fields/app_loading.dart';
import '../register/data/model/user.dart';
import 'code_password_screen.dart';
import 'logic/forget_cubit.dart';

class EnterEmailScreen extends StatefulWidget {
  static const String id = '/enter_email';
  const EnterEmailScreen({Key? key}) : super(key: key);

  @override
  State<EnterEmailScreen> createState() => _EnterEmailScreenState();
}

class _EnterEmailScreenState extends State<EnterEmailScreen> {
  final cubit = getIt<ForgetCubit>();
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      child: Column(
        children: [
          50.heightBox(),
          ImageLoader(path: Assets.logo, height: 80),
          40.heightBox(),
          AppText('Password Reset', style: AppStyles.bold18.copyWith(color: AppColors.primary)),
          30.heightBox(),
          AppTextField(
            labelKey: 'Email',
            hintKey: 'email',
            textInputType: TextInputType.emailAddress,
            controller: email,
            prefixIcon: const Icon(Icons.email, color: AppColors.primary),
          ),
          30.heightBox(),
          const Spacer(),
          _sendButton,
          30.heightBox(),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const AppText('Back'),
          ),
          50.heightBox(),
        ],
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
          RedirectManager(context).redirect(CodePasswordScreen.id, extra: email.text);
        }
      },
      builder: (context, state) {
        if (state.loading) {
          return const AppLoadingWidget();
        }
        return AppButton(
          onPressed: () {
            // if (formKey.currentState?.validate() == true) {
            final user = User(email: email.text);
            cubit.forgetRequest(user: user);
            // }
          },
          padding: symmetricPadding(0, 30),
          textKey: 'Send Code',
        );
      },
    );
  }
}
