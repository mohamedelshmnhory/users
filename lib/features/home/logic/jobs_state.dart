part of 'jobs_cubit.dart';

class JobsState {
  final Failure? failure;
  final bool loading;
  final bool success;

  //? Model Area
  final bool? status;
  final String? message;
  final JobsResponseModel? model;
  final Job? job;

  JobsState requestLoading() => copyWith(loading: true, failure: null, model: null);

  JobsState requestFailed(Failure failure) {
    if (failure is ErrorFailure) {
      return copyWith(status: failure.error.status, message: failure.error.message, loading: false, failure: Nullable(failure));
    }
    return copyWith(loading: false, failure: Nullable(failure));
  }

  JobsState requestSuccess({JobsResponseModel? model}) => copyWith(loading: false, failure: null, success: true, model: model);

  JobsState addRequestSuccess({Job? model}) =>
      copyWith(loading: false, failure: null, success: true, jobResponseModel: model);

  JobsState copyWith({
    final Nullable<Failure?>? failure,
    final bool loading = false,
    final bool success = false,
    final bool? status,
    final String? message,
    final JobsResponseModel? model,
    final Job? jobResponseModel,
  }) {
    return JobsState(
      failure: failure?.value,
      loading: loading,
      success: success,
      status: status ?? this.status,
      message: message ?? this.message,
      model: model ?? this.model,
      job: jobResponseModel ,
    );
  }

  JobsState(
      {this.failure, this.loading = false, this.success = false, this.status, this.message, this.model, this.job});
}
