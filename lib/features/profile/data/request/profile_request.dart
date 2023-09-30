import 'package:users/core/profile_api.dart';

import '../../../../core/data/api_manager.dart';
import '../../../authentication/register/data/model/user.dart';

class ProfileRequest with Request, GetRequest {
  final GENERIC profileApi;
  ProfileRequest({required this.profileApi});

  @override
  String get path => profileApi.profile;
}

class ProfileUpdateRequest with Request, PutRequest {
  final GENERIC profileApi;
  final bool isFile;
  ProfileUpdateRequest(this.profileApi, this.requestModel, {this.isFile = false});

  @override
  String get path => profileApi.updateProfile;

  @override
  bool get multiPart => isFile;

  @override
  final User requestModel;
}
