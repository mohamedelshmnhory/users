import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/data/api_manager.dart';
import '../../../../../core/profile_api.dart';
// import '../../../firebase/data/repo/firebase_repo.dart';
import '../../../register/data/model/user.dart';
import '../model/login_response_model.dart';
import '../request/login_http_request.dart';

@injectable
class LoginRepo {
  final APIsManager _apIsManager;
  LoginRepo(this._apIsManager);

  Future<Either<Failure, LoginResponseModel>> login({required User user}) async {
    // String? fcmToken = await FirebaseRepo.getFCMToken();
    // user.fcm_token = fcmToken;
    final result = await _apIsManager.send(
      request: LoginHttpRequest(GENERIC(), user),
      responseFromMap: (map) => LoginResponseModel.fromMap(map),
    );
    return result;
  }

  Future<Either<Failure, LoginResponseModel>> socialLogin({required User user}) async {
    // String? fcmToken = await FirebaseRepo.getFCMToken();
    // user.fcm_token = fcmToken;
    final result = await _apIsManager.send(
      request: SocialLoginRequest(GENERIC(), user),
      responseFromMap: (map) => LoginResponseModel.fromMap(map),
    );
    return result;
  }
}
