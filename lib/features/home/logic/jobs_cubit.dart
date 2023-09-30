import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../core/data/failures.dart';
import '../../../core/utils/nullable.dart';
import '../data/models/job.dart';
import '../data/models/job_response_model.dart';
import '../data/models/jobs_request_params.dart';
import '../data/repo/jobs_repo.dart';

part 'jobs_state.dart';

@injectable
class JobsCubit extends Cubit<JobsState> {
  final JobsRepo jobsRepo;
  JobsCubit(this.jobsRepo) : super(JobsState());

  List<Job> jobs = [];
  bool reachMaX = true;
  int page = 1;

  void getJobs({bool more = false, JobsRequestParams? params}) async {
    if (more) {
      page++;
    } else {
      page = 1;
      emit(state.requestLoading());
    }
    params ??= JobsRequestParams();
    params.page = page;
    final result = await jobsRepo.getJobs(params);

    result.fold(
      (l) => emit(state.requestFailed(l)),
      (r) {
        if (more) {
          jobs.addAll(r.results ?? []);
        } else {
          jobs = r.results ?? [];
        }
        reachMaX = r.next == null;
        emit(state.requestSuccess());
      },
    );
  }

  void getJob(Job model) async {
    emit(state.requestLoading());
    final result = await jobsRepo.getJob(model);
    result.fold(
      (l) => emit(state.requestFailed(l)),
      (r) {
        emit(state.addRequestSuccess(model: r));
      },
    );
  }

  void addJob(Job model) async {
    emit(state.requestLoading());
    final result = await jobsRepo.addJob(model);
    result.fold(
      (l) => emit(state.requestFailed(l)),
      (r) {
        jobs.add(r);
        emit(state.addRequestSuccess());
      },
    );
  }

  void updateJob(Job model) async {
    emit(state.requestLoading());
    final result = await jobsRepo.updateJob(model);
    result.fold(
      (l) => emit(state.requestFailed(l)),
      (r) {
        final int index = jobs.indexOf(model);
        jobs[index] = r;
        emit(state.addRequestSuccess());
      },
    );
  }

  void deleteJob(Job model) async {
    emit(state.requestLoading());
    final result = await jobsRepo.deleteJob(model);
    result.fold(
      (l) => emit(state.requestFailed(l)),
      (r) {
        jobs.remove(model);
        emit(state.addRequestSuccess());
      },
    );
  }
}
