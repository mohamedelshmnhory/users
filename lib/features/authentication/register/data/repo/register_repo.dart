import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/data/api_manager.dart';
import '../../../../../core/profile_api.dart';
// import '../../../firebase/data/repo/firebase_repo.dart';
import '../../../login/data/model/login_response_model.dart';
import '../model/user.dart';
import '../request/registration_request.dart';

@injectable
class RegisterRepository {
  final APIsManager _apIsManager;

  RegisterRepository(this._apIsManager);



  Future<Either<Failure, LoginResponseModel>> register({required User user}) async {
    // String? fcmToken = await FirebaseRepo.getFCMToken();
    // user.fcm_token = fcmToken;
    final result = await _apIsManager.send(
      request: RegistrationRequest(GENERIC(), user),
      responseFromMap: (map) => LoginResponseModel.fromMap(map),
    );
    return result;
  }
}
