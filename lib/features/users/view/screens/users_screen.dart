import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users/core/services/redirect_manager.dart';
import 'package:users/core/view/widgets/search_container.dart';
import 'package:users/features/home/view/screens/home_screen.dart';
import 'package:users/features/levels/data/models/levels_request_params.dart';
import 'package:users/features/levels/view/screens/levels_screen.dart';

import '../../../../../../core/resources.dart';
import '../../../../../../core/view/widgets/app_screen.dart';
import '../../../../core/dependencies/dependency_init.dart';
import '../../../../core/view/widgets/empty_widget.dart';
import '../../../../core/view/widgets/pagination_list.dart';
import '../../../../core/view/widgets/text_fields/app_loading.dart';
import '../../../profile/view/profile_screen.dart';
import '../../data/models/users_request_params.dart';
import '../../logic/users_cubit.dart';
import '../widgets/user_card.dart';

class UsersScreen extends StatefulWidget {
  static const id = "users";
  static const homeLevelsID = "${HomeScreen.id}/${LevelsScreen.id}/$id";
  const UsersScreen({Key? key, required this.params}) : super(key: key);
  final LevelsRequestParams params;

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final usersCubit = getIt<UsersCubit>();
  String? searchValue;
  bool search = false;

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  void getUsers({bool? more = false}) => usersCubit.getUsers(
        UsersRequestParams(
          job_id: widget.params.job?.id,
          level_id: widget.params.level?.id,
          fullname: searchValue,
          more: more,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      padding: symmetricPadding(0, 0),
      appBar: AppBar(
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200), // Animation duration
          child: search
              ? SearchContainer(
                  key: const ValueKey<int>(1),
                  function: (value) {
                    searchValue = value;
                    getUsers();
                  },
                  onClose: () {
                    searchValue = null;
                    getUsers();
                  },
                )
              : AppText(
                  '${widget.params.job?.name} - ${widget.params.level?.name}',
                  maxLines: 1,
                  key: const ValueKey<int>(2),
                ),
        ),
        actions: [
          AnimateIcons(
            startIcon: Icons.search,
            endIcon: Icons.close,
            controller: AnimateIconController(),
            size: 20.0,
            onStartIconPress: () {
              toggleSearch();
              return true;
            },
            onEndIconPress: () {
              if (searchValue?.isNotEmpty == true) {
                searchValue = null;
                getUsers();
              }
              toggleSearch();

              return true;
            },
            duration: const Duration(milliseconds: 300),
            startIconColor: Colors.black,
            endIconColor: Colors.black,
            clockwise: false,
          ),
        ],
      ),
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
            separator: 10.heightBox(),
            onReachBottom: () => getUsers(more: true),
            itemBuilder: (ctx, i) {
              final user = usersCubit.users[i];
              return UserCard(path: ProfileScreen.homeID, user: user, usersCubit: usersCubit);
            },
          ),
        );
      },
    );
  }

  void toggleSearch() {
    setState(() {
      search = !search;
      searchValue = null;
    });
  }
}
