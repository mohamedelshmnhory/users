import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/data/api_manager.dart';
import '../../../../core/profile_api.dart';
import '../../../authentication/register/data/model/user.dart';
import '../models/users_response_model.dart';
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

  Future<Either<Failure, User>> getUser(User user) async {
    return await _apIsManager.send(
      request: UserDetailsRequest(GENERIC(), user),
      responseFromMap: (map) => User.fromJson(map),
      // errorResponseFromMap: (errors){
      //   print(errors);
      //   return UserResponseModel(status: true);
      // }
    );
  }

  Future<Either<Failure, User>> updateUser(User user) async {
    return await _apIsManager.send(
      request: UserUpdateRequest(GENERIC(), user),
      responseFromMap: (map) => User.fromJson(map),
    );
  }

  Future<Either<Failure, User>> addUser(User user) async {
    return await _apIsManager.send(
      request: AddUserRequest(GENERIC(), user),
      responseFromMap: (map) => User.fromJson(map),
    );
  }

  Future<Either<Failure, UserResponseModel>> deleteUser(User user) async {
    return await _apIsManager.send(
      request: DeleteUserRequest(GENERIC(), user),
      responseFromMap: (map) => UserResponseModel.fromJson(map),
    );
  }
}
