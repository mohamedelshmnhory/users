import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/resources.dart';
import '../../../../../../core/view/widgets/app_screen.dart';
import '../../../../core/dependencies/dependency_init.dart';
import '../../../../core/view/widgets/empty_widget.dart';
import '../../../../core/view/widgets/pagination_list.dart';
import '../../../../core/view/widgets/text_fields/app_loading.dart';
import '../../../profile/view/profile_screen.dart';
import '../../../users/logic/users_cubit.dart';
import '../../../users/view/widgets/user_card.dart';
import '../../data/models/favourites_request_params.dart';
import '../../logic/favourites_cubit.dart';

class FavouritesScreen extends StatefulWidget {
  static const id = "/favourites";
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  final favouritesCubit = getIt<FavouritesCubit>();
  String? searchValue;
  bool search = false;

  @override
  void initState() {
    super.initState();
    getFavourites();
  }

  void getFavourites({bool? more = false}) => favouritesCubit.getFavourites(
        FavouritesRequestParams(username: searchValue, more: more),
      );

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      padding: symmetricPadding(0, 0),
      title: 'Saved',
      child: _body,
    );
  }

  Widget get _body {
    return BlocConsumer<FavouritesCubit, FavouritesState>(
      bloc: favouritesCubit,
      listener: (context, state) {},
      builder: (context, state) {
        if (state.loading) {
          return const AppLoadingWidget();
        }
        if (favouritesCubit.users.isEmpty) {
          return const EmptyWidget();
        }
        return RefreshIndicator(
          onRefresh: () async => getFavourites(),
          child: PaginationList(
            reachedMax: true,
            itemCount: favouritesCubit.users.length,
            separator: 10.heightBox(),
            onReachBottom: () => getFavourites(more: true),
            itemBuilder: (ctx, i) {
              final user = favouritesCubit.users[i];
              return UserCard(path: ProfileScreen.favouritesID, user: user, usersCubit: getIt<UsersCubit>());
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
