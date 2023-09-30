part of 'levels_cubit.dart';

class LevelsState {
  final Failure? failure;
  final bool loading;
  final bool success;

  //? Model Area
  final bool? status;
  final String? message;
  final LevelsResponseModel? model;
  final Level? level;

  LevelsState requestLoading() => copyWith(loading: true, failure: null, model: null);

  LevelsState requestFailed(Failure failure) {
    if (failure is ErrorFailure) {
      return copyWith(status: failure.error.status, message: failure.error.message, loading: false, failure: Nullable(failure));
    }
    return copyWith(loading: false, failure: Nullable(failure));
  }

  LevelsState requestSuccess({LevelsResponseModel? model}) => copyWith(loading: false, failure: null, success: true, model: model);

  LevelsState addRequestSuccess({Level? model}) =>
      copyWith(loading: false, failure: null, success: true, levelResponseModel: model);

  LevelsState copyWith({
    final Nullable<Failure?>? failure,
    final bool loading = false,
    final bool success = false,
    final bool? status,
    final String? message,
    final LevelsResponseModel? model,
    final Level? levelResponseModel,
  }) {
    return LevelsState(
      failure: failure?.value,
      loading: loading,
      success: success,
      status: status ?? this.status,
      message: message ?? this.message,
      model: model ?? this.model,
      level: levelResponseModel ,
    );
  }

  LevelsState(
      {this.failure, this.loading = false, this.success = false, this.status, this.message, this.model, this.level});
}
