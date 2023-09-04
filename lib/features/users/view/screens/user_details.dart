import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users/core/view/widgets/app_screen.dart';
import 'package:users/core/view/widgets/text_fields/app_loading.dart';

import '../../../../core/dependencies/dependency_init.dart';
import '../../../../core/faker/app_faker.dart';
import '../../../../core/resources.dart';
import '../../data/models/user_response_model.dart';
import '../../logic/users_cubit.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({Key? key, required this.user}) : super(key: key);
  final UserModel user;

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final usersCubit = getIt<UsersCubit>();
  late UserModel user = widget.user;

  @override
  void initState() {
    super.initState();
    usersCubit.getUser(widget.user);
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      title: '${user.first_name} Details',
      child: BlocConsumer<UsersCubit, UsersState>(
        bloc: usersCubit,
        listener: (context, state) {
          if (state.success) {
            user = state.userResponseModel?.data ?? user;
          }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              20.heightBox(),
              Center(
                child: Hero(
                  tag: 'userAvatar${user.id}', // Match the tag used in UserCard
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(user.avatar ?? AppFaker.randomImage),
                  ),
                ),
              ),
              20.heightBox(),
              state.loading
                  ? const AppLoadingWidget()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${user.first_name ?? '-'} ${user.last_name ?? '-'}',
                          textAlign: TextAlign.center,
                          style: AppStyles.bold24,
                        ),
                        10.heightBox(),
                        Text(
                          user.email ?? '-',
                          textAlign: TextAlign.center,
                          style: AppStyles.medium20.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
            ],
          );
        },
      ),
    );
  }
}
