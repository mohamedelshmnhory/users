import 'package:json_annotation/json_annotation.dart';

part 'jobs_request_params.g.dart';

@JsonSerializable(includeIfNull: false)
class JobsRequestParams {
  num? per_page;
  num? page;
  String? name;
  String? description;

  JobsRequestParams({
    this.per_page,
    this.page,
    this.name,
    this.description,
  });

  factory JobsRequestParams.fromJson(Map<String, dynamic> json) => _$JobsRequestParamsFromJson(json);

  Map<String, dynamic> toJson() => _$JobsRequestParamsToJson(this);
}
