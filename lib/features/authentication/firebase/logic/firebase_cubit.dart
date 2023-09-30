
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/api_manager.dart';
import '../data/repo/firebase_repo.dart';

part 'firebase_state.dart';

@injectable
class FirebaseCubit extends Cubit<FirebaseState> {
  final FirebaseRepo repo;
  RequestModel? requestModel;
  // final auth = FirebaseAuth.instance;
  String? verificationID = "";

  FirebaseCubit(this.repo) : super(const FirebaseState());

  // Future<UserCredential> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //
  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  //   // printFullText(googleAuth?.idToken ?? '');
  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );
  //
  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }
  //
  // Future<UserCredential> signInWithFacebook() async {
  //   // Trigger the sign-in flow
  //   final LoginResult loginResult = await FacebookAuth.instance.login();
  //
  //   // Create a credential from the access token
  //   final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
  //
  //   // Once signed in, return the UserCredential
  //   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  // }
  //
  // Future<UserCredential> signInWithTwitter() async {
  //   // Create a TwitterLogin instance
  //   final twitterLogin = TwitterLogin(
  //     apiKey: '3NdwuKXvWmwJcxVv5jfNLpyZS',
  //     apiSecretKey: '86Ak2eCvRNvKpQWkJCnKlAJbmdQBVrhnlfmuAk3TAz87vNC3Dn',
  //     redirectURI: 'https://silah-8defe.firebaseapp.com/__/auth/handler',
  //   );
  //
  //   // Trigger the sign-in flow
  //   final authResult = await twitterLogin.login();
  //
  //   // Create a credential from the access token
  //   final twitterAuthCredential = TwitterAuthProvider.credential(
  //     accessToken: authResult.authToken!,
  //     secret: authResult.authTokenSecret!,
  //   );
  //
  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
  // }

  // emitError(String? message) {
  //   emit(state.requestFailed(ErrorFailure(error: MessageResponse(message: message!), errorStatus: ErrorStatus.unknownError)));
  // }

  // Future<String> _getToken() {
  //   return FirebaseAuth.instance.currentUser!.getIdToken(false);
  // }
}
