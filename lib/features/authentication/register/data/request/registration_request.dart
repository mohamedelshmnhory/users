import '../../../../../core/data/api_manager.dart';
import '../../../../../core/profile_api.dart';
import '../model/user.dart';

class RegistrationRequest with Request, PostRequest {
  GENERIC profile;

  RegistrationRequest(this.profile, this.requestModel);

  @override
  String get path => profile.registerApi;

  @override
  final User requestModel;
}

class ProfessionListRequest with Request, GetRequest {
  GENERIC profile;

  ProfessionListRequest(this.profile);

  @override
  String get path => profile.professionApi;
}
