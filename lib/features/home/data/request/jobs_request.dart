import '../../../../core/data/request/base_request.dart';
import '../../../../core/profile_api.dart';
import '../models/job.dart';

class JobsRequest with Request, GetRequest {
  final BaseApi profileApi;
  JobsRequest(this.profileApi, this.queryParameters);

  @override
  Map<String, dynamic>? queryParameters;

  @override
  String get path => profileApi.jobs;
}

class JobDetailsRequest with Request, GetRequest {
  final BaseApi profileApi;
  JobDetailsRequest(this.profileApi, this.model);

  @override
  String get path => '${profileApi.jobs}/${model.id}';

  final Job model;
}

class AddJobRequest with Request, PostRequest {
  final BaseApi profileApi;
  final bool isFile;
  AddJobRequest(this.profileApi, this.requestModel, {this.isFile = false});

  @override
  String get path => '${profileApi.jobs}/';

  @override
  bool get multiPart => isFile;

  @override
  final Job requestModel;
}

class JobUpdateRequest with Request, PutRequest {
  final BaseApi profileApi;
  final bool isFile;
  JobUpdateRequest(this.profileApi, this.requestModel, {this.isFile = false});

  @override
  String get path => '${profileApi.jobs}/${requestModel.id}';

  @override
  bool get multiPart => isFile;

  @override
  final Job requestModel;
}

class DeleteJobRequest with Request, DeleteRequest {
  final BaseApi profileApi;
  DeleteJobRequest(this.profileApi, this.model);

  @override
  String get path => '${profileApi.jobs}/${model.id}';

  final Job model;
}
