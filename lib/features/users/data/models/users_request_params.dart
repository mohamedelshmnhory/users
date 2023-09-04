import 'package:json_annotation/json_annotation.dart';

part 'users_request_params.g.dart';

@JsonSerializable(includeIfNull: false)
class UsersRequestParams {
  num? perPage;
  num? page;

  UsersRequestParams({
    this.perPage,
    this.page,
  });

  factory UsersRequestParams.fromJson(Map<String, dynamic> json) => _$UsersRequestParamsFromJson(json);

  Map<String, dynamic> toJson() => _$UsersRequestParamsToJson(this);
}
