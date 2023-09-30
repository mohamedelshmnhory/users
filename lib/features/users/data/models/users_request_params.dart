import 'package:json_annotation/json_annotation.dart';

part 'users_request_params.g.dart';

@JsonSerializable(includeIfNull: false)
class UsersRequestParams {
  num? perPage;
  num? page;
  num? job_id;
  num? level_id;
  String? username;
  String? fullname;
  String? description;
  bool? more;

  UsersRequestParams({
    this.perPage,
    this.page,
    this.username,
    this.fullname,
    this.description,
    this.job_id,
    this.level_id,
    this.more,
  });

  factory UsersRequestParams.fromJson(Map<String, dynamic> json) => _$UsersRequestParamsFromJson(json);

  Map<String, dynamic> toJson() => _$UsersRequestParamsToJson(this);
}
