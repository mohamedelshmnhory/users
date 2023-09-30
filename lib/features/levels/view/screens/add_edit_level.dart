// A method to show the dialog
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users/core/services/redirect_manager.dart';
import 'package:users/core/utils/app_validator.dart';
import 'package:users/core/view/widgets/app_screen.dart';
import 'package:users/core/view/widgets/text_fields/app_text_field.dart';

import '../../../../core/data/api_manager.dart';
import '../../../../core/resources.dart';
import '../../../../core/services/alert.dart';
import '../../../../core/services/generic_error_handler.dart';
import '../../../../core/view/widgets/text_fields/app_loading.dart';
import '../../../home/view/screens/home_screen.dart';
import '../../data/models/level.dart';
import '../../logic/levels_cubit.dart';
import 'levels_screen.dart';

class AddEditLevelScreen extends StatefulWidget {
  static const String id = 'add_edit_level';
  static const homeLevelsID = "${HomeScreen.id}/${LevelsScreen.id}/$id";
  const AddEditLevelScreen({Key? key, this.level, required this.levelsCubit}) : super(key: key);
  final LevelsCubit levelsCubit;
  final Level? level;

  @override
  State<AddEditLevelScreen> createState() => _AddEditLevelScreenState();
}

class _AddEditLevelScreenState extends State<AddEditLevelScreen> {
  final formKey = GlobalKey<FormState>();
  late Level level = widget.level ?? Level();

  @override
  Widget build(BuildContext context) {
    return AppScreen(
        title: 'Level',
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const AppText('Enter name and description'),
                20.heightBox(),
                AppTextField(
                  hintKey: 'Name',
                  initialValue: level.name,
                  onChanged: (value) => level.name = value,
                  validator: (value) => AppValidator.validatorRequired(value),
                ),
                10.heightBox(),
                AppTextField(
                  hintKey: 'Description',
                  initialValue: level.description,
                  onChanged: (value) => level.description = value,
                  maxLines: 4,
                ),
                40.heightBox(),
                BlocConsumer<LevelsCubit, LevelsState>(
                  bloc: widget.levelsCubit,
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
                          if (widget.level != null) {
                            widget.levelsCubit.updateLevel(level);
                          } else {
                            widget.levelsCubit.addLevel(level);
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
