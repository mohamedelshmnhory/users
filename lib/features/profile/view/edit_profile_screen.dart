import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/decorations.dart';
import '../../../core/data/failures.dart';
import '../../../core/data/models/message_response.dart';
import '../../../core/dependencies/dependency_init.dart';
import '../../../core/resources.dart';
import '../../../core/services/alert.dart';
import '../../../core/services/generic_error_handler.dart';
import '../../../core/services/redirect_manager.dart';
import '../../../core/view/widgets/app_screen.dart';
import '../../../core/view/widgets/text_fields/app_loading.dart';
import '../../../core/view/widgets/text_fields/app_text_field.dart';
import '../../authentication/login/logic/auth_handler.dart';
import '../../authentication/login/view/screen/login_screen.dart';
import '../../authentication/register/data/model/user.dart';
import '../../home/data/models/job.dart';
import '../../home/data/models/jobs_request_params.dart';
import '../../home/data/repo/jobs_repo.dart';
import '../../levels/data/models/level.dart';
import '../../levels/data/models/levels_request_params.dart';
import '../../levels/data/repo/levels_repo.dart';
import '../../users/logic/users_cubit.dart';
import '../logic/profile_cubit.dart';
import 'edit_password_screen.dart';
import 'profile_screen.dart';

class EditProfileScreen extends StatefulWidget {
  static const id = 'edit-profile-screen';
  static const profileID = '/${ProfileScreen.id}/$id';
  const EditProfileScreen({super.key, required this.user});
  final User user;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final authHandler = getIt<AuthHandler>();
  final cubit = getIt<ProfileCubit>();
  final usersCubit = getIt<UsersCubit>();
  late final bool adminAccess = isAdmin;
  final email = TextEditingController();
  final phone = TextEditingController();
  final name = TextEditingController();
  final fullname = TextEditingController();
  List<Job> jobs = [];
  Level? level;

