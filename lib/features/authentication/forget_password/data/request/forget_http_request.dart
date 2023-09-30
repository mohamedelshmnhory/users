

import 'package:users/core/profile_api.dart';

import '../../../../../core/data/api_manager.dart';
import '../../../register/data/model/user.dart';

class ForgetReqHttpRequest with Request, PostRequest {
  final GENERIC profile;

  ForgetReqHttpRequest(this.profile, this.requestModel);

  @override
  String get path => profile.forgetPasswordRequest;

  @override
  final User requestModel;
}

class ForgetUpdateHttpRequest with Request, PostRequest {
  final GENERIC profile;

  ForgetUpdateHttpRequest(this.profile, this.requestModel);

  @override
  String get path => profile.forgetPasswordUpdate;

  @override
  final User requestModel;
}
