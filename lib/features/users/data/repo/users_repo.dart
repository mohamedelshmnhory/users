import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/data/api_manager.dart';
import '../../../../core/profile_api.dart';
import '../models/user_response_model.dart';
import '../models/users_request_params.dart';
import '../request/users_request.dart';

@injectable
class UsersRepo {
  final APIsManager _apIsManager;

  UsersRepo(this._apIsManager);

  Future<Either<Failure, UsersResponseModel>> getUsers(UsersRequestParams? params) async {
    return await _apIsManager.send(
      request: UsersRequest(GENERIC(), params?.toJson()),
      responseFromMap: (map) => UsersResponseModel.fromJson(map),
    );
  }

  Future<Either<Failure, UserResponseModel>> getUser(UserModel message) async {
    return await _apIsManager.send(
      request: UserRequest(GENERIC(), message),
      responseFromMap: (map) => UserResponseModel.fromJson(map),
    );
  }

  Future<Either<Failure, UserResponseModel>> updateUser(UserModel message) async {
    return await _apIsManager.send(
      request: UsersUpdateRequest(GENERIC(), message),
      responseFromMap: (map) => UserResponseModel.fromJson(map),
    );
  }
}
