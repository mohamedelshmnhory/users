part of 'login_cubit.dart';

class LoginState extends Equatable {
  final Failure? failure;
  final bool loading;
  final bool socialLoading;

  //? Model Area
  final bool? status;
  final String? message;
  final LoginModel? loginResponse;

  const LoginState(
      {this.failure,
      this.loading = false,
      this.socialLoading = false,

      //? Model Area
      this.status,
      this.message,
      this.loginResponse});

  LoginState requestSuccess(LoginResponseModel response) => copyWith(
        loading: false,

        //? Model Area
        status: response.status,
        message: response.message,
        loginResponseBody: response.data,
      );

  LoginState requestFailed(Failure failure) {
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

  LoginState requestLoading() => copyWith(
        loading: true,
        failure: Nullable(null),
      );
  LoginState requestSocialLoading() => copyWith(
        socialLoading: true,
        failure: Nullable(null),
      );

  LoginState copyWith({
    Nullable<Failure?>? failure,
    bool? loading,
    bool? socialLoading,

    //? Model Area
    bool? status,
    String? message,
    LoginModel? loginResponseBody,
  }) {
    return LoginState(
      failure: failure == null ? this.failure : failure.value,
      loading: loading ?? this.loading,
      socialLoading: socialLoading ?? this.socialLoading,

      //? Model Area
      status: status ?? false,
      message: message ?? '',
      loginResponse: loginResponseBody,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        failure,

        //? Model Area
        status,
        message,
        loginResponse,
      ];

  @override
  bool get stringify => true;
}
