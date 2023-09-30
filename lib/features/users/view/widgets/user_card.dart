import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users/core/dependencies/dependency_init.dart';
import 'package:users/features/favourites/logic/favourites_cubit.dart';
import '../../../../core/constants/decorations.dart';
import '../../../../core/resources.dart';
import '../../../../core/services/alert.dart';
import '../../../../core/services/redirect_manager.dart';
import '../../../../core/view/widgets/should_login.dart';
import '../../../authentication/register/data/model/user.dart';
import '../../../levels/view/screens/levels_screen.dart';
import '../../../profile/view/profile_screen.dart';
import '../../logic/users_cubit.dart';

class UserCard extends StatelessWidget {
  const UserCard({Key? key, required this.user, required this.usersCubit, required this.path}) : super(key: key);
  final UsersCubit usersCubit;
  final User user;
  final String path;

  @override
  Widget build(BuildContext context) {
    return AdminWidget(
      child: buildBody(context),
      adminWidget: CupertinoContextMenu.builder(
        actions: <Widget>[
          // CupertinoContextMenuAction(
          //   onPressed: () {
          //     RedirectManager(context).back();
          //     // RedirectManager(context).redirect(AddEditUserScreen.id, extra: {'usersCubit': usersCubit, 'user': user});
          //   },
          //   isDefaultAction: true,
          //   trailingIcon: Icons.edit,
          //   child: const Text('Edit'),
          // ),
          CupertinoContextMenuAction(
            onPressed: () {
              RedirectManager(context).back();
              Alert.instance.showDeleteAlert(context, () => usersCubit.deleteUser(user));
            },
            isDestructiveAction: true,
            trailingIcon: CupertinoIcons.delete,
            child: const Text('Delete'),
          ),
        ],
        builder: (BuildContext context, Animation<double> animation) {
          final Animation<Decoration> boxDecorationAnimation = AppDecorations.boxDecorationAnimation(animation);

          return Container(
            decoration: animation.value < CupertinoContextMenu.animationOpensAt ? boxDecorationAnimation.value : null,
            child: buildBody(context),
          );
        },
      ),
    );
  }

  buildBody(context) {
    return GestureDetector(
      onTap: () => RedirectManager(context).redirect(path, extra: user),
      child: Container(
        padding: symmetricPadding(25, 20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
              (user.fullname?.isNotEmpty == true ? user.fullname : user.username) ?? "-",
              textAlign: TextAlign.center,
              style: AppStyles.bold14.copyWith(decoration: TextDecoration.none, color: AppColors.black),
            ),
            FavouriteButton(user: user),
          ],
        ),
      ),
    );
  }
}

class FavouriteButton extends StatelessWidget {
  const FavouriteButton({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavouritesCubit, FavouritesState>(
      bloc: getIt<FavouritesCubit>(),
      listener: (context, state) {},
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            if (state.loading) return;
            if (user.is_favourite == true) {
              getIt<FavouritesCubit>().deleteFavourite(user);
            } else {
              getIt<FavouritesCubit>().addFavourite(user);
            }
          },
          child: Icon(user.is_favourite == true ? Icons.bookmark : Icons.bookmark_border),
        );
      },
    );
  }
}
