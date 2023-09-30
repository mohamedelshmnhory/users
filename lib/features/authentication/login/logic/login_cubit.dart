import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
// import 'package:firebase_auth/firebase_auth.dart' as fire_auth;
import '../../../../core/data/api_manager.dart';
import '../../../../core/dependencies/dependency_init.dart';
import '../../../../core/utils/nullable.dart';
import '../data/model/login_response_model.dart';
import '../data/repo/login_repo.dart';
import 'auth_handler.dart';
// import '../../firebase/logic/firebase_cubit.dart';
import '../../register/data/model/login_model.dart';
import '../../register/data/model/user.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;

  LoginCubit(this._loginRepo) : super(const LoginState());

  Future<void> login({required User user}) async {
    emit(state.requestLoading());
    final result = await _loginRepo.login(user: user);

    result.fold(
      (l) => emit(state.requestFailed(l)),
      (r) async {
        await getIt<AuthHandler>().saveLogin(r.data);
        emit(state.requestSuccess(r));
      },
    );
  }

  void socialLogin({required SocialLogin socialLogin}) async {
    // emit(state.requestSocialLoading());
    // fire_auth.UserCredential? userCredential;
    // if (socialLogin == SocialLogin.google) {
    //   userCredential = await getIt<FirebaseCubit>().signInWithGoogle();
    // }
    // if (socialLogin == SocialLogin.facebook) {
    //   userCredential = await getIt<FirebaseCubit>().signInWithFacebook();
    // }
    // if (socialLogin == SocialLogin.twitter) {
    //   userCredential = await getIt<FirebaseCubit>().signInWithTwitter();
    // }
    // final String token = await userCredential?.user?.getIdToken(true) ?? '';
    // // printFullText(token);
    // var result = await _loginRepo.socialLogin(
    //   user: User(
    //     name: userCredential?.user?.displayName,
    //     email: userCredential?.user?.email,
    //     token: token,
    //     social: socialLogin,
    //   ),
    // );
    //
    // result.fold(
    //   (l) => emit(state.requestFailed(l)),
    //   (r) {
    //     getIt<AuthHandler>().saveLogin(r.data);
    //     emit(state.requestSuccess(r));
    //   },
    // );
  }
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => debugPrint(match.group(0)));
}
