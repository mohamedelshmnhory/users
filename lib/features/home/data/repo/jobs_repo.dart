import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/data/api_manager.dart';
import '../../../../core/profile_api.dart';
import '../models/job.dart';
import '../models/job_response_model.dart';
import '../models/jobs_request_params.dart';
import '../request/jobs_request.dart';

@injectable
class JobsRepo {
  final APIsManager _apIsManager;

  JobsRepo(this._apIsManager);

  Future<Either<Failure, JobsResponseModel>> getJobs(JobsRequestParams? params) async {
    return await _apIsManager.send(
      request: JobsRequest(GENERIC(), params?.toJson()),
      responseFromMap: (map) => JobsResponseModel.fromJson(map),
    );
  }

  Future<Either<Failure, Job>> getJob(Job job) async {
    return await _apIsManager.send(
      request: JobDetailsRequest(GENERIC(), job),
      responseFromMap: (map) => Job.fromJson(map),
      // errorResponseFromMap: (errors){
      //   print(errors);
      //   return JobResponseModel(status: true);
      // }
    );
  }

  Future<Either<Failure, Job>> updateJob(Job job) async {
    return await _apIsManager.send(
      request: JobUpdateRequest(GENERIC(), job),
      responseFromMap: (map) => Job.fromJson(map),
    );
  }

  Future<Either<Failure, Job>> addJob(Job job) async {
    return await _apIsManager.send(
      request: AddJobRequest(GENERIC(), job),
      responseFromMap: (map) => Job.fromJson(map),
    );
  }

  Future<Either<Failure, JobResponseModel>> deleteJob(Job job) async {
    return await _apIsManager.send(
      request: DeleteJobRequest(GENERIC(), job),
      responseFromMap: (map) => JobResponseModel.fromJson(map),
    );
  }
}
