import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:users/features/levels/data/models/levels_request_params.dart';
import 'package:users/features/users/view/screens/users_screen.dart';
import '../../../../core/constants/decorations.dart';
import '../../../../core/resources.dart';
import '../../../../core/services/alert.dart';
import '../../../../core/services/redirect_manager.dart';
import '../../../../core/view/widgets/should_login.dart';
import '../../data/models/level.dart';
import '../../logic/levels_cubit.dart';
import '../screens/add_edit_level.dart';

class LevelCard extends StatelessWidget {
  const LevelCard({Key? key, required this.params}) : super(key: key);
  final LevelsRequestParams params;

  @override
  Widget build(BuildContext context) {
    return AdminWidget(
      child: buildBody(context),
      adminWidget: CupertinoContextMenu.builder(
        // enableHapticFeedback: true,
        actions: <Widget>[
          CupertinoContextMenuAction(
            onPressed: () {
              RedirectManager(context).back();
              RedirectManager(context)
                  .redirect(AddEditLevelScreen.homeLevelsID, extra: {'levelsCubit': params.levelsCubit, 'level': params.level});
            },
            isDefaultAction: true,
            trailingIcon: Icons.edit,
            child: const Text('Edit'),
          ),
          CupertinoContextMenuAction(
            onPressed: () {
              RedirectManager(context).back();
              Alert.instance.showDeleteAlert(context, () => params.levelsCubit?.deleteLevel(params.level!));
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
      onTap: () => RedirectManager(context).redirect(UsersScreen.homeLevelsID, extra: params),
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
          children: [
            AppText(
              params.level?.name ?? "-",
              textAlign: TextAlign.center,
              style: AppStyles.bold18.copyWith(decoration: TextDecoration.none, color: AppColors.black),
            ),
          ],
        ),
      ),
    );
  }
}
