import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/decorations.dart';
import '../../../../core/resources.dart';
import '../../../../core/services/alert.dart';
import '../../../../core/services/redirect_manager.dart';
import '../../../../core/view/widgets/should_login.dart';
import '../../../levels/view/screens/levels_screen.dart';
import '../../data/models/job.dart';
import '../../logic/jobs_cubit.dart';
import '../screens/add_edit_job.dart';

class JobCard extends StatelessWidget {
  const JobCard({Key? key, required this.job, required this.jobsCubit}) : super(key: key);
  final JobsCubit jobsCubit;
  final Job job;

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
              RedirectManager(context).redirect(AddEditJobScreen.homeID, extra: {'jobsCubit': jobsCubit, 'job': job});
            },
            isDefaultAction: true,
            trailingIcon: Icons.edit,
            child: const Text('Edit'),
          ),
          CupertinoContextMenuAction(
            onPressed: () {
              RedirectManager(context).back();
              Alert.instance.showDeleteAlert(context, () => jobsCubit.deleteJob(job));
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
      onTap: () => RedirectManager(context).redirect(LevelsScreen.homeID, extra: job),
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
              job.name ?? "-",
              textAlign: TextAlign.center,
              style: AppStyles.bold18.copyWith(decoration: TextDecoration.none, color: AppColors.black),
            ),
          ],
        ),
      ),
    );
  }
}
