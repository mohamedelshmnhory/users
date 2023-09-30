import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/data/api_manager.dart';
import '../../../../core/profile_api.dart';
import '../models/level.dart';
import '../models/level_response_model.dart';
import '../models/levels_request_params.dart';
import '../request/levels_request.dart';

@injectable
class LevelsRepo {
  final APIsManager _apIsManager;

  LevelsRepo(this._apIsManager);

  Future<Either<Failure, LevelsResponseModel>> getLevels(LevelsRequestParams? params) async {
    return await _apIsManager.send(
      request: LevelsRequest(GENERIC(), params?.toJson()),
      responseFromMap: (map) => LevelsResponseModel.fromJson(map),
    );
  }

  Future<Either<Failure, Level>> getLevel(Level job) async {
    return await _apIsManager.send(
      request: LevelDetailsRequest(GENERIC(), job),
      responseFromMap: (map) => Level.fromJson(map),
      // errorResponseFromMap: (errors){
      //   print(errors);
      //   return LevelResponseModel(status: true);
      // }
    );
  }

  Future<Either<Failure, Level>> updateLevel(Level job) async {
    return await _apIsManager.send(
      request: LevelUpdateRequest(GENERIC(), job),
      responseFromMap: (map) => Level.fromJson(map),
    );
  }

  Future<Either<Failure, Level>> addLevel(Level job) async {
    return await _apIsManager.send(
      request: AddLevelRequest(GENERIC(), job),
      responseFromMap: (map) => Level.fromJson(map),
    );
  }

  Future<Either<Failure, LevelResponseModel>> deleteLevel(Level job) async {
    return await _apIsManager.send(
      request: DeleteLevelRequest(GENERIC(), job),
      responseFromMap: (map) => LevelResponseModel.fromJson(map),
    );
  }
}
