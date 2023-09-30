import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users/core/services/redirect_manager.dart';
import 'package:users/core/view/widgets/search_container.dart';

import '../../../../../../core/resources.dart';
import '../../../../../../core/view/widgets/app_screen.dart';
import '../../../../core/dependencies/dependency_init.dart';
import '../../../../core/view/widgets/empty_widget.dart';
import '../../../../core/view/widgets/pagination_list.dart';
import '../../../../core/view/widgets/should_login.dart';
import '../../../../core/view/widgets/text_fields/app_loading.dart';
import '../../data/models/jobs_request_params.dart';
import '../../logic/jobs_cubit.dart';
import 'add_edit_job.dart';
import '../widgets/job_card.dart';

class HomeScreen extends StatefulWidget {
  static const id = "/home";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final jobsCubit = getIt<JobsCubit>();
  String? searchValue;
  bool search = false;

  @override
  void initState() {
    super.initState();
    getJobs();
  }

  void getJobs({JobsRequestParams? params}) => jobsCubit.getJobs(params: params);

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
                    getJobs(params: JobsRequestParams(name: searchValue));
                  },
                  onClose: () => getJobs(),
                )
              : const AppText('Jobs', key: ValueKey<int>(2)),
        ),
        actions: [
          AdminWidget(
            adminWidget: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => RedirectManager(context).redirect(
                AddEditJobScreen.homeID,
                extra: {'jobsCubit': jobsCubit},
              ),
            ),
          ),
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
              if (searchValue?.isNotEmpty == true) getJobs();
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
    return BlocConsumer<JobsCubit, JobsState>(
      bloc: jobsCubit,
      listener: (context, state) {},
      builder: (context, state) {
        if (state.loading) {
          return const AppLoadingWidget();
        }
        if (jobsCubit.jobs.isEmpty) {
          return const EmptyWidget();
        }
        return RefreshIndicator(
          onRefresh: () async => getJobs(params: JobsRequestParams(name: searchValue)),
          child: PaginationList(
            reachedMax: jobsCubit.reachMaX,
            itemCount: jobsCubit.jobs.length,
            separator: 10.heightBox(),
            onReachBottom: () => jobsCubit.getJobs(more: true, params: JobsRequestParams(name: searchValue)),
            itemBuilder: (ctx, i) {
              final job = jobsCubit.jobs[i];
              return JobCard(job: job, jobsCubit: jobsCubit);
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
