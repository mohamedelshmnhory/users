

import 'package:users/core/profile_api.dart';

import '../../../../../core/data/api_manager.dart';
import '../../../register/data/model/user.dart';

class LoginHttpRequest with Request, PostRequest {
  final GENERIC profile;

  LoginHttpRequest(this.profile, this.requestModel);

  @override
  String get path => profile.loginApi;

  @override
  final User requestModel;
}

class SocialLoginRequest with Request, PostRequest {
  final GENERIC profile;

  SocialLoginRequest(this.profile, this.requestModel);

  @override
  String get path => profile.socialLoginApi;

  @override
  final User requestModel;
}
