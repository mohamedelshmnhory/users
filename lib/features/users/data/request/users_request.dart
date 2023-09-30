import '../../../../core/data/request/base_request.dart';
import '../../../../core/profile_api.dart';
import '../../../authentication/register/data/model/user.dart';

class UsersRequest with Request, GetRequest {
  final BaseApi profileApi;
  UsersRequest(this.profileApi, this.queryParameters);

  @override
  Map<String, dynamic>? queryParameters;

  @override
  String get path => profileApi.users;
}

class UserDetailsRequest with Request, GetRequest {
  final BaseApi profileApi;
  UserDetailsRequest(this.profileApi, this.model);

  @override
  String get path => '${profileApi.users}/${model.id}';

  final User model;
}

class AddUserRequest with Request, PostRequest {
  final BaseApi profileApi;
  final bool isFile;
  AddUserRequest(this.profileApi, this.requestModel, {this.isFile = false});

  @override
  String get path => '${profileApi.users}/';

  @override
  bool get multiPart => isFile;

  @override
  final User requestModel;
}

class UserUpdateRequest with Request, PutRequest {
  final BaseApi profileApi;
  final bool isFile;
  UserUpdateRequest(this.profileApi, this.requestModel, {this.isFile = false});

  @override
  String get path => '${profileApi.users}/${requestModel.id}';

  @override
  bool get multiPart => isFile;

  @override
  final User requestModel;
}

class DeleteUserRequest with Request, DeleteRequest {
  final BaseApi profileApi;
  DeleteUserRequest(this.profileApi, this.model);

  @override
  String get path => '${profileApi.users}/${model.id}';

  final User model;
}
