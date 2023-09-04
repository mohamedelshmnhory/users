part of 'users_cubit.dart';

class UsersState {
  final Failure? failure;
  final bool loading;
  final bool success;

  //? Model Area
  final bool? status;
  final String? message;
  final UsersResponseModel? model;
  final UserResponseModel? userResponseModel;

  UsersState requestLoading() => copyWith(loading: true, failure: null, model: null);

  UsersState requestFailed(Failure failure) {
    if (failure is ErrorFailure) {
      return copyWith(
        status: failure.error.status,
        message: failure.error.message,
        loading: false,
        failure: Nullable(failure),
      );
    }
    return copyWith(loading: false, failure: Nullable(failure));
  }

  UsersState requestSuccess({UsersResponseModel? model}) => copyWith(loading: false, failure: null, success: true, model: model);

  UsersState addRequestSuccess({UserResponseModel? model}) =>
      copyWith(loading: false, failure: null, success: true, userResponseModel: model);

  UsersState copyWith({
    final Nullable<Failure?>? failure,
    final bool loading = false,
    final bool success = false,
    final bool? status,
    final String? message,
    final UsersResponseModel? model,
    final UserResponseModel? userResponseModel,
  }) {
    return UsersState(
      failure: failure == null ? this.failure : failure.value,
      loading: loading,
      success: success,
      status: status ?? this.status,
      message: message ?? this.message,
      model: model ?? this.model,
      userResponseModel: userResponseModel ?? this.userResponseModel,
    );
  }

  UsersState(
      {this.failure, this.loading = false, this.success = false, this.status, this.message, this.model, this.userResponseModel});
}
