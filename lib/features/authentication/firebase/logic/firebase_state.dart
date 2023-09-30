
part of 'firebase_cubit.dart';


class FirebaseState extends Equatable {
  final Failure? failure;
  final bool loading;
  final bool otpVisibility;

  //? Model Area
  final int? statusCode;
  final String? message;

  const FirebaseState({
    this.failure,
    this.loading = false,
    this.otpVisibility = false,
    //? Model Area
    this.statusCode,
    this.message,
  });

  FirebaseState requestSuccess({required String message, required int statusCode}) => copyWith(
    loading: false,
    //? Model Area
    statusCode: statusCode,
    message: message,
  );

  FirebaseState requestFailed(Failure failure) => copyWith(
    loading: false,
    failure: failure,
  );

  FirebaseState requestLoading() => copyWith(
    loading: true,
    failure: null,
  );
  FirebaseState requestOtpInput({String? verificationID}) => copyWith(
    otpVisibility: true,
    loading: false,
    failure: null,
  );

  FirebaseState copyWith({
    Failure? failure,
    bool? loading,
    bool? otpVisibility,

    //? Model Area
    int? statusCode,
    String? message,
    String? verificationID,
  }) {
    return FirebaseState(
      failure: failure ?? this.failure,
      loading: loading ?? this.loading,
      otpVisibility: otpVisibility ?? this.otpVisibility,
      //? Model Area
      statusCode: statusCode ?? 0,
      message: message ?? '',
    );
  }

  @override
  List<Object?> get props => [
    loading,
    failure,
    statusCode,
    message,
  ];

  @override
  bool get stringify => true;
}
