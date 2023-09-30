part of 'register_cubit.dart';

@immutable
class RegisterState {
  final Failure? failure;
  final bool loading;
  final bool? status;
  final LoginResponseModel? loginResponseModel;
  const RegisterState({this.failure, this.loading = false, this.status, this.loginResponseModel});

  RegisterState requestFailure(Failure failure) => copyWith(
        loading: false,
        failure: failure,
      );

  RegisterState registerSuccess(LoginResponseModel loginResponseModel) => copyWith(
        loading: false,
        loginResponseModel: loginResponseModel,
      );
  RegisterState requestLoading() => copyWith(
        loading: true,
        failure: null,
      );
  RegisterState copyWith({
    final Failure? failure,
    final bool? status,
    bool? loading,
    LoginResponseModel? loginResponseModel,
  }) {
    return RegisterState(
      failure: failure,
      status: status ?? this.status,
      loading: loading ?? this.loading,
      loginResponseModel: loginResponseModel,
    );
  }
}
