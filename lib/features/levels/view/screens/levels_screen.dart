import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users/core/services/redirect_manager.dart';
import 'package:users/features/home/view/screens/home_screen.dart';

import '../../../../../../core/resources.dart';
import '../../../../../../core/view/widgets/app_screen.dart';
import '../../../../core/dependencies/dependency_init.dart';
import '../../../../core/view/widgets/empty_widget.dart';
import '../../../../core/view/widgets/pagination_list.dart';
import '../../../../core/view/widgets/should_login.dart';
import '../../../../core/view/widgets/text_fields/app_loading.dart';
import '../../../home/data/models/job.dart';
import '../../data/models/levels_request_params.dart';
import '../../logic/levels_cubit.dart';
import 'add_edit_level.dart';
import '../widgets/level_card.dart';

class LevelsScreen extends StatefulWidget {
  static const id = "levels";
  static const homeID = "${HomeScreen.id}/$id";
  const LevelsScreen({Key? key, required this.job}) : super(key: key);
  final Job job;

  @override
  State<LevelsScreen> createState() => _LevelsScreenState();
}

class _LevelsScreenState extends State<LevelsScreen> {
  final levelsCubit = getIt<LevelsCubit>();

  @override
  void initState() {
    super.initState();
    getLevels();
  }

  void getLevels({LevelsRequestParams? params}) => levelsCubit.getLevels(params: params);

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      padding: symmetricPadding(0, 0),
      title: '${widget.job.name} - Levels',
      actions: [
        AdminWidget(
          adminWidget: IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => RedirectManager(context).redirect(
              AddEditLevelScreen.homeLevelsID,
              extra: {'levelsCubit': levelsCubit},
            ),
          ),
        )
      ],
      child: _body,
    );
  }

  Widget get _body {
    return BlocConsumer<LevelsCubit, LevelsState>(
      bloc: levelsCubit,
      listener: (context, state) {},
      builder: (context, state) {
        if (state.loading) {
          return const AppLoadingWidget();
        }
        if (levelsCubit.levels.isEmpty) {
          return const EmptyWidget();
        }
        return RefreshIndicator(
          onRefresh: () async => getLevels(),
          child: PaginationList(
            reachedMax: levelsCubit.reachMaX,
            itemCount: levelsCubit.levels.length,
            separator: 10.heightBox(),
            onReachBottom: () => levelsCubit.getLevels(more: true),
            itemBuilder: (ctx, i) {
              final level = levelsCubit.levels[i];
              return LevelCard(
                params: LevelsRequestParams(levelsCubit: levelsCubit, level: level, job: widget.job),
              );
            },
          ),
        );
      },
    );
  }
}
