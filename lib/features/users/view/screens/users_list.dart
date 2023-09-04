import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/resources.dart';
import '../../../../../../core/view/widgets/app_screen.dart';
import '../../../../core/dependencies/dependency_init.dart';
import '../../../../core/view/widgets/empty_widget.dart';
import '../../../../core/view/widgets/pagination_list.dart';
import '../../../../core/view/widgets/text_fields/app_loading.dart';
import '../../logic/users_cubit.dart';
import '../widgets/user_card.dart';

class UsersList extends StatefulWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  final usersCubit = getIt<UsersCubit>();

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  void getUsers() => usersCubit.getUsers();

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      padding: symmetricPadding(0, 15),
      title: 'Users',
      child: _body,
    );
  }

  Widget get _body {
    return BlocConsumer<UsersCubit, UsersState>(
      bloc: usersCubit,
      listener: (context, state) {},
      builder: (context, state) {
        if (state.loading) {
          return const AppLoadingWidget();
        }
        if (usersCubit.users.isEmpty) {
          return const EmptyWidget();
        }
        return RefreshIndicator(
          onRefresh: () async => getUsers(),
          child: PaginationList(
            reachedMax: usersCubit.reachMaX,
            itemCount: usersCubit.users.length,
            onReachBottom: () {
              usersCubit.getUsers(more: true);
            },
            itemBuilder: (context, i) {
              final message = usersCubit.users[i];
              return GestureDetector(
                onTap: () {},
                child: UserCard(user: message),
              );
            },
          ),
        );
      },
    );
  }
}
