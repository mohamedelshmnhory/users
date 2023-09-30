import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/data/api_manager.dart';
import '../../../../../core/profile_api.dart';
import '../../../register/data/model/user.dart';
import '../model/forget_response_model.dart';
import '../request/forget_http_request.dart';

@injectable
class ForgetRepo {
  final APIsManager _apIsManager;

  ForgetRepo(this._apIsManager);

  Future<Either<Failure, ForgetResponseModel>> forgetRequest({required User user}) async {
    final result = await _apIsManager.send(
      request: ForgetReqHttpRequest(GENERIC(), user),
      responseFromMap: (map) => ForgetResponseModel.fromMap(map),
    );
    return result;
  }

  Future<Either<Failure, ForgetResponseModel>> forgetUpdate({required User user}) async {
    final result = await _apIsManager.send(
      request: ForgetUpdateHttpRequest(GENERIC(), user),
      responseFromMap: (map) => ForgetResponseModel.fromMap(map),
    );
    return result;
  }
}
