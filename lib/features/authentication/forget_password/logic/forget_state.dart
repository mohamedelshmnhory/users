part of 'forget_cubit.dart';

class ForgetState extends Equatable {
  final Failure? failure;
  final bool loading;

  //? Model Area
  final bool? status;
  final String? message;
  final String? loginModel;

  const ForgetState(
      {this.failure,
      this.loading = false,

      //? Model Area
      this.status,
      this.message,
      this.loginModel});

  ForgetState requestSuccess(ForgetResponseModel response) => copyWith(
        loading: false,

        //? Model Area
        status: response.status,
        message: response.message,
        forgetResponseBody: response.data,
      );

  ForgetState requestFailed(Failure failure) {
    if (failure is ErrorFailure) {
      return copyWith(
        status: failure.error.status,
        message: failure.error.message,
        loading: false,
        failure: Nullable(failure),
      );
    }
    return copyWith(
      loading: false,
      failure: Nullable(failure),
    );
  }

  ForgetState requestLoading() => copyWith(
        loading: true,
        failure: Nullable(null),
      );

  ForgetState copyWith({
    Nullable<Failure?>? failure,
    bool? loading,

    //? Model Area
    bool? status,
    String? message,
    String? forgetResponseBody,
  }) {
    return ForgetState(
      failure: failure == null ? this.failure : failure.value,
      loading: loading ?? this.loading,

      //? Model Area
      status: status ?? false,
      message: message ?? '',
      loginModel: forgetResponseBody,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        failure,

        //? Model Area
        status,
        message,
        loginModel,
      ];

  @override
  bool get stringify => true;
}
