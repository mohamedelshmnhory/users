import '../../../../core/data/request/base_request.dart';
import '../../../../core/profile_api.dart';
import '../../../authentication/register/data/model/user.dart';

class FavouritesRequest with Request, GetRequest {
  final BaseApi profileApi;
  FavouritesRequest(this.profileApi, this.queryParameters);

  @override
  Map<String, dynamic>? queryParameters;

  @override
  String get path => profileApi.favourite;
}

class AddFavouriteRequest with Request, PostRequest {
  final BaseApi profileApi;
  AddFavouriteRequest(this.profileApi, this.requestModel);

  @override
  String get path => '${profileApi.favourite}/${requestModel.id}';

  @override
  final User requestModel;
}

class DeleteFavouriteRequest with Request, DeleteRequest {
  final BaseApi profileApi;
  DeleteFavouriteRequest(this.profileApi, this.model);

  @override
  String get path => '${profileApi.favourite}/${model.id}';

  final User model;
}
