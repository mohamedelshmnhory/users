import '../../../../core/data/request/base_request.dart';
import '../../../../core/profile_api.dart';
import '../models/user_response_model.dart';

class UsersRequest with Request, GetRequest {
  final BaseApi profileApi;
  UsersRequest(this.profileApi, this.queryParameters);

  @override
  Map<String, dynamic>? queryParameters;

  @override
  String get path => profileApi.users;
}

class UserRequest with Request, GetRequest {
  final BaseApi profileApi;
  UserRequest(this.profileApi, this.requestModel);

  @override
  String get path => '${profileApi.users}/${requestModel.id}';

  @override
  final UserModel requestModel;
}

class UsersUpdateRequest with Request, PostRequest {
  final BaseApi profileApi;
  final bool isFile;
  UsersUpdateRequest(this.profileApi, this.requestModel, {this.isFile = false});

  @override
  String get path => profileApi.users;

  @override
  bool get multiPart => isFile;

  @override
  final UserModel requestModel;
}


