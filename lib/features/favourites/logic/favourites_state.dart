part of 'favourites_cubit.dart';

class FavouritesState {
  final Failure? failure;
  final bool loading;
  final bool success;

  //? Model Area
  final bool? status;
  final String? message;
  final FavouritesResponseModel? model;
  final User? user;

  FavouritesState requestLoading() => copyWith(loading: true, failure: null, model: null);

  FavouritesState requestFailed(Failure failure) {
    if (failure is ErrorFailure) {
      return copyWith(status: failure.error.status, message: failure.error.message, loading: false, failure: Nullable(failure));
    }
    return copyWith(loading: false, failure: Nullable(failure));
  }

  FavouritesState requestSuccess({FavouritesResponseModel? model}) => copyWith(loading: false, failure: null, success: true, model: model);

  FavouritesState addRequestSuccess({User? model}) =>
      copyWith(loading: false, failure: null, success: true, userResponseModel: model);

  FavouritesState copyWith({
    final Nullable<Failure?>? failure,
    final bool loading = false,
    final bool success = false,
    final bool? status,
    final String? message,
    final FavouritesResponseModel? model,
    final User? userResponseModel,
  }) {
    return FavouritesState(
      failure: failure?.value,
      loading: loading,
      success: success,
      status: status ?? this.status,
      message: message ?? this.message,
      model: model ?? this.model,
      user: userResponseModel ,
    );
  }

  FavouritesState(
      {this.failure, this.loading = false, this.success = false, this.status, this.message, this.model, this.user});
}
