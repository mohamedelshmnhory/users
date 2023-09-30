import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/data/api_manager.dart';
import '../../../../core/profile_api.dart';
import '../../../authentication/register/data/model/user.dart';
import '../models/favourites_response_model.dart';
import '../models/favourites_request_params.dart';
import '../request/favourites_request.dart';

@injectable
class FavouritesRepo {
  final APIsManager _apIsManager;

  FavouritesRepo(this._apIsManager);

  Future<Either<Failure, FavouritesResponseModel>> getFavourites(FavouritesRequestParams? params) async {
    return await _apIsManager.send(
      request: FavouritesRequest(GENERIC(), params?.toJson()),
      responseFromMap: (map) => FavouritesResponseModel.fromJson(map),
    );
  }



  Future<Either<Failure, User>> add(User user) async {
    return await _apIsManager.send(
      request: AddFavouriteRequest(GENERIC(), user),
      responseFromMap: (map) => User.fromJson(map),
    );
  }

  Future<Either<Failure, User>> delete(User user) async {
    return await _apIsManager.send(
      request: DeleteFavouriteRequest(GENERIC(), user),
      responseFromMap: (map) => User.fromJson(map),
    );
  }
}
