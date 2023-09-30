// A method to show the dialog
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users/core/services/redirect_manager.dart';
import 'package:users/core/utils/app_validator.dart';
import 'package:users/core/view/widgets/app_screen.dart';
import 'package:users/core/view/widgets/text_fields/app_text_field.dart';
import 'package:users/features/home/data/models/job.dart';
import 'package:users/features/home/logic/jobs_cubit.dart';

import '../../../../core/data/api_manager.dart';
import '../../../../core/resources.dart';
import '../../../../core/services/alert.dart';
import '../../../../core/services/generic_error_handler.dart';
import '../../../../core/view/widgets/text_fields/app_loading.dart';
import 'home_screen.dart';

class AddEditJobScreen extends StatefulWidget {
  static const String id = 'add_edit_job';
  static const homeID = "${HomeScreen.id}/$id";
  const AddEditJobScreen({Key? key, this.job, required this.jobsCubit}) : super(key: key);
  final JobsCubit jobsCubit;
  final Job? job;

  @override
  State<AddEditJobScreen> createState() => _AddEditJobScreenState();
}

class _AddEditJobScreenState extends State<AddEditJobScreen> {
  final formKey = GlobalKey<FormState>();
  late Job job = widget.job ?? Job();

  @override
  Widget build(BuildContext context) {
    return AppScreen(
        title: 'Job',
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const AppText('Enter name and description'),
                20.heightBox(),
                AppTextField(
                  hintKey: 'Name',
                  initialValue: job.name,
                  onChanged: (value) => job.name = value,
                  validator: (value) => AppValidator.validatorRequired(value),
                ),
                10.heightBox(),
                AppTextField(
                  hintKey: 'Description',
                  initialValue: job.description,
                  onChanged: (value) => job.description = value,
                  maxLines: 4,
                ),
                40.heightBox(),
                BlocConsumer<JobsCubit, JobsState>(
                  bloc: widget.jobsCubit,
                  listener: (context, state) {
                    final failure = state.failure;
                    if (failure is ErrorFailure && failure.error is MessageResponse) {
                      Alert.instance.error(context, failure.error.convertErrorsToString());
                    } else if (failure != null) {
                      GenericErrorHandler.instance.handle(onRetry: () => null, failure: failure, context: context);
                    } else if (state.success) {
                      Alert.instance.success(context, null);
                      RedirectManager(context).back();
                    }
                  },
                  builder: (context, state) {
                    if (state.loading) return const AppLoadingWidget();
                    return AppButton(
                      textKey: 'Save',
                      onPressed: () {
                        if (formKey.currentState?.validate() == true) {
                          if (widget.job != null) {
                            widget.jobsCubit.updateJob(job);
                          } else {
                            widget.jobsCubit.addJob(job);
                          }
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
