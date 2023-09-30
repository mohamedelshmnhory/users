import 'package:json_annotation/json_annotation.dart';

import '../../../home/data/models/job.dart';
import '../../logic/levels_cubit.dart';
import 'level.dart';

part 'levels_request_params.g.dart';

@JsonSerializable(includeIfNull: false)
class LevelsRequestParams {
  num? per_page;
  num? page;
  String? name;
  String? description;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final LevelsCubit? levelsCubit;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Level? level;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Job? job;

  LevelsRequestParams({
    this.per_page,
    this.page,
    this.name,
    this.description,
    this.levelsCubit,
    this.level,
    this.job,
  });

  factory LevelsRequestParams.fromJson(Map<String, dynamic> json) => _$LevelsRequestParamsFromJson(json);

  Map<String, dynamic> toJson() => _$LevelsRequestParamsToJson(this);
}
