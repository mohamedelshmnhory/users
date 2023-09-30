part of 'profile_cubit.dart';

class ProfileState {
  final Failure? failure;
  final bool loading;

  //? Model Area
  final bool? status;
  final String? message;
  final ProfileResponseModel? profileResponseModel;

  ProfileState requestLoading() => copyWith(loading: true, failure: null, profileResponseModel: null);

  ProfileState requestFailed(Failure failure) {
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

  ProfileState requestSuccess({ProfileResponseModel? profileResponseModel}) =>
      copyWith(loading: false, failure: null, status: true, profileResponseModel: profileResponseModel);

  ProfileState copyWith({
    final Nullable<Failure?>? failure,
    final bool loading = false,
    final bool? status,
    final String? message,
    final ProfileResponseModel? profileResponseModel,
  }) {
    return ProfileState(
        failure: failure?.value,
        loading: loading,
        status: status,
        message: message,
        profileResponseModel: profileResponseModel ?? profileResponseModel);
  }

  ProfileState({this.failure, this.loading = false, this.status, this.message, this.profileResponseModel});
}