  @override
  void initState() {
    super.initState();
    email.text = widget.user.email ?? '';
    phone.text = widget.user.phone ?? '';
    name.text = widget.user.username ?? '';
    fullname.text = widget.user.fullname ?? '';
    jobs = widget.user.jobs ?? [];
    level = widget.user.level;
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      title: 'Edit',
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField(
              hintKey: widget.user.username ?? 'Username',
              controller: name,
              prefixIcon: const Icon(Icons.person, color: AppColors.primary),
            ),
            AppTextField(
              hintKey: widget.user.fullname ?? 'Fullname',
              controller: fullname,
              prefixIcon: const Icon(Icons.person_pin_rounded, color: AppColors.primary),
            ),
            AppTextField(
              hintKey: widget.user.email ?? 'Email',
              controller: email,
              prefixIcon: const Icon(Icons.email, color: AppColors.primary),
            ),
            AppTextField(
              hintKey: widget.user.phone ?? 'Phone',
              controller: phone,
              textInputType: TextInputType.phone,
              prefixIcon: const Icon(Icons.phone, color: AppColors.primary),
            ),
            15.heightBox(),
            DropdownSearch<Level>(
              popupProps: PopupProps.menu(
                // showSearchBox: true,
                // isFilterOnline: true,
                loadingBuilder: (context, _) => const AppLoadingWidget(),
                searchFieldProps: TextFieldProps(
                  decoration: AppDecorations.inputTextDecoration(
                    label: 'Search level',
                    isDense: true,
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
              selectedItem: level,
              dropdownDecoratorProps: DropDownDecoratorProps(
                baseStyle: AppStyles.medium14,
                dropdownSearchDecoration: AppDecorations.inputTextDecoration(isDense: true, hint: 'Level'),
              ),
              itemAsString: (Level level) => level.name ?? '-',
              asyncItems: (String filter) async {
                List<Level> levels = [];
                await getIt<LevelsRepo>().getLevels(LevelsRequestParams(name: filter, per_page: 50)).then((result) {
                  result.fold(
                    (l) => null,
                    (r) {
                      levels = r.results ?? [];
                    },
                  );
                });
                return levels;
              },
              onChanged: (Level? value) {
                level = value;
                // _tasksController
                //     .updateTask(
                //       Task(id: selectedTask!.id, level_id: value?.id),
                //     );
              },
            ),
            15.heightBox(),
            DropdownSearch<Job>.multiSelection(
              popupProps: PopupPropsMultiSelection.menu(
                showSearchBox: true,
                isFilterOnline: true,
                loadingBuilder: (context, _) => const AppLoadingWidget(),
                searchFieldProps: TextFieldProps(
                  decoration: AppDecorations.inputTextDecoration(
                    label: 'Search skill',
                    isDense: true,
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
              selectedItems: jobs,
              dropdownDecoratorProps: DropDownDecoratorProps(
                baseStyle: AppStyles.medium14,
                dropdownSearchDecoration: AppDecorations.inputTextDecoration(isDense: true, hint: 'Skills'),
              ),
              itemAsString: (Job job) => job.name ?? '-',
              asyncItems: (String filter) async {
                List<Job> jobs = [];
                await getIt<JobsRepo>().getJobs(JobsRequestParams(name: filter, per_page: 50)).then((result) {
                  result.fold(
                    (l) => null,
                    (r) {
                      jobs = r.results ?? [];
                    },
                  );
                });
                return jobs;
              },
              onChanged: (List<Job>? results) {
                jobs = results ?? jobs;
                // if (jobs != null) {
                //   getIt<TasksRepository>()
                //       .attachUsers(taskID: selectedTask!.id!, jobsIDs: jobs.map((e) => e.id!).toList())
                //       .whenComplete(() {
                //     selectedTask!.users = jobs;
                //   });
                // }
              },
            ),
            15.heightBox(),
            if (!adminAccess)
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                    return const EditPasswordScreen();
                  })).then((value) => value == true ? showDoneMessage(context) : null);
                },
                child: AppText('Edit Password', style: buildTextUnderline),
              ),
            5.heightBox(),
            if (!adminAccess)
              GestureDetector(
                onTap: () {
                  getIt<AuthHandler>().logOut();
                  RedirectManager(context).redirectAndPopStack(LoginScreen.id);
                },
                child: AppText('Logout', style: buildTextUnderline),
              ),
            40.heightBox(),
            adminAccess ? _adminSaveButton : _saveButton,
            25.heightBox(),
          ],
        ),
      ),
    );
  }

  BlocConsumer get _saveButton {
    return BlocConsumer<ProfileCubit, ProfileState>(
      bloc: cubit,
      listener: (context, state) {
        final failure = state.failure;
        if (failure is ErrorFailure && failure.error is MessageResponse) {
          Alert.instance.error(context, failure.error.convertErrorsToString());
        } else if (failure != null) {
          GenericErrorHandler.instance.handle(onRetry: () => null, failure: failure, context: context);
        } else if (state.status == true) {
          RedirectManager(context).back(extra: state.profileResponseModel?.data);
        }
      },
      builder: (context, state) {
        if (state.loading) {
          return const AppLoadingWidget();
        }
        return AppButton(
          onPressed: () {
            final user = updatedUser;
            cubit.updateProfile(user);
          },
          padding: symmetricPadding(0, 50),
          textKey: 'Save',
        );
      },
    );
  }

  BlocConsumer get _adminSaveButton {
    return BlocConsumer<UsersCubit, UsersState>(
      bloc: usersCubit,
      listener: (context, state) {
        final failure = state.failure;
        if (failure is ErrorFailure && failure.error is MessageResponse) {
          Alert.instance.error(context, failure.error.convertErrorsToString());
        } else if (failure != null) {
          GenericErrorHandler.instance.handle(onRetry: () => null, failure: failure, context: context);
        } else if (state.success) {
          Alert.instance.success(context, null);
          RedirectManager(context).back(extra: state.user);
        }
      },
      builder: (context, state) {
        if (state.loading) {
          return const AppLoadingWidget();
        }
        return AppButton(
          onPressed: () {
            final user = updatedUser;
            usersCubit.updateUser(user..id = widget.user.id);
          },
          padding: symmetricPadding(0, 50),
          textKey: 'Admin save',
        );
      },
    );
  }

  User get updatedUser {
    return User(
      email: email.text,
      username: name.text,
      fullname: fullname.text,
      phone: phone.text,
      level_id: level?.id,
      jobs_id: jobs.map((e) => e.id!).toList(),
    );
  }

  TextStyle get buildTextUnderline {
    return AppStyles.medium18.copyWith(height: 2, color: AppColors.primary, decoration: TextDecoration.underline);
  }

  void showDoneMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: AppText('Successfully Done'),
      backgroundColor: AppColors.primary,
    ));
  }

  TextStyle get buildGreyStyle => AppStyles.medium10.copyWith(color: AppColors.darkGrey);
  bool get isAdmin => authHandler.loginModel?.user?.is_superuser == true && widget.user != authHandler.loginModel?.user;
}
