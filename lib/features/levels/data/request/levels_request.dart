import '../../../../core/data/request/base_request.dart';
import '../../../../core/profile_api.dart';
import '../models/level.dart';

class LevelsRequest with Request, GetRequest {
  final BaseApi profileApi;
  LevelsRequest(this.profileApi, this.queryParameters);

  @override
  Map<String, dynamic>? queryParameters;

  @override
  String get path => profileApi.levels;
}

class LevelDetailsRequest with Request, GetRequest {
  final BaseApi profileApi;
  LevelDetailsRequest(this.profileApi, this.model);

  @override
  String get path => '${profileApi.levels}/${model.id}/';

  final Level model;
}

class AddLevelRequest with Request, PostRequest {
  final BaseApi profileApi;
  final bool isFile;
  AddLevelRequest(this.profileApi, this.requestModel, {this.isFile = false});

  @override
  String get path => '${profileApi.levels}/';

  @override
  bool get multiPart => isFile;

  @override
  final Level requestModel;
}

class LevelUpdateRequest with Request, PutRequest {
  final BaseApi profileApi;
  final bool isFile;
  LevelUpdateRequest(this.profileApi, this.requestModel, {this.isFile = false});

  @override
  String get path => '${profileApi.levels}/${requestModel.id}/';

  @override
  bool get multiPart => isFile;

  @override
  final Level requestModel;
}

class DeleteLevelRequest with Request, DeleteRequest {
  final BaseApi profileApi;
  DeleteLevelRequest(this.profileApi, this.model);

  @override
  String get path => '${profileApi.levels}/${model.id}/';

  final Level model;
}
