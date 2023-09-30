import 'package:json_annotation/json_annotation.dart';

part 'favourites_request_params.g.dart';

@JsonSerializable(includeIfNull: false)
class FavouritesRequestParams {
  num? perPage;
  num? page;
  String? username;
  bool? more;

  FavouritesRequestParams({
    this.perPage,
    this.page,
    this.username,
    this.more,
  });

  factory FavouritesRequestParams.fromJson(Map<String, dynamic> json) => _$FavouritesRequestParamsFromJson(json);

  Map<String, dynamic> toJson() => _$FavouritesRequestParamsToJson(this);
}
